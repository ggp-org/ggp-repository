package ggp.repository.dresden;

import ggp.repository.CachedStaticServlet;
import ggp.repository.base.BaseRepository;

import java.io.File;
import java.io.IOException;

import com.google.appengine.repackaged.org.json.JSONArray;
import com.google.appengine.repackaged.org.json.JSONException;
import com.google.appengine.repackaged.org.json.JSONObject;

public class DresdenRepository {
    public static byte[] getResponseBytesForURI(String reqURI) throws IOException {
        // Special case: the main page.
        if (reqURI.equals("/") || reqURI.equals("/index.html")) {
            return BaseRepository.readFile(new File("root/gameListDresden.html")).getBytes();
        }
        
        // Special case: game ingestion.
        if (reqURI.startsWith("/ingest/")) {
            String gameKey = reqURI.replace("/ingest/", "");
            if (CachedGame.loadCachedGame(gameKey) == null) {
                CachedGame.ingestCachedGame(gameKey);
                CachedStaticServlet.getCache().clear();
                return ("Just ingested game: " + gameKey).getBytes();
            } else {
                return ("Already ingested game: " + gameKey).getBytes();
            }
        }

        // Files not under /games/ aren't versioned, and can just be
        // accessed directly.
        if (!reqURI.startsWith("/games/")) {
            // TODO: Do something here?
            return null;
        }
        
        // Strip off the "/games/" prefix.
        reqURI = reqURI.replace("/games/", "");
        
        // Provide a listing of all of the metadata files for all of
        // the games, on request.
        if (reqURI.equals("metadata")) {
            JSONObject theGameMetaMap = new JSONObject();
            for (CachedGame cachedGame : CachedGame.loadCachedGames()) {
                try {
                    theGameMetaMap.put(cachedGame.getGameKey(), new JSONObject(new String(getResponseBytesForURI("/games/" + cachedGame.getGameKey() + "/"))));
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
            return theGameMetaMap.toString().getBytes();
        }

        if (reqURI.isEmpty()) {
            JSONArray theGamesList = new JSONArray();
            for (CachedGame cachedGame : CachedGame.loadCachedGames()) {
                theGamesList.put(cachedGame.getGameKey());
            }
            return theGamesList.toString().getBytes();
        }

        if (!reqURI.contains("/")) return null;
        String theGameKey = reqURI.substring(0, reqURI.lastIndexOf("/"));
        String theResource = reqURI.substring(reqURI.lastIndexOf("/")+1);
        if (theGameKey.endsWith("/v0")) {
            theGameKey = theGameKey.substring(0, theGameKey.length()-3);
        }
        CachedGame cachedGame = CachedGame.loadCachedGame(theGameKey);
        if (cachedGame == null) return null;
        return cachedGame.getResource(theResource);
    }
}
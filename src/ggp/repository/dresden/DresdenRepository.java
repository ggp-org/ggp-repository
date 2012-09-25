package ggp.repository.dresden;

import ggp.repository.CachedStaticServlet;
import ggp.repository.base.BaseRepository;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import util.configuration.RemoteResourceLoader;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class DresdenRepository {
    public static byte[] getResponseBytesForURI(String reqURI) throws IOException {
        // Special case: the main page.
        if (reqURI.equals("/") || reqURI.equals("/index.html")) {
            return BaseRepository.readFile(new File("root/gameListDresden.html")).getBytes();
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
    
    public static void performRegularIngestion() throws IOException {
        try {
            Set<CachedGame> theKnownGames = CachedGame.loadCachedGames();
            Map<String,CachedGame> gamesByKey = new HashMap<String,CachedGame>();
            for (CachedGame g : theKnownGames) {
           		gamesByKey.put(g.getGameKey(),g);
            }
            
            boolean foundNewGames = false;
            JSONObject theJSON = RemoteResourceLoader.loadJSON("http://database.ggp.org/statistics/f69721b2f73839e513eed991e96824f1af218ac1/overall");
            JSONArray theObservedGames = theJSON.getJSONArray("observedGames");
            for (int i = 0; i < theObservedGames.length(); i++) {
                String observedGame = theObservedGames.getString(i);
                String gameKey = observedGame.replace("http://games.ggp.org/dresden/games/", "").replace("/v0/","");
                if (!gamesByKey.containsKey(gameKey) || gamesByKey.get(gameKey).needsUpdateFromDresden()) {
            		foundNewGames = true;
            		CachedGame.ingestCachedGame(gameKey);
                }
            }
            if (foundNewGames) {
                CachedStaticServlet.getCache().clear();
            }
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }
}
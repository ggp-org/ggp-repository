package ggp.repository.dresden;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.ggp.galaxy.shared.loader.RemoteResourceLoader;
import org.ggp.galaxy.shared.website.CachedStaticServlet;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class DresdenRepository {
    public static byte[] getResponseBytesForURI(String reqURI) throws IOException {
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
            for (CachedDresdenGame cachedGame : CachedDresdenGame.loadCachedGames()) {
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
            for (CachedDresdenGame cachedGame : CachedDresdenGame.loadCachedGames()) {
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
        CachedDresdenGame cachedGame = CachedDresdenGame.loadCachedGame(theGameKey);
        if (cachedGame == null) return null;
        return cachedGame.getResource(theResource);
    }
    
    private static final String DRESDEN_HASH = "f69721b2f73839e513eed991e96824f1af218ac1";
    public static void performRegularIngestion(boolean fullRefresh) throws IOException {
        try {
            Set<CachedDresdenGame> theKnownGames = CachedDresdenGame.loadCachedGames();
            Map<String,CachedDresdenGame> gamesByKey = new HashMap<String,CachedDresdenGame>();
            for (CachedDresdenGame g : theKnownGames) {
           		gamesByKey.put(g.getGameKey(),g);
            }
            
            boolean foundNewGames = false;
            JSONObject theJSON = RemoteResourceLoader.loadJSON("http://database.ggp.org/statistics/" + DRESDEN_HASH + "/overall");
            JSONArray theObservedGames = theJSON.getJSONArray("observedGames");
            for (int i = 0; i < theObservedGames.length(); i++) {
                String observedGame = theObservedGames.getString(i);
                String gameKey = observedGame.replace("http://games.ggp.org/dresden/games/", "").replace("/v0/","");
                if (!gamesByKey.containsKey(gameKey) || gamesByKey.get(gameKey).needsUpdateFromDresden() || fullRefresh) {
            		foundNewGames = true;
            		CachedDresdenGame.ingestCachedGame(gameKey);
                }
            }
            if (foundNewGames) {
                CachedStaticServlet.getCache().clear();
            }
        } catch (JSONException e) {
            throw new IOException(e);
        }
    }
}
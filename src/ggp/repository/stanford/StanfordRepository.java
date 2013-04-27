package ggp.repository.stanford;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;

import org.ggp.galaxy.shared.loader.RemoteResourceLoader;
import org.ggp.galaxy.shared.website.CachedStaticServlet;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class StanfordRepository {
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
            for (CachedStanfordGame cachedGame : CachedStanfordGame.loadCachedGames()) {
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
            for (CachedStanfordGame cachedGame : CachedStanfordGame.loadCachedGames()) {
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
        CachedStanfordGame cachedGame = CachedStanfordGame.loadCachedGame(theGameKey);
        if (cachedGame == null) return null;
        return cachedGame.getResource(theResource);
    }
    
    public static void performRegularIngestion(boolean fullRefresh) throws IOException {
    	Set<String> knownGameKeys = new HashSet<String>();
    	if (!fullRefresh) {
	        Set<CachedStanfordGame> theKnownGames = CachedStanfordGame.loadCachedGames();        
	        for (CachedStanfordGame g : theKnownGames) {
	        	knownGameKeys.add(g.getGameKey());
	        }
    	}

    	boolean foundNewGames = false;
   		String gameMetaListing = RemoteResourceLoader.loadRaw("http://gamemaster.stanford.edu/findgames.php");
    	for (String gameMeta : gameMetaListing.split("\n")) {
    		try {
	    		JSONObject gameMetaJSON = new JSONObject(gameMeta);
	    		if (knownGameKeys.contains(gameMetaJSON.getString("id")))
	    			continue;
	    		CachedStanfordGame.ingestCachedGame(gameMetaJSON);
	    		foundNewGames = true;
    		} catch (JSONException je) {
    			Logger.getAnonymousLogger().severe("JSON Exception " + je.toString() + " on " + gameMeta);
    		}    		
    	}
    	if (foundNewGames) {
    		CachedStaticServlet.getCache().clear();
    	}
    }
}
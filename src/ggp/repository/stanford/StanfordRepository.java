package ggp.repository.stanford;

import ggp.repository.base.BaseRepository;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.ggp.galaxy.shared.loader.RemoteResourceLoader;
import org.ggp.galaxy.shared.website.CachedStaticServlet;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class StanfordRepository {
    public static byte[] getResponseBytesForURI(String reqURI) throws IOException {
        // Special case: the main page.
        if (reqURI.equals("/") || reqURI.equals("/index.html")) {
            return BaseRepository.readFile(new File("root/gameListStanford.html")).getBytes();
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
    
    public static void performRegularIngestion() throws IOException {
        Set<CachedStanfordGame> theKnownGames = CachedStanfordGame.loadCachedGames();
        Set<String> knownGameKeys = new HashSet<String>();
        for (CachedStanfordGame g : theKnownGames) {
        	knownGameKeys.add(g.getGameKey());
        }
        
        // Load all of the game keys directly 
       	Set<String> allGameKeys = new HashSet<String>();
   		String gamesListPage = RemoteResourceLoader.loadRaw("http://gamemaster.stanford.edu/showgames");
    	for (String gameToken : gamesListPage.split("'")) {
    		if (gameToken.startsWith("inspectgame.php?id=")) {
    			allGameKeys.add(gameToken.substring("inspectgame.php?id=".length()));
    		}
    	}
    	
    	Set<String> newGameKeys = new HashSet<String>();
    	newGameKeys.addAll(allGameKeys);
    	newGameKeys.removeAll(knownGameKeys);
    	if (newGameKeys.size() == 0)
    		return;
        
    	for (String newGameKey : newGameKeys) {
    		CachedStanfordGame.ingestCachedGame(newGameKey);
    	}
    	CachedStaticServlet.getCache().clear();
    }   
}
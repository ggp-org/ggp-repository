package ggp.repository.stanford;

import external.JSON.JSONException;
import external.JSON.JSONObject;
import ggp.repository.CachedGame;

import org.ggp.base.util.loader.RemoteResourceLoader;
import org.ggp.galaxy.shared.persistence.Persistence;

import java.io.IOException;
import java.util.Set;

import javax.jdo.annotations.PersistenceCapable;

@PersistenceCapable
public class CachedStanfordGame extends CachedGame {
    public CachedStanfordGame(String theGameKey, String theName, String theCurator, String theRulesheet, String theDescription) {
		super(theGameKey, theName, theCurator, theRulesheet, theDescription);
	}

    public static void ingestCachedGame(JSONObject gameMeta) throws IOException, JSONException {
    	String gameKey = gameMeta.getString("id");
    	String gameName = gameMeta.getString("name");
    	String gameCurator = gameMeta.getString("curator");
    	String theDescription = "";
    	if (gameMeta.has("description")) {
    		theDescription = RemoteResourceLoader.loadRaw("http://gamemaster.stanford.edu" + gameMeta.getString("description"));
    	}
    	String theRulesheet = RemoteResourceLoader.loadRaw("http://gamemaster.stanford.edu" + gameMeta.getString("rulesheet"));
		if (!theRulesheet.startsWith("<html><head>")) {
			new CachedStanfordGame(gameKey, gameName, gameCurator, theRulesheet, theDescription);
		}
    }
    
    public static CachedStanfordGame loadCachedGame(String gameKey) {
        return Persistence.loadSpecific(gameKey, CachedStanfordGame.class);
    }
    
    public static Set<CachedStanfordGame> loadCachedGames() {
        return Persistence.loadAll(CachedStanfordGame.class);
    }    
}
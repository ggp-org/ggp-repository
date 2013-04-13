package ggp.repository.stanford;

import ggp.repository.CachedGame;
import org.ggp.galaxy.shared.persistence.Persistence;

import java.io.IOException;
import java.util.Set;

import javax.jdo.annotations.PersistenceCapable;

import org.ggp.galaxy.shared.loader.RemoteResourceLoader;

@PersistenceCapable
public class CachedStanfordGame extends CachedGame {
    public CachedStanfordGame(String theGameKey, String theRulesheet, String theDescription) {
		super(theGameKey, theRulesheet, theDescription);
	}

    private final static String gameLoadingPrefix = "http://gamemaster.stanford.edu/inspectgame.php?id="; 

    public static void ingestCachedGame(String gameKey) throws IOException {
		String gamePage = RemoteResourceLoader.loadRaw(gameLoadingPrefix + gameKey);
		String theDescription = extractDescription(gamePage);
		String theRulesheet = getRulesForGameFromHTML(gamePage);
		if (!theRulesheet.startsWith("<html><head>")) {
			new CachedStanfordGame(gameKey, theRulesheet, theDescription);
		}
    }
    
    private static String extractDescription(String theHTML) {
		try {
    		String description = theHTML.split("<br/>")[5];
    		if (description.contains("<") || description.contains(">")) {
    			return null;
    		}
    		return description.trim();
		} catch (Exception e) {
			;
		}
		return null;
    }
    
    private static String getRulesForGameFromHTML(String theHTML) throws IOException {
		String x = theHTML.substring(theHTML.indexOf("View Rulesheet")+"View Rulesheet".length());
		String y = x.substring(x.indexOf("location.href=\"")+"location.href=\"".length());
		String z = y.substring(0,y.indexOf("\""));        		
		return RemoteResourceLoader.loadRaw("http://gamemaster.stanford.edu/" + z);
    } 
    
    public static CachedStanfordGame loadCachedGame(String gameKey) {
        return Persistence.loadSpecific(gameKey, CachedStanfordGame.class);
    }
    
    public static Set<CachedStanfordGame> loadCachedGames() {
        return Persistence.loadAll(CachedStanfordGame.class);
    }    
}
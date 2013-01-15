package ggp.repository.dresden;

import ggp.repository.MetadataCompleter;
import org.ggp.galaxy.shared.persistence.Persistence;

import java.io.IOException;
import java.util.Set;

import javax.jdo.PersistenceManager;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Text;

import org.ggp.galaxy.shared.loader.RemoteResourceLoader;
import org.json.JSONException;
import org.json.JSONObject;

@PersistenceCapable
public class CachedGame {
    @PrimaryKey @Persistent private String gameKey;
    @Persistent private Text rulesheet;
    @Persistent private Text description;

    public CachedGame(String theGameKey, String theRulesheet, String theDescription) {
        gameKey = theGameKey;
        rulesheet = new Text(theRulesheet);
        description = new Text(theDescription);
        save();
    }

    public String getGameKey() {
        return gameKey;
    }

    public byte[] getResource(String theURI) {
        if (theURI.isEmpty()) {
            return getMetadata().getBytes();
        } else if (theURI.equals("rulesheet.kif")) {
            return rulesheet.getValue().getBytes();
        } else if (description != null && !description.getValue().isEmpty() && theURI.equals("description.txt")) {
        	return description.getValue().getBytes();
        }
        return null;
    }
    
    public boolean needsUpdateFromDresden() {
    	return false;
    }

    private String getMetadata() {
        JSONObject metadata = new JSONObject();
        try {
            metadata.put("version", 0);
            metadata.put("rulesheet", "rulesheet.kif");
            if (description != null && !description.getValue().isEmpty()) {
            	metadata.put("description", "description.txt");
            }
            MetadataCompleter.completeMetadataFromRulesheet(metadata, rulesheet.getValue());
            return metadata.toString(); 
        } catch (JSONException je) {
            throw new RuntimeException(je);
        }
    }

    private void save() {
        PersistenceManager pm = Persistence.getPersistenceManager();
        pm.makePersistent(this);
        pm.close();
    }    

    /* Static */
    
    public static CachedGame loadCachedGame(String gameKey) {
        return Persistence.loadSpecific(gameKey, CachedGame.class);
    }
    
    public static Set<CachedGame> loadCachedGames() {
        return Persistence.loadAll(CachedGame.class);
    }
    
    private final static String descLoadingPrefix = "http://130.208.241.192/ggpserver/public/view_game.jsp?name=";
    private final static String gameLoadingPrefix = "http://130.208.241.192/ggpserver/public/download_gdl.jsp?name=";

    public static void ingestCachedGame(String gameKey) throws IOException {
    	String theDescription = extractDescription(RemoteResourceLoader.loadRaw(descLoadingPrefix + gameKey));
        String theRulesheet = RemoteResourceLoader.loadRaw(gameLoadingPrefix + gameKey);
        if (!theRulesheet.startsWith("<html><head>")) {
            // Don't store error pages as rulesheets.
            new CachedGame(gameKey, theRulesheet, theDescription);
        }
    }
    
    public static String extractDescription(String theHTML) {
    	try {
    		String theDescPrefix = theHTML.substring(theHTML.indexOf("<th><a name=\"description\">description</a></th>\n			<td>"));
    		String theDesc = theDescPrefix.substring("<th><a name=\"description\">description</a></th>\n			<td>".length(), theDescPrefix.indexOf("</td>"));
    		return theDesc;
    	} catch (StringIndexOutOfBoundsException e) {
    		return "";
    	}
    }
}
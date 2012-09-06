package ggp.repository.dresden;

import ggp.repository.MetadataCompleter;
import ggp.repository.Persistence;

import java.io.IOException;
import java.util.Set;

import javax.jdo.PersistenceManager;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import util.configuration.RemoteResourceLoader;

import com.google.appengine.api.datastore.Text;
import org.json.JSONException;
import org.json.JSONObject;

@PersistenceCapable
public class CachedGame {
    @PrimaryKey @Persistent private String gameKey;
    @Persistent private Text rulesheet;

    public CachedGame(String theGameKey, String theRulesheet) {
        gameKey = theGameKey;
        rulesheet = new Text(theRulesheet);
        save();
    }

    public String getGameKey() {
        return gameKey;
    }

    public byte[] getResource(String theURI) {
        if (theURI.isEmpty()) {
            return getMetadata().getBytes();
        } else if (theURI.equals("rulesheet.kif")) {
            return getRulesheet().getBytes();
        }
        return null;
    }

    private String getMetadata() {
        JSONObject metadata = new JSONObject();
        try {
            metadata.put("version", 0);
            metadata.put("rulesheet", "rulesheet.kif");
            MetadataCompleter.completeMetadataFromRulesheet(metadata, rulesheet.getValue());
            return metadata.toString(); 
        } catch (JSONException je) {
            throw new RuntimeException(je);
        }
    }

    private String getRulesheet() {
        return rulesheet.getValue();
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
    
    private final static String gameLoadingPrefix = "http://130.208.241.192/ggpserver/public/download_gdl.jsp?name=";

    public static void ingestCachedGame(String gameKey) throws IOException {
        String theRulesheet = RemoteResourceLoader.loadRaw(gameLoadingPrefix + gameKey);
        if (!theRulesheet.startsWith("<html><head>")) {
            // Don't store error pages as rulesheets.
            new CachedGame(gameKey, theRulesheet);
        }
    }    
}
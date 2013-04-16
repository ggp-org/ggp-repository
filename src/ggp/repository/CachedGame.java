package ggp.repository;

import ggp.repository.MetadataCompleter;

import org.ggp.galaxy.shared.persistence.Persistence;

import javax.jdo.PersistenceManager;
import javax.jdo.annotations.Inheritance;
import javax.jdo.annotations.InheritanceStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Text;

import org.json.JSONException;
import org.json.JSONObject;

@PersistenceCapable
@Inheritance(strategy=InheritanceStrategy.SUBCLASS_TABLE)
public abstract class CachedGame {
    @PrimaryKey @Persistent private String gameKey;
    @Persistent private Text rulesheet;
    @Persistent private Text description;
    @Persistent private String curator;
    @Persistent private String name;

    public CachedGame(String theGameKey, String theName, String theCurator, String theRulesheet, String theDescription) {
    	name = theName;
        gameKey = theGameKey;        
        curator = theCurator;
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
    
    private String getMetadata() {
        JSONObject metadata = new JSONObject();
        try {
            metadata.put("version", 0);
            metadata.put("rulesheet", "rulesheet.kif");
            if (description != null && !description.getValue().isEmpty()) {
            	metadata.put("description", "description.txt");
            }
            if (curator != null && !curator.isEmpty()) {
            	metadata.put("curator", curator);
            }
            if (name != null && !name.isEmpty()) {
            	metadata.put("gameName", name);
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
}
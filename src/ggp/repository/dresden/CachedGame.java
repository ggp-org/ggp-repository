package ggp.repository.dresden;

import ggp.repository.Persistence;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.jdo.PersistenceManager;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import util.configuration.RemoteResourceLoader;
import util.gdl.factory.GdlFactory;
import util.gdl.factory.exceptions.GdlFormatException;
import util.gdl.grammar.Gdl;
import util.gdl.grammar.GdlRelation;
import util.symbol.factory.SymbolFactory;
import util.symbol.factory.exceptions.SymbolFormatException;
import util.symbol.grammar.SymbolList;

import com.google.appengine.api.datastore.Text;
import com.google.appengine.repackaged.org.json.JSONException;
import com.google.appengine.repackaged.org.json.JSONObject;

@PersistenceCapable
public class CachedGame {
    @PrimaryKey @Persistent private String gameKey;
    @Persistent private int numRoles;
    @Persistent private Text rulesheet;

    public CachedGame(String theGameKey, String theRulesheet) {
        gameKey = theGameKey;
        rulesheet = new Text(theRulesheet);
        numRoles = getRoleCountFromRulesheet(theRulesheet);
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
            metadata.put("numRoles", numRoles);
            metadata.put("version", 0);
            metadata.put("rulesheet", "rulesheet.kif");
            return metadata.toString(); 
        } catch (JSONException je) {
            throw new RuntimeException(je);
        }
    }

    private String getRulesheet() {
        return rulesheet.getValue();
    }

    private static int getRoleCountFromRulesheet(String gameRulesheet) {
        int nRoles = 0;
        try {
            List<Gdl> gdlRulesheet = new ArrayList<Gdl>();
            StringBuilder cleanRulesheet = new StringBuilder("( ");
            String[] splitRulesheet = gameRulesheet.split("\n");
            for (int i = 0; i < splitRulesheet.length; i++) {
                String line = splitRulesheet[i].trim();
                int comment = line.indexOf(';');
                int cutoff = (comment == -1) ? line.length() : comment;
                cleanRulesheet.append(line.substring(0, cutoff));
                cleanRulesheet.append(" ");                
            }
            cleanRulesheet.append(" )");
            SymbolList list = (SymbolList) SymbolFactory.create(cleanRulesheet.toString().trim());
            for (int i = 0; i < list.size(); i++) {
                gdlRulesheet.add(GdlFactory.create(list.get(i)));
            }
            for (Gdl gdl : gdlRulesheet) {
                if (gdl instanceof GdlRelation) {
                    GdlRelation relation = (GdlRelation) gdl;
                    if (relation.getName().getValue().equals("role")) {
                        nRoles++;
                    }
                }
            }
        } catch (SymbolFormatException se) {
            throw new RuntimeException(se);
        } catch (GdlFormatException ge) {
            throw new RuntimeException(ge);
        }
        return nRoles;
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
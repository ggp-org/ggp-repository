package ggp.repository;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import util.gdl.factory.GdlFactory;
import util.gdl.factory.exceptions.GdlFormatException;
import util.gdl.grammar.Gdl;
import util.gdl.grammar.GdlRelation;
import util.symbol.factory.SymbolFactory;
import util.symbol.factory.exceptions.SymbolFormatException;
import util.symbol.grammar.SymbolList;

public class MetadataCompleter {
	/**
	 * Complete fields in the metadata procedurally, based on the game rulesheet.
	 * This is used to fill in the number of roles, and create a list containing
	 * the names of all of the roles. Applications which read the game metadata
	 * can use these without also having to process the rulesheet.
	 * 
	 * @param theMetaJSON
	 * @param theRulesheet
	 * @throws JSONException
	 */
	public static void completeMetadataFromRulesheet(JSONObject theMetaJSON, String theRulesheet) throws JSONException {
        List<String> theRoles = getRolesFromRulesheet(theRulesheet);
        theMetaJSON.put("roleNames", theRoles);
        theMetaJSON.put("numRoles", theRoles.size());
	}
	
    private static List<String> getRolesFromRulesheet(String gameRulesheet) {
        List<String> theRoles = new ArrayList<String>();
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
                        theRoles.add(relation.getBody().iterator().next().toString());
                    }
                }
            }
        } catch (SymbolFormatException se) {
            throw new RuntimeException(se);
        } catch (GdlFormatException ge) {
            throw new RuntimeException(ge);
        }
        return theRoles;
    }
}
package ggp.repository;

import java.util.List;

import org.ggp.galaxy.shared.game.Game;
import org.ggp.galaxy.shared.statemachine.Role;
import org.json.JSONException;
import org.json.JSONObject;

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
        List<Role> theRoles = Role.computeRoles(Game.createEphemeralGame(Game.preprocessRulesheet(theRulesheet)).getRules());
        theMetaJSON.put("roleNames", theRoles);
        theMetaJSON.put("numRoles", theRoles.size());
	}
}
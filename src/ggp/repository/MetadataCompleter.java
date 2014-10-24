package ggp.repository;

import java.util.ArrayList;
import java.util.List;

import org.ggp.base.util.game.Game;
import org.ggp.base.util.statemachine.Role;

import external.JSON.JSONException;
import external.JSON.JSONObject;

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
        List<String> theRoleNames = new ArrayList<String>();
        for (Role r : theRoles) theRoleNames.add(r.getName().getValue());
        theMetaJSON.put("roleNames", theRoleNames);
        theMetaJSON.put("numRoles", theRoles.size());
	}
}
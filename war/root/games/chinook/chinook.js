// Game interface description.
{
  [BOARD_INTERFACE_JS]

  // ============= GAME SPECIFIC ====================

  getCellForMove: function(move) {
	if (move == "oddnoop" || move == "evennoop") {
		return "cell_a1";
	} else {
		return "cell_" + move[1] + move[2];
	}
  },

  getTargetsForMove: function(move) {
      var targets = [];
      if (move == "oddnoop" || move == "evennoop") {
    	  return targets;
      }
      
      targets.push(document.getElementById("cell_" + move[3] + move[4]));

      if (move.length > 5) {
	      targets.push(document.getElementById("cell_" + move[5] + move[6]));
      }
      if (move.length > 7) {
	      targets.push(document.getElementById("cell_" + move[7] + move[8]));
      }
      
      return targets;
  }
}
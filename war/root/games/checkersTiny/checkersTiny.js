// Game interface description.
{
  [BOARD_INTERFACE_JS]

  // ============= GAME SPECIFIC ====================

  getCellForMove: function(move) {
  	return "cell_" + move[2] + move[3];
  },

  getTargetsForMove: function(move) {
      var targets = [];
      targets.push(document.getElementById("cell_" + move[4] + move[5]));

      if (move.length > 6) {
	      targets.push(document.getElementById("cell_" + move[6] + move[7]));
      }
      if (move.length > 8) {
	      targets.push(document.getElementById("cell_" + move[8] + move[9]));
      }
      
      return targets;
  }
}
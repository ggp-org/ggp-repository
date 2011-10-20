// Game interface description.
{
  [BOARD_INTERFACE_JS]

  // ============= GAME SPECIFIC ====================

  getCellForMove: function(move) {
    if (move[0] == "mark1") {
  	  return "cell_" + move[1] + move[2] + "1";
  	} else {
  	  return "cell_" + move[1] + move[2] + "2";
  	}
  },

  getTargetsForMove: function(move) {
    return [];
  }
}
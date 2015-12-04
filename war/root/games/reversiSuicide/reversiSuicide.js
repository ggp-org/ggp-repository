// Game interface description.
{
  [BOARD_INTERFACE_JS]

  // ============= GAME SPECIFIC ====================

  getCellForMove: function(move) {
  	return "cell_" + move[1] + move[2];
  },

  getTargetsForMove: function(move) {
	  return [];
  }
}
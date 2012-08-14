// Game interface description.
{
  [BOARD_INTERFACE_JS]

  // ============= GAME SPECIFIC ====================

  getCellForMove: function(move) {
  	return "cell_" + move[1] + "9";
  },

  getTargetsForMove: function(move) {
      return [];
  }
}
// Game interface description.
{
  [BOARD_INTERFACE_JS]

  // ============= GAME SPECIFIC ====================

  getCellForMove: function(move) {
  	return "cell_" + move[1] + move[2] + move[3] + move[4];
  },

  getTargetsForMove: function(move) {
      return [];
  }
}
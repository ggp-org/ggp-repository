// Game interface description.
{
  [BOARD_INTERFACE_JS]

  // ============= GAME SPECIFIC ====================

  getCellForMove: function(move) {
    if (move.length == 2) {
      return "cell_" + move[1] + "7";
    } else if (move.length == 5) {
      return "cell_" + move[1] + move[2];
    } else if (move.length == 7) {
      return "cell_" + move[1] + move[2];
    }  	
  },

  getTargetsForMove: function(move) {
      var targets = [];
      
      if (move.length == 2) {
      } else if (move.length == 5) {
        targets.push(document.getElementById("cell_" + move[3] + move[4]));      
      } else if (move.length == 7) {
        targets.push(document.getElementById("cell_" + move[5] + move[6]));
      }  	
      
      return targets;
  }
}
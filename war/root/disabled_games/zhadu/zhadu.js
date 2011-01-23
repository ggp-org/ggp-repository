// Game interface description.
{
  // Arguments from "attach".
  legals: null,
  viz_div: null,
  selectionCallback: function (x) {},

  // Current state of the interface.
  legalMapping: {},
  selectedCell: null,
  targetedCells: [],
  selectedMoveIndex: null,  

  // "clearSelection" is called by external scripts.
  clearSelection: function () {
    this.unrenderSelectedMove();
  
    this.selectedCell = null;
    this.targetedCells = [];
    this.selectedMoveIndex = null;
        
    this.selectionCallback(null);
  },

  // "attach" is called by external scripts.
  attach: function (args) {
    // Read all of the arguments and save them locally.
    this.selectionCallback = args.selection_callback;
    this.viz_div = args.viz_div;
    this.legals = args.legals;

    // Start out by clearing the selection.
    this.clearSelection();

    // Cache the cell->move mapping.
    this.cacheLegalMapping();

    // Highlight the legal cells.
    this.highlightLegalMoves();

    // Go through each cell and assign a handler to that cell.  
    var cells = this.viz_div.getElementsByClassName("cell");
    for(var i = 0; i < cells.length; i++) {
      var cell = cells[i];
      if (this.legalMapping[cell.id]) {      
      	cell.onclick = this.getCellClickHandler(cell);
      }
    }    
  },

  cacheLegalMapping: function() {
    this.legalMapping = {};
    for(var i = 0; i < this.legals.length; i++) {
      if (this.legals[i].length == undefined) continue;
      var cellId = this.getCellForMove(this.legals[i]);

      if (this.legalMapping[cellId] == undefined) {
      	this.legalMapping[cellId] = [];
      }

      this.legalMapping[cellId].push(this.legals[i]);
      this.legalMapping[cellId].sort();
    }
  },

  highlightLegalMoves: function() {
    for(var cellId in this.legalMapping) {
      var cell = document.getElementById(cellId);      
      //cell.style.backgroundColor = '#DFC184';
      cell.style.borderStyle = 'solid';
    }
  },

  markCell: function (cell, color) {
    if (cell) {
      cell.style.borderColor = color;
    }
  },

  unrenderSelectedMove: function() {
  	this.markCell(this.selectedCell, null);
  	for(var i = 0; i < this.targetedCells.length; i++) {
  	  this.markCell(this.targetedCells[i], null);
  	}
  },

  renderSelectedMove: function() {
  	this.markCell(this.selectedCell, "#FF0000");
  	for(var i = 0; i < this.targetedCells.length; i++) {
  	  this.markCell(this.targetedCells[i], "#00FF00");
  	}
  },

  getCellClickHandler: function(cell) {
    var parent = this;
    return function() {
      // Not a legal move? Return.
      var movesSelected = parent.legalMapping[cell.id];
      if (!movesSelected) return;

      // Get number of moves for this cell.
      var legalMoves = parent.legalMapping[cell.id].length;

      // Already selected this cell, and only one move? Done.
      if (parent.selectedCell == cell && legalMoves == 1) return;          

      // New cell? Reset the move index.
      if (parent.selectedCell != cell) {
	      parent.selectedMoveIndex = -1;
	  }

      // Choose our move in the selected cell.
      parent.selectedMoveIndex += 1;
      if (parent.selectedMoveIndex >= legalMoves) {
        parent.selectedMoveIndex = 0;
      }
      var selectedMove = movesSelected[parent.selectedMoveIndex];

      // Identify the target cell(s).
      var targets = parent.getTargetsForMove(selectedMove);

      parent.unrenderSelectedMove();
      parent.selectedCell = cell;
      parent.targetedCells = targets;
      parent.renderSelectedMove();
      parent.selectionCallback(selectedMove);
    }
  },

  // ============= GAME SPECIFIC ====================

  getCellForMove: function(move) {
  	return "cell_" + move[2];
  },

  getTargetsForMove: function(move) {
    var targets = [];
    //targets.push(document.getElementById("cell_" + move[2]));
      
    return targets;  
  }
}
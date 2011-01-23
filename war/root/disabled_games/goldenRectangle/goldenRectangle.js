// Game interface description.
{
  // Arguments from "attach".
  legals: null,
  viz_div: null,
  selectionCallback: function (x) {},
  
  // Current state of the interface.
  legalMapping: {},
  selectedColumn: null,

  // "clearSelection" is called by external scripts.
  clearSelection: function () {
    this.markColumn(this.selectedColumn, null);
  
    this.selectedColumn = null;
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
    for (var i = 0; i < this.legals.length; i++) {
      for (var j = 1; j <= 6; j++) {
        if (this.legals[i].length == undefined) continue;
        var cellId = "cell_" + this.legals[i][1] + j;
        this.legalMapping[cellId] = this.legals[i];
      }
    }
  },
  
  highlightLegalMoves: function() {
    for(var cellId in this.legalMapping) {
      var cell = document.getElementById(cellId);      
      cell.style.backgroundColor = '#DFC184';
    }
  },

  markColumn: function (x, bgColor) {
    if (x) {
      for(var j = 1; j <= 6; j++) {
        var cell = document.getElementById("cell_" + x + "" + j);
        cell.style.borderColor = bgColor;
      }
    }
  },

  getCellClickHandler: function(cell) {
    var parent = this;
    return function() {
      // Already selected this cell? Return.
      if (parent.selectedColumn == cell.id[5]) return;

      // Not a legal move? Return.
      var moveSelected = parent.legalMapping[cell.id];
      if (!moveSelected) return;
      
      parent.markColumn(parent.selectedColumn, null);
      parent.markColumn(cell.id[5], "#FF0000");    

      parent.selectedColumn = cell.id[5];
      parent.selectionCallback(moveSelected);
    }
  },
}
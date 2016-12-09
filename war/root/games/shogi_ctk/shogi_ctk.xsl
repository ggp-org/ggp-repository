<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <script>
    function switchPieceStyles() {
      //We use a static variable here to preserve the value across rendering different states of the game.
      window.shogiCtkAlternativeStyle = !window.shogiCtkAlternativeStyle;
      setActiveStylesheet();
    }
    function setActiveStylesheet() {
      if (!window.shogiCtkAlternativeStyle) {
        document.getElementById("traditionalPieces").disabled = false;
        document.getElementById("simplifiedPieces").disabled = true;
      } else {
        document.getElementById("traditionalPieces").disabled = true;
        document.getElementById("simplifiedPieces").disabled = false;
      }
    }
  </script>
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.111"/>px;
        height: <xsl:value-of select="$height * 0.111"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #000000;
      }
      .piece {
        width: <xsl:value-of select="$width * 0.9 * 0.111"/>px;
        height: <xsl:value-of select="$height * 0.9 * 0.111"/>px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: contain;
      }
      .whitePiece {
        -webkit-transform: rotate(180deg);
        -moz-transform: rotate(180deg);
        -o-transform: rotate(180deg);
        -ms-transform: rotate(180deg);
        transform: rotate(180deg);
      }
      .container {
        display: flex;
        flex-direction: row;
      }
      .whiteInHand {
        display: flex;
        flex-direction: column;
        padding: 5px;
      }
      .blackInHand {
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
        padding: 5px;
      }
    </style>
    <style type="text/css" media="all" id="traditionalPieces">
      .whiteKing {
        background-image: url("&ROOT;/resources/images/shogi/kingLowerRank.svg");
      }
      .blackKing {
        background-image: url("&ROOT;/resources/images/shogi/kingHigherRank.svg");
      }
      .gold {
        background-image: url("&ROOT;/resources/images/shogi/gold.svg");
      }
      .silver {
        background-image: url("&ROOT;/resources/images/shogi/silver.svg");
      }
      .silverPromoted {
        background-image: url("&ROOT;/resources/images/shogi/silverPromoted.svg");
      }
      .knight {
        background-image: url("&ROOT;/resources/images/shogi/knight.svg");
      }
      .knightPromoted {
        background-image: url("&ROOT;/resources/images/shogi/knightPromoted.svg");
      }
      .lance {
        background-image: url("&ROOT;/resources/images/shogi/lance.svg");
      }
      .lancePromoted {
        background-image: url("&ROOT;/resources/images/shogi/lancePromoted.svg");
      }
      .bishop {
        background-image: url("&ROOT;/resources/images/shogi/bishop.svg");
      }
      .bishopPromoted {
        background-image: url("&ROOT;/resources/images/shogi/bishopPromoted.svg");
      }
      .rook {
        background-image: url("&ROOT;/resources/images/shogi/rook.svg");
      }
      .rookPromoted {
        background-image: url("&ROOT;/resources/images/shogi/rookPromoted.svg");
      }
      .pawn {
        background-image: url("&ROOT;/resources/images/shogi/pawn.svg");
      }
      .pawnPromoted {
        background-image: url("&ROOT;/resources/images/shogi/pawnPromoted.svg");
      }
    </style>
    <style type="text/css" media="all" id="simplifiedPieces">
      .whiteKing {
        background-image: url("&ROOT;/resources/images/shogi/alt/king.svg");
      }
      .blackKing {
        background-image: url("&ROOT;/resources/images/shogi/alt/king.svg");
      }
      .gold {
        background-image: url("&ROOT;/resources/images/shogi/alt/gold.svg");
      }
      .silver {
        background-image: url("&ROOT;/resources/images/shogi/alt/silver.svg");
      }
      .silverPromoted {
        background-image: url("&ROOT;/resources/images/shogi/alt/silverPromoted.svg");
      }
      .knight {
        background-image: url("&ROOT;/resources/images/shogi/alt/knight.svg");
      }
      .knightPromoted {
        background-image: url("&ROOT;/resources/images/shogi/alt/knightPromoted.svg");
      }
      .lance {
        background-image: url("&ROOT;/resources/images/shogi/alt/lance.svg");
      }
      .lancePromoted {
        background-image: url("&ROOT;/resources/images/shogi/alt/lancePromoted.svg");
      }
      .bishop {
        background-image: url("&ROOT;/resources/images/shogi/alt/bishop.svg");
      }
      .bishopPromoted {
        background-image: url("&ROOT;/resources/images/shogi/alt/bishopPromoted.svg");
      }
      .rook {
        background-image: url("&ROOT;/resources/images/shogi/alt/rook.svg");
      }
      .rookPromoted {
        background-image: url("&ROOT;/resources/images/shogi/alt/rookPromoted.svg");
      }
      .pawn {
        background-image: url("&ROOT;/resources/images/shogi/alt/pawn.svg");
      }
      .pawnPromoted {
        background-image: url("&ROOT;/resources/images/shogi/alt/pawnPromoted.svg");
      }
    </style>
    <script>
      setActiveStylesheet();
    </script>
    <div class="container">
    <!-- White's in-hand pieces -->
    <div class="whiteInHand">
      <xsl:for-each select="//fact[relation='inHand' and argument[1]='white' and argument[3]!='0']">
        <div>
          <xsl:value-of select="argument[3]"/>x
          <xsl:if test="argument[2]='gold'"> <div class="piece whitePiece gold"/> </xsl:if>
          <xsl:if test="argument[2]='silver'"> <div class="piece whitePiece silver"/> </xsl:if>
          <xsl:if test="argument[2]='knight'"> <div class="piece whitePiece knight"/> </xsl:if>
          <xsl:if test="argument[2]='lance'"> <div class="piece whitePiece lance"/> </xsl:if>
          <xsl:if test="argument[2]='rook'"> <div class="piece whitePiece rook"/> </xsl:if>
          <xsl:if test="argument[2]='bishop'"> <div class="piece whitePiece bishop"/> </xsl:if>
          <xsl:if test="argument[2]='pawn'"> <div class="piece whitePiece pawn"/> </xsl:if>
        </div>
      </xsl:for-each>
    </div>
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="9"/>
      <xsl:with-param name="rows" select="9"/>
    </xsl:call-template>		    
    <!-- Black's in-hand pieces -->
    <div class="blackInHand">
      <xsl:for-each select="//fact[relation='inHand' and argument[1]='black' and argument[3]!='0']">
        <div>
          <xsl:value-of select="argument[3]"/>x
          <xsl:if test="argument[2]='gold'"> <div class="piece gold"/> </xsl:if>
          <xsl:if test="argument[2]='silver'"> <div class="piece silver"/> </xsl:if>
          <xsl:if test="argument[2]='knight'"> <div class="piece knight"/> </xsl:if>
          <xsl:if test="argument[2]='lance'"> <div class="piece lance"/> </xsl:if>
          <xsl:if test="argument[2]='rook'"> <div class="piece rook"/> </xsl:if>
          <xsl:if test="argument[2]='bishop'"> <div class="piece bishop"/> </xsl:if>
          <xsl:if test="argument[2]='pawn'"> <div class="piece pawn"/> </xsl:if>
        </div>
      </xsl:for-each>
    </div>
    </div>
    <button onClick="switchPieceStyles();">Switch piece images</button>
  </div>
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 
  
  <xsl:param name="row_char" select="translate(translate(translate(translate(translate(translate(translate(translate(translate($row,1,'a'),2,'b'),3,'c'),4,'d'),5,'e'),6,'f'),7,'g'),8,'h'),9,'i')"/>

  <td class="cell">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col"/>
    <xsl:value-of select="$row_char"/>
  </xsl:attribute>

  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='king']"> <div class="piece blackKing"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='gold']"> <div class="piece gold"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='silver' and argument[5]='unpromoted']"> <div class="piece silver"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='silver' and argument[5]='promoted']"> <div class="piece silverPromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='knight' and argument[5]='unpromoted']"> <div class="piece knight"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='knight' and argument[5]='promoted']"> <div class="piece knightPromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='lance' and argument[5]='unpromoted']"> <div class="piece lance"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='lance' and argument[5]='promoted']"> <div class="piece lancePromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='rook' and argument[5]='unpromoted']"> <div class="piece rook"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='rook' and argument[5]='promoted']"> <div class="piece rookPromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='bishop' and argument[5]='unpromoted']"> <div class="piece bishop"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='bishop' and argument[5]='promoted']"> <div class="piece bishopPromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='pawn' and argument[5]='unpromoted']"> <div class="piece pawn"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='black' and argument[4]='pawn' and argument[5]='promoted']"> <div class="piece pawnPromoted"/> </xsl:if>

  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='king']"> <div class="piece whitePiece whiteKing"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='gold']"> <div class="piece whitePiece gold"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='silver' and argument[5]='unpromoted']"> <div class="piece whitePiece silver"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='silver' and argument[5]='promoted']"> <div class="piece whitePiece silverPromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='knight' and argument[5]='unpromoted']"> <div class="piece whitePiece knight"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='knight' and argument[5]='promoted']"> <div class="piece whitePiece knightPromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='lance' and argument[5]='unpromoted']"> <div class="piece whitePiece lance"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='lance' and argument[5]='promoted']"> <div class="piece whitePiece lancePromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='rook' and argument[5]='unpromoted']"> <div class="piece whitePiece rook"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='rook' and argument[5]='promoted']"> <div class="piece whitePiece rookPromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='bishop' and argument[5]='unpromoted']"> <div class="piece whitePiece bishop"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='bishop' and argument[5]='promoted']"> <div class="piece whitePiece bishopPromoted"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='pawn' and argument[5]='unpromoted']"> <div class="piece whitePiece pawn"/> </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row_char and argument[3]='white' and argument[4]='pawn' and argument[5]='promoted']"> <div class="piece whitePiece pawnPromoted"/> </xsl:if>
  
  </td>  
</xsl:template>

<xsl:template name="board_row">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="9"/>
  
  <xsl:call-template name="cell">
    <xsl:with-param name="row" select="$row"/>
    <xsl:with-param name="col" select="$col"/>
  </xsl:call-template>

  <xsl:if test="1 &lt; $col">
    <xsl:call-template name="board_row">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row"/>
      <xsl:with-param name="col" select="$col - 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="board_rows">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="row" select="1"/>

  <tr>
  <xsl:call-template name="board_row">
    <xsl:with-param name="cols" select="$cols"/>
    <xsl:with-param name="rows" select="$rows"/>
    <xsl:with-param name="row" select="$row"/>
  </xsl:call-template>
  </tr>

  <xsl:if test="$row &lt; $rows">
    <xsl:call-template name="board_rows">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row + 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="board">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>

  <table class="board">
  <xsl:call-template name="board_rows">
    <xsl:with-param name="cols" select="$cols"/>
    <xsl:with-param name="rows" select="$rows"/>
  </xsl:call-template>
  </table>
</xsl:template>

</xsl:stylesheet>

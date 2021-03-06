<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.125"/>px;
        height: <xsl:value-of select="$height * 0.125"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #000000;
      }
      img.piece {
        width: <xsl:value-of select="$width * 0.9 * 0.125"/>px;
        height: <xsl:value-of select="$height * 0.9 * 0.125"/>px;        
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="8"/>
      <xsl:with-param name="rows" select="8"/>
    </xsl:call-template>		    
  </div>  
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 
  
  <td class="cell">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col"/>
    <xsl:value-of select="$row"/>
  </xsl:attribute>

  <center>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='whitePawn']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Pawn.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='whiteRook']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Rook.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='whiteKing']"> <img class="piece" src="&ROOT;/resources/images/chess/White_King.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='whiteQueen']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Queen.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='whiteKnight']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Knight.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='whiteBishop']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Bishop.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='blackPawn']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Pawn.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='blackRook']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Rook.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='blackKing']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_King.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='blackQueen']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Queen.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='blackKnight']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Knight.png"/> </xsl:if>
  <xsl:if test="//fact[relation='location' and argument[1]=$col and argument[2]=$row and argument[3]='blackBishop']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Bishop.png"/> </xsl:if>  
  </center>
  
  </td>  
</xsl:template>

<xsl:template name="board_row">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/>
  
  <xsl:call-template name="cell">
    <xsl:with-param name="row" select="$row"/>
    <xsl:with-param name="col" select="$col"/>
  </xsl:call-template>

  <xsl:if test="$col &lt; $cols">
    <xsl:call-template name="board_row">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row"/>
      <xsl:with-param name="col" select="$col + 1"/>
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.142"/>px;
        height: <xsl:value-of select="$height * 0.142"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #000000;
      }
      img.piece {
        width: <xsl:value-of select="$width * 0.9 * 0.142"/>px;
        height: <xsl:value-of select="$height * 0.9 * 0.142"/>px;        
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="7"/>
      <xsl:with-param name="rows" select="7"/>
    </xsl:call-template>		    
  </div>  
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 

  <xsl:param name="true_row" select="$col"/>
  <xsl:param name="true_col" select="8 - $row"/>

  <td class="cell">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>    
    <xsl:value-of select="$true_row"/>   
    <xsl:value-of select="$true_col"/> 
  </xsl:attribute>

  <xsl:choose>
    <xsl:when test="($true_row=1 or $true_row=7) and ($true_col &lt; 3 or $true_col &gt; 5)"> <xsl:attribute name="style">background-color: #222</xsl:attribute> </xsl:when>
    <xsl:when test="$true_col=1 or $true_col=7"> <xsl:attribute name="style">background-color: #222</xsl:attribute> </xsl:when>
    <xsl:when test="$true_row &lt; 3 or $true_row &gt; 5 or $true_col &lt; 3 or $true_col &gt; 5"> <xsl:attribute name="style">background-color: #888</xsl:attribute> </xsl:when>
  </xsl:choose>  

  <center>
  <xsl:choose>
    <xsl:when test="//fact[relation='cell' and argument[1]=$true_row and argument[2]=$true_col and argument[3]='lightDisc']"> <img class="piece" src="&ROOT;/resources/images/discs/red.png"/> </xsl:when>
    <xsl:when test="//fact[relation='cell' and argument[1]=$true_row and argument[2]=$true_col and argument[3]='lightPawn']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Pawn.png"/> </xsl:when>
    <xsl:when test="//fact[relation='cell' and argument[1]=$true_row and argument[2]=$true_col and argument[3]='lightChecker']"> <img class="piece" src="&ROOT;/resources/images/checkers/red_king.png"/> </xsl:when>
    <xsl:when test="//fact[relation='cell' and argument[1]=$true_row and argument[2]=$true_col and argument[3]='lightKnight']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Knight.png"/> </xsl:when>
    <xsl:when test="//fact[relation='cell' and argument[1]=$true_row and argument[2]=$true_col and argument[3]='darkDisc']"> <img class="piece" src="&ROOT;/resources/images/discs/black.png"/> </xsl:when>
    <xsl:when test="//fact[relation='cell' and argument[1]=$true_row and argument[2]=$true_col and argument[3]='darkPawn']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Pawn.png"/> </xsl:when>
    <xsl:when test="//fact[relation='cell' and argument[1]=$true_row and argument[2]=$true_col and argument[3]='darkChecker']"> <img class="piece" src="&ROOT;/resources/images/checkers/black_king.png"/> </xsl:when>
    <xsl:when test="//fact[relation='cell' and argument[1]=$true_row and argument[2]=$true_col and argument[3]='darkKnight']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Knight.png"/> </xsl:when>
  </xsl:choose>
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
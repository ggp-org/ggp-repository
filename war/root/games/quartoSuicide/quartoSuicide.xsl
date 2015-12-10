<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.25"/>px;
        height: <xsl:value-of select="$height * 0.25"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #000000;
      }
      img.piece {
        width: <xsl:value-of select="$width * 0.9 * 0.25"/>px;
        height: <xsl:value-of select="$height * 0.9 * 0.25"/>px;        
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="4"/>
      <xsl:with-param name="rows" select="4"/>
    </xsl:call-template>		    
  </div>  
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 

  <td class="cell">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$row"/>
    <xsl:value-of select="$col"/>    
  </xsl:attribute>

  <xsl:choose>
    <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],2,1)='0']"> <xsl:attribute name="style">background-color: #CCC</xsl:attribute> </xsl:when>
    <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],2,1)='1']"> <xsl:attribute name="style">background-color: #888</xsl:attribute> </xsl:when>
    <xsl:otherwise> <xsl:attribute name="style">background-color: #CCC</xsl:attribute> </xsl:otherwise>
  </xsl:choose>   
  
  <center>
    <xsl:choose>
      <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],3,3)='000']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Pawn.png"/> </xsl:when>
      <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],3,3)='001']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Pawn.png"/> </xsl:when>
      <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],3,3)='010']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Knight.png"/> </xsl:when>
      <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],3,3)='011']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Knight.png"/> </xsl:when>
      <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],3,3)='100']"> <img class="piece" src="&ROOT;/resources/images/quarto/Black_Pawn_Flipped.png"/> </xsl:when>
      <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],3,3)='101']"> <img class="piece" src="&ROOT;/resources/images/quarto/White_Pawn_Flipped.png"/> </xsl:when>
      <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],3,3)='110']"> <img class="piece" src="&ROOT;/resources/images/quarto/Black_Knight_Flipped.png"/> </xsl:when>
      <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and substring(argument[3],3,3)='111']"> <img class="piece" src="&ROOT;/resources/images/quarto/White_Knight_Flipped.png"/> </xsl:when>
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
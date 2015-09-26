<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <xsl:param name="boardsize">
    <xsl:for-each select="state/fact[relation='cell']/argument[1]">
      <xsl:sort data-type="number" order="descending"/>
      <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
    </xsl:for-each>
  </xsl:param>
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width div $boardsize"/>px;
        height: <xsl:value-of select="$height div $boardsize"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #000000;
      }
      img.piece {
        width: <xsl:value-of select="($width * 0.9) div $boardsize"/>px;
        height: <xsl:value-of select="($height * 0.9) div $boardsize"/>px;
      }
    </style>

    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="$boardsize"/>
      <xsl:with-param name="rows" select="$boardsize"/>
    </xsl:call-template>		
  </div>
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/>

  <td class="cell">

  <center>
    <xsl:if test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and argument[3]='queen']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Queen.png"/> </xsl:if>
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

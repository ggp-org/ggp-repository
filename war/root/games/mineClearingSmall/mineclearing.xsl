<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
   <xsl:param name="xsize">
     <xsl:for-each select="state/fact[relation='cell']/argument[1]">
       <xsl:sort data-type="number" order="descending"/>
       <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
     </xsl:for-each>
   </xsl:param>
   <xsl:param name="ysize">
     <xsl:for-each select="state/fact[relation='cell']/argument[2]">
       <xsl:sort data-type="number" order="descending"/>
       <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
     </xsl:for-each>
   </xsl:param>
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        height: <xsl:value-of select="(2 * $height * 0.7) div (2 * $ysize + 1)"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        font-size: <xsl:value-of select="($width * 0.3) div $ysize"/>px;
        text-align: center;
        font-weight: bold;
        align: center;
      }
      table.board {
        background-color: #000000;
        width:  <xsl:value-of select="$width * 0.6"/>px;
        table-layout: fixed;
      }
      td.count {
        width:  50%;
        height: <xsl:value-of select="($height * 0.7) div (2 * $ysize + 1)"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        font-size: <xsl:value-of select="$width * 0.6 * 0.1"/>px;
        text-align: left;
        font-weight: bold;
        align: left;
      }
      table.counts {
        background-color: #000000;
        width:  <xsl:value-of select="$width * 0.6"/>px;
      }
    </style>

    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="$xsize"/>
      <xsl:with-param name="rows" select="$ysize"/>
    </xsl:call-template>	

    <!--  Add move and fire counts -->	
    <xsl:call-template name="counts"/>
  </div>
</xsl:template>

<xsl:template name="counts" match="state/fact">
<table class="counts">
<tr>
<td class="count">Fired:
    <xsl:value-of select="//fact[relation='fired']/argument[1]" />
</td>
<td class="count">Moved:
    <xsl:value-of select="//fact[relation='moved']/argument[1]" />
</td>
</tr>
</table>
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

  <xsl:if test="//fact[relation='ship' and argument[1]=$col and argument[2]=$row]">S:</xsl:if>

  <xsl:choose>
    <xsl:when test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='dot']">.</xsl:when>
    <xsl:when test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='star']">*</xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="//fact[relation='cell' and argument[1]=$col and argument[2]=$row]/argument[3]" />
    </xsl:otherwise>
  </xsl:choose>

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

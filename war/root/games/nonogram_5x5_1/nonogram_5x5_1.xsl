<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.166"/>px;
        height: <xsl:value-of select="$height * 0.166"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
      }
      td.colLabel {
        width:  <xsl:value-of select="$width * 0.166"/>px;
        height: <xsl:value-of select="$height * 0.166"/>px;
        text-align: center;
        vertical-align: bottom;
        font-size: 2em;
        font-family: Arial, Helvetica, sans-serif;
      }
      td.rowLabel {
        width:  <xsl:value-of select="$width * 0.166"/>px;
        height: <xsl:value-of select="$height * 0.166"/>px;
        text-align: right;
        vertical-align: middle;
        padding: 5px;
        font-size: 2em;
        font-family: Arial, Helvetica, sans-serif;
      }
      table.board {
        background-color: #CCCCCC;
        border-collapse: collapse;
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="6"/>
      <xsl:with-param name="rows" select="6"/>
    </xsl:call-template>		    
  </div>  
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 

  <td class="cell">
    <xsl:if test="//fact[relation='marked' and argument[1]+1=$col and argument[2]+1=$row]">
      <xsl:attribute name="style">background-color: #000000</xsl:attribute>
    </xsl:if>
  </td>  
</xsl:template>

<xsl:template name="board_row">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/>

<!-- ; Board and solution looks like:
;      11
;     111
;    31112
;  3  XXX
;  1 X
; 13 X XXX
; 11 X   X
;  3  XXX    -->

  <xsl:if test="$col = 1 and $row = 1">
    <td></td>
  </xsl:if>

  <xsl:if test="$col = 1">
    <xsl:if test="$row = 2"><td class="rowLabel">3</td></xsl:if>
    <xsl:if test="$row = 3"><td class="rowLabel">1</td></xsl:if>
    <xsl:if test="$row = 4"><td class="rowLabel">1 3</td></xsl:if>
    <xsl:if test="$row = 5"><td class="rowLabel">1 1</td></xsl:if>
    <xsl:if test="$row = 6"><td class="rowLabel">3</td></xsl:if>
  </xsl:if>
  
  <xsl:if test="$row = 1">
    <xsl:if test="$col = 2"><td class="colLabel">3</td></xsl:if>
    <xsl:if test="$col = 3"><td class="colLabel">1<br/>1</td></xsl:if>
    <xsl:if test="$col = 4"><td class="colLabel">1<br/>1<br/>1</td></xsl:if>
    <xsl:if test="$col = 5"><td class="colLabel">1<br/>1<br/>1</td></xsl:if>
    <xsl:if test="$col = 6"><td class="colLabel">2</td></xsl:if>
  </xsl:if>

  <xsl:if test="$col &gt; 1 and $row &gt; 1">
    <xsl:call-template name="cell">
      <xsl:with-param name="row" select="$row"/>
      <xsl:with-param name="col" select="$col"/>
    </xsl:call-template>
  </xsl:if>

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
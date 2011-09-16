<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.dot {
        width:  <xsl:value-of select="$width * 0.02"/>px;
        height: <xsl:value-of select="$height * 0.02"/>px;
        border: none;
        background-color: #000000;
      }
      td.hline {
        width:  <xsl:value-of select="$width * 0.14"/>px;
        height: <xsl:value-of select="$height * 0.02"/>px;
        border: none;
        background-color: #CCCCCC;
      }
      td.vline {
        width:  <xsl:value-of select="$width * 0.02"/>px;
        height: <xsl:value-of select="$height * 0.14"/>px;
        border: none;
        background-color: #CCCCCC;
      }
      td.box {
        width:  <xsl:value-of select="$width * 0.14"/>px;
        height: <xsl:value-of select="$height * 0.14"/>px;
        border: none;
        background-color: #CCCCCC;
      }
      table.board {
        background-color: #000000;
        border-collapse: collapse;
      }
      p {
        font-size: <xsl:value-of select="$height * 0.6 * 0.14"/>px;
        text-align: center;
        align: center;
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="7"/>
      <xsl:with-param name="rows" select="7"/>
    </xsl:call-template>		    
  </div>  
</xsl:template>

<xsl:template name="cell_upper" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 

  <td class="dot" />

  <xsl:if test="7 > $col">
  <td class="hline">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col"/>
    <xsl:value-of select="$row"/>
  </xsl:attribute>

  <xsl:if test="//fact[(relation='line') and argument[1]=$col and argument[2]=$row and argument[4]=$row]">
    <xsl:attribute name="style">
      background-color: #000000;
    </xsl:attribute>
  </xsl:if>
  </td>  
  </xsl:if>
   
</xsl:template>

<xsl:template name="cell_lower" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 

  <td class="vline">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col"/>
    <xsl:value-of select="$row"/>
  </xsl:attribute>

  <xsl:if test="//fact[(relation='line') and argument[1]=$col and argument[2]=$row and argument[3]=$col]">
    <xsl:attribute name="style">
      background-color: #000000;
    </xsl:attribute>
  </xsl:if>
  
  </td>
  <xsl:if test="$col &lt; 7">
  <td class="box">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col"/>
    <xsl:value-of select="$row"/>
  </xsl:attribute>

  <p><b>
  <xsl:if test="//fact[(relation='box') and argument[1]=$col and argument[2]=$row and argument[3]='x']">X</xsl:if>
  <xsl:if test="//fact[(relation='box') and argument[1]=$col and argument[2]=$row and argument[3]='o']"><font color="#999999">O</font></xsl:if>
  </b></p>
  
  </td>
  </xsl:if> 
</xsl:template>

<xsl:template name="board_row_upper">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/>
  
  <xsl:call-template name="cell_upper">
    <xsl:with-param name="row" select="$row"/>
    <xsl:with-param name="col" select="$col"/>
  </xsl:call-template>

  <xsl:if test="$col &lt; $cols">
    <xsl:call-template name="board_row_upper">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row"/>
      <xsl:with-param name="col" select="$col + 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="board_row_lower">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/>
  
  <xsl:call-template name="cell_lower">
    <xsl:with-param name="row" select="$row"/>
    <xsl:with-param name="col" select="$col"/>
  </xsl:call-template>

  <xsl:if test="$col &lt; $cols">
    <xsl:call-template name="board_row_lower">
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
  <xsl:call-template name="board_row_upper">
    <xsl:with-param name="cols" select="$cols"/>
    <xsl:with-param name="rows" select="$rows"/>
    <xsl:with-param name="row" select="$row"/>
  </xsl:call-template>
  </tr>

  <xsl:if test="$row &lt; 7">
  <tr>
  <xsl:call-template name="board_row_lower">
    <xsl:with-param name="cols" select="$cols"/>
    <xsl:with-param name="rows" select="$rows"/>
    <xsl:with-param name="row" select="$row"/>
  </xsl:call-template>
  </tr>
  </xsl:if>

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
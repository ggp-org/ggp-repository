<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.2"/>px;
        height: <xsl:value-of select="$height * 0.2"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        align: center;
        valign: middle;
        text-align: center;
        font-weight: bold;
        font-size: <xsl:value-of select="$width * 0.6 * 0.2"/>px;        
      }
      table.board {
        background-color: #000000;
      }
      div.small {
        font-size: <xsl:value-of select="$width * 0.6 * 0.1"/>px;
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="5"/>
      <xsl:with-param name="rows" select="5"/>
    </xsl:call-template>		    
  </div>  
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 
  <xsl:if test="$col=1 or $col=2 or $col=3 or $row=1 or $row=2 or $row=3 or $row=4">
  
  <td class="cell">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col"/>
    <xsl:value-of select="$row"/>
  </xsl:attribute>
  
  <xsl:if test="$row=1 or $row=5 or $col=1 or $col=5">
    <xsl:attribute name="style">background-color: #222</xsl:attribute>
  </xsl:if>
  <xsl:if test="$row=5 and $col=1">
    <xsl:attribute name="style">background-color: #777</xsl:attribute>
    <xsl:attribute name="colspan">2</xsl:attribute>
    <div class="small">x =
      <xsl:if test="//fact[relation='coins' and argument[1]='x' and argument[2]='0']">0</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='x' and argument[2]='1']">1</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='x' and argument[2]='2']">2</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='x' and argument[2]='3']">3</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='x' and argument[2]='4']">4</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='x' and argument[2]='5']">5</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='x' and argument[2]='6']">6</xsl:if>
      <xsl:if test="//fact[relation='tiebreaker' and argument[1]='x']">*</xsl:if>
    </div>
  </xsl:if>
  <xsl:if test="$row=5 and $col=3">
    <xsl:attribute name="style">background-color: #777</xsl:attribute>
    <xsl:attribute name="colspan">2</xsl:attribute>
    <div class="small">o =
      <xsl:if test="//fact[relation='coins' and argument[1]='o' and argument[2]='0']">0</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='o' and argument[2]='1']">1</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='o' and argument[2]='2']">2</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='o' and argument[2]='3']">3</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='o' and argument[2]='4']">4</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='o' and argument[2]='5']">5</xsl:if>
      <xsl:if test="//fact[relation='coins' and argument[1]='o' and argument[2]='6']">6</xsl:if>
      <xsl:if test="//fact[relation='tiebreaker' and argument[1]='o']">*</xsl:if>
    </div>
  </xsl:if>

  <xsl:if test="//fact[relation='cell' and (argument[1]+1)=$col and (argument[2]+1)=$row and argument[3]='x']">X</xsl:if>
  <xsl:if test="//fact[relation='cell' and (argument[1]+1)=$col and (argument[2]+1)=$row and argument[3]='o']"><font color="#999999">O</font></xsl:if>
  
  </td>  
  </xsl:if>  
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
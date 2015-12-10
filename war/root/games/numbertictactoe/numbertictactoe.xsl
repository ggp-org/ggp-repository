<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.333"/>px;
        height: <xsl:value-of select="$height * 0.333"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        font-size: <xsl:value-of select="$width * 0.6 * 0.333"/>px;
        text-align: center;
        font-weight: bold;
        align: center;        
      }
      table.board {
        background-color: #000000;
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="3"/>
      <xsl:with-param name="rows" select="3"/>
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

  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='1']"><font color="#3333CC">1</font></xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='2']"><font color="#33CC33">2</font></xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='3']"><font color="#3333CC">3</font></xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='4']"><font color="#33CC33">4</font></xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='5']"><font color="#3333CC">5</font></xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='6']"><font color="#33CC33">6</font></xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='7']"><font color="#3333CC">7</font></xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='8']"><font color="#33CC33">8</font></xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='9']"><font color="#3333CC">9</font></xsl:if>
  
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
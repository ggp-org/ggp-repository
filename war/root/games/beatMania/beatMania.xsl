<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.333"/>px;
        height: <xsl:value-of select="$height * 0.033 -2"/>px;
        border: 1px solid #000;
        background-color: #CCCCCC;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #000000;
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="3"/>
      <xsl:with-param name="rows" select="31"/>
    </xsl:call-template>		    
  </div>  
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 
  <xsl:if test="$row != 31 or $col = 1">
  
  <td class="cell">
    <xsl:attribute name="id">
      <xsl:value-of select="'cell_'"/>
      <xsl:value-of select="$col"/>
      <xsl:value-of select="$row"/>
    </xsl:attribute>

    <xsl:if test="//fact[relation='block' and argument[1]=$col and argument[2]=$row]">
      <xsl:if test="$row = 1">
        <xsl:attribute name="style">background-color: #F00</xsl:attribute>
      </xsl:if>
      <xsl:if test="$row != 1">
        <xsl:attribute name="style">background-color: #777</xsl:attribute>
      </xsl:if>  
    </xsl:if>
    <xsl:if test="$row = 31">
      <xsl:attribute name="colspan">3</xsl:attribute>
      
      <div style="text-align: center">
        So far
        <xsl:text> </xsl:text>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='0']">0</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='1']">1</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='2']">2</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='3']">3</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='4']">4</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='5']">5</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='6']">6</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='7']">7</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='8']">8</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='9']">9</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='10']">10</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='11']">11</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='12']">12</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='13']">13</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='14']">14</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='15']">15</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='16']">16</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='17']">17</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='18']">18</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='19']">19</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='20']">20</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='21']">21</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='22']">22</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='23']">23</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='24']">24</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='25']">25</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='26']">26</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='27']">27</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='28']">28</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='29']">29</xsl:if>
        <xsl:if test="//fact[relation='blocksCaught' and argument[1]='30']">30</xsl:if>
        <xsl:text> </xsl:text>
        pieces caught
      </div>
    </xsl:if>
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
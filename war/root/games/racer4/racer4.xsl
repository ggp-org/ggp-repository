<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.04"/>px;
        height: <xsl:value-of select="$height * 0.04"/>px;
        border: 0px solid #DDDDDD;
        background-color: #DDDDDD;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #DDDDDD;
      }
      div.race_track {
        position:relative;
      }
      div.racerCar {
        position:absolute;
        height:12px;
        width:12px;
      }
      div.carVelocity {
        position:absolute;
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="25"/>
      <xsl:with-param name="rows" select="25"/>
    </xsl:call-template>

  </div>  
</xsl:template>

<xsl:template name="constant_to_number">
	<xsl:param name="constant"/>
	<xsl:value-of select="number(translate(translate($constant, 'n', '-'), 'p', ''))"/>
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 

  <xsl:param name="row_adj" select="$row - 5"/>
  <xsl:param name="col_adj" select="$col - 1"/> 

  <xsl:param name="col_char" select="translate(translate(translate(translate(translate(translate(translate(translate(string($col),'1','a'),'2','b'),'3','c'),'4','d'),'5','e'),'6','f'),'7','g'),'8','h')"/>
  <xsl:param name="row_str" select="replace(concat('p', string($row_adj)), 'p-', 'n')"/>
  <xsl:param name="col_str" select="concat('p', $col_adj)"/>

  <td class="cell">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col_char"/>
    <xsl:value-of select="$row"/>
  </xsl:attribute>
  
  <xsl:choose>
				<xsl:when test="
							($col=1 and $row=9) or
							($col=1 and $row=10) or
							($col=1 and $row=11) or
							($col=1 and $row=12) or
							($col=2 and $row=5) or
							($col=2 and $row=6) or
							($col=2 and $row=7) or
							($col=2 and $row=8) or
							($col=2 and $row=9) or
							($col=2 and $row=10) or
							($col=2 and $row=11) or
							($col=2 and $row=12) or
							($col=2 and $row=13) or
							($col=3 and $row=5) or
							($col=3 and $row=6) or
							($col=3 and $row=7) or
							($col=3 and $row=8) or
							($col=3 and $row=9) or
							($col=3 and $row=10) or
							($col=3 and $row=11) or
							($col=3 and $row=12) or
							($col=3 and $row=13) or
							($col=3 and $row=14) or
							($col=3 and $row=15) or
							($col=4 and $row=5) or
							($col=4 and $row=6) or
							($col=4 and $row=7) or
							($col=4 and $row=8) or
							($col=4 and $row=9) or
							($col=4 and $row=10) or
							($col=4 and $row=11) or
							($col=4 and $row=12) or
							($col=4 and $row=13) or
							($col=4 and $row=14) or
							($col=4 and $row=15) or
							($col=4 and $row=16) or
							($col=4 and $row=17) or
							($col=5 and $row=5) or
							($col=5 and $row=6) or
							($col=5 and $row=7) or
							($col=5 and $row=8) or
							($col=5 and $row=9) or
							($col=5 and $row=10) or
							($col=5 and $row=11) or
							($col=5 and $row=12) or
							($col=5 and $row=13) or
							($col=5 and $row=14) or
							($col=5 and $row=15) or
							($col=5 and $row=16) or
							($col=5 and $row=17) or
							($col=5 and $row=18) or
							($col=6 and $row=11) or
							($col=6 and $row=12) or
							($col=6 and $row=13) or
							($col=6 and $row=14) or
							($col=6 and $row=15) or
							($col=6 and $row=16) or
							($col=6 and $row=17) or
							($col=6 and $row=18) or
							($col=6 and $row=19) or
							($col=7 and $row=12) or
							($col=7 and $row=13) or
							($col=7 and $row=14) or
							($col=7 and $row=15) or
							($col=7 and $row=16) or
							($col=7 and $row=17) or
							($col=7 and $row=18) or
							($col=7 and $row=19) or
							($col=7 and $row=20) or
							($col=8 and $row=13) or
							($col=8 and $row=14) or
							($col=8 and $row=15) or
							($col=8 and $row=16) or
							($col=8 and $row=17) or
							($col=8 and $row=18) or
							($col=8 and $row=19) or
							($col=8 and $row=20) or
							($col=8 and $row=21) or
							($col=9 and $row=15) or
							($col=9 and $row=16) or
							($col=9 and $row=17) or
							($col=9 and $row=18) or
							($col=9 and $row=19) or
							($col=9 and $row=20) or
							($col=9 and $row=21) or
							($col=9 and $row=22) or
							($col=10 and $row=15) or
							($col=10 and $row=16) or
							($col=10 and $row=17) or
							($col=10 and $row=18) or
							($col=10 and $row=19) or
							($col=10 and $row=20) or
							($col=10 and $row=21) or
							($col=10 and $row=22) or
							($col=11 and $row=12) or
							($col=11 and $row=13) or
							($col=11 and $row=14) or
							($col=11 and $row=15) or
							($col=11 and $row=16) or
							($col=11 and $row=17) or
							($col=11 and $row=18) or
							($col=11 and $row=19) or
							($col=11 and $row=20) or
							($col=11 and $row=21) or
							($col=12 and $row=12) or
							($col=12 and $row=13) or
							($col=12 and $row=14) or
							($col=12 and $row=15) or
							($col=12 and $row=16) or
							($col=12 and $row=17) or
							($col=12 and $row=18) or
							($col=12 and $row=19) or
							($col=12 and $row=20) or
							($col=13 and $row=11) or
							($col=13 and $row=12) or
							($col=13 and $row=13) or
							($col=13 and $row=14) or
							($col=13 and $row=15) or
							($col=13 and $row=16) or
							($col=14 and $row=11) or
							($col=14 and $row=12) or
							($col=14 and $row=13) or
							($col=14 and $row=14) or
							($col=14 and $row=15) or
							($col=15 and $row=11) or
							($col=15 and $row=12) or
							($col=15 and $row=13) or
							($col=15 and $row=14) or
							($col=15 and $row=15) or
							($col=16 and $row=10) or
							($col=16 and $row=11) or
							($col=16 and $row=12) or
							($col=16 and $row=13) or
							($col=16 and $row=14) or
							($col=16 and $row=15) or
							($col=17 and $row=10) or
							($col=17 and $row=11) or
							($col=17 and $row=12) or
							($col=17 and $row=13) or
							($col=17 and $row=14) or
							($col=17 and $row=15) or
							($col=18 and $row=11) or
							($col=18 and $row=12) or
							($col=18 and $row=13) or
							($col=18 and $row=14) or
							($col=18 and $row=15) or
							($col=18 and $row=16) or
							($col=19 and $row=12) or
							($col=19 and $row=13) or
							($col=19 and $row=14) or
							($col=19 and $row=15) or
							($col=19 and $row=16) or
							($col=20 and $row=13) or
							($col=20 and $row=14) or
							($col=20 and $row=15) or
							($col=20 and $row=16) or
							($col=20 and $row=17) or
							($col=21 and $row=13) or
							($col=21 and $row=14) or
							($col=21 and $row=15) or
							($col=21 and $row=16) or
							($col=21 and $row=17) or
							($col=21 and $row=18) or
							($col=22 and $row=5) or
							($col=22 and $row=6) or
							($col=22 and $row=7) or
							($col=22 and $row=8) or
							($col=22 and $row=9) or
							($col=22 and $row=10) or
							($col=22 and $row=11) or
							($col=22 and $row=12) or
							($col=22 and $row=13) or
							($col=22 and $row=14) or
							($col=22 and $row=15) or
							($col=22 and $row=16) or
							($col=22 and $row=17) or
							($col=22 and $row=18) or
							($col=23 and $row=5) or
							($col=23 and $row=6) or
							($col=23 and $row=7) or
							($col=23 and $row=8) or
							($col=23 and $row=9) or
							($col=23 and $row=10) or
							($col=23 and $row=11) or
							($col=23 and $row=12) or
							($col=23 and $row=13) or
							($col=23 and $row=14) or
							($col=23 and $row=15) or
							($col=23 and $row=16) or
							($col=23 and $row=17) or
							($col=24 and $row=5) or
							($col=24 and $row=6) or
							($col=24 and $row=7) or
							($col=24 and $row=8) or
							($col=24 and $row=9) or
							($col=24 and $row=10) or
							($col=24 and $row=11) or
							($col=24 and $row=12) or
							($col=24 and $row=13) or
							($col=24 and $row=14) or
							($col=24 and $row=15) or
							($col=24 and $row=16) or
							($col=25 and $row=5) or
							($col=25 and $row=6) or
							($col=25 and $row=7) or
							($col=25 and $row=8) or
							($col=25 and $row=9) or
							($col=25 and $row=10) or
							($col=25 and $row=11) or
							($col=25 and $row=12) or
							($col=25 and $row=13) or
							($col=25 and $row=14) or
							($col=25 and $row=15)">
					<xsl:attribute name="style">
						background-color: #444444;
					</xsl:attribute>
				</xsl:when>
<xsl:when test="
						($col=22 and $row=1) or
						($col=22 and $row=2) or
						($col=22 and $row=3) or
						($col=22 and $row=4) or
						($col=23 and $row=1) or
						($col=23 and $row=2) or
						($col=23 and $row=3) or
						($col=23 and $row=4) or
						($col=24 and $row=1) or
						($col=24 and $row=2) or
						($col=24 and $row=3) or
						($col=24 and $row=4) or
						($col=25 and $row=1) or
						($col=25 and $row=2) or
						($col=25 and $row=3) or
						($col=25 and $row=4)
						">
					<xsl:attribute name="style">
						background-color: #999999;
					</xsl:attribute>
				</xsl:when>
	</xsl:choose>
	
	<xsl:if test="//fact[relation='posx' and argument[1]='red' and argument[2]=$col_str] and
	              //fact[relation='posy' and argument[1]='red' and argument[2]=$row_str]"><div style="position: relative; width: 100%; height: 100%"><div style="background-color: red; height: 50%; width: 50%; position: absolute; top: 0%; left: 0%; z-index: 1"></div></div></xsl:if>
	<xsl:if test="//fact[relation='posx' and argument[1]='blue' and argument[2]=$col_str] and
	              //fact[relation='posy' and argument[1]='blue' and argument[2]=$row_str]"><div style="position: relative; width: 100%; height: 100%"><div style="background-color: blue; height: 50%; width: 50%; position: absolute; top: 50%; left: 0%; z-index: 1"></div></div></xsl:if>
	<xsl:if test="//fact[relation='posx' and argument[1]='green' and argument[2]=$col_str] and
	              //fact[relation='posy' and argument[1]='green' and argument[2]=$row_str]"><div style="position: relative; width: 100%; height: 100%"><div style="background-color: green; height: 50%; width: 50%; position: absolute; top: 0%; left: 50%; z-index: 1"></div></div></xsl:if>
	<xsl:if test="//fact[relation='posx' and argument[1]='yellow' and argument[2]=$col_str] and
	              //fact[relation='posy' and argument[1]='yellow' and argument[2]=$row_str]"><div style="position: relative; width: 100%; height: 100%"><div style="background-color: yellow; height: 50%; width: 50%; position: absolute; top: 50%; left: 50%; z-index: 1"></div></div></xsl:if>
	
  <center>
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.125"/>px;
        height: <xsl:value-of select="$height * 0.125"/>px;
        border: 0px;
        background-color: #DDDDDD;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #000000;
        border:0px;
      }
      img.piece {
        width: <xsl:value-of select="$width * 0.125"/>px;
        height: <xsl:value-of select="$height * 0.125"/>px;        
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="8"/>
      <xsl:with-param name="rows" select="8"/>
    </xsl:call-template>		    
  </div>  
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 
  
  <td class="cell">
<!--  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col"/>
    <xsl:value-of select="$row"/>
  </xsl:attribute> -->
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='blue']">
    <xsl:attribute name="style">background-color: #6592cc</xsl:attribute>  
  </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='red']">
    <xsl:attribute name="style">background-color: #ee8181</xsl:attribute>  
  </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='green']">
    <xsl:attribute name="style">background-color: #6edb56</xsl:attribute>  
  </xsl:if>
  <xsl:if test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='yellow']">
    <xsl:attribute name="style">background-color: #f5ee86</xsl:attribute>  
  </xsl:if>

  <center>
  <xsl:if test="//fact[relation='at' and argument[2]=$col and argument[3]=$row and argument[1]='bluebrush']"> <img class="piece" src="&ROOT;/resources/images/battlebrushes/bluebrush.png"/> </xsl:if>
  <xsl:if test="//fact[relation='at' and argument[2]=$col and argument[3]=$row and argument[1]='redbrush']"> <img class="piece" src="&ROOT;/resources/images/battlebrushes/redbrush.png"/> </xsl:if>  
  <xsl:if test="//fact[relation='at' and argument[2]=$col and argument[3]=$row and argument[1]='greenbrush']"> <img class="piece" src="&ROOT;/resources/images/battlebrushes/greenbrush.png"/> </xsl:if>  
  <xsl:if test="//fact[relation='at' and argument[2]=$col and argument[3]=$row and argument[1]='yellowbrush']"> <img class="piece" src="&ROOT;/resources/images/battlebrushes/yellowbrush.png"/> </xsl:if>  
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
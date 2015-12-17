<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      div#board {
        width:  <xsl:value-of select="$width"/>px;
        height: <xsl:value-of select="$height"/>px;        
      }
      img.board {
        width:  <xsl:value-of select="$width"/>px;
        height: <xsl:value-of select="$height"/>px;      
      }
      td.cell {
        width:  <xsl:value-of select="$width * 0.125"/>px;
        height: <xsl:value-of select="$height * 0.125"/>px;
        border: 2px solid #000;
        border-style: hidden;
        moz-border-radius: 45px;
        border-radius: 45px;
        background-color: transparent;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #000000;
      }
      img.piece {
        width: <xsl:value-of select="$width * 0.125 * 0.9"/>px;
        height: <xsl:value-of select="$height * 0.125 * 0.9"/>px;        
      }
    </style> 
    
    <div id="board" style="position:relative">
      <!-- Draw Background -->
      <img class="board" src="&ROOT;/resources/images/qyshinsu/board.png"/>
			
       <xsl:call-template name="cells">
        <xsl:with-param name="max_index" select="12"/>
      </xsl:call-template>
    </div>
  </div>  
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="index" select="1"/> 

  <xsl:variable name="xfactor">
    <xsl:choose>
      <xsl:when test="$index=1">  0.6800 </xsl:when>
      <xsl:when test="$index=2">  0.7725 </xsl:when>
      <xsl:when test="$index=3">  0.7850 </xsl:when>
      <xsl:when test="$index=4">  0.7200 </xsl:when>
      <xsl:when test="$index=5">  0.5925 </xsl:when>
      <xsl:when test="$index=6">  0.4325 </xsl:when>
      <xsl:when test="$index=7">  0.2925 </xsl:when>
      <xsl:when test="$index=8">  0.2025 </xsl:when>
      <xsl:when test="$index=9">  0.1900 </xsl:when>
      <xsl:when test="$index=10"> 0.2600 </xsl:when>
      <xsl:when test="$index=11"> 0.3825 </xsl:when>
      <xsl:when test="$index=12"> 0.5425 </xsl:when>
    </xsl:choose>
  </xsl:variable>


  <xsl:variable name="yfactor">
    <xsl:choose>
      <xsl:when test="$index=1">  0.2525 </xsl:when>
      <xsl:when test="$index=2">  0.3775 </xsl:when>
      <xsl:when test="$index=3">  0.5300 </xsl:when>
      <xsl:when test="$index=4">  0.6775 </xsl:when>
      <xsl:when test="$index=5">  0.7675 </xsl:when>
      <xsl:when test="$index=6">  0.7775 </xsl:when>
      <xsl:when test="$index=7">  0.7075 </xsl:when>
      <xsl:when test="$index=8">  0.5850 </xsl:when>
      <xsl:when test="$index=9">  0.4300 </xsl:when>
      <xsl:when test="$index=10"> 0.2900 </xsl:when>
      <xsl:when test="$index=11"> 0.1975 </xsl:when>
      <xsl:when test="$index=12"> 0.1875 </xsl:when>
    </xsl:choose>
  </xsl:variable>
  
  <table>
  <xsl:attribute name="style">
    <xsl:value-of select="concat('position:absolute; left: ',$width * ($xfactor - 0.0625),'px; top: ',$height * ($yfactor - 0.05),'px')"/>		
  </xsl:attribute>
  
  <tr>
  <td class="cell">
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$index"/>
  </xsl:attribute>
    
  <xsl:variable name="value" select="//fact[relation='position' and argument[1]=$index]/argument[2]"/>
  <xsl:variable name="owner" select="//fact[relation='owner' and argument[1]=$index]/argument[2]"/>
  
  <center>
    <xsl:if test="$value!='empty'">  
      <img class="piece">
      <xsl:attribute name="src">
        <xsl:if test="$owner='red'"><xsl:value-of select="concat('&ROOT;/resources/images/qyshinsu/R',$value,'.png')"/></xsl:if>
        <xsl:if test="$owner='black'"><xsl:value-of select="concat('&ROOT;/resources/images/qyshinsu/B',$value,'.png')"/></xsl:if>
      </xsl:attribute>
      </img>
    </xsl:if>
  </center>  
  
  </td>
  </tr>
  </table>
</xsl:template>

<xsl:template name="cells">
  <xsl:param name="max_index" select="1"/>
  <xsl:param name="index" select="1"/>
  
  <xsl:call-template name="cell">
    <xsl:with-param name="index" select="$index"/>
  </xsl:call-template>

  <xsl:if test="$index &lt; $max_index">
    <xsl:call-template name="cells">
      <xsl:with-param name="max_index" select="$max_index"/>
      <xsl:with-param name="index" select="$index + 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="15"/>
      <xsl:with-param name="rows" select="15"/>
    </xsl:call-template>

    <xsl:for-each select="//fact[relation='isColor' and argument[1]='player1']">
      <xsl:variable name="color" select="argument[2]"/>
      <p>Player 1 is <xsl:value-of select="$color"/>.</p>
    </xsl:for-each>
  </div>  
</xsl:template>

<xsl:template name="horizontal_lines">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="row" select="1"/>
  
  <xsl:variable name="xoff" select="10 + (($width - 20) * 0.5 div ($cols))" />
  <xsl:variable name="ypos" select="10 + (($height - 20) * ($row - 0.5) div ($rows))" />

  <line stroke-width="2" stroke="black">
    <xsl:attribute name="x1"><xsl:value-of select="$xoff"/></xsl:attribute>
    <xsl:attribute name="x2"><xsl:value-of select="$width - $xoff"/></xsl:attribute>
    <xsl:attribute name="y1"><xsl:value-of select="$ypos"/></xsl:attribute>
    <xsl:attribute name="y2"><xsl:value-of select="$ypos"/></xsl:attribute>
  </line>
  
  <xsl:if test="$row &lt; $rows">
    <xsl:call-template name="horizontal_lines">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row + 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>


<xsl:template name="vertical_lines">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="col" select="1"/>
  
  <xsl:variable name="yoff" select="10 + (($height - 20) * 0.5 div ($rows))" />
  <xsl:variable name="xpos" select="10 + (($width - 20) * ($col - 0.5) div ($cols))" />
  
  <line stroke-width="2" stroke="black">
    <xsl:attribute name="x1"><xsl:value-of select="$xpos"/></xsl:attribute>
    <xsl:attribute name="x2"><xsl:value-of select="$xpos"/></xsl:attribute>
    <xsl:attribute name="y1"><xsl:value-of select="$yoff"/></xsl:attribute>
    <xsl:attribute name="y2"><xsl:value-of select="$height - $yoff"/></xsl:attribute>
  </line>
  
  <xsl:if test="$col &lt; $cols">
    <xsl:call-template name="vertical_lines">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="col" select="$col + 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="board">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>

  <svg>
    <xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
    <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
    
    <defs>
      <radialGradient id="grad_white" cx="50%" cy="25%" r="50%" fx="40%" fy="30%">
        <stop offset="0%" style="stop-color:#ffffff" />
        <stop offset="100%" style="stop-color:#d0d0d0" />
      </radialGradient>
      <radialGradient id="grad_black" cx="50%" cy="25%" r="50%" fx="40%" fy="30%">
        <stop offset="0%" style="stop-color:#d0d0d0" />
        <stop offset="100%" style="stop-color:#000000" />
      </radialGradient>
    </defs>
    
    <rect x="0" y="0" fill="#dcb35c">
      <xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
      <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
    </rect>

    <xsl:call-template name="horizontal_lines">
      <xsl:with-param name="cols" select="$cols" />
      <xsl:with-param name="rows" select="$rows" />
    </xsl:call-template>

    <xsl:call-template name="vertical_lines">
      <xsl:with-param name="cols" select="$cols" />
      <xsl:with-param name="rows" select="$rows" />
    </xsl:call-template>

    <xsl:for-each select="//fact[relation='cell']">
      <xsl:variable name="row" select="argument[1]"/>
      <xsl:variable name="col" select="argument[2]"/>
      <!-- <xsl:variable name="xpos" select="10 + (($width - 20) * ($col + 1) div ($cols + 2))" /> -->
      <xsl:variable name="xpos" select="10 + (($width - 20) * ($col - 0.5) div ($cols))" />
      <!-- <xsl:variable name="ypos" select="10 + (($height - 20) * ($row + 1) div ($rows + 2))" /> -->
      <xsl:variable name="ypos" select="10 + (($height - 20) * ($row - 0.5) div ($rows))" />
      <!-- <xsl:variable name="radius" select="((($width - 20) div ($cols + 2)) div 2) - 2" /> -->
      <xsl:variable name="radius" select="((($width - 20) div ($cols)) div 2) - 2" />

      <circle r="10">
        <xsl:attribute name="cx"><xsl:value-of select="$xpos"/></xsl:attribute>
        <xsl:attribute name="cy"><xsl:value-of select="$ypos"/></xsl:attribute>
        <xsl:attribute name="r"><xsl:value-of select="$radius"/></xsl:attribute>
        <xsl:attribute name="fill">url(#grad_<xsl:value-of select="argument[3]"/>)</xsl:attribute>
      </circle>
    </xsl:for-each>

  </svg>
</xsl:template>

</xsl:stylesheet>
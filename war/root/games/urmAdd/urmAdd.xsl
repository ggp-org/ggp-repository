<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <table style="background-color: black; color: lime; font-family: 'Lucida Console', monospace; font-size: 16pt;">
    <xsl:call-template name="row">
      <xsl:with-param name="rows" select="10"/>
      <xsl:with-param name="row" select="1"/>
    </xsl:call-template>
    </table>
  </div>  
</xsl:template>

<xsl:template name="row">
  <xsl:param name="rows" select="1" />
  <xsl:param name="row" select="1" />
  <tr>
    <td style="min-width: 1em">
      <xsl:if test="//fact[relation='lineToAdd' and argument[1]=$row] or //fact[relation='pc' and argument[1]=$row]">
        &gt;
      </xsl:if>
    </td>
    <td style="text-align: right; padding-right: 10px">
      <xsl:value-of select="$row"/>
    </td>
    <td style="min-width: 20em">
      <xsl:for-each select="//fact[relation='line' and argument[1]=$row]">
        <xsl:variable name="line" select="argument[2]"/>
        <xsl:choose>
        <!-- The first four should work in the case of GGP-Base, the last in the case of Tiltyard JS -->
          <xsl:when test="$line[relation='beq']">
            jump-if-equal
            <xsl:value-of select="$line/argument[1]"/><xsl:value-of select="' '"/> 
            <xsl:value-of select="$line/argument[2]"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$line/argument[3]"/>
          </xsl:when>
          <xsl:when test="$line[relation='zero']">
            zero
            <xsl:value-of select="$line/argument[1]"/>
          </xsl:when>
          <xsl:when test="$line[relation='incr']">
            increment
            <xsl:value-of select="$line/argument[1]"/>
          </xsl:when>
          <xsl:when test="$line[relation='move']">
            move
            <xsl:value-of select="$line/argument[1]"/><xsl:value-of select="' '"/>
            <xsl:value-of select="$line/argument[2]"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$line"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </td>
    <td style="padding-right: 10px">
      <xsl:if test="//fact[relation='rv' and argument[1]=$row]">
        R<xsl:value-of select="$row" />
      </xsl:if>
    </td>
    <td>
      <xsl:for-each select="//fact[relation='rv' and argument[1]=$row]">
        <xsl:value-of select="argument[2]" />
      </xsl:for-each>
    </td>
  </tr>

  <xsl:if test="$row &lt; $rows">
    <xsl:call-template name="row">
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row + 1"/>
    </xsl:call-template>
  </xsl:if>
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



</xsl:stylesheet>
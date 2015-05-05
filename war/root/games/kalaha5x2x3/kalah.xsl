<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      table.board
      {
        border: 1px solid black;
      }

      table.board td
      {
        text-align: center;
        border: 1px solid black;
        overflow: hidden;
        width:  <xsl:value-of select="$width * 0.125"/>px;
        height: <xsl:value-of select="$height * 0.4"/>px;
      }
    </style>

    <table class="board">
    <tbody>
      <tr>
        <td rowspan="2"><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='pwinnorth']/argument[2], 2)"/></td>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p10']/argument[2], 2)"/></td>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p9' ]/argument[2], 2)"/></td>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p8' ]/argument[2], 2)"/></td>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p7' ]/argument[2], 2)"/></td>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p6' ]/argument[2], 2)"/></td>
        <td rowspan="2"><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='pwinsouth']/argument[2], 2)"/></td>
      </tr>
      <tr>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p1' ]/argument[2], 2)"/></td>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p2' ]/argument[2], 2)"/></td>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p3' ]/argument[2], 2)"/></td>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p4' ]/argument[2], 2)"/></td>
        <td><xsl:value-of select="substring(//fact[relation='pit' and argument[1]='p5' ]/argument[2], 2)"/></td>
      </tr>
    </tbody>
    </table>

    <p align="left">It is <xsl:value-of select="//fact[relation='control']/argument[1]"/>'s turn.  They have <xsl:value-of select="substring(//fact[relation='hand' and argument[1]=//fact[relation='control']/argument[1]]/argument[2], 2)"/> seeds in hand.</p>
  </div>
</xsl:template>

</xsl:stylesheet>

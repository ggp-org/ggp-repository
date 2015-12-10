<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      table.board
      {
        background-color: #000000;
      }

      table.board td
      {
        width:  <xsl:value-of select="$width * 0.08"/>px;
        height: <xsl:value-of select="$height * 0.08"/>px;
        border: 2px solid #000;
      }

      table.board td.unvisited
      {
        background-color: #ffffff;
      }

      table.board td.visited
      {
        background-color: #000000;
      }

      table.board td.red
      {
        background-color: #ff0000;
      }

      table.board td.blue
      {
        background-color: #0000ff;
      }

    </style>

    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="12"/>
      <xsl:with-param name="rows" select="12"/>
    </xsl:call-template>		
  </div>
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/>

  <td>
  <xsl:attribute name="id">
    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col"/>
    <xsl:value-of select="'_'"/>
    <xsl:value-of select="$row"/>
  </xsl:attribute>

  <xsl:attribute name="class">
    <xsl:choose>
      <xsl:when test="//fact[relation='cell' and argument[1]=$col and argument[2]=$row and argument[3]='v']">
        <xsl:value-of select="'visited'"/>
      </xsl:when>
      <xsl:when test="//fact[relation='position' and argument[1]='red' and argument[2]=$col and argument[3]=$row]">
        <xsl:value-of select="'red'"/>
      </xsl:when>
      <xsl:when test="//fact[relation='position' and argument[1]='blue' and argument[2]=$col and argument[3]=$row]">
        <xsl:value-of select="'blue'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'unvisited'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>

  </td>
</xsl:template>

<xsl:template name="board_row">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="0"/>

  <xsl:call-template name="cell">
    <xsl:with-param name="row" select="11 - $row"/>
    <xsl:with-param name="col" select="$col"/>
  </xsl:call-template>

  <xsl:if test="$col &lt; $cols - 1">
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
  <xsl:param name="row" select="0"/>

  <tr>
  <xsl:call-template name="board_row">
    <xsl:with-param name="cols" select="$cols"/>
    <xsl:with-param name="rows" select="$rows"/>
    <xsl:with-param name="row" select="$row"/>
  </xsl:call-template>
  </tr>

  <xsl:if test="$row &lt; $rows - 1">
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="width" select="400"/>
  <xsl:param name="height" select="400"/>

  <xsl:template name="main" match="/">
     <xsl:param name="boardsize">
       <xsl:for-each select="state/fact[relation='cell']/argument[1]">
         <xsl:sort data-type="number" order="descending"/>
         <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
       </xsl:for-each>
     </xsl:param>
    <div>
      <!-- Set Style -->
      <style type="text/css" media="all">
        .square
        {
          float:          left;
          position:       relative;
          width:          <xsl:value-of select="90 div $boardsize" />vmin;
          padding-bottom: <xsl:value-of select="90 div $boardsize" />vmin;
          border:         2px solid black;
        }

        .content
        {
          position:       absolute;
          height:         56%; /* = 100% - 2 * 22% padding */
          width:          90%; /* = 100% - 2 *  5% padding */
          padding:        22% 5%;
          text-align:     center;
          font-size:      <xsl:value-of select="45 div ($boardsize + 1)" />vmin;
        }

        .row
        {
          clear: both;
        }

        .this_gt_right:after
        {
          position:       absolute;
          content:        " ";
          transform:      rotate(45deg);
          width:          30%;
          height:         30%;
          left:           85%;
          left:           calc(85% + 1px);
          top:            35%;
          border-top:     2px solid black;
          border-right:   2px solid black;
          z-index:        1;
          background:     white;
        }

        .this_lt_right:after
        {
          position:       absolute;
          content:        " ";
          transform:      rotate(45deg);
          width:          30%;
          height:         30%;
          left:           85%;
          left:           calc(85% + 2px);
          top:            35%;
          border-bottom:  2px solid black;
          border-left:    2px solid black;
          z-index:        1;
          background:     white;
        }

        .this_gt_below:before
        {
          position:       absolute;
          content:        " ";
          transform:      rotate(45deg);
          width:          30%;
          height:         30%;
          left:           35%;
          top:            85%;
          top:            calc(85% + 1px);
          border-bottom:  2px solid black;
          border-right:   2px solid black;
          z-index:        1;
          background:     white;
        }

        .this_lt_below:before
        {
          position:       absolute;
          content:        " ";
          transform:      rotate(45deg);
          width:          30%;
          height:         30%;
          left:           35%;
          top:            85%;
          top:            calc(85% + 2px);
          border-top:     2px solid black;
          border-left:    2px solid black;
          z-index:        1;
          background:     white;
        }
      </style>

      <!-- Draw Board -->
      <xsl:call-template name="board">
        <xsl:with-param name="cols" select="$boardsize"/>
        <xsl:with-param name="rows" select="$boardsize"/>
      </xsl:call-template>	
    </div>
  </xsl:template>

  <xsl:template name="cell" match="state/fact">
    <xsl:param name="row" select="1"/>
    <xsl:param name="col" select="1"/>

    <div>
      <xsl:attribute name="class">
        <xsl:text>square</xsl:text>
        <xsl:if test="//fact[relation='cell_gt_right' and argument[1]=$row and argument[2]=$col]"> this_gt_right</xsl:if>
        <xsl:if test="//fact[relation='cell_lt_right' and argument[1]=$row and argument[2]=$col]"> this_lt_right</xsl:if>
        <xsl:if test="//fact[relation='cell_gt_below' and argument[1]=$row and argument[2]=$col]"> this_gt_below</xsl:if>
        <xsl:if test="//fact[relation='cell_lt_below' and argument[1]=$row and argument[2]=$col]"> this_lt_below</xsl:if>
      </xsl:attribute>

      <div class="content">
        <xsl:choose>
          <xsl:when test="//fact[relation='cell' and argument[1]=$row and argument[2]=$col and argument[3]='blank']">
            <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="//fact[relation='cell' and argument[1]=$row and argument[2]=$col]/argument[3]"/>
          </xsl:otherwise>
        </xsl:choose>
      </div>
    </div>
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

    <div class="row">
    <xsl:call-template name="board_row">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row"/>
    </xsl:call-template>
    </div>

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

    <div class="board">
    <xsl:call-template name="board_rows">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
    </xsl:call-template>
    </div>
  </xsl:template>

</xsl:stylesheet>

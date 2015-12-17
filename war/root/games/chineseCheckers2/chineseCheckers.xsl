<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
					#main
					{
						position:   relative;
						width:  <xsl:value-of select="$width"/>px;
						height: <xsl:value-of select="$height"/>px;
						padding:    10px;
						border:     2px solid #b17735;
						background: transparent url(&ROOT;/resources/images/chineseCheckers/ccboard.png) repeat top left; 
					}		
					div.teal
					{
						width: <xsl:value-of select="$width * 0.142857143"/>px;
						height: <xsl:value-of select="$height * 0.113"/>px;
						background: #00ffff;
					}
					div.red
					{
						width: <xsl:value-of select="$width * 0.142857143"/>px;
						height: <xsl:value-of select="$height * 0.113"/>px;
						background: #ff0000;
					}
					div.blue
					{
						width: <xsl:value-of select="$width * 0.142857143"/>px;
						height: <xsl:value-of select="$height * 0.113"/>px;
						background: #0000ff;
					}
					div.green
					{
						width: <xsl:value-of select="$width * 0.142857143"/>px;
						height: <xsl:value-of select="$height * 0.113"/>px;
						background: #00ff00;
					}
					div.yellow
					{
						width: <xsl:value-of select="$width * 0.142857143"/>px;
						height: <xsl:value-of select="$height * 0.113"/>px;
						background: #ffff00;
					}
					div.magenta
					{
						width: <xsl:value-of select="$width * 0.142857143"/>px;
						height: <xsl:value-of select="$height * 0.113"/>px;
						background: #ff00ff;
					}
					div.blank
					{
						width: <xsl:value-of select="$width * 0.142857143"/>px;
						height: <xsl:value-of select="$height * 0.113"/>px;
						background: #cca083;
					}
					#a1,#i1
					{
						margin-left: <xsl:value-of select="$width * 0.428571429"/>px;
						clear: left;
					}
					#b1,#h1
					{
						margin-left: <xsl:value-of select="$width * 0.357142857"/>px;
						float: left;
						clear: left;
					}
					#c1,#g1
					{
						margin-left: 0px;
						clear: left;
						float: left;
					}
					#d1,#f1
					{
						margin-left: <xsl:value-of select="$width * 0.0714285714"/>px;
						clear: left;
						float: left;
					}
					#e1
					{
						margin-left: <xsl:value-of select="$width * 0.142857143"/>px;
						clear: left;
						float: left;
					}
      img.piece {
      	width: <xsl:value-of select="$width * 0.142857143"/>px;
      	height: <xsl:value-of select="$height * 0.113"/>px;     
      }					
    </style>
    
    <div id="main">
    	<xsl:call-template name="cell"><xsl:with-param name="loc">a1</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">b1</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">b2</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">c1</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">c2</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">c3</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">c4</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">c5</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">c6</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">c7</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">d1</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">d2</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">d3</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">d4</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">d5</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">d6</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">e1</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">e2</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">e3</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">e4</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">e5</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">f1</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">f2</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">f3</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">f4</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">f5</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">f6</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">g1</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">g2</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">g3</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">g4</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">g5</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">g6</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">g7</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">h1</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">h2</xsl:with-param></xsl:call-template>
    	<xsl:call-template name="cell"><xsl:with-param name="loc">i1</xsl:with-param></xsl:call-template>
    </div> 

  </div>  
</xsl:template>

<xsl:template name="cell">
  <xsl:param name="loc" select="a1"/>

  <div style="float: left">
	<xsl:attribute name="id"><xsl:value-of select="$loc"/></xsl:attribute>
	  <xsl:for-each select="//fact[relation='cell' and argument[1]=$loc]">
			<xsl:choose>
			    <xsl:when test="argument[2]='yellow'">
				<xsl:attribute name="class">yellow</xsl:attribute>
				<img class="piece" src="&ROOT;/resources/images/chineseCheckers/boardpit.png"/>
			</xsl:when>
		    <xsl:when test="argument[2]='magenta'">
				<xsl:attribute name="class">magenta</xsl:attribute>
				<img class="piece" src="&ROOT;/resources/images/chineseCheckers/boardpit.png"/>
		    </xsl:when>
	 	    <xsl:when test="argument[2]='teal'">
				<xsl:attribute name="class">teal</xsl:attribute>
				<img class="piece" src="&ROOT;/resources/images/chineseCheckers/boardpit.png"/>
		    </xsl:when>
		    <xsl:when test="argument[2]='green'">
				<xsl:attribute name="class">green</xsl:attribute>
				<img class="piece" src="&ROOT;/resources/images/chineseCheckers/boardpit.png"/>
		    </xsl:when>
		    <xsl:when test="argument[2]='red'">
				<xsl:attribute name="class">red</xsl:attribute>
				<img class="piece" src="&ROOT;/resources/images/chineseCheckers/boardpit.png"/>
		    </xsl:when>
		    <xsl:when test="argument[2]='blue'">
				<xsl:attribute name="class">blue</xsl:attribute>
				<img class="piece" src="&ROOT;/resources/images/chineseCheckers/boardpit.png"/>
		    </xsl:when>
		    <xsl:otherwise>
		    	<!-- Old-style blank space, where there's an explicit representation of the blank square -->
				<xsl:attribute name="class">blank</xsl:attribute>
				<img class="piece" src="&ROOT;/resources/images/chineseCheckers/boardpitb.png"/>
		  	</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:if test="not (//fact[relation='cell' and argument[1]=$loc])">
    	<!-- New-style blank space, with no explicit representation in the XML -->
    	<xsl:attribute name="class">blank</xsl:attribute>
		<img class="piece" src="&ROOT;/resources/images/chineseCheckers/boardpitb.png"/>
    </xsl:if>
  </div>
</xsl:template>

</xsl:stylesheet>
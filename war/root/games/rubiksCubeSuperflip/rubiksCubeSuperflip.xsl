<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="width" select="400"/>
	<xsl:param name="height" select="400"/>
	<xsl:template name="main" match="/state">

    <div>
	<style type="text/css" media="all">

		div.upsticker
		{
			width: 52px;
			height: 30px;
			position: absolute;
		}
		div.leftsticker
		{
			width: 26px;
			height: 45px;
			position: absolute;
		}
		div.rightsticker
		{
			width: 26px;
			height: 45px;
			position: absolute;
		}

		
		#wwgo {left: 62px; top: 20px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wgo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'w'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#wwg {left: 36px; top: 35px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wg']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#wwo {left: 88px; top: 35px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#wwgr {left: 10px; top: 50px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wgr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'w'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#ww {left: 62px; top: 50px; background-image: url('&ROOT;/resources/images/rubiksCube/wup.png');}
		#wwbo {left: 114px; top: 50px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wbo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'w'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#wwr {left: 36px; top: 65px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#wwb {left: 88px; top: 65px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wb']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#wwbr {left: 62px; top: 80px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wbr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'w'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#rwgr {left: 10px; top: 65px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wgr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'r'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#rgr {left: 10px; top: 95px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='gr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#rygr {left: 10px; top: 125px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ygr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'r'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#rwr {left: 36px; top: 80px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#rr {left: 36px; top: 110px; background-image: url('&ROOT;/resources/images/rubiksCube/rleft.png');}
		#ryr {left: 36px; top: 140px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='yr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#rwbr {left: 62px; top: 95px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wbr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'r'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#rbr {left: 62px; top: 125px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='br']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#rybr {left: 62px; top: 155px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ybr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'r'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#bwbr {left: 88px; top: 95px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wbr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'b'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#bbr {left: 88px; top: 125px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='br']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#bybr {left: 88px; top: 155px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ybr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'b'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#bwb {left: 114px; top: 80px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wb']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#bb {left: 114px; top: 110px; background-image: url('&ROOT;/resources/images/rubiksCube/bright.png');}
		#byb {left: 114px; top: 140px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='yb']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#bwbo {left: 140px; top: 65px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wbo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'b'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#bbo {left: 140px; top: 95px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='bo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#bybo {left: 140px; top: 125px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ybo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'b'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#owbo {left: 200px; top: 50px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wbo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'r'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#obo {left: 200px; top: 80px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='bo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#oybo {left: 200px; top: 110px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ybo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'r'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#owo {left: 226px; top: 35px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#oo {left: 226px; top: 65px; background-image: url('&ROOT;/resources/images/rubiksCube/oright.png');}
		#oyo {left: 226px; top: 95px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='yo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#owgo {left: 252px; top: 20px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wgo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'r'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#ogo {left: 252px; top: 50px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='go']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#oygo {left: 252px; top: 80px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ygo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'r'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>right.png');}
		#gwgo {left: 278px; top: 20px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wgo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'b'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#ggo  {left: 278px; top: 50px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='go']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#gygo {left: 278px; top: 80px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ygo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'b'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#gwg  {left: 304px; top: 35px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wg']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#gg   {left: 304px; top: 65px; background-image: url('&ROOT;/resources/images/rubiksCube/gleft.png');}
		#gyg  {left: 304px; top: 95px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='yg']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#gwgr {left: 330px; top: 50px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='wgr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'b'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#ggr  {left: 330px; top: 80px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='gr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');}
		#gygr {left: 330px; top: 110px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ygr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'b'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>left.png');} 
		#yybo {left: 200px; top: 140px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ybo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'w'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#yyo  {left: 226px; top: 125px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='yo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#yygo {left: 252px; top: 110px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ygo']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'w'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#yyb  {left: 226px; top: 155px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='yb']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#yy   {left: 252px; top: 140px; background-image: url('&ROOT;/resources/images/rubiksCube/yup.png');}
		#yyg  {left: 278px; top: 125px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='yg']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'0'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#yybr {left: 252px; top: 170px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ybr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'w'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#yyr  {left: 278px; top: 155px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='yr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="edgecolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'1'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		#yygr {left: 304px; top: 140px; position: absolute;
		background-image: url('&ROOT;/resources/images/rubiksCube/<xsl:for-each select="fact[relation='cubie' and argument[2]='ygr']"><xsl:variable name="cubievar" select="argument[1]"/><xsl:call-template name="cornercolor">
				<xsl:with-param name="cubie" select="argument[1]"/>
				<xsl:with-param name="side" select="'w'"/>
				<xsl:with-param name="orientation"><xsl:for-each select="../fact[relation='cubieorient' and argument[1]=$cubievar]"><xsl:value-of select="argument[2]"/></xsl:for-each></xsl:with-param>
				</xsl:call-template>
				</xsl:for-each>up.png');}
		
	</style>

	<div style="position: relative; width: 400px; height: 220px">
	<div class="upsticker" id="wwgo"></div>
	<div class="upsticker" id="wwo"></div>
	<div class="upsticker" id="wwbo"/>
	<div class="upsticker" id="wwgr"/>
	<div class="upsticker" id="wwr"/>
	<div class="upsticker" id="wwbr"/>
	<div class="upsticker" id="wwg"/>
	<div class="upsticker" id="ww"/>
	<div class="upsticker" id="wwb"/>
	<div class="leftsticker" id="rwgr"/>
	<div class="leftsticker" id="rwr"/>
	<div class="leftsticker" id="rwbr"/>
	<div class="leftsticker" id="rgr"/>
	<div class="leftsticker" id="rr"/>
	<div class="leftsticker" id="rbr"/>
	<div class="leftsticker" id="rygr"/>
	<div class="leftsticker" id="ryr"/>
	<div class="leftsticker" id="rybr"/>
	<div class="rightsticker" id="bwbr"/>
	<div class="rightsticker" id="bwb"/>
	<div class="rightsticker" id="bwbo"/>
	<div class="rightsticker" id="bbr"/>
	<div class="rightsticker" id="bb"/>
	<div class="rightsticker" id="bbo"/>
	<div class="rightsticker" id="bybr"/>
	<div class="rightsticker" id="byb"/>
	<div class="rightsticker" id="bybo"/>
	<div class="rightsticker" id="owgo"/>
	<div class="rightsticker" id="owo"/>
	<div class="rightsticker" id="owbo"/>
	<div class="rightsticker" id="ogo"/>
	<div class="rightsticker" id="oo"/>
	<div class="rightsticker" id="obo"/>
	<div class="rightsticker" id="oygo"/>
	<div class="rightsticker" id="oyo"/>
	<div class="rightsticker" id="oybo"/>
	<div class="leftsticker" id="gwgo"/>
	<div class="leftsticker" id="ggo"/>
	<div class="leftsticker" id="gygo"/>
	<div class="leftsticker" id="gwg"/>
	<div class="leftsticker" id="gg"/>
	<div class="leftsticker" id="gyg"/>
	<div class="leftsticker" id="gwgr"/>
	<div class="leftsticker" id="ggr"/>
	<div class="leftsticker" id="gygr"/>
	<div class="upsticker" id="yygo"/>
	<div class="upsticker" id="yyo"/>
	<div class="upsticker" id="yybo"/>
	<div class="upsticker" id="yygr"/>
	<div class="upsticker" id="yyr"/>
	<div class="upsticker" id="yybr"/>
	<div class="upsticker" id="yyg"/>
	<div class="upsticker" id="yy"/>
	<div class="upsticker" id="yyb"/>
	</div>
    </div>
</xsl:template>

<xsl:template name="cornercolor">
	<xsl:param name="cubie" />
	<xsl:param name="side" />
	<xsl:param name="orientation" />
	<xsl:variable name="w" select="translate(translate(translate(translate($cubie,'b',''),'g',''),'r',''),'o','')" />
	<xsl:variable name="b" select="translate(translate(translate(translate($cubie,'w',''),'y',''),'r',''),'o','')" />
	<xsl:variable name="r" select="translate(translate(translate(translate($cubie,'w',''),'y',''),'b',''),'g','')" />
	<xsl:if test="$side='w' and $orientation='0'"><xsl:value-of select="$w"/></xsl:if>
	<xsl:if test="$side='b' and $orientation='0'"><xsl:value-of select="$b"/></xsl:if>
	<xsl:if test="$side='r' and $orientation='0'"><xsl:value-of select="$r"/></xsl:if>
	<xsl:if test="$side='w' and $orientation='wb'"><xsl:value-of select="$b"/></xsl:if>
	<xsl:if test="$side='b' and $orientation='wb'"><xsl:value-of select="$w"/></xsl:if>
	<xsl:if test="$side='r' and $orientation='wb'"><xsl:value-of select="$r"/></xsl:if>
	<xsl:if test="$side='w' and $orientation='br'"><xsl:value-of select="$w"/></xsl:if>
	<xsl:if test="$side='b' and $orientation='br'"><xsl:value-of select="$r"/></xsl:if>
	<xsl:if test="$side='r' and $orientation='br'"><xsl:value-of select="$b"/></xsl:if>
	<xsl:if test="$side='w' and $orientation='wr'"><xsl:value-of select="$r"/></xsl:if>
	<xsl:if test="$side='b' and $orientation='wr'"><xsl:value-of select="$b"/></xsl:if>
	<xsl:if test="$side='r' and $orientation='wr'"><xsl:value-of select="$w"/></xsl:if>
	<xsl:if test="$side='w' and $orientation='wbr'"><xsl:value-of select="$b"/></xsl:if>
	<xsl:if test="$side='b' and $orientation='wbr'"><xsl:value-of select="$r"/></xsl:if>
	<xsl:if test="$side='r' and $orientation='wbr'"><xsl:value-of select="$w"/></xsl:if>
	<xsl:if test="$side='w' and $orientation='wrb'"><xsl:value-of select="$r"/></xsl:if>
	<xsl:if test="$side='b' and $orientation='wrb'"><xsl:value-of select="$w"/></xsl:if>
	<xsl:if test="$side='r' and $orientation='wrb'"><xsl:value-of select="$b"/></xsl:if>
</xsl:template>

<xsl:template name="edgecolor">
 <xsl:param name="cubie"/>
 <xsl:param name="side"/>
 <xsl:param name="orientation"/>
 <xsl:choose>
  <xsl:when test="$cubie='wr' or $cubie='wo' or $cubie='yr' or $cubie='yo'">
   <xsl:variable name="c0" select="substring($cubie,2,1)"/>
   <xsl:variable name="c1" select="substring($cubie,1,1)"/>
   <xsl:choose>
    <xsl:when test="$side=$orientation"><xsl:value-of select="$c0"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="$c1"/></xsl:otherwise>
   </xsl:choose>
  </xsl:when>
  <xsl:otherwise>
   <xsl:variable name="c0" select="substring($cubie,1,1)"/>
   <xsl:variable name="c1" select="substring($cubie,2,1)"/>
   <xsl:choose>
    <xsl:when test="$side=$orientation"><xsl:value-of select="$c0"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="$c1"/></xsl:otherwise>
   </xsl:choose>
  </xsl:otherwise>
 </xsl:choose>
 </xsl:template>
</xsl:stylesheet>
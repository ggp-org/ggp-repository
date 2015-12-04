<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      .hex-row
      {
        clear: left;
        font-family: Arial, sans-serif;
        font-size: 20px;
        text-align: center;
        vertical-align: middle;
      }

      .hex
      {
        float: left;
        margin-right: -19px;
        margin-bottom: -36px;
      }

      .hex .left
      {
        float: left;
        width: 0;
        border-right: 22px solid transparent;
        border-top: 38px solid transparent;
        border-bottom: 38px solid transparent;
      }

      .hex .middle
      {
        float: left;
        width: 40px;
        height: 76px;
        background: transparent;
      }

      .hex .right
      {
        float: left;
        width: 0;
        border-left: 22px solid transparent;
        border-top: 38px solid transparent;
        border-bottom: 38px solid transparent;
      }

      .hex.even
      {
        margin-top: 39px;
      }


      .hex.empty .left
      {
        border-right: 22px solid #DDDDDD;
      }

      .hex.empty .middle
      {
        background: #DDDDDD;
      }

      .hex.empty .right
      {
        border-left: 22px solid #DDDDDD;
      }


      .hex.red .left
      {
        border-right: 22px solid #FF8888;
      }

      .hex.red .middle
      {
        background: #FF8888;
      }

      .hex.red .right
      {
        border-left: 22px solid #FF8888;
      }


      .hex.blue .left
      {
        border-right: 22px solid #8888FF;
      }

      .hex.blue .middle
      {
        background: #8888FF;
      }

      .hex.blue .right
      {
        border-left: 22px solid #8888FF;
      }
    </style>

    <xsl:variable name="c11"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='1' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='1' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c12"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='1' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='1' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c13"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='1' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='1' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c14"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='1' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='1' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c21"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='2' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='2' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c22"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='2' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='2' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c23"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='2' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='2' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c24"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='2' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='2' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c25"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='2' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='2' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c31"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='3' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='3' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c32"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='3' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='3' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c33"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='3' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='3' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c34"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='3' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='3' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c35"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='3' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='3' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c36"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='3' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='3' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c41"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='4' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='4' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c42"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='4' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='4' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c43"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='4' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='4' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c44"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='4' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='4' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c45"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='4' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='4' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c46"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='4' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='4' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c47"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='4' and argument[2]=7]"><xsl:value-of select="//fact[relation='cell' and argument[1]='4' and argument[2]=7]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c51"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='5' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='5' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c52"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='5' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='5' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c53"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='5' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='5' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c54"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='5' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='5' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c55"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='5' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='5' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c56"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='5' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='5' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c61"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='6' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='6' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c62"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='6' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='6' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c63"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='6' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='6' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c64"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='6' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='6' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c65"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='6' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='6' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c71"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='7' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='7' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c72"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='7' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='7' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c73"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='7' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='7' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c74"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='7' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='7' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>

    <div class="hex-row">
      <div class="red    hex     "><div class="left"></div><div class="middle"><p>P1</p></div><div class="right"></div></div>
      <div class="       hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$c13} hex even"><div class="left"></div><div class="middle"><p>1 3</p></div><div class="right"></div></div>
      <div class="{$c14} hex     "><div class="left"></div><div class="middle"><p>1 4</p></div><div class="right"></div></div>
      <div class="{$c25} hex even"><div class="left"></div><div class="middle"><p>2 5</p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="blue   hex     "><div class="left"></div><div class="middle"><p>P2</p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$c11} hex even"><div class="left"></div><div class="middle"><p>1 1</p></div><div class="right"></div></div>
      <div class="{$c12} hex     "><div class="left"></div><div class="middle"><p>1 2</p></div><div class="right"></div></div>
      <div class="{$c23} hex even"><div class="left"></div><div class="middle"><p>2 3</p></div><div class="right"></div></div>
      <div class="{$c24} hex     "><div class="left"></div><div class="middle"><p>2 4</p></div><div class="right"></div></div>
      <div class="{$c35} hex even"><div class="left"></div><div class="middle"><p>3 5</p></div><div class="right"></div></div>
      <div class="{$c36} hex     "><div class="left"></div><div class="middle"><p>3 6</p></div><div class="right"></div></div>
      <div class="{$c47} hex even"><div class="left"></div><div class="middle"><p>4 7</p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$c21} hex even"><div class="left"></div><div class="middle"><p>2 1</p></div><div class="right"></div></div>
      <div class="{$c22} hex     "><div class="left"></div><div class="middle"><p>2 2</p></div><div class="right"></div></div>
      <div class="{$c33} hex even"><div class="left"></div><div class="middle"><p>3 3</p></div><div class="right"></div></div>
      <div class="{$c34} hex     "><div class="left"></div><div class="middle"><p>3 4</p></div><div class="right"></div></div>
      <div class="{$c45} hex even"><div class="left"></div><div class="middle"><p>4 5</p></div><div class="right"></div></div>
      <div class="{$c46} hex     "><div class="left"></div><div class="middle"><p>4 6</p></div><div class="right"></div></div>
      <div class="{$c56} hex even"><div class="left"></div><div class="middle"><p>5 6</p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$c31} hex even"><div class="left"></div><div class="middle"><p>3 1</p></div><div class="right"></div></div>
      <div class="{$c32} hex     "><div class="left"></div><div class="middle"><p>3 2</p></div><div class="right"></div></div>
      <div class="{$c43} hex even"><div class="left"></div><div class="middle"><p>4 3</p></div><div class="right"></div></div>
      <div class="{$c44} hex     "><div class="left"></div><div class="middle"><p>4 4</p></div><div class="right"></div></div>
      <div class="{$c54} hex even"><div class="left"></div><div class="middle"><p>5 4</p></div><div class="right"></div></div>
      <div class="{$c55} hex     "><div class="left"></div><div class="middle"><p>5 5</p></div><div class="right"></div></div>
      <div class="{$c65} hex even"><div class="left"></div><div class="middle"><p>6 5</p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$c41} hex even"><div class="left"></div><div class="middle"><p>4 1</p></div><div class="right"></div></div>
      <div class="{$c42} hex     "><div class="left"></div><div class="middle"><p>4 2</p></div><div class="right"></div></div>
      <div class="{$c52} hex even"><div class="left"></div><div class="middle"><p>5 2</p></div><div class="right"></div></div>
      <div class="{$c53} hex     "><div class="left"></div><div class="middle"><p>5 3</p></div><div class="right"></div></div>
      <div class="{$c63} hex even"><div class="left"></div><div class="middle"><p>6 3</p></div><div class="right"></div></div>
      <div class="{$c64} hex     "><div class="left"></div><div class="middle"><p>6 4</p></div><div class="right"></div></div>
      <div class="{$c74} hex even"><div class="left"></div><div class="middle"><p>7 4</p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$c51} hex     "><div class="left"></div><div class="middle"><p>5 1</p></div><div class="right"></div></div>
      <div class="{$c61} hex even"><div class="left"></div><div class="middle"><p>6 1</p></div><div class="right"></div></div>
      <div class="{$c62} hex     "><div class="left"></div><div class="middle"><p>6 2</p></div><div class="right"></div></div>
      <div class="{$c72} hex even"><div class="left"></div><div class="middle"><p>7 2</p></div><div class="right"></div></div>
      <div class="{$c73} hex     "><div class="left"></div><div class="middle"><p>7 3</p></div><div class="right"></div></div>
      <div class="       hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$c71} hex     "><div class="left"></div><div class="middle"><p>7 4</p></div><div class="right"></div></div>
      <div class="       hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="       hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>

  </div>
</xsl:template>

</xsl:stylesheet>

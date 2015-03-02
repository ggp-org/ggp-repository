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

    <xsl:variable name="a5"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='a' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='a' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="a6"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='a' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='a' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="a7"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='a' and argument[2]=7]"><xsl:value-of select="//fact[relation='cell' and argument[1]='a' and argument[2]=7]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="a8"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='a' and argument[2]=8]"><xsl:value-of select="//fact[relation='cell' and argument[1]='a' and argument[2]=8]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="a9"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='a' and argument[2]=9]"><xsl:value-of select="//fact[relation='cell' and argument[1]='a' and argument[2]=9]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="b4"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='b' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='b' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="b5"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='b' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='b' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="b6"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='b' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='b' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="b7"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='b' and argument[2]=7]"><xsl:value-of select="//fact[relation='cell' and argument[1]='b' and argument[2]=7]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="b9"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='b' and argument[2]=9]"><xsl:value-of select="//fact[relation='cell' and argument[1]='b' and argument[2]=9]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c3"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='c' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='c' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c4"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='c' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='c' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c5"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='c' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='c' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c6"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='c' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='c' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c7"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='c' and argument[2]=7]"><xsl:value-of select="//fact[relation='cell' and argument[1]='c' and argument[2]=7]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c8"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='c' and argument[2]=8]"><xsl:value-of select="//fact[relation='cell' and argument[1]='c' and argument[2]=8]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="c9"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='c' and argument[2]=9]"><xsl:value-of select="//fact[relation='cell' and argument[1]='c' and argument[2]=9]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="d2"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='d' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='d' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="d3"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='d' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='d' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="d4"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='d' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='d' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="d5"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='d' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='d' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="d7"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='d' and argument[2]=7]"><xsl:value-of select="//fact[relation='cell' and argument[1]='d' and argument[2]=7]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="d8"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='d' and argument[2]=8]"><xsl:value-of select="//fact[relation='cell' and argument[1]='d' and argument[2]=8]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="d9"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='d' and argument[2]=9]"><xsl:value-of select="//fact[relation='cell' and argument[1]='d' and argument[2]=9]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="e1"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='e' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='e' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="e3"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='e' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='e' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="e5"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='e' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='e' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="e6"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='e' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='e' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="e7"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='e' and argument[2]=7]"><xsl:value-of select="//fact[relation='cell' and argument[1]='e' and argument[2]=7]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="e8"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='e' and argument[2]=8]"><xsl:value-of select="//fact[relation='cell' and argument[1]='e' and argument[2]=8]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="e9"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='e' and argument[2]=9]"><xsl:value-of select="//fact[relation='cell' and argument[1]='e' and argument[2]=9]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="f1"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='f' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='f' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="f2"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='f' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='f' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="f3"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='f' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='f' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="f4"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='f' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='f' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="f6"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='f' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='f' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="f7"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='f' and argument[2]=7]"><xsl:value-of select="//fact[relation='cell' and argument[1]='f' and argument[2]=7]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="f8"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='f' and argument[2]=8]"><xsl:value-of select="//fact[relation='cell' and argument[1]='f' and argument[2]=8]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="g1"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='g' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='g' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="g2"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='g' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='g' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="g3"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='g' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='g' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="g4"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='g' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='g' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="g5"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='g' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='g' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="g6"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='g' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='g' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="g7"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='g' and argument[2]=7]"><xsl:value-of select="//fact[relation='cell' and argument[1]='g' and argument[2]=7]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="h1"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='h' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='h' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="h2"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='h' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='h' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="h3"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='h' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='h' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="h4"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='h' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='h' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="h6"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='h' and argument[2]=6]"><xsl:value-of select="//fact[relation='cell' and argument[1]='h' and argument[2]=6]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="i1"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='i' and argument[2]=1]"><xsl:value-of select="//fact[relation='cell' and argument[1]='i' and argument[2]=1]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="i2"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='i' and argument[2]=2]"><xsl:value-of select="//fact[relation='cell' and argument[1]='i' and argument[2]=2]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="i3"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='i' and argument[2]=3]"><xsl:value-of select="//fact[relation='cell' and argument[1]='i' and argument[2]=3]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="i4"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='i' and argument[2]=4]"><xsl:value-of select="//fact[relation='cell' and argument[1]='i' and argument[2]=4]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="i5"><xsl:choose><xsl:when test="//fact[relation='cell' and argument[1]='i' and argument[2]=5]"><xsl:value-of select="//fact[relation='cell' and argument[1]='i' and argument[2]=5]/argument[3]"/></xsl:when><xsl:otherwise>empty</xsl:otherwise></xsl:choose></xsl:variable>

    <div class="hex-row">
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$a8} hex even"><div class="left"></div><div class="middle"><p>a8</p></div><div class="right"></div></div>
      <div class="{$a9} hex     "><div class="left"></div><div class="middle"><p>a9</p></div><div class="right"></div></div>
      <div class="{$b9} hex even"><div class="left"></div><div class="middle"><p>b9</p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$a6} hex even"><div class="left"></div><div class="middle"><p>a6</p></div><div class="right"></div></div>
      <div class="{$a7} hex     "><div class="left"></div><div class="middle"><p>a7</p></div><div class="right"></div></div>
      <div class="{$b7} hex even"><div class="left"></div><div class="middle"><p>b7</p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$c8} hex even"><div class="left"></div><div class="middle"><p>c8</p></div><div class="right"></div></div>
      <div class="{$c9} hex     "><div class="left"></div><div class="middle"><p>c9</p></div><div class="right"></div></div>
      <div class="{$d9} hex even"><div class="left"></div><div class="middle"><p>d9</p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$a5} hex     "><div class="left"></div><div class="middle"><p>a5</p></div><div class="right"></div></div>
      <div class="{$b5} hex even"><div class="left"></div><div class="middle"><p>b5</p></div><div class="right"></div></div>
      <div class="{$b6} hex     "><div class="left"></div><div class="middle"><p>b6</p></div><div class="right"></div></div>
      <div class="{$c6} hex even"><div class="left"></div><div class="middle"><p>c6</p></div><div class="right"></div></div>
      <div class="{$c7} hex     "><div class="left"></div><div class="middle"><p>c7</p></div><div class="right"></div></div>
      <div class="{$d7} hex even"><div class="left"></div><div class="middle"><p>d7</p></div><div class="right"></div></div>
      <div class="{$d8} hex     "><div class="left"></div><div class="middle"><p>d8</p></div><div class="right"></div></div>
      <div class="{$e8} hex even"><div class="left"></div><div class="middle"><p>e8</p></div><div class="right"></div></div>
      <div class="{$e9} hex     "><div class="left"></div><div class="middle"><p>e9</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$b4} hex     "><div class="left"></div><div class="middle"><p>b4</p></div><div class="right"></div></div>
      <div class="{$c4} hex even"><div class="left"></div><div class="middle"><p>c4</p></div><div class="right"></div></div>
      <div class="{$c5} hex     "><div class="left"></div><div class="middle"><p>c5</p></div><div class="right"></div></div>
      <div class="{$d5} hex even"><div class="left"></div><div class="middle"><p>d5</p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$e6} hex even"><div class="left"></div><div class="middle"><p>e6</p></div><div class="right"></div></div>
      <div class="{$e7} hex     "><div class="left"></div><div class="middle"><p>e7</p></div><div class="right"></div></div>
      <div class="{$f7} hex even"><div class="left"></div><div class="middle"><p>f7</p></div><div class="right"></div></div>
      <div class="{$f8} hex     "><div class="left"></div><div class="middle"><p>f8</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$c3} hex     "><div class="left"></div><div class="middle"><p>c3</p></div><div class="right"></div></div>
      <div class="{$d3} hex even"><div class="left"></div><div class="middle"><p>d3</p></div><div class="right"></div></div>
      <div class="{$d4} hex     "><div class="left"></div><div class="middle"><p>d4</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$e5} hex     "><div class="left"></div><div class="middle"><p>e5</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$f6} hex     "><div class="left"></div><div class="middle"><p>f6</p></div><div class="right"></div></div>
      <div class="{$g6} hex even"><div class="left"></div><div class="middle"><p>g6</p></div><div class="right"></div></div>
      <div class="{$g7} hex     "><div class="left"></div><div class="middle"><p>g7</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$d2} hex     "><div class="left"></div><div class="middle"><p>d2</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$e3} hex     "><div class="left"></div><div class="middle"><p>e3</p></div><div class="right"></div></div>
      <div class="{$f3} hex even"><div class="left"></div><div class="middle"><p>f3</p></div><div class="right"></div></div>
      <div class="{$f4} hex     "><div class="left"></div><div class="middle"><p>f4</p></div><div class="right"></div></div>
      <div class="{$g4} hex even"><div class="left"></div><div class="middle"><p>g4</p></div><div class="right"></div></div>
      <div class="{$g5} hex     "><div class="left"></div><div class="middle"><p>g5</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$h6} hex     "><div class="left"></div><div class="middle"><p>h6</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$e1} hex     "><div class="left"></div><div class="middle"><p>e1</p></div><div class="right"></div></div>
      <div class="{$f1} hex even"><div class="left"></div><div class="middle"><p>f1</p></div><div class="right"></div></div>
      <div class="{$f2} hex     "><div class="left"></div><div class="middle"><p>f2</p></div><div class="right"></div></div>
      <div class="{$g2} hex even"><div class="left"></div><div class="middle"><p>g2</p></div><div class="right"></div></div>
      <div class="{$g3} hex     "><div class="left"></div><div class="middle"><p>g3</p></div><div class="right"></div></div>
      <div class="{$h3} hex even"><div class="left"></div><div class="middle"><p>h3</p></div><div class="right"></div></div>
      <div class="{$h4} hex     "><div class="left"></div><div class="middle"><p>h4</p></div><div class="right"></div></div>
      <div class="{$i4} hex even"><div class="left"></div><div class="middle"><p>i4</p></div><div class="right"></div></div>
      <div class="{$i5} hex     "><div class="left"></div><div class="middle"><p>i5</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$g1} hex     "><div class="left"></div><div class="middle"><p>g1</p></div><div class="right"></div></div>
      <div class="{$h1} hex even"><div class="left"></div><div class="middle"><p>h1</p></div><div class="right"></div></div>
      <div class="{$h2} hex     "><div class="left"></div><div class="middle"><p>h2</p></div><div class="right"></div></div>
      <div class="{$i2} hex even"><div class="left"></div><div class="middle"><p>i2</p></div><div class="right"></div></div>
      <div class="{$i3} hex     "><div class="left"></div><div class="middle"><p>i3</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>
    <div class="hex-row">
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="{$i1} hex     "><div class="left"></div><div class="middle"><p>i1</p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex     "><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
      <div class="      hex even"><div class="left"></div><div class="middle"><p>  </p></div><div class="right"></div></div>
    </div>

  </div>
</xsl:template>

</xsl:stylesheet>

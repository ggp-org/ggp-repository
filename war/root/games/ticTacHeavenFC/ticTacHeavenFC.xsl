<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>
<xsl:template name="main" match="/">  
  <div style="float:right;" >    <!-- Set Style -->    
  <style type="text/css" media="all">      td.cell {        width:  <xsl:value-of select="$width * 0.7"/>px;        height: <xsl:value-of select="$height *0.07"/>px;        border: 2px solid #000;        background-color: #CCCCCC; font-size: <xsl:value-of select="$width * 0.6 * 0.07"/>px; text-align: center; font-weight: bold;        align: center; }      table.board { background-color: #000000;  table.board_small { background-color:#000000;    }
</style>    <!-- Draw Board -->    
<xsl:call-template name="board">
  <xsl:with-param name="cols" select="3"/>    
  <xsl:with-param name="rows" select="3"/>    
</xsl:call-template> 
<xsl:call-template name="board_small"> 
    <xsl:with-param name="cols" select="3"/>
    <xsl:with-param name="rows" select="3"/>
</xsl:call-template>	
       </div>
  </xsl:template><xsl:template name="minicell" match="state/fact">
<xsl:param name="row" select="1"/>  <xsl:param name="col" select="1"/>
<xsl:param name="mrow" select="1"/>  <xsl:param name="mcol" select="1"/>     
<td class="cell">  <xsl:attribute name="id">
<xsl:value-of select="'cell_'"/>    <xsl:value-of select="$col"/>
<xsl:value-of select="$row"/>    <xsl:value-of select="$mcol"/>
<xsl:value-of select="$mrow"/>  </xsl:attribute>    <xsl:if test="//fact[relation='mark_large' and argument[1]=$col and argument[2]=$row and argument[3]=$mcol and argument[4]=$mrow and argument[5]='x']">X</xsl:if>
<xsl:if test="//fact[relation='mark_large' and argument[1]=$col and argument[2]=$row and argument[3]=$mcol and argument[4]=$mrow and argument[5]='o']"><font color="#999999">O</font>
</xsl:if>      </td></xsl:template><xsl:template name="cell">  <xsl:param name="row" select="1"/>  <xsl:param name="col" select="1"/>   
<table border="1"><tr>  
<xsl:call-template name="minicell"> <xsl:with-param name="mrow" select="1"/> 
<xsl:with-param name="mcol" select="1"/> <xsl:with-param name="row" select="$row"/>
<xsl:with-param name="col" select="$col"/> 
</xsl:call-template>

<xsl:call-template name="minicell"> <xsl:with-param name="mrow" select="1"/> 
<xsl:with-param name="mcol" select="2"/> <xsl:with-param name="row" select="$row"/> <xsl:with-param name="col" select="$col"/>
</xsl:call-template>  

<xsl:call-template name="minicell"> <xsl:with-param name="mrow" select="1"/> <xsl:with-param name="mcol" select="3"/>
<xsl:with-param name="row" select="$row"/> <xsl:with-param name="col" select="$col"/> 
</xsl:call-template>  </tr><tr> 

 <xsl:call-template name="minicell"> <xsl:with-param name="mrow" select="2"/> <xsl:with-param name="mcol" select="1"/> <xsl:with-param name="row" select="$row"/>
<xsl:with-param name="col" select="$col"/> 
</xsl:call-template>

<xsl:call-template name="minicell"> <xsl:with-param name="mrow" select="2"/> <xsl:with-param name="mcol" select="2"/> 
<xsl:with-param name="row" select="$row"/> <xsl:with-param name="col" select="$col"/>
</xsl:call-template>  

<xsl:call-template name="minicell"> <xsl:with-param name="mrow" select="2"/> <xsl:with-param name="mcol" select="3"/>
<xsl:with-param name="row" select="$row"/> <xsl:with-param name="col" select="$col"/> 
</xsl:call-template>  </tr><tr>  

<xsl:call-template name="minicell"> <xsl:with-param name="mrow" select="3"/> 
<xsl:with-param name="mcol" select="1"/> <xsl:with-param name="row" select="$row"/>
<xsl:with-param name="col" select="$col"/> 
</xsl:call-template>

<xsl:call-template name="minicell"> <xsl:with-param name="mrow" select="3"/> 
<xsl:with-param name="mcol" select="2"/> <xsl:with-param name="row" select="$row"/> <xsl:with-param name="col" select="$col"/>
</xsl:call-template>  

<xsl:call-template name="minicell"> <xsl:with-param name="mrow" select="3"/> <xsl:with-param name="mcol" select="3"/>
<xsl:with-param name="row" select="$row"/> <xsl:with-param name="col" select="$col"/> 

</xsl:call-template>
</tr></table>

</xsl:template>

<xsl:template name="board_row">  <xsl:param name="cols" select="1"/>  <xsl:param name="rows" select="1"/>
  <xsl:param name="row" select="1"/>  <xsl:param name="col" select="1"/>
  <td> 
  <xsl:call-template name="cell">    <xsl:with-param name="row" select="$row"/>    <xsl:with-param name="col" select="$col"/>
  </xsl:call-template>  </td>  <xsl:if test="$col &lt; $cols">
  <xsl:call-template name="board_row">      <xsl:with-param name="cols" select="$cols"/>      <xsl:with-param name="rows" select="$rows"/>
  <xsl:with-param name="row" select="$row"/>      <xsl:with-param name="col" select="$col + 1"/>    
  </xsl:call-template>
  </xsl:if>
</xsl:template><xsl:template name="board_rows">  <xsl:param name="cols" select="1"/>  <xsl:param name="rows" select="1"/>
<xsl:param name="row" select="1"/>  <tr>  
<xsl:call-template name="board_row">    <xsl:with-param name="cols" select="$cols"/>
<xsl:with-param name="rows" select="$rows"/>    <xsl:with-param name="row" select="$row"/>  
</xsl:call-template>  </tr>  <xsl:if test="$row &lt; $rows">    
<xsl:call-template name="board_rows">
<xsl:with-param name="cols" select="$cols"/>      <xsl:with-param name="rows" select="$rows"/>      
<xsl:with-param name="row" select="$row + 1"/>    
</xsl:call-template>
</xsl:if></xsl:template><xsl:template name="board">  <xsl:param name="cols" select="1"/>  <xsl:param name="rows" select="1"/>  
<table class="board">  
<xsl:call-template name="board_rows">    <xsl:with-param name="cols" select="$cols"/>    <xsl:with-param name="rows" select="$rows"/>  
</xsl:call-template>  </table></xsl:template>
<xsl:template name="cell_small" match="state/fact"> <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/>
  <td class="cell">  <xsl:attribute name="id">    <xsl:value-of select="'cell_'"/>
    <xsl:value-of select="$col"/>
    <xsl:value-of select="$row"/>
  </xsl:attribute>  <xsl:if test="//fact[relation='cell_small' and argument[1]=$col and argument[2]=$row and argument[3]='x']">X</xsl:if> <xsl:if test="//fact[relation='cell_small' and argument[1]=$col and argument[2]=$row and argument[3]='o']"><font color="#999999">O</font></xsl:if>    </td> </xsl:template><xsl:template name="board_small_row">  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>
    <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/>
    <xsl:call-template name="cell_small">    <xsl:with-param name="row" select="$row"/>
 <xsl:with-param name="col" select="$col"/>
  </xsl:call-template>  <xsl:if test="$col &lt; $cols">   
  <xsl:call-template name="board_small_row"> <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row"/>
 <xsl:with-param name="col" select="$col + 1"/>
    </xsl:call-template> </xsl:if></xsl:template><xsl:template name="board_small_rows">  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>
    <xsl:param name="row" select="1"/>
  <tr>  <xsl:call-template name="board_small_row"> <xsl:with-param name="cols" select="$cols"/>
    <xsl:with-param name="rows" select="$rows"/>
    <xsl:with-param name="row" select="$row"/>
 </xsl:call-template>  </tr>  <xsl:if test="$row &lt; $rows"> <xsl:call-template name="board_small_rows">      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
 <xsl:with-param name="row" select="$row + 1"/>
    </xsl:call-template> </xsl:if></xsl:template><xsl:template name="board_small">  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>
  <table class="board_small">  <xsl:call-template name="board_small_rows">    <xsl:with-param name="cols" select="$cols"/>
    <xsl:with-param name="rows" select="$rows"/>
  </xsl:call-template>
  </table>
</xsl:template>
</xsl:stylesheet>



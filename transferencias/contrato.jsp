<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@page import="java.util.Locale"%>
<%@ include file="../head.jsp"%> 
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Comic Sans MS";
	panose-1:3 15 7 2 3 3 2 2 2 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
p.MsoCaption, li.MsoCaption, div.MsoCaption
	{margin-right:0cm;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin-right:0cm;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:Tahoma;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.Section1
	{page:Section1;}
-->
</style>
<%@ include file="../body.jsp"%>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
}
%>
<div align="center"> 
<html:form method="post" action="/aceptacion">
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="92%"><div align="left" class="login"><bean:message key="lbl.transf.inter.contrato"/></div></td>
			<td width="8%">
				<div align="center"><a href="<html:rewrite page='/transferencias/printContrato.jsp'/>" target="_new"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
			</td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
		  		<div style="width:90%;height:200px;overflow:scroll;border:#cccccc 1px solid">
		  		<% if ("en".equals(locale.getLanguage())){%>
		  			<%@ include file="./agreement_en.htm" %>
				<%}else{%>
					<%@ include file="./agreement_es.htm" %>
				<%}%>
		  		</div>
		</td>
  </tr>


  <tr> 
		<td align="center"><br>
		<div id="bankdiv" style="display:">
			<html:submit styleClass="botton"><bean:message key="lbl.aceptar.contrato"/></html:submit>
			
			<input type="button" class="botton" name="foo" value="<bean:message key="lbl.no.aceptar.contrato"/>" onclick="document.location='<html:rewrite page='/start.jsp'/>'">
		</div></td>
  </tr>

	
	</table></html:form></div>
<%@ include file="../footer.jsp"  %>
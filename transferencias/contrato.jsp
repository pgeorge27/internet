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

<!DOCTYPE html>
<html:html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>
<%@ include file="../body.jsp"%>

<body>

<div class="container">
		<div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.transf.inter.contrato"/></strong></div>
  <div class="panel-body">

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
}
%>

<div align="center"> 
<html:form method="post" action="/aceptacion">

				<div align="right"><a href="<html:rewrite page='/transferencias/printContrato.jsp'/>" target="_new"><img class="img-responsive" alt="Responsive image" src="<html:rewrite page='/images/printer2.jpg'/>"></a></div>
  <br> 
	<div align="center">
		  		<div style="height:200px;overflow:scroll;border:#cccccc 1px solid">
		  		<% if ("en".equals(locale.getLanguage())){%>
		  			<%@ include file="./agreement_en.htm" %>
				<%}else{%>
					<%@ include file="./agreement_es.htm" %>
				<%}%>
		  		</div>
		</div>



		<div align="center"><br>
		<div id="bankdiv" style="display:">
			<html:submit styleClass="btn btn-default" style="width: 110px;"><bean:message key="lbl.aceptar.contrato"/></html:submit>
			
			<input type="button" class="btn btn-default" style="width: 110px;" name="foo" value="<bean:message key="lbl.no.aceptar.contrato"/>" onclick="document.location='<html:rewrite page='/start.jsp'/>'">
		</div></div>


	</html:form></div>


  
  </div>
</div>

</div>
</body>
</html:html>
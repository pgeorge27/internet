<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@page import="java.util.Locale"%>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
}
%>
<!DOCTYPE html>
<html:html>
<head>
<script language="javascript">
<!--
var da = (document.all) ? 1 : 0;
var pr = (window.print) ? 1 : 0;
var mac = (navigator.userAgent.indexOf("Mac") != -1);

if (da && !pr && !mac) with (document) {
  writeln('<OBJECT ID="WB" WIDTH="0" HEIGHT="0" CLASSID="clsid:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>');
  writeln('<' + 'SCRIPT LANGUAGE="VBScript">');
  writeln('Sub window_onunload');
  writeln('  On Error Resume Next');
  writeln('  Set WB = nothing');
  writeln('End Sub');
  writeln('Sub vbPrintPage');
  writeln('  OLECMDID_PRINT = 6');
  writeln('  OLECMDEXECOPT_DONTPROMPTUSER = 1');
  writeln('  OLECMDEXECOPT_PROMPTUSER = 2');
  writeln('  On Error Resume Next');
  writeln('  WB.ExecWB OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER');
  writeln('End Sub');
  writeln('<' + '/SCRIPT>');
}

function hideElement(){    
    if (document.getElementById){
    	var obj = document.getElementById("bankdiv");   
        obj.style.display = 'none';
    }
    else{
        name.style.display = 'none';
    }

}
function showElement(){
    if (document.getElementById){    
    	var obj = document.getElementById("bankdiv");
        obj.style.display = '';
    }
    else{
        name.style.display = '';
    }
}
function printContrato() {
  var obj;
  showElement();
  if (pr){ // NS4, IE5    
	window.print();
  }	
  else if (da && !mac){ // IE4 (Windows)    
    vbPrintPage();
  }
  hideElement();
}
// -->
</script>
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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container" style="padding-top: 30px;">
<table>
	<tr>
		<td><div align="center" id="bankdiv" style="display:"><a href="javascript:printContrato()"><img class="img-responsive" alt="Responsive image" src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
		</td></tr>
		
	  <div class="row">
  <div class="col-md-4"></div>
  <div class="col-md-7"><img class="img-responsive" alt="Responsive image" border="0" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/></div>
<div class="col-md-1"></div>
  </div>
  <br>
	<tr>	
	<br>
		<td>
			<% if ("en".equals(locale.getLanguage())){%>
				<%@ include file="./agreement_en.htm" %>
			<%}else{%>
				<%@ include file="./agreement_es.htm" %>
			<%}%>
		</td>
	</tr>
</table>
</div>
</body>
</html:html>
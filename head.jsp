<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page contentType="text/html; charset=ISO-8859-1" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
java.util.Calendar cal2 =  java.util.Calendar.getInstance();

%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script type="text/javascript" src="<html:rewrite page='/scripts/xaramenu.js' />"></script>
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/estilo.css'/>">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/newlf.css '/>">

<script LANGUAGE="JavaScript">

<!--
var da = (document.all) ? 1 : 0;
var pr = (window.print) ? 1 : 0;
var mac = (navigator.userAgent.indexOf("Mac") != -1);

function printPage2() {  
  if (pr){ // NS4, IE5    
	window.print();
  }	
  else if (da && !mac){ // IE4 (Windows)    
    vbPrintPage();
  }
}

function hideElement(){    
    if (document.getElementById){
    	var obj = document.getElementById("bankdiv"); 
    	var bdj = document.getElementById("bk2");
		if (obj)
			obj.style.display = 'none';
		if (bdj)
			bdj.style.display = 'none';
    }
    else{
        name.style.display = 'none';
    }

}
function showElement(){
    if (document.getElementById){    
    	var obj = document.getElementById("bankdiv");
    	var bdj = document.getElementById("bk2"); 
		if (obj)
			obj.style.display = '';
		if (bdj)
			bdj.style.display = '';
    }
    else{
        name.style.display = '';
    }
}

function printPage3() {
  var obj;
  if (document.getById){
	obj = document.getElementById("printHeader1");
  }    
  else{
    obj = printHeader1;
  }
  
  if (obj){
	obj.style.display ="none";
  }
  hideMenu();
	showElement();
  if (pr){ // NS4, IE5    
	window.print();
  }	
  else if (da && !mac){ // IE4 (Windows)    
    vbPrintPage();
  }
  if (obj){
    obj.style.display = "";
  }
  showMenu();
	hideElement();
}

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

// -->
</SCRIPT>

<SCRIPT language="Javascript">
var mensaje = "<bean:message key='msg.derechos.reservados' arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>";
function noViewSource(btnClick)
{
	if (navigator.appName == "Netscape" && btnClick.which == 3)
	{   alert(mensaje);
		return false;
	}
	else if (navigator.appName =="Microsoft Internet Explorer" && event.button == 2)
	{	alert(mensaje);
		return false;
	}
}
document.onmousedown = noViewSource;
if (navigator.appName =="Microsoft Internet Explorer")
   document.oncontextmenu = noViewSource;
</SCRIPT>

<SCRIPT language="JavaScript">
function protect(evt){
 if (navigator.appName != "Microsoft Internet Explorer"){
 if (evt.which != 3)
 return true;
};
return false;
}

function trap(){
 if(document.images){
 if(navigator.appName != "Microsoft Internet Explorer"){
 document.onmousedown = protect;}
 else{
document.oncontextmenu = protect;}}}
</SCRIPT>
<script language="JavaScript">

function ventanaAyuda(texto)
{
     link=texto+".htm";
     win1=open(link,'AYUDA', 'toolbar=no menubar=no personalbar=no locationbar=no resizable statusbar=no scrollbars=yes width=240 height=480');
     if (!win1.closed)
       {
         win1.focus();
       }
}
function regresar(){
	window.history.back(1);
}
</script>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
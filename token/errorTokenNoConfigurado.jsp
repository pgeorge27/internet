<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.realiza.afiliacion.automatica", "true");
session.removeAttribute("pantalla.principal.por.defecto");
%>

<HTML>
<HEAD>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="<html:rewrite page='/scripts/jquery-latest.min.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/bootstrap.min.css'/>">

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
    <title><bean:message key="tit.title.banco"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/estilo.css'/>">

</head>
<body>

<div class="container"> 
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

    <div align="right">
      <img class="img-responsive" border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
    </div>
    <br>
    <br>
    <div class="col-md-4 col-md-offset-4">
      <div class="panel panel-default" >
        <div class="panel-heading">
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
            <!-- TItulo del panel header -->
          </strong>
        </div>
        <div class="panel-body">
          <div align="center">
            <img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>">
          </div>
          <p class="bienvenida"></p>
        </div>
      </div>
    </div>
  </div>
</div>

</body>

</html>
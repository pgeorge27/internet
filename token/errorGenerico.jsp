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
<title><bean:message key="tit.title.banco"/></title>

<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/estilo.css'/>">

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


</head>
<body>

<div class="container">
  <div class="row">

    <div align="right">
      <img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
    </div>

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
          <logic:present name="error">
            <p class="bienvenida"><% String error = session.getAttribute("error").toString();%></p>
            <p class="bienvenida"><bean:message key="<%=error%>"/></p>
            <p class="bienvenida"><%session.removeAttribute("error");%></p>
          </logic:present>
        </div>
      </div>
    </div>
  </div>
</div>
<div align="center" class="derechos">&copy;
  <bean:message key="msg.derechos.reservados"  arg0='<%=" "+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
</div>

</body>

</html>
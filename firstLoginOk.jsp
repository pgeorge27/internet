<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
%>
<!DOCTYPE html>
<html:html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="./style/estilo.css">


<%@page import="com.arango.common.delegate.Manager"%>
<%@page import="com.arango.common.beans.constant.ConstantesGlobales"%><HTML>

<SCRIPT language="Javascript">
var mensaje = "<bean:message key='<%=copyrigth %>' arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>";
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

setTimeout("window.close()", 3000);
</SCRIPT>

</head>

<body>

<div class="container">

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
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>

      	 <header style="padding-top: 20px;">
			<img border="0" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/>
		    </header>
		    <br>

                <div class="row" style="padding-left: 3%; padding-right: 3%; padding-top: 80px;">

		  <div class="row"><div class="col-md-4 col-md-offset-4">
		
				<div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="msg.end.session"/></strong></div>
					 
					 <br>
                  					 <div class="row" align="center">
                                        <div class="col-md-4"></div>
 <div class="col-md-4"> <img src="<html:rewrite page='/images/user_login.gif' />" border="0" title="Reingresar al sitio"/></div>
                                       <div class="col-md-4"></div>
                  </div>
                  <br>
					 <div class="row" style="padding-right: 3%; padding-left: 3%;">
                       
					 
  <div class="col-md-2"></div>
  <div class="col-md-8" align="center"><bean:message key="lbl.primer.cambio.clave"/></div>
  <div class="col-md-2"></div>
  
                        </div>
					 
					 
						 <br>
						
					</div>
				
						</div>
							</div>

                </div>

<%Manager mgr = new Manager();
mgr.disableFirstLogin(session.getAttribute("user.id").toString(), ConstantesGlobales.DESACTIVA_PRIMER_LOGIN);
session.removeAttribute("codigos.Banco.formularios"); %>

</div>
<footer class="footer">
      <div class="container">
       <%@ include file="footer.jsp" %>
      </div>
    </footer>
</body>

</html:html>
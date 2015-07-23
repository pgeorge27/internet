<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext()); 
String serv = session.getAttribute("codigo.servicio").toString();
String  copyrigth = (serv.equals("1")) ? "msg.derechos.reservados" : "msg.derechos.reservados2";
String  introduccion = (serv.equals("1")) ? "msg.introduccion.texto.cliente.panama" : "msg.introduccion.texto.cliente.cayman";

boolean Actualiza = false;
try{
ArrayList codigos = (ArrayList)session.getAttribute("codigos.Banco.formularios");	
	if (codigos != null && codigos.size() > 0  ){
		Actualiza = true;
	}
}catch(Exception ex){
	Actualiza = false;
}
%>

<!DOCTYPE html>
<html:html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">


<%@page import="com.arango.common.beans.UserInfo"%>
<%@page import="java.util.ArrayList"%><HTML>

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
</SCRIPT>
<script type="text/javascript">
<!--
if (typeof window.event != 'undefined') // IE
document.onkeydown = function() // IE
 {
 var t=event.srcElement.type;
 var kc=event.keyCode;
 return ((kc != 8 ) || ( t == 'text'  ) ||
          (t == 'textarea') || ( t == 'submit' ) || (t =='password'))
 }
else
document.onkeypress = function(e)  // FireFox/Others 
 {
 var t=e.target.type;
 var kc=e.keyCode;
 if ((kc != 8 ) || ( t == 'text'  ) ||
     (t == 'textarea') || ( t == 'submit' ) || (t =='password'))
     return true
 else {
     return false
 }
}
//-->
</script>


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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<LINK REL="stylesheet" TYPE="text/css" HREF="./style/estilo.css">

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<div class="container" style="padding-top:20px">

   	 <header>
			<img border="0" class="img-responsive" alt="Responsive image" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/>
		    </header>

<br>
<br>

<br>

		<div class="row" style="padding-top: 5%; padding-left: 3%; padding-right: 3%;">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="msg.introduccion.saludo"/></strong></div>
					 	

					  <div class="panel-body">

		
			<p align="justify"><bean:message key="<%=introduccion %>"/></p>
			
				<UL>
										
										<%int Flag =  Integer.parseInt(session.getAttribute("flag").toString());
										
											if(Flag != 7){ 
											while( Flag <= 13){
												if (8 ==Flag){%>
													<li><bean:message key="lbl.flujo.login.password" /></li>
									           	<%} %>
									           	
									           	<!-- Introduzco nuevo pazo en el flujo basico :Cambio de usuario -->
									           	<%if (9 == Flag){%>
													<li><bean:message key="lbl.flujo.login.usuario" /></li>
									          	<%} %>	
									           	
									            <%if (10 == Flag){%>
													<li><bean:message key="lbl.flujo.login.imagen" /></li>
									          	<%} %>	
									            	
									          	<%if("50".equals(userInfo.getRole()) ||"70".equals(userInfo.getRole())){ %>
										          	<%if (11 == Flag){%>
														<li><bean:message key="lbl.flujo.login.firma" /></li>
										            	<%} %>
											        <%if (12 == Flag){%>
														<li><bean:message key="lbl.flujo.login.preguntas" /></li>
											            <%} %>   	
											        <%if (13 == Flag && Actualiza){%>
													    <li><bean:message key="lbl.flujo.login.actualizacion.formulario" /></li>
													    <%} %>    
									        <%}
									       Flag++; }
									        }%>
								          </UL>
								          
								         
								          <br>


     <div align="center">
	        								<form name="formConfirma" action="<html:rewrite page='/do.primerinicio'/>" >
                                       			 <input name="baceptar"  onclick="submit();" type="button" class="btn btn-default" value="CONTINUAR"> 							</form >
	  										</div>

 </div>

</div>
</div>
</div>
</div>

</div>
</body>

</html:html>
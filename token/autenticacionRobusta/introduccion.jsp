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
String  introduccion = (serv.equals("1")) ? "lbl.token.introduccion.cliente.panama" : "lbl.token.introduccion.cliente.cayman";

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


<%@page import="com.arango.common.beans.UserInfo"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

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

<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/estilo.css'/>" />

</head>
<body>

	<div class="container">
		<div class="row">
			<div align="right">
				<img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
			</div>
			<br>
			<br>
			<div height="26" width="100%" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
				<div  class="fuente-principal">
					<bean:message key="tit.title.atenticacion.paso4"/>
				</div>
			</div>
			<br>
			<br>
			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default" >
					<div class="panel-heading">
						<img src="<html:rewrite page='/images/logo_icon.png' />" />
						<strong><bean:message key="msg.introduccion.saludo"/></strong>
					</div>
					<div class="panel-body">
						<p align="justify">
								<bean:message key="<%=introduccion %>"/>
						</p>

						<ol type=1>

							<%
							int Flag =  Integer.parseInt(session.getAttribute("flag").toString());
							String pantalla = (String)session.getAttribute("pantalla");

							while( Flag <= 87){
							if (81 ==Flag){

							%>
							<li><div class="fuente-principal"><bean:message key="tit.title.cambio_clave" /></div></li>
							<%}%>
							<%if (82 == Flag){

							%>
							<li><div class="fuente-principal"><bean:message key="lbl.token.introduccion.cambioUsuario" /></div></li>
							<%}%>
							<%if (83 ==Flag){

							%>
							<li><div class="fuente-principal"><bean:message key="lbl.flujo.login.imagen" /></div></li>
							<%}%>
							<%if (84 == Flag){

							%>
							<li><div class="fuente-principal"><bean:message key="lbl.token.introduccion.activarPin" /></div></li>
							<%}%>
							<%if (85 == Flag){

							%>
							<li><div class="fuente-principal"><bean:message key="lbl.token.introduccion.registroPin" /></div></li>
							<%}%>
							<%if (86 ==Flag){

							%>
							<li><div class="fuente-principal"><bean:message key="lbl.token.autenticacion.introduccion.pregunta" /></div></li>
							<%}%>
							<%if (87 ==Flag){

							%>
							<li><div class="fuente-principal"><bean:message key="lbl.token.introduccion.actualizaInformacion" /></div></li>
							<%}%>
							<%
							Flag++; }
							%>
						</ol>

						<div align="center">
							<html:form method="post" action="/autenticacionRobusta.do" >
								<html:hidden  property="pantalla" value="<%=pantalla %>"/>
								<input type="submit" value='<bean:message key="lbl.token.cambio.usuario.boton1" />' class="btn btn-default"/>
							</html:form>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>


</div>
	<!-- empieza cinta con derechos reservados -->
	<div align="center" class="derechos" style="width:100%;height:31;background-color:#4D4F53;">
		<bean:message key="<%=copyrigth %>" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
	</div>
</body>

</html>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@page import="java.util.Locale"%>
<%
Locale locale = new Locale("es", "PA");
session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
String message="Basados en la filosofía de servicio personalizado, "
			  +"nuestro banco ha entendido y adoptado \"LA IMPORTANCIA DE LA DIFERENCIA\""
			  +" como un estilo único para agregar valor a los productos y servicios"
			  +" que entrega a sus clientes.";
session.setAttribute("no.realiza.afiliacion.automatica", "true");
session.setAttribute("pantalla.principal.por.defecto", "true");
//String remote_hostname = request.getRemoteHost();
//String remote_ip = request.getRemoteAddr();
%>
<!DOCTYPE html>
<html:html>
<head>
    <title><bean:message key="tit.title.banco"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">

<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>

<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
  
 <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
 
 

 
  <script language="JavaScript" src="<html:rewrite page='/scripts/campos.js'/>"></script>
 


<script language="JavaScript">
function deshabilitarCajaLogin(){
    document.forma.usuario.disabled=true;
    document.forma.clave.disabled=true;
    document.forma.btnSend.disabled=true;   
}
    
function send(){
    window.status="Espere mientras se conecta a Internet Banking ....";
    document.forma.clave.value=encripta2(document.forma.clave.value);
	document.forma.submit();
	deshabilitarCajaLogin();
}
function loginEnter(){ 
   if (event.keyCode == "013") 
      send();
} 

function changeLocale(){
	document.forma2.locale.value = document.forma.locale.value;
	document.forma2.submit();
}
function loadPage(){
	document.forma.usuario.focus();
	window.status="";
	<logic:present name="error">
	    <% String error = session.getAttribute("error").toString();%>
		alert("<bean:message key="<%=error%>"/>");
	<%session.removeAttribute("error");%>
	</logic:present>
}

</script>

<SCRIPT language=Javascript>	
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

</head>


<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="loadPage();">

   <div class="container" style="padding-top:20px">
   	 <header>
			<img border="0" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/>
		    </header>
		    <br>
<br>
<br>
  <br>
<hr>
    <br>
		<div class="row" style="padding-right: 3%; padding-left: 3%;">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">
		
				<div class="panel panel-default" >
					<div class="panel-heading">
						<strong>Login</strong>
					</div>
					<div class="panel-body">
					    <form id="forma" method="POST" action="<html:rewrite page='/do.signon'/>" name="forma">
				 	    <input type="hidden" name="servicio" value="1">
					<input type="hidden" name="remotehost" value="<%=request.getRemoteHost() %>">
					<input type="hidden" name="remoteip" value="<%=request.getRemoteAddr() %>">
					<input type="hidden" name="opt" value="3">
                    <fieldset>
							<div class="row">
									<div class="center-block">
										<h5 style="text-align: center;">Bienvenidos a nuestro servicio de 
												Helm Virtual con acceso las 24 horas del día, todos los días del 
												año.</h5>
									</div>
								</div>
			  	
								
										<div class="form-group">
											<div class="input-group">
												<span class="input-group-addon">
													<i class="glyphicon glyphicon-user"></i>
												</span> 
												<input type="text"  id="usuario" name="usuario" placeholder="Usuario" size="20" maxlength="16" title="Introduzca en este campo el login suministrado por el banco." class="form-control" autofocus>
											</div>
										</div>
										<div class="form-group">
											<div class="input-group">
												<span class="input-group-addon">
													<i class="glyphicon glyphicon-lock"></i>
												</span>
												<input  type="password" id="clave" name="clave" placeholder="Clave" size="20" maxlength="16" onkeypress="loginEnter();" title="Introduzca en este campo la clave para el login especificado." class="form-control">
											</div>
										</div>
										<div class="form-group">
										
											<input name="btnSend" type="button" class="btn btn-lg btn-primary btn-block" value="<bean:message key="lbl.signon"/>" onclick="send();">
										</div>
										
										
							
							
			    	</fieldset>
			      	</form>

					</div>
						</div>
							</div>
				
                </div>
                
      
		</div>
		 <br>
		 
<hr>
<div id="otro">
     
        <div align="justify">
         <strong style="color:#7f8c8d">NOTICIAS</strong><br>
        
        <common:mensaje-servicio servicio="1"  msgDefault="<%=message%>"/></div>
    
    </div>
	</div>
	<br>
	<script src=https://seal.verisign.com/getseal?host_name=www.helmpanama.com&size=M&use_flash=YES&use_transparent=YES></script>
	<footer>
     
        <div align="center" class="derechos">&copy; 
        <bean:message key="msg.derechos.reservados"  arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div>
    
    </footer>
</body>
</html:html>
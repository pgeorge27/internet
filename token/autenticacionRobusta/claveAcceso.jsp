<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import = "com.arango.common.beans.UserInfo"%>

<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.aplicar.regla.password", "true");
String role = session.getAttribute("role.user").toString();
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";

%>

<html>
<head>
<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> -->
<script type="text/javascript"
	src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<script language="javascript" src="./scripts/campos.js"></script>
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
<script language="javascript">
function campoChange(campo){
	if(1 == campo){
		Foco = "claveold"
	}else if(2 == campo){
		Foco = "clavenew"
	}else if(3 == campo){
		Foco = "claveconf"
	}
 }


function send(){
    if(validatePass())
    {
      document.forma.oldPassw.value=encripta2(document.forma.oldPassw.value);
	  document.forma.newPassw.value=encripta2(document.forma.newPassw.value);
	  document.forma.confirmPassw.value=encripta2(document.forma.confirmPassw.value);
	  document.forma.submit();
    }
}
function validatePass(){
  if (document.forma.newPassw.value.length < 8 || document.forma.newPassw.value.length > 11){
      alert("<bean:message key="lbl.cambio.clave.observacion1"/>");
      return false;
  }
  return true;    				 
}

function limpiar(){
	  document.forms[0].oldPassw.value='';
	  document.forms[0].newPassw.value='';
	  document.forms[0].confirmPassw.value='';
}

function validateQuestion(){
  	if (document.forma.respuesta1.value == "")
  	{
     	 alert("El campo de respuesta 1 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.respuesta2.value == "")
  	{
     	 alert("El campo de respuesta 2 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.pregunta3.value == "")
  	{
     	 alert("El campo de pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.respuesta3.value == "")
  	{
     	 alert("El campo de respuesta 3 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.pregunta1.value == document.forma.pregunta2.value)
  	{
     	 alert("Las preguntas 1 y 2 deben ser diferentes");
     	 return false;
  	}
  	return true;    				 
}


function validatePreg(campo) {
    var RegExPattern = /([a-zA-Z0-9]{4,10})$/;
    var resp = false;
    var errorMessage = 'Los campos solo pueden contener caracteres alfanumericos y deben poseer mas de 4 caracteres.';
    if ((campo.value.match(RegExPattern)) && (campo.value!='')) {
        resp = true;
    } else {
        alert(errorMessage);
        resp = false;
    }
    return resp;
}


function visita()
{
	document.location = "startv.jsp";
}

var Foco = "claveold";
</script>
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
window.statusbar=' ';
</SCRIPT>
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/teclado.css'/>">
<script type="text/javascript" src="<html:rewrite page='/scripts/tecladoUpdate.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
</head>
<body onLoad="reset();" >

	<div class="container">
		<div class="row">

			<div align="right">
				<img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
			</div>
			<br>
			<br>
			<div height="26" width="100%" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
				<div  class="fuente-principal">
					<bean:message key="tit.title.atenticacion.paso1"/>
				</div>
			</div>
			<br>
			<br>

			<div class="col-md-6">
				<div class="panel panel-default" >
					<div class="panel-heading" >
						<img src="<html:rewrite page='/images/logo_icon.png' />" />
						<strong>
							<bean:message key="lbl.preg.secreta.observacion"/>
						</strong>
					</div>

					<div class="panel-body">
						<p><bean:message key="lbl.cambio.clave.obs1" /></p>
						<p><bean:message key="lbl.cambio.clave.obs2" /></p>
						<p><bean:message key="lbl.cambio.clave.firstLogin.obs3" /></p>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="panel panel-default" >
					<div class="panel-heading" >
						<img src="<html:rewrite page='/images/logo_icon.png' />" />
						<strong>
							<bean:message key="tit.title.cambio_clave"/>
						</strong>
					</div>

					<div class="panel-body">

						<logic:present name="msg">
						<div class="well">
							<img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>">
							<p class="bienvenida">
								<b><bean:message key="errors.header"/></b>
							</p>
							<p class="bienvenida">
								<%String error = session.getAttribute("msg").toString();%>
								<bean:message key="<%=error%>"/>
							</p>
						</div>
					</logic:present>
					<%
					session.removeAttribute("msg");
					UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
					%>

					<form method="post" action="<html:rewrite page='/do.claveAcceso'/>" name="forma">
						<html:form action="/change/psw" method="post">
							<p>
								<bean:message key="lbl.clave_usuario_anterior"/>
								<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
							</p>
							<p>
								<html:password property="oldPassw" styleClass="caja-acceso form-control" maxlength="11"   styleId="claveold" />
							</p>
							<p>
								<bean:message key="lbl.clave_usuario_nueva"/>
								<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
							</p>
							<p>
								<html:password property="newPassw" styleClass="caja-acceso form-control" maxlength="11"  styleId="clavenew" />
							</p>
							<p>
								<bean:message key="lbl.reescriba_clave_usuario"/>
								<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
							</p>
							<p>
								<html:password property="confirmPassw" styleClass="caja-acceso form-control" maxlength="11"  styleId="claveconf" />
							</p>
							<div align="center">
								<input name="button" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.enviar"/>"> 
								<input name="limpiar" type="reset" onclick="limpiar();" class="btn btn-default" value="<bean:message key="btn.limpiar"/>">
								<p><bean:message key="lbl.mensaje.campo.requerido"/></p>

							</div>
						</html:form>
					</form>
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

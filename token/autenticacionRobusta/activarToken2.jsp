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

<%@ include file="../../head.jsp"%>
<%@ include file="jsScripts.jsp"%>

<script language="javascript"> src="<html:rewrite page='/scripts/campos.js'/>"</script>
<script language="javascript"> src="<html:rewrite page='/scripts/ValidaFirmaDigital.js'/>"</script>

<script language="javascript">
function campoChange(campo){
if(1 == campo){
document.forma.Foco.value = "claveold"
}else if(2 == campo){
document.forma.Foco.value = "clavenew"
}else if(3 == campo){
document.forma.Foco.value = "claveconf"
}
}
function send(){
    if(validatePass())
    {
		document.forma.submit();
	}  
}

function validatePass(){
	if(document.getElementById('claveold').value=="")
	{
		alert("<bean:message key="lbl.actualiza.campos.requeridos"/>");
		return false;
	}
	else if(document.getElementById('claveold').value.length<8)
	{	
		alert("<bean:message key="error.token.activarToken.largo"/>");
		return false;
	}
	else
	{
		return true;
	}

}

function exito()
{
	window.location.href="<html:rewrite page='/token/autenticacionRobusta/preguntasSeguridadForm.jsp'/>";
}

var option = "0"; // Solamente teclado numerico   
</script>
<!--%@ include file="../body.jsp"%-->
<!-- Body -->
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/teclado.css'/>">
<script type="text/javascript"  src="<html:rewrite page='/scripts/statusbar.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>
</HEAD>
<body onLoad="reset(); ">

	<div class="container">
		<div class="row" style="padding-right: 3%; padding-left: 3%;">

			<div align="right">
				<img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
			</div>
			<br>
			<br>
			<div height="26" width="100%" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
				<div  class="fuente-principal">
					<bean:message key="tit.title.atenticacion.paso5"/>
				</div>
			</div>
			<br>
			<br>

			<%@ include file="blockDiv.jsp"%>
			<logic:present name="msg">
			<p>
				<img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>">
				<p class="bienvenida">
					<b><bean:message key="errors.header"/></b>
				</p>
				<p class="bienvenida">
					<%String error = session.getAttribute("msg").toString();%>
					<bean:message key="<%=error%>"/>
				</p>
			</p>
		</logic:present>
		<%
		session.removeAttribute("msg");

		if (session.getAttribute("act")!=null){	
		%>
		<script language="javascript">
			$.blockUI({ message: $('#msgExito'), css: { width: '350px' } });
		</script> 
		<%
		session.removeAttribute("act");
	}

	%>

	<div class="col-md-6 col-md-offset-3">
		<div class="panel panel-default" >
			<div class="panel-heading" >
				<img src="<html:rewrite page='/images/logo_icon.png' />" />
				<strong>
					<bean:message key="tit.title.registro.token"/>
				</strong>
			</div>

			<div class="panel-body">

				<p>
					<bean:message key="lbl.title.registro.token.otp2"/>
				</p>
				<p>
					<bean:message key="lbl.title.registro.token.pasos" />
				</p>
				<p>
					<bean:message key="lbl.pasos.registro.token.paso1" />
					<img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15">
				</p>
				<p>
					<bean:message key="lbl.pasos.registro.token.paso2" />
					<img src="<html:rewrite page='/images/TokenClave.png'/>" height="15">
				</p>
				<p>
					<bean:message key="lbl.pasos.registro.token.paso3" />
				</p>


				<form method="post" action="<html:rewrite page='/do.activarTokenAutenticacion'/>" name="forma">
				<!--  Tabla con Cajas -->
				<p>
					<input type="hidden" name="Foco" value="claveold" id="Foco" >
				</p>
				<p>
					<input type="hidden" name="paso" value="1" id="paso" >
				</p>
				<p>
					<bean:message key="lbl.registro.token.clave.generada" />
					<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
				</p>
				<p>
					<input type="text" name="otp2" class="inputf form-control" maxlength="8"  onclick="campoChange(1);" id="claveold"/> 
				</p>
				<p
				<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
			</p>
			<div align="center">
				<input name="button" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.enviar"/>"> 
				<input name="Submit2" type="reset" class="btn btn-default" value="<bean:message key="btn.limpiar"/>"> 
				<p><bean:message key="lbl.mensaje.campo.requerido"/></p>
			</div>
		</form>
	</div>
</div>
</div>
</div>
</div>


</body>
</html>
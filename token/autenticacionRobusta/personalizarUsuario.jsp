<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import = "com.arango.common.beans.UserInfo"%>

<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
String role = session.getAttribute("role.user").toString();
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";

%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
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

function containBlank(){
	var name = document.getElementById("nuevoUsuario").value;
	if(name.indexOf(" ") >=0 ){
		alert("<bean:message key="lbl.token.cambio.usuario.obs5"/>");		
	}
	else{
		document.forms[0].submit();
	}		
}

function validatePass(){
  if (document.forma.newPassw.value.length < 6 || document.forma.newPassw.value.length > 16){
      alert("<bean:message key="lbl.token.cambio.usuario.obs5"/>");
      return false;
  }
  return true;    				 
}

function clear(){
	  document.getElementById("usuarioActual").value="";
	  document.getElementById("nuevoUsuario").value="";
	  document.getElementById("nuevoUsuarioConfirmacion").value="";
}

function send(){
    if(validatePass())
    {
    	document.forms[0].submit();
	}  
}
function validatePass(){
  	if ((document.getElementById("nuevoUsuario").value.length < 6) || (document.getElementById("nuevoUsuario").value.length > 16))
  	{
     	alert("<bean:message key="lbl.token.cambio.usuario.obs5"/>");
     	return false;
  	}
  	else
  	{
  		return true;
  	}
  	 				 
}
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
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
</head>
<body onLoad="reset();" >

<div class="container">
	<div class="row" style="padding-right: 3%; padding-left: 3%;">

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

		<logic:present name="msg">
		<div class="col-md-4 col-md-offset-4">
			<div align="center" class="well">
				<p><img src="<html:rewrite page='/images/warning.gif'/>"></p>
				<p><b><bean:message key="errors.header"/></b></p>
				<p class="fuente-principal">
					<%String error = session.getAttribute("msg").toString();%>
				<bean:message key="<%=error%>"/></p>
			</div>
		</div>
		</logic:present>
		<%
		   session.removeAttribute("msg");
		   UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
		%>

		<div class="col-md-4 col-md-offset-1">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.preg.secreta.observacion"/>
					</strong>
				</div>

				<div class="panel-body">
					<UL>
						<li><bean:message key="lbl.token.cambio.usuario.obs4"/></li>
						<li><bean:message key="lbl.token.cambio.usuario.obs5"/></li>
					</UL>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.token.introduccion.activarPin"/>
					</strong>
				</div>
				<div class="panel-body">
					<html:form method="post" action="/personalizarUsuario.do">

						<p>
							<bean:message key="lbl.token.cambio.usuario.usuarioActual"/>
							<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
						</p>
						<p>
							<html:text property="usuarioActual" styleClass="caja-acceso form-control" maxlength="16"   styleId="usuarioActual" value=""/> 
						</p>
						<p>
							<bean:message key="lbl.token.cambio.usuario.nuevoUsuario"/>
							<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
						</p>
						<p>
							<html:text property="nuevoUsuario" styleClass="caja-acceso form-control" maxlength="16"  styleId="nuevoUsuario" value=""/>
						</p>
						<p>
							<bean:message key="lbl.token.cambio.usuario.confirmeUsuario"/>
							<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
						</p>
						<p>
							<html:text property="nuevoUsuarioConfirmacion" styleClass="caja-acceso form-control" maxlength="16"  styleId="nuevoUsuarioConfirmacion" value=""/>
						</p>

						<div align="center">
							<html:hidden  property="pantalla" value="success"/>   
							<input name="button" type="button" onClick="containBlank()" class="btn btn-default" value="<bean:message key="btn.enviar"/>"> 
							<input name="limpiar" type="reset" onClick="clear();" class="btn btn-default" value="<bean:message key="btn.limpiar"/>"> 
						</div>

					</html:form>
				</div>
			</div>
		</div>
	</div>
</div>


</body>

</html>

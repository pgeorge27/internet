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

<html>
<head>
<link rel="stylesheet" type="text/css"
	href="<html:rewrite page='/style/flujos.css'/>" />
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
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="reset();" >
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
   <tr> 
        <td ><br>
		<table width="100%" border="0" cellpadding="10" cellspacing="0">
			<tr><td align="right" ><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
			<br></td>
    <td>&nbsp;</td>
    
  </tr>
  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF;"><div  class="fuente-principal"><bean:message key="tit.title.first.login.paso1"/></div></td>
  </tr>
  <tr valign="top"> 
    <td colspan="4">
    
<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td height="300" valign="middle"><table border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td>
 <br>
<logic:present name="msg">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabla-acceso">
	<tr> 
		<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
		<td valign="top">
			<table>
				<tr><td class="fuente-principal"><b><bean:message key="errors.header"/></b></td></tr>
				<tr><td class="fuente-principal">
		        <%String error = session.getAttribute("msg").toString();%>
					<bean:message key="<%=error%>"/></td></tr>
			</table>
		</td>
	</tr>
</table>   
</logic:present>
<%
   session.removeAttribute("msg");
   UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
%>
<div align="center">
<html:form method="post"  action="/cambioUsuarioToken.do">
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="20" valign="bottom">
		 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			  <tr> 
				<td >
					
					
						
				</td>
				<td >
					
				</td>
			  </tr>
			</table>
		  
	  </td>
  </tr>
 
<tr> 
	<td valign="top">
		<table>
		  <tr valign="top">
		    <td>
		      <!--  Tabla con Campos -->

		<table width="450" border="0" align="center" cellpadding="0" cellspacing="2">
			<tr>
				<td><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
				<td colspan="2" >
					<div align="left" class="fuente-titulo">
						<bean:message key="lbl.token.introduccion.cambioUsuario"/>
					</div>
				</td>
					
			</tr>
            <tr> 
            	<td></td>
                <td width="31%" height="20" ><div align="left" class="fuente-principal"><bean:message key="lbl.token.cambio.usuario.usuarioActual"/></div></td>
                <td colspan="2"><html:text property="usuarioActual" styleClass="caja-acceso" maxlength="16"   styleId="usuarioActual" value=""/> 
                <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
            </tr>
            <tr>
            	<td></td> 
                <td height="20" ><div align="left" class="fuente-principal"><bean:message key="lbl.token.cambio.usuario.nuevoUsuario"/></div></td>
                <td ><html:text property="nuevoUsuario" styleClass="caja-acceso" maxlength="16"  styleId="nuevoUsuario" value=""/>
                <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
            </tr>
            <tr> 
            	<td></td>
                <td height="20">
	                <div align="left" class="fuente-principal">
	                	<bean:message key="lbl.token.cambio.usuario.confirmeUsuario"/>
	                </div>
                </td>
                <td ><html:text property="nuevoUsuarioConfirmacion" styleClass="caja-acceso" maxlength="16"  styleId="nuevoUsuarioConfirmacion" value=""/> 
                <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
            </tr>
            <tr>
            	<td></td>
				<td colspan="2" height="20" valign="middle" class="fuente-obligatorio"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  			</tr>
		</table>

		    </td>
	<td>
	<!--  Tabla con Tips -->
	 	<%@ include file="../../divHeader.jsp"%>
	  <table cellspacing="3" cellpading="3" >
        <tr valign="top">
      	  <td colspan="2">
      	  <table><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><B><p class="fuente-recuadro-titulo"><bean:message key="lbl.token.cambio.usuario.recuerde"/></p></B></td>
	      </tr></table>
	      </td>
	    </tr>
	    <tr>
	       <td colspan="2" class="fuente-principal">
	          <UL>
	          	<li><bean:message key="lbl.token.cambio.usuario.obs4"/></li>
	          	<li><bean:message key="lbl.token.cambio.usuario.obs5"/></li>
	          </UL>
	       </td>
	    </tr>
	  </table>
	  <%@ include file="../../divFooter.jsp"%>
	</td>
		   </tr>
		 </table>
	</td>
  </tr>
 
   
  <tr><td>&nbsp;</td></tr>
<tr> 
	<td align="center">
        <html:hidden  property="pantalla" value="cambioUsuarioSuccess"/>   
        <input name="button" type="button" onClick="containBlank()" class="botton" value="<bean:message key="btn.enviar"/>"> 
        <input name="limpiar" type="reset" onClick="clear();" class="botton" value="<bean:message key="btn.limpiar"/>"> 
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>


</table>


</html:form>
</div>
</td>
</tr></table></td></tr>

</table></td></tr>
<tr>
	<td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;">
		<div align="center" class="derechos">&copy; 
			<bean:message key="<%=copyrigth %>"  arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
		</div>
	</td>
</tr>
</table></body></html>

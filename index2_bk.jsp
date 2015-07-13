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

<html:html>
<head>
    <title><bean:message key="tit.title.banco"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
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
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
    <td ><br>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr><td align="right"><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
			<br></td>
    <td>&nbsp;</td>
    
  </tr>
  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="width:254;height:26;background-color:#EFEFEF;"><div  class="bienvenida"></div></td>
  </tr>
  <tr valign="top"> 
    <td colspan="4"><table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td height="300" valign="middle"><table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center"> 
                    <form id="forma" method="POST" action="<html:rewrite page='/do.signon'/>" name="forma">
					<input type="hidden" name="servicio" value="1">
					<input type="hidden" name="remotehost" value="<%=request.getRemoteHost() %>">
					<input type="hidden" name="remoteip" value="<%=request.getRemoteAddr() %>">
					<input type="hidden" name="opt" value="3">
                      <table width="400" height="200" border="0" cellpadding="0" cellspacing="0" class="subtabla-acceso">
                        <tr> 
                          <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                              <tr> 
                                <td width="46%" rowspan="2"><div align="center"> 
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                      <tr> 
                                        <td><div align="center"><img src="<html:rewrite page='/images/system.jpg'/>"></div></td>
                                      </tr>
                                      <tr> 
                                        <td class="bienvenida">Bienvenidos a nuestro servicio de 
												Helm Virtual con acceso las 24 horas del día, todos los días del 
												año. </td>
                                      </tr>
                                    </table>
                                  </div></td>
                                <td width="54%" height="26" class="login1">Login</td>
                              </tr>
                              <tr> 
                                <td><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <tr> 
                                      <td><table width="100%" border="0" cellspacing="1" cellpadding="1">
                                          <tr> 
                                            <td class="texto-acceso">Usuario</td>
                                          </tr>
                                          <tr> 
                                            <td><input type="text" id="usuario" name="usuario" size="20" maxlength="16" title="Introduzca en este campo el login suministrado por el banco." class="botton-acceso"></td>
                                          </tr>
                                          <tr> 
                                            <td class="texto-acceso">Clave</td>
                                          </tr>
                                          <tr> 
                                            <td><input  type="password" id="clave" name="clave" size="20" maxlength="16" onkeypress="loginEnter();" title="Introduzca en este campo la clave para el login especificado." class="botton-acceso"></td>
                                          </tr>
										  <!-- 
										  <tr> 
                                            <td class="texto-acceso">Idioma</td>
                                          </tr>
                                          <tr> 
                                            <td><select name="locale" class="botton-acceso">   						
											<option value="es_PA" selected><bean:message key="lbl.espanol"/></option>
											<option value="en_US"><bean:message key="lbl.ingles"/></option>
										   </select> </td>
                                          </tr-->
										  <tr> 
                                            <td class="texto-acceso">&nbsp;<br></td>
                                          </tr>
                                          <tr> 
                                            <td><input name="btnSend" type="button" class="botton-acceso" value="<bean:message key="lbl.signon"/>" onclick="send();"></td>
                                          </tr>
                                        </table></td>
                                    </tr>
                                  </table></td>
                              </tr>
                            </table></td>
                        </tr>
                      </table>
                    </form>
                  </div></td>
              </tr>
              <tr> 
                <td><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="linea">
                    <tr> 
                      <td width="20%" class="tabla-acceso"><div align="center" class="bienvenida4">Noticias</div></td>
                      <td width="80%">&nbsp;</td>
                    </tr>
                    <tr> 
                      <td colspan="2"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                          <tr> 
                            <td class="bienvenida">
								<div align="justify"><common:mensaje-servicio servicio="1"  msgDefault="<%=message%>"/></div></td>
                          </tr>
                          <tr><td>&nbsp;</td></tr>
                          <tr><td>&nbsp;</td></tr>
                          <tr><td align="center">&nbsp;<script src=https://seal.verisign.com/getseal?host_name=www.helmpanama.com&size=M&use_flash=YES&use_transparent=YES></script></td></tr>                                                    
                        </table></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">&copy; 
        <bean:message key="msg.derechos.reservados"  arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div></td>
  </tr>
</table>
</body>
</html:html>
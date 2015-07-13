<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="com.arango.common.token.AuthenticationBroker"%>
<%@ page import="com.arango.common.token.beans.initAuthenticationResult"%>
<%@ page import="com.arango.common.util.Actividad"%>
<%@ include file="../head.jsp"%>


<script language="javascript" src="../scripts/campos.js"></script>
<script language="javascript" src="../scripts/ValidaFirmaDigital.js"></script>
<script type="text/javascript" src="<html:rewrite page='/token/firstLogin/tokenPinValidation.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script src="<html:rewrite page='/scripts/jquery.numeric.js'/>" type="text/javascript"></script>

<script language="javascript">

<% 
//Inicia proceso de autenticación
AuthenticationBroker auth = new AuthenticationBroker();
	//Entrada
String DomainMnemonic 	= session.getAttribute("fromDomainMnemonic").toString();
UserInfo userInfo2 = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
String userName = userInfo2.getEmpresa() + "-" + userInfo2.getUsuario() + "@" + DomainMnemonic;
String channelName = "IB_CCR";
channelName+= (userInfo2.getEmpresa()==1)?"_PAN":"_CAY";
String preferredLocale = "";
String notes = "";
//Salida
int initAuthenticationResult = 0;
int authMode = 0;
String uiDesc = new String();
String newHandle = new String();

initAuthenticationResult icta = auth.initAuthentication(/*IN*/userName,channelName,preferredLocale,notes, 
					/*OUT*/initAuthenticationResult,authMode,uiDesc,newHandle);
initAuthenticationResult = icta.getInitAuthenticationResult();
authMode = icta.getAuthMode();
uiDesc = icta.getUiDesc();
newHandle = icta.getNewHandle();				
if (initAuthenticationResult!=0 || authMode!=1){
	String error="Ocurrio un error al iniciar la autenticación.";
	Actividad.writeLog(new Exception(error + 
			"\ninitAuthenticationResult=" + initAuthenticationResult + 
			"\nauthMode="+ authMode + 
			"\nuiDesc="+uiDesc), userInfo2);
	
	if(uiDesc.lastIndexOf("-10013") > 0){
		response.sendRedirect(request.getContextPath()+"/token/errorToken.jsp"); 
	}
	else{
		throw new Exception(error);
	}					
}	
%>

$(document).ready(function(){
	 
	$("#claveold").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
	$("#clavenew").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
	$("#claveconf").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
	 
	 $("form").submit(function(){
		send();
		return false;		
	});
});


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
		
	//primero validamos si los campos son iguales
	campo1 = document.getElementById("clavenew").value;
	campo2 = document.getElementById("claveconf").value;
	
	if(campo1 != campo2){
		alert("<bean:message key="error.token.activarPin.confirmacion"/>");
		return false;
	}
	else{
		//validamos que sean del tamaño adecuado y sin sequencias
		if(!tokenLenValidation(6,campo1)) 
		{
			alert("<bean:message key="error.token.activarPin"/>");
			return false;
		}
		else if(!IsNumeric(campo1))
		{
			alert("<bean:message key="error.token.activarPin"/>");
			return false;
		}
		else if(!tokenSeqValidation(campo1))
		{
			alert("<bean:message key="error.token.activarPin"/>");
			return false;
		}
		else
		{
			return true;
		}
				
	}
	
}
var option = "0"; // Solamente teclado numerico

function IsNumeric(input)
{
    var RE = /^-{0,1}\d*\.{0,1}\d+$/;
    return (RE.test(input));
}
</script>
<%@ include file="../body.jsp"%>

<logic:present name="msg">
<table width="100%" border="0" cellspacing="1" cellpadding="1" class="tabla-acceso" >
	<tr> 
		<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
		<td valign="top">
			<table>
				<tr><td class="bienvenida"><b><bean:message key="errors.header"/></b></td></tr>
				<tr><td class="bienvenida">
		        <%String error = session.getAttribute("msg").toString();%>
					<bean:message key="<%=error%>"/></td></tr>
			</table>
		</td>
	</tr>
</table>   
</logic:present>
		 <%
   session.removeAttribute("msg");
	%>
<div align="center">
<table width="100%" align="left">
  <tr> 
	<td height="40" valign="top" colspan="4">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<!-- td width="92%"><div align="left" class="login"><bean:message key="tit.title.cambio.clave.especial"/></div></td>
			<td width="8%"><div align="right"></div></td-->
			<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
				<td width="100%"><div align="left" class="login"><bean:message key="tit.title.cambio.pin"/></div></td>
				<td width="8%"><div align="right"></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
<tr><td>
<table width="95%" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr valign="top">
     <td>
     <!--  Tabla con Cajas -->
     <form method="post" action="<html:rewrite page='/do.cambioPin'/>" name="forma">
		<input type="hidden" name="Foco" value="claveold" id="Foco" >
		<table width="600" border="0" align="center" cellpadding="0" cellspacing="2">
		  <tr> 
			<td width="31%" height="20" class="celda-clave1"><div  class="texto-acceso"><bean:message key="lbl.pin.actual"/></div></td>
			<td ><html:password property="oldPassw" styleClass="inputf" redisplay="false" onclick="campoChange(1);" styleId="claveold" maxlength="6"/> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			  
		  </tr>
		  <tr><td width="31%" height="20" class="celda-clave1"></td></tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div  class="texto-acceso"><bean:message key="lbl.nuevo.pin"/></div></td>
			<td ><html:password property="newPassw" styleClass="inputf" redisplay="false" onclick="campoChange(2);" styleId="clavenew" maxlength="6"/> 
			   <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			   
		  </tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div  class="texto-acceso"><bean:message key="lbl.confirme.nuevo.pin"/></div></td>
			<td ><html:password property="confirmPassw" styleClass="inputf" redisplay="false" onclick="campoChange(3);" styleId="claveconf" maxlength="6"/> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			  
		  </tr>
		  			<tr>
				<td  align="center"class="texto-acceso">
						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
				</td>
			</tr>
				<tr><td width="30%"><div align="right"></div></td>
			    	<td  align="left"  colspan="3" >
				    	<div id="teclado" style=" visibility: hidden;">
							<div id="lower" style="display: none;" ></div>
							<div id="upper"></div>
							<div id="cls" align="bottom"></div>		
						</div>
					</td>
			     </tr>
				<tr><td colspan="3">&nbsp;</td></tr>
		 

		  <tr> 
			<td>&nbsp;</td>
			<td colspan="2"><input name="button" onclick="send();" type="button" class="botton" value="<bean:message key="btn.enviar"/>"> 
			  <input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>"> 
			</td>
		  </tr>
		</table>
	  </form>
     </td>
   <td>
	<!--  Tabla con Tips -->
	<%@ include file="../divHeader.jsp"%>
	  <table  cellspacing="3" cellpading="3" >
        <tr valign="top">
      	  <td colspan="2">
      	  <table><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><p class="bienvenida"><B><bean:message key="lbl.cambio.pin.tips.titulo"/></B></p></td>
	      </tr>
	      </table>
	      </td>
	    </tr>
	    <tr valign="top">
	       <td colspan="2" class="bienvenida_2">
	          <UL>
	          	<li><bean:message key="lbl.cambio.pin.obs1" /></li>
	          	<li><bean:message key="lbl.cambio.pin.obs2" /></li>
	            <li><bean:message key="lbl.cambio.pin.obs3" /></li>
	            <li><bean:message key="lbl.cambio.pin.obs5" /></li>
	          </UL>
	       </td>
	    </tr>
	  </table>
	   <%@ include file="../divFooter.jsp"%>
	</td>
     </tr>
  <tr>
	<td height="20" valign="middle" class="texto-acceso" align="center"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table>
</tr>
</table>

</div>
<%@ include file="../footer.jsp" %>
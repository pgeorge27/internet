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
String DomainMnemonic = session.getAttribute("fromDomainMnemonic").toString();
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

<div class="container">
	<div class="row">

		
			<logic:present name="msg">
			<div class="well col-md-4 col-md-offset-4">
				<img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8">
				<p><b><bean:message key="errors.header"/></b></p>
				<p>
					<%String error = session.getAttribute("msg").toString();%>
					<bean:message key="<%=error%>"/>
				</p>
				</div>
			</logic:present>
			<p><% session.removeAttribute("msg"); %></p>
		

		<div class="col-md-4 col-md-offset-1">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.cambio.pin.obs1" />
					</strong>
				</div>

				<div class="panel-body">
					<p><bean:message key="lbl.cambio.pin.obs2" /></p>
					<p><bean:message key="lbl.cambio.pin.obs3" /></p>
					<p><bean:message key="lbl.cambio.pin.obs5" /></p>
				</div>
			</div>
		</div>

		<div class="col-md-6">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="tit.title.cambio.pin" />
					</strong>
				</div>

				<div class="panel-body">
					<form method="post" action="<html:rewrite page='/do.cambioPin'/>" name="forma">
						<input type="hidden" name="Foco" value="claveold" id="Foco" >

						<p>
							<bean:message key="lbl.pin.actual"/>
							<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
							<html:password property="oldPassw" styleClass="inputf form-control" redisplay="false" onclick="campoChange(1);" styleId="claveold" maxlength="6"/>
						</p>
						<p>
							<bean:message key="lbl.nuevo.pin"/>
							<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
							<html:password property="newPassw" styleClass="inputf form-control" redisplay="false" onclick="campoChange(2);" styleId="clavenew" maxlength="6"/>
						</p>
						<p>
							<bean:message key="lbl.confirme.nuevo.pin"/>
							<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
							<html:password property="confirmPassw" styleClass="inputf form-control" redisplay="false" onclick="campoChange(3);" styleId="claveconf" maxlength="6"/>
						</p>

						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />

						<div id="teclado" style=" visibility: hidden;">
							<div id="lower" style="display: none;" ></div>
							<div id="upper"></div>
							<div id="cls" align="bottom"></div>
						</div>

						<div align="center">
							<input name="button" onclick="send();" type="button" class="botton btn btn-default" value="<bean:message key="btn.enviar"/>">
							<input name="Submit2" type="reset" class="botton btn btn-default" value="<bean:message key="btn.limpiar"/>">
							<h6 style="color:#95A5A6 ">
								<bean:message key="lbl.mensaje.campo.requerido" />
							</h6>
						</div>
						</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../footer.jsp" %>
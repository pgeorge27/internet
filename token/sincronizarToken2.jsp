<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../head.jsp"%>
<%@ include file="../ib/jsScripts.jsp"%>

<script language="javascript" src="../scripts/campos.js"></script>
<script language="javascript" src="../scripts/ValidaFirmaDigital.js"></script>

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
    //if(validatePass())
    //{
    	document.forma.submit();
	//}  
}
function validatePass(){
  	if ((document.forma.newPassw.value.length < 7) || (document.forma.newPassw.value.length > 7))
  	{
     	 alert("<bean:message key="lbl.cambio.pin.observacion1"/>");
     	 return false;
  	}else if(!checkVal(document.forma.newPassw.value)){
  		 alert("<bean:message key="lbl.cambio.clave.especial.observacion3"/>");
    	 return false;
  	}
  	return true;    				 
}
var option = "0"; // Solamente teclado numerico   
</script>
<%@ include file="../body.jsp"%>
<%@ include file="../ib/blockDiv.jsp"%>



<div class="container">
	<div class="row" style="padding-right: 3%; padding-left: 3%;">

		
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
		

		<div class="col-md-8 col-md-offset-2">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.title.sincronizar.token.opt2"/>
					</strong>
				</div>

				<div class="panel-body">
					<form method="post" action="<html:rewrite page='/do.syncToken'/>" name="forma">
						<%
							String otp1 = session.getAttribute("otp1").toString();
							System.out.println("OTP1=" + otp1);
						%>
						<input type="hidden" name="Foco" value="claveold" id="Foco" >
						<input type="hidden" name="paso" value="2" id="paso" >
						<p><bean:message key="lbl.title.sincronizar.token.pasos" /></p>
						<p><bean:message key="lbl.pasos.sincronizar.token.paso1" /><img src="../images/TokenON.jpg" height="15"></p>
						<p><bean:message key="lbl.pasos.sincronizar.token.paso2" /><img src="../images/TokenClave.png" height="15"></p>
						<p>
						<bean:message key="lbl.pasos.sincronizar.token.paso3" /></p>


						<p><bean:message key="lbl.sincronizar.token.clave.generada" /><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></p>
						<p><input type="text" name="otp2" maxlength="8" class="inputf"  onclick="campoChange(1);" id="claveold"/>
						<input name="otp1" value="<%=otp1%>" type="hidden"></p>
						<p><input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" /></p>

						<div align="center">
							<input id="espera" name="button" onclick="send();" type="button" class="botton" value='<bean:message key="btn.enviar"/>'>
							<input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>"/>
							<div id="teclado" style="display: none; visibility: hidden;">
								<div id="lower" style="display: none;" ></div>
								<div id="upper"></div>
								<div id="cls" align="bo"></div>		
							</div>

							<bean:message key="lbl.mensaje.campo.requerido"/>
						</div>
					</form>
				</div>
			</div>
		</div>


	</div>
</div>



<%@ include file="../footer.jsp" %>
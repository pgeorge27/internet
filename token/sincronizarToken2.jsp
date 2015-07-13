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
				<td width="100%"><div align="left" class="login"><bean:message key="tit.title.sincronizar.token"/></div></td>
				<td width="8%"><div align="right"></div></td>
		  </tr>
		  <tr>
		  	<td width="50px">&nbsp;</td>
		  	<td width="100%" class="bienvenida"><bean:message key="lbl.title.sincronizar.token.opt2"/></td>
		  	<td width="8%"><div align="right"></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
<tr><td>
<form method="post" action="<html:rewrite page='/do.syncToken'/>" name="forma">
<%
	String otp1 = session.getAttribute("otp1").toString();
	System.out.println("OTP1=" + otp1);
%>
<table width="95%" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr valign="top">
     <td>
     <!--  Tabla con Cajas -->     
		<input type="hidden" name="Foco" value="claveold" id="Foco" >
		<input type="hidden" name="paso" value="2" id="paso" >
		<table width="600" border="0" cellpadding="0" cellspacing="2">
		  <tr><td class="bienvenida" colspan="2"><bean:message key="lbl.title.sincronizar.token.pasos" /></td>
		  </tr>
		  <tr><td class="bienvenida" colspan="2"><dd><bean:message key="lbl.pasos.sincronizar.token.paso1" /><img src="../images/TokenON.jpg" height="15"></dd></td></tr>
		  <tr><td class="bienvenida" colspan="2"><dd><bean:message key="lbl.pasos.sincronizar.token.paso2" /><img src="../images/TokenClave.png" height="15"></dd></td></tr>
		  <tr><td class="bienvenida" colspan="2"><dd><bean:message key="lbl.pasos.sincronizar.token.paso3" /></dd><br></td></tr>
		  <tr> 
			<td width="31%" height="20" class="celda-clave1" align="left"><div  class="texto-acceso"><bean:message key="lbl.sincronizar.token.clave.generada" /></div></td>
			<td><input type="text" name="otp2" maxlength="8" class="inputf"  onclick="campoChange(1);" id="claveold"/> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span><input name="otp1" value="<%=otp1%>" type="hidden"></td>	  
		  </tr>
		  <tr>
				<td  align="center"class="texto-acceso">
						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
				</td>
			</tr>
				<tr><td width="30%"><div align="right"></div></td>
			    	<td  align="left"  colspan="3" >
						<input id="espera" name="button" onclick="send();" type="button" class="botton" value='<bean:message key="btn.enviar"/>'><input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>"/>
						<div id="teclado" style=" visibility: hidden;">
							<div id="lower" style="display: none;" ></div>
							<div id="upper"></div>
							<div id="cls" align="bo"></div>		
						</div>
					</td>
			     </tr>
				<tr><td colspan="3">&nbsp;</td></tr>
		 

		  <tr> 
			<td>&nbsp;</td>
			<td colspan="2"> 
			   
			</td>
		  </tr>
		</table>
	  </form>
     </td>
   <td>
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
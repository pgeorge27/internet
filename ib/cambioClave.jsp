<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../head.jsp"%>

<%session.setAttribute("no.aplicar.regla.password", "true"); %>
<script language="javascript" src="../scripts/campos.js"></script>
<script language="javascript">
function campoChange(campo){
if(1 == campo){
	Foco = "claveold"
}else if(2 == campo){
	Foco = "clavenew"
}else if(3 == campo){
	Foco = "claveconf"
}}
function limpiar(){
	document.forms['UsuarioForm'].oldPassw.value = "";
	document.forms['UsuarioForm'].newPassw.value = "";
	document.forms['UsuarioForm'].confirmPassw.value = "";	
}
function send(){
    if(validatePass())
    {
    	document.forms['UsuarioForm'].submit();
	}  
}
function validatePass(){
  	if ((document.forms['UsuarioForm'].newPassw.value.length < 8) || (document.forms['UsuarioForm'].newPassw.value.length > 11))
  	{
     	 alert("<bean:message key="lbl.cambio.clave.observacion1"/>");
     	 return false;
  	}
  	return true; 				 
}

var Foco = "claveold";
</script>
<%@ include file="../body.jsp"%>
 
<logic:present name="msg">
<table width="100%" border="0" cellspacing="1" cellpadding="1" class="tabla-acceso">
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
<table width="850" align="left"><tr><td width="20">&nbsp;</td>
<td> 
<table width="830" border="0" align="left" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<!-- td width="68%"><div align="right" ><img src="<html:rewrite page='/images/gancho.gif' />"/></div></td>
			<td width="32%"><div align="left" class="login"><bean:message key="tit.title.cambio_clave"/></div></td-->
			<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
				<td width="100%"><div align="left" class="login"><bean:message key="tit.title.cambio_clave"/></div></td>
				<td width="8%"><div align="right"></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr> 
	<td valign="top">
		<table>
		  <tr valign="top">
		    <td>
		      <!--  Tabla con Campos -->
		      <html:form action="/change/psw" method="post">
		     
		<table width="450" border="0" align="center" cellpadding="0" cellspacing="2">
		  <tr> 
			<td width="31%" height="20" class="celda-clave1"><div  class="texto-acceso"><bean:message key="lbl.clave_usuario_anterior"/></div></td>
			 <td colspan="2"><html:password property="oldPassw" styleClass="caja-acceso" maxlength="11"   styleId="claveold" /> 
			   <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
		  </tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div  class="texto-acceso"><bean:message key="lbl.clave_usuario_nueva"/></div></td>
			 <td colspan="2"><html:password property="newPassw" styleClass="caja-acceso" maxlength="11"  styleId="clavenew" />
			  
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
		  </tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div  class="texto-acceso"><bean:message key="lbl.reescriba_clave_usuario"/></div></td>
				<td colspan="2"><html:password property="confirmPassw" styleClass="caja-acceso" maxlength="11"  styleId="claveconf" /> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
		  </tr>
		  										<!-- tr>
											<td colspan="2" class="style4">
												<input type="checkbox" id="changeLettersfull" checked="false" onclick="changeStyle();"  />
												<b class="texto-acceso">Cambiar a teclado en minúscula</b>
											</td>
										</tr>
										<tr align="center">
											<td colspan="3">

												<div id="teclado_full">
													<div id="lowerf" style="display: none;"></div>
													<div id="upperf"></div>
													<div id="cls" align="bottom"></div>		
												</div>
											</td>
										</tr -->	
		  <tr><td colspan="3">&nbsp;</td></tr>
		  <tr> 
			<td>&nbsp;</td>
			<td colspan="2"><input name="button" onclick="send();" type="button" class="botton" value="<bean:message key="btn.enviar"/>"> 
			  <input name="Submit2" type="button" class="botton" onclick="limpiar();" value="<bean:message key="btn.limpiar"/>"> 
			</td>
		  </tr>
		</table>
	  </html:form>
		    </td>
	<td>
	<!--  Tabla con Tips -->
	<%@ include file="../divHeader.jsp"%>
	  <table cellspacing="3" cellpading="3" >
        <tr valign="top">
      	  <td colspan="2">
      	  <table><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><B><p class="bienvenida_2"><bean:message key="lbl.preg.secreta.observacion"/></p></B></td>
	      </tr></table>
	      </td>
	    </tr>
	    <tr>
	       <td colspan="2" class="bienvenida_2">
	          <UL>
	          	<li><bean:message key="lbl.cambio.clave.obs1" /></li>
	          	<li><bean:message key="lbl.cambio.clave.obs2" /></li>
	          	<li><bean:message key="lbl.cambio.clave.obs3" /></li>
	          </UL>
	       </td>
	    </tr>
	  </table>
	  <%@ include file="../divFooter.jsp"%>
	</td>
		   </tr>
		 </table>
	</td>
  </tr>
  
  <tr>
	<td height="20" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table>
</td></tr>
</table>
<%@ include file="../footer.jsp" %>
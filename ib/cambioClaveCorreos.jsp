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
function send(){
    if(validatePass())
    {
    	document.forma.submit();
	}  
}
function validatePass(){
  	if ((document.forma.newPassw.value.length < 8) || (document.forma.newPassw.value.length > 11))
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabla-acceso">
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
<table width="750" align="left"><tr><td width="20">&nbsp;</td>
<td> 
<table width="730" border="0" align="left" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="68%"><div align="left" class="login"><bean:message key="lbl.cambio.clave.correos"/></div></td>
			<td width="32%"><div align="right"></div></td>
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
<form method="post" action="<html:rewrite page='/do.ChangeEmailPassword'/>"  name="forma">
			
		<table width="450" border="0" align="center" cellpadding="0" cellspacing="2">
		  <tr> 
			<td width="31%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.clave_anterior"/></div></td>
			<td colspan="2"><html:password property="oldPassw" styleClass="inputf" redisplay="false"  styleId="claveold" onclick="campoChange(1);" onkeypress="javascript: return false;" onkeydown="javascript: return false;"/> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
		  </tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.clave_nueva"/></div></td>
			<td colspan="2"><html:password property="newPassw" styleClass="inputf" redisplay="false" styleId="clavenew" onclick="campoChange(2);" onkeypress="javascript: return false;" onkeydown="javascript: return false;" /> 
			 
			 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
		  </tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.reescriba_clave"/></div></td>
			<td colspan="2"><html:password property="confirmPassw" styleClass="inputf" redisplay="false"  styleId="claveconf"  onclick="campoChange(3);"  onkeypress="javascript: return false;" onkeydown="javascript: return false;"/> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
		  </tr>			
		  
		  <tr>
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
	  <table cellspacing="3" >
        <tr valign="top">
      	  <td colspan="2">
      	  <table><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><B><bean:message key="lbl.preg.secreta.observacion"/></B></td>
	      </tr></table>
	      </td>
	    </tr>
	    <tr>
	       <td colspan="2" class="bienvenida">
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
</td></tr></table>
<%@ include file="../footer.jsp" %>
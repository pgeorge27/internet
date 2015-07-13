<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../head.jsp"%>


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
    if(validatePass())
    {
    	document.forma.submit();
	}  
}
function validatePass(){
  	if ((document.forma.newPassw.value.length < 4) || (document.forma.newPassw.value.length > 4))
  	{
     	 alert("<bean:message key="lbl.cambio.clave.especial.observacion1"/>");
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
				<td width="100%"><div align="left" class="login"><bean:message key="tit.title.cambio.clave.especial"/></div></td>
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
     <form method="post" action="<html:rewrite page='/do.claveespecial'/>" name="forma">
		<input type="hidden" name="Foco" value="claveold" id="Foco" >
		<table width="600" border="0" align="center" cellpadding="0" cellspacing="2">
		  <tr> 
			<td width="31%" height="20" class="celda-clave1"><div  class="texto-acceso"><bean:message key="lbl.clave_anterior"/></div></td>
			<td ><html:password property="oldPassw" styleClass="inputf" redisplay="false" onclick="campoChange(1);" styleId="claveold" onkeypress="javascript: return false;" onkeydown="javascript: return false;" maxlength="4" /> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			  
		  </tr>
		  <tr><td width="31%" height="20" class="celda-clave1"></td></tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div  class="texto-acceso"><bean:message key="lbl.clave_nueva"/></div></td>
			<td ><html:password property="newPassw" styleClass="inputf" redisplay="false" onclick="campoChange(2);" styleId="clavenew" onkeypress="javascript: return false;" onkeydown="javascript: return false;" maxlength="4"/> 
			   <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			   
		  </tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div  class="texto-acceso"><bean:message key="lbl.reescriba_clave"/></div></td>
			<td ><html:password property="confirmPassw" styleClass="inputf" redisplay="false" onclick="campoChange(3);" styleId="claveconf" onkeypress="javascript: return false;" onkeydown="javascript: return false;" maxlength="4"/> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			  
		  </tr>
		  			<tr>
				<td  align="center"class="texto-acceso">
						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
				</td>
			</tr>
				<tr><td width="30%"><div align="right"></div></td>
			    	<td  align="left"  colspan="3" >
				    	<div id="teclado">
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
	      <td><p class="bienvenida"><B><bean:message key="lbl.firma.digital.tips.titulo"/></B></p></td>
	      </tr>
	      </table>
	      </td>
	    </tr>
	    <tr valign="top">
	       <td colspan="2" class="bienvenida_2">
	          <UL>
	          	<li><bean:message key="lbl.cambio.clave.especial.obs1" /></li>
	          	<li><bean:message key="lbl.cambio.clave.especial.obs2" /></li>
	            <li><bean:message key="lbl.cambio.clave.especial.obs3" /></li>
	            <li><bean:message key="lbl.cambio.clave.especial.obs4" /></li>
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
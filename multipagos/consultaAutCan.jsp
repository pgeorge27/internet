<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
System.out.print("JSP-BEGIN");
System.out.println(new java.util.Date(System.currentTimeMillis()));
%>
<%@ include file="../head.jsp"  %> 

<%@ include file="../body.jsp"%>
<script type="text/javascript">
function send(){
	
		if(document.forms['consultaForm'].cliente.value == ""){
			alert(" - Cliente es requerido. "); 
			document.forms['consultaForm'].desde.focus();
			return;
		}
		
	document.forms['consultaForm'].submit();
}

</script>


<br>
<logic:messagesPresent>
  <table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
	<span class="bienvenida">
		<table width="80%">
		<html:messages id="error">					
			<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
		</html:messages>
		</table>
	</span><br>
								   </td></tr>
			 </table></td></tr>
		  </table>
</logic:messagesPresent>
<div align="left"> 
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
	<div align="left"> 
		<table  width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr valign="bottom">  <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
			<td><div align="left" class="login"><bean:message key="lbl.transf.inter.aprobacion"/> Multipagos</div></td>
		  </tr>
		</table>
		</div>
	</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
<html:form method="post" action="/multipagos/Consulta/autorizaciones">
<html:hidden property="estado" value="P" /> 
<html:hidden property="tipo" value="1" /> 
		<%@ include file="../divHeader.jsp"%>
		<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">
		  <tr> 
			<td width="31%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.transf.inter.cliente"/></div></td>
			<td width="34%" nowrap><html:select property="cliente" styleClass="botton-acceso">
										<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
										<csic:forEachCliente orderBy="NAME_ORDER">  
											<html:option value="<%=codigo%>" ><%=nombre%>&nbsp;<%=apellido%></html:option>	
										 </csic:forEachCliente>
								   </html:select> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
		  
		  <tr > 
			<td width="50%" align="center" colspan="2"><br>
			<input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">
			
			<html:reset styleClass="botton"><bean:message key="btn.limpiar"/></html:reset>
			</td>
		  </tr>
		</table>
		 <%@ include file="../divFooter.jsp"%>
	  </html:form></td>
  </tr>
  
  <tr>
	<td  colspan="2" height="20" valign="middle"  align="center" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table></div>
	
<%@ include file="../footer.jsp"  %>
<%
System.out.print("JSP-END");
System.out.println(new java.util.Date(System.currentTimeMillis()));
%>
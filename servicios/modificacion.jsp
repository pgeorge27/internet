<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../head.jsp"  %> 

<%@ include file="../body.jsp"%>

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
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
			<td><div align="left" class="login"><bean:message key="lbl.transf.inter.modificacion"/></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top" align="center" >
<html:form method="post" action="/query3">
<html:hidden property="estado"  /> 
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
		  
		  <tr> 
			<td colspan="2" align="center"><br>
			<html:submit styleClass="botton"><bean:message key="btn.consultar"/></html:submit>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<html:reset styleClass="botton"><bean:message key="btn.limpiar"/></html:reset>
			</td>
		  </tr>
		</table>
<%@ include file="../divFooter.jsp"%>
	  </html:form></td>
  </tr>
  
  <tr>
	<td height="20" valign="middle" class="texto-acceso" align="center"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table></div>
	
<%@ include file="../footer.jsp"  %>
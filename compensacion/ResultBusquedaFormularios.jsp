<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@ page import="com.arango.common.util.Format" %>
<%@ page import="java.util.Locale" %>

<%@ include file="../head.jsp"%>

<SCRIPT language=javascript src="../scripts/formatDes.js"></SCRIPT>
<%@ include file="../body.jsp"%>
<%
 Format f = Format.getFormat();
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
%>
<div id="estcta" align="left">
<logic:messagesPresent>
	<table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso">
		<tr>
			<td>
				<table border="0" cellpadding="1" cellspacing="0" width="100%">
					<tr valign="top">
						<td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
						<td width="95%" class="msg">
							<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
							<span class="bienvenida">
								<table width="80%">
								<html:messages id="error">					
									<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
								</html:messages>
								</table>
							</span><br>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</logic:messagesPresent>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr> 
		<td height="30" class="texto-acceso">
			<div id=bankdiv align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>"  width="116" height="68"></div>
		</td>
		<td class="texto-acceso"><div align="right">&nbsp;</div></td>
	</tr>
	<tr> 
		<td height="40" colspan="2" valign="bottom">
			<div align="center"> 
				<table width="100%" border="0" cellpadding="2" cellspacing="2"  align="left">
					<tr>
						<td width="50px" align="center" ><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
						<td width="92%">
							<div align="left" class="login">
							<%
							Object obj = session.getAttribute("con.tipo.doc");
							String tipo = obj == null ? "1" : obj.toString();
							if ("1".equals(tipo)){%>
							Consulta Documentos Importacion
							<%}else if("2".equals(tipo)){%>
							Consulta Documentos Exportacion
							<%}%>
							<br/>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
	<tr> 
		<td valign="top" align="center">
			<table width="100%" border="0" cellspacing="1" cellpadding="0">                   
				<tr> 
				  <td width="55%" height="20" class="catra-texto" align="center">
				  <br/>
	<%@ include file="../divHeader.jsp"%>
	<table width="60%" border="0" cellpadding="0" cellspacing="2" align="center">
		<tr> 
		<br/>
			<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.desde"/></div></td>
			<td height="15" class="bienvenida" align="right"><%=f.formatFecha((java.util.Date)session.getAttribute("desde"), locale)%></td>
			<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.hasta"/></div></td>
			<td height="15" class="bienvenida" align="right"><%=f.formatFecha((java.util.Date)session.getAttribute("hasta"), locale)%></td>
		</tr>
	</table>

	<table width="60%" border="0" cellpadding="0" cellspacing="2" align="center">
		<tr> 
			<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso">N° Cuenta</div></td>
			<td align="right" height="15" class="bienvenida"><%=session.getAttribute("busqueda.resultado.cuenta")%></td>
		</tr>
		<tr> 
			<td height="15" class="celda-clave1"><div align="right" class="texto-acceso">Número Documento</div></td>
			<td height="15" align="right" class="bienvenida"><%=session.getAttribute("busqueda.resultado.Doc")%></td>
       </tr>
	</table>

	<br>
	<table width="100%" border="0" cellpadding="0" cellspacing="2">
		<logic:present name="busqueda.resultados.formularios">
		<tr class="tabla-acceso">
			<td class="texto-acceso" align="center" width="20%" ><bean:message key="formulario.1059.numero.declaracion.cambio"/></TD>
			<td class="texto-acceso" align="center" width="20%"><bean:message key="formulario.1059.fecha.declaracion.cambio"/></TD>
			<td class="texto-acceso" align="center" width="20%">Formato Dian</TD>
			<td class="texto-acceso" align="center" width="20%" align="right">Número Documento</TD>
		</tr>
	 
		<logic:iterate name="busqueda.resultados.formularios" id="row" type="com.arango.internet.banking.dian.Formulario" indexId="resultNo" >
			<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
			<logic:equal name="remainder" value="0">
			   <tr>
			</logic:equal>
			<logic:notEqual name="remainder" value="0">
			   <tr class="celda-clave1">
			</logic:notEqual>
				<TD class="bienvenida" align=middle width="20%"><bean:write name="row" property="numeroDeclaracion"/></TD>
				<TD class="bienvenida" align=middle width="20%"><bean:write name="row" property="fechaDeclaracionCambio" formatKey="formato-fecha"/></TD>
				<TD class="bienvenida" align=middle width="20%"><bean:write name="row" property="action"/></TD>
				<TD class="bienvenida" align=middle width="20%"><bean:write name="row" property="numeral"/></TD>
			</tr>
		</logic:iterate>
		</logic:present>
		<logic:notPresent name="busqueda.resultados.formularios">
		<table width="100%" border="0" cellpadding="0" cellspacing="2">
			<tr class="tabla-acceso">
			<TD class="texto-acceso" width="80%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No existen movimientos para este Número Documento&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr></table>
			<br/>
		<%@ include file="../divFooter.jsp"%>
		</logic:notPresent>
	</table>
	<logic:present name="busqueda.resultados.formularios">
	<br/>
		<%@ include file="../divFooter.jsp"%>
	</logic:present>
	<br/>
	<table width="80%" border="0" cellpadding="0" cellspacing="2">
		<tr> 
			<td valign="top" class="texto-acceso" colspan="2">
				<div align="center">
					<input type="image" onclick="printPage3()" src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32">
				</div>
			</td>
		</tr>
		<tr> 
			<td valign="top" class="texto-acceso" colspan="2">
				<div align="center"><br>
					<INPUT class="botton" onclick="history.back();" type=button value="<bean:message key="lbl.retroceder"/>">
					<br/>
				</div>
			</td>
		</tr>
	</table>
</table>
</div>
<br/>
<%@ include file="../footer.jsp"  %>
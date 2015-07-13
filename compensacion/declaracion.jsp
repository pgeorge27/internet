<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="com.arango.common.util.Format" %>
<%@page import="com.arango.internet.banking.Movimiento" %>
<%@page import="com.arango.internet.banking.EstadoCuenta" %>
<%@page import="com.arango.internet.banking.Titular" %>

<%! Format f = Format.getFormat();%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
%>
<%
Object objEstCta = session.getAttribute("movimiento");
EstadoCuenta ec = null;
java.util.ArrayList mov = null;

if (objEstCta instanceof com.arango.internet.banking.EstadoCuenta){
	ec = (EstadoCuenta)objEstCta;
	mov = ec.Movimientos;
}
else{
}

if (ec == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/compensacion/seleccion.jsp");   
	return;
}
String cuenta = (String)session.getAttribute("cuenta.banco");
String cliente = ((Titular)ec.Titulares.get(0)).getNombre();
Integer indice = (Integer)session.getAttribute("indice");
Movimiento movimiento = null;
if (indice != null){
	movimiento = (Movimiento)mov.get(indice.intValue());
    movimiento.setRuta(null);
}

%>

<script>
function _submit(_path){
	document.forms[0].ruta.value = ""+_path;
	openwin("<html:rewrite page='/compensacion/formulario4.jsp'/>?cuenta=<%=session.getAttribute("cuenta.csic")%>&indice=<%=indice%>&ruta="+_path);
	document.location="<html:rewrite page='/compensacion/movimiento.jsp'/>";
}
function openwin(url)
{
	nwin=window.open(url, "nwin",config="scrollbars=no,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no");
	nwin.focus();
}

</script>

<%@ include file="../body.jsp" %>
<%
	Integer indiceSession = (Integer) session.getAttribute("indice");
	String cuentaSession = (String) session.getAttribute("cuenta.csic");	
%>
<html:form action="/consultar/formulario" method="post" target="_formulario">
	<html:hidden property="indice" value="<%=indiceSession.toString() %>"/>
	<html:hidden property="cuenta" value="<%=cuentaSession %>"/>
	<html:hidden property="ruta" />
</html:form>
<br>
<logic:messagesPresent>
  <table cellpadding="1" align="center" cellspacing="1" width="80%" class="tabla-acceso">
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

<div align="center"> 
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td	height="40"	valign="bottom">
		<div align="center">
		<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			<tr>
				<td>
				<div align="center"> 
			<table width="100%" border="0" cellpadding="2" cellspacing="2" class="linea-botton">
			  <tr> 
				<td width="92%"><div align="left" class="login">
					<bean:message key="lbl.compensacion.movimiento.titulo"/>
					</div></td>
				<td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="document.location='<html:rewrite page='/compensacion/movimiento.jsp'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
			  </tr>
			</table></div>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td class="texto-acceso">&nbsp;</td>
	</tr>
</table>	 
<table width="40%" border="0" cellpadding="0" cellspacing="2" align="center">
		<tr> 
		  <td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.numero.cuenta"/></div></td>
          <td align="right" height="15" class="bienvenida"><%=f.formatCuenta(ec.getNumeroCuenta())%></td>
       </tr>
		<tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.titular"/></div></td>
          <td height="15" align="right" class="bienvenida"><%=cliente %></td>
       </tr>
		<tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.3"/></div></td>
          <td height="15" align="right" class="bienvenida"><bean:write name="descripcionMovimiento" property="fechaValida" format="dd/MMM/yyyy"/></td>
       </tr>
		<tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.6"/></div></td>
          <td height="15" align="right" class="bienvenida"><bean:write name="descripcionMovimiento" property="descripcion"/></td>
       </tr>
       
		<tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.5"/></div></td>
          <td height="15" align="right" class="bienvenida"><bean:write name="descripcionMovimiento" property="monto" format="##,###,###,##0.00"/></td>
       </tr>
</table>	 
<table border="0" cellpadding="0" cellspacing="0" width="595" bgcolor="#FFFFFF">
			<tr>
				<td height="45">
					<center>
					<font face=arial size=3><b> FORMULARIOS REGIMEN CAMBIARIO </b></font>
					<table border="1" cellpadding="4" cellspacing="0" width="446" bordercolor="#B1B990" height="159">
						<%if (movimiento.getTipo() == 0){ %>
						<tr>
							<td width="456" height="14"><font size="1">
								<a href="javascript:_submit('Formulario1.pdf');">
								Formulario No. 1 -  Declaración de cambio por Importación de Bienes</a>
							</font></td>
							<td width="456" height="14"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" width="16" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a  target="new" href="https://quimbaya.banrep.gov.co/secinternet/instructivos/instr120031201.pdf">
								Instrucciones</a>
							</font></td>
						</tr>
						<tr>
							<td width="456" height="14"><font size="1">
								<a href="javascript:_submit('Formulario2.pdf');">
								Formulario No. 2 - Declaración de Cambio por Exportación de Bienes</a>
							</font></td>
							<td width="456" height="14"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" width="16" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a  target="new" href="https://quimbaya.banrep.gov.co/secinternet/instructivos/instr220031201..pdf">
								Instrucciones</a>
							</font></td>
						</tr>
						<tr>
							<td width="456" height="14"><font size="1">
								<a href="javascript:_submit('Formulario3.pdf');">
								Formulario No. 3 - Declaración de Cambio por Endeudamiento Externo</a>
							</font></td>
							<td width="456" height="14"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" width="16" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a  target="new" href="https://quimbaya.banrep.gov.co/secinternet/instructivos/Instr320031201.pdf">
								Instrucciones</a>
							</font></td>
						</tr>
						
						<tr>
							<td width="456" height="14"><font size="1">
								<a  href="javascript:_submit('Formulario4.pdf');">
								Formulario No. 4 - Declaración de Cambio por Inversiones Internacionales</a>
							</td>
							<td width="456" height="14"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" width="16" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/instr420031201.pdf">
								Instrucciones</a>
							</font></td>
						</tr>
						<%} %>
						<tr>
							<td width="456" height="14"><font size="1">
								<a  href="javascript:_submit('Formulario5.pdf');">
								Formulario No. 5 - Declaración de Cambio Servicios, Transferencias y otros Conceptos</a>
							</td>
							<td width="456" height="14"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" width="16" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/InstrF520031201.pdf">
								Instrucciones</a>
							</font></td>
						</tr>
						
						
						
						
					</table>
				</td>
			</tr>
		</table>
		</div>

<table width="80%" border="0" cellpadding="0" cellspacing="2">
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
				<INPUT class="botton" onclick="document.location='<html:rewrite page='/compensacion/movimiento.jsp'/>'" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>

<%@ include file="../footer.jsp"  %>	
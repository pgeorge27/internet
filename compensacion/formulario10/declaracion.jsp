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
<%@ include file="../../head.jsp"%>
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
String cliente = (String)session.getAttribute("titular");
Integer indice = (Integer)session.getAttribute("indice");
if (indice != null){
    Movimiento movimiento = (Movimiento)mov.get(indice.intValue());
    movimiento.setRuta(null);
}
%>

<script>
function _submit(_path){
    document.forms[0].ruta.value = ""+_path;	
	openwin("<html:rewrite page='/compensacion/formulario10/formulario4.jsp'/>?cuenta=<%=session.getAttribute("cuenta.csic")%>&indice=<%=indice%>&ruta="+_path);
	document.location="<html:rewrite page='/formulario10/mant/cuenta.do'/>";
}
function openwin(url)
{
	nwin=window.open(url, "nwin",config="scrollbars=no,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no");
	nwin.focus();
}
</script>
<html:form action="/formulario10/elaborar/formulario" method="post" target="_formulario">
	<html:hidden property="indice" value="<%=session.getAttribute("indice").toString()%>"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
	<html:hidden property="ruta" />
</html:form>
<%@ include file="../../body.jsp" %>

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
					<bean:message key="lbl.compensacion.formulario.10.movimiento.titulo"/>
					</div></td>
				<td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="document.location='<html:rewrite page='/formulario10/mant/cuenta.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
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
</table>	 
<table border="0" cellpadding="0" cellspacing="0" width="595" bgcolor="#FFFFFF">
			<tr>
				<td height="45">
					<center>
					<font face=arial size=3><b> FORMULARIOS REGIMEN CAMBIARIO </b></font>
					<table border="1" cellpadding="4" cellspacing="0" width="446" bordercolor="#B1B990" height="159">
						
						<tr>
							<td width="456" height="14"><font size="1">
								<a  href="javascript:_submit('Formulario10.pdf');">
								Formulario No. 10 - Relación de Operaciones Cuenta Corriente de Compensación</a>
							</td>
							<td width="456" height="14"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" width="16" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/Instr1020031201.pdf">
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
				<INPUT class="botton" onclick="document.location='<html:rewrite page='/formulario10/mant/cuenta.do'/>'" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>

<%@ include file="../../footer.jsp"  %>	
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>

<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>

<script language="javascript">
function __retornar(){
	document.location="<html:rewrite page='/multicash.do'/>";
}	
function __submit()
{
	document.forms[0].submit();
}


</script>

<!--  Funcion para Rellenar de Ceros -->
<%! String valores(int numero)
{
	String cad = String.valueOf(numero);
	String resp = "0";
	if (cad.length() < 2)
	{
		resp += cad;
	}
	else
		resp = cad;
	return resp;
}
%>
<%
session.removeAttribute("representante.accion.nuevo");
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
Calendar cal = Calendar.getInstance();
int dia = cal.get(Calendar.DAY_OF_MONTH);
int ano = cal.get(Calendar.YEAR);
int mes = cal.get(Calendar.MONTH) + 1;
String anoCorto = String.valueOf(ano).substring(2,4);
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>
<%@ include file="../body.jsp" %>

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


	<html:form method="post" action="/multicash/links">
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
				<td width="92%"><div align="left" class="login"><div> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
            <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>		  
			<td><div align="left" class="login">Helm Conexión</div></td>
		  </tr>
		</table>
	  </div></div></td>
				<td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="document.location='<html:rewrite page='multicash.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
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
		  <td height="15" class="celda-clave1" width="30%"nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.numero.cuenta"/></div></td>
          <td align="right" height="15"  width="70%" class="bienvenida"><%= com.arango.common.util.Format.getFormat().formatCuenta((String)session.getAttribute("cuentaMC"), "A-S-C")%></td>
       </tr>
		<tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.titular"/></div></td>
          <td height="15" align="right" class="bienvenida"><%=session.getAttribute("nombreClienteMC") %></td>
       </tr>
       <tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.fecha"/></div></td>
          <td height="15" align="right" class="bienvenida"><%=session.getAttribute("fechaDesde") %></td>
       </tr>
       <tr><td colspan="2">
       
	<table border="0" cellpadding="0" cellspacing="0" width="595" bgcolor="#FFFFFF">
			<tr>
				<td height="45">
					<center>
					<font face=arial size=3><b>Descargar </b></font>
					<table border="1" cellpadding="4" cellspacing="0" width="446" bordercolor="#B1B990" height="159">
						<tr>
							<td width="50%" height="14"><a target="_NEW" href="<html:rewrite page='/a.multicashArchivoAction?opt=E'/>">Encabezado</a></td>
								<td width="50%" class="bienvenida"><a target="_NEW" href="<html:rewrite page='/a.multicashArchivoAction?opt=D'/>">Detalle</a></td>
				</tr>
				</table></center>
				<tr>
					<td align="center" colspan="2"><br><br><br><br><br><br><input type="button" class="botton" name="btnpc" onclick="__retornar()" value="<bean:message key="lbl.retroceder"/>"/></td></tr>
								
</table></div></html:form>
<%@ include file="../footer.jsp"  %>	
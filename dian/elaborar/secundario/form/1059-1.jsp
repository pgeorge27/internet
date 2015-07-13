<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ include file="/dian/elaborar/edit/include/jspfunciones.inc.jsp" %>
<%@ include file="/head.jsp"  %>
	
<link href="<html:rewrite page='/dian/elaborar/edit/css/estilo.css'/>" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>

<%
session.setAttribute("{codigoMoneda}", GetList(application, "DTABLA7"));


java.util.Locale localeCalendar = (java.util.Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (localeCalendar == null){
    localeCalendar = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, localeCalendar);
}
String calendar = "/calendar/calendar-"+localeCalendar.getLanguage()+".js";
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>

<script language=javascript>
function __retornar(){
	document.location="<html:rewrite page='/dian/elaborar/secundario/1059-1.jsp'/>";
}
</script>


<%@ include file="/body.jsp"%>
<html:form action="/dian/elaborar/guardar" method="post">
<html:hidden property="formulario" value="1059"/>
<table width="500" border="0" align="center" cellpadding="0"
	cellspacing="0" class="cuadro">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td>
						<div align="center" class="txtTitulo">FORMULARIO 1059 Informaci�n de la Descripci�n de la Operaci�n</div>
						</td>
						<td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
					</tr>
					<tr>
						<td height="5" colspan="2" align="right"></td>
					</tr>
				
					<tr>
						<td>
						<div align="right" class="txtTexto">Fecha declaraci�n de cambio</div>
						</td>
						<td nowrap>
						<html:text property="strFechaDeclaracionCambio" styleId="fechaDeclaracionCambio" 
						size="20" maxlength="10"/><img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>" 
						onclick="return showCalendar('fechaDeclaracionCambio', 'y-mm-dd');" 
						alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N�mero declaraci�n cambio
						</div>
						</td>
						<td>
						<html:text property="numeroDeclaracionCambio" styleId="numeroDeclaracionCambio" 
							 size="20" maxlength="5"/></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C�digo moneda de giro
						</div>
						</td>
						<td>
						<html:select property="codigoMoneda"
							styleClass="lstbox" styleId="codigoMoneda">
							<bean:define id="cp" scope="session" name="{codigoMoneda}" type="java.util.ArrayList"/>
				            <html:options collection="cp" property="code" labelProperty="value"/>
						</html:select></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Tipo de cambio a USD
						</div>
						</td>
						<td>
						<html:text property="tipoCambioUSD" styleId="tipoCambioUSD" maxlength="6" size="20"/></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Numeral
						</div>
						</td>
						<td>
						<html:text property="numeral" styleId="numeral" maxlength="4"/></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor moneda de giro
						</div>
						</td>
						<td>
						<html:text property="valorMonedaGiro" styleId="valorMonedaGiro" maxlength="22" onkeypress="__digit(this);" /></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor USD
						</div>
						</td>
						<td>
						<html:text property="valorUSD" styleId="valorUSD" maxlength="22" onkeypress="__digit(this);"/></td>
					</tr>
	
	
					<tr>
						<td height="5" colspan="2"></td>
					</tr>
					<tr>
						<td><input name="txtvalidar" type="hidden" styleId="txtvalidar"
							value="valorUSD,numeral"></td>
						<td>
						<div align="right"><input name="Button" type="button"
							class="cmdBoton" value="Aceptar"
							onclick="frmValida('formulario-dian','txtvalidar')"></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</html:form>


<%@ include file="/footer.jsp"  %>
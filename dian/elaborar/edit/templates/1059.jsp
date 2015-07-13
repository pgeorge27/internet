<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<script language="javascript" src="<html:rewrite page='/dian/elaborar/edit/js/sce.js'/>"></script>
<script language="javascript" src="<html:rewrite page='/dian/elaborar/edit/js/jfunciones.js'/>"></script>
<link href="<html:rewrite page='/dian/elaborar/edit/css/estilo.css'/>" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<%
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
	document.location="<html:rewrite page='/dian/elaborar/1059.jsp'/>";
}
</script>
<html:form action="/dian/elaborar/guardar" method="post">
<input type="hidden" name="formulario" value="1059">
<html:hidden property="indice"/>
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
						<div align="center" class="txtTitulo">FORMULARIO 1059</div>
						</td>
						<td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
					</tr>
					<tr>
						<td height="5" colspan="2" align="right"></td>
					</tr>
					<tr>
						<td width="50%">
						<div align="right" class="txtTexto">Tipo de Informante:</div>
						</td>
						<td width="50%"><html:select property="tipoInformante" styleClass="lstbox"
							styleId="tipoInformante">
							<html:option value="1">Intermediario del mercado Cambiario
							&ndash; IMC</html:option>
							<html:option value="2">Usuario de Cuentas de
							Compensaci&oacute;n &ndash; CCC</html:option>
						</html:select></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Tipo de operación:</div>
						</td>
						<td><html:select property="tipoOperacion" styleClass="lstbox"
							styleId="tipoOperacion">
							<html:option value="1">Inicial</html:option>
							<html:option value="2">Devoluci&oacute;n</html:option>
							<html:option value="3">Cambio formulario</html:option>
							<html:option value="4">Modificaci&oacute;n</html:option>
						</html:select></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C&oacute;digo Cuenta
						Compensaci&oacute;n:</div>
						</td>
						<td><input name="codigoCuentaCompensacion" type="text"
							class="txtTexto" styleId="codigoCuentaCompensacion" size="40" maxlength="10" value="<bean:write
							name='formulario-dian' property='codigoCuentaCompensacion'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Fecha declaraci&oacute;n
						de cambio:</div>
						</td>
						<td><html:text property="strFechaDeclaracionCambio" styleClass="txtTexto" styleId="strFechaDeclaracionCambio"  maxlength="10" size="20"/> <img
							src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>" 
							onclick="return showCalendar('strFechaDeclaracionCambio', 'y-mm-dd');" alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero
						declaraci&oacute;n cambio:</div>
						</td>
						<td><input name="numeroDeclaracionCambio" type="text"  maxlength="5" 
							class="txtTexto" styleId="numeroDeclaracionCambio" size="40" value="<bean:write
							name='formulario-dian' property='numeroDeclaracionCambio'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Fecha declaraci&oacute;n
						cambio anterior:</div>
						</td>
						<td><html:text property="strFechaDeclaracionCambioAnterior"
							 maxlength="10" styleClass="txtTexto" styleId="strFechaDeclaracionCambioAnterior" size="20"/>
						<img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>" 
						onclick="return showCalendar('strFechaDeclaracionCambioAnterior', 'y-mm-dd');" alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Número declaración cambio anterior:</div>
						</td>
						<td><input name="numeroDeclaracionCambioAnterior" type="text"  maxlength="5" 
							class="txtTexto" styleId="numeroDeclaracionCambioAnterior" size="40" value="<bean:write
							name='formulario-dian' property='numeroDeclaracionCambioAnterior'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Tipo de
						Identificaci&oacute;n del importador:</div>
						</td>
						<td><html:select property="tipoIdentificacionImportador"
							styleClass="lstbox" styleId="tipoIdentificacionImportador">
							<bean:define id="cp" scope="session" name="{tipoIdentificacionImportador}" type="java.util.ArrayList"/>
				            <html:options collection="cp" property="code" labelProperty="value"/>
						</html:select></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero
						identificaci&oacute;n importador:</div>
						</td>
						<td><input name="numeroIdentificacionImportador" type="text" maxlength="20" 
							class="txtTexto" styleId="numeroIdentificacionImportador" size="40" value="<bean:write
							name='formulario-dian' property='numeroIdentificacionImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">DV importador:</div>
						</td>
						<td><input name="digitoVerificadorImportador" type="text" maxlength="1" 
							class="txtTexto" styleId="digitoVerificadorImportador" size="30" value="<bean:write
							name='formulario-dian' property='digitoVerificadorImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer apellido
						importador:</div>
						</td>
						<td><input name="primerApellidoImportador" type="text" onkeypress="alphabetic();"
							class="txtTexto" styleId="primerApellidoImportador" maxlength="60"  size="40" value="<bean:write
							name='formulario-dian' property='primerApellidoImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Segundo apellido
						importador:</div>
						</td>
						<td><input name="segundoApellidoImpotador" type="text"
							class="txtTexto" styleId="segundoApellidoImpotador" onkeypress="alphabetic();" maxlength="60" size="40" value="<bean:write
							name='formulario-dian' property='segundoApellidoImpotador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer nombre
						importador:</div>
						</td>
						<td><input name="nombreImportador" type="text"
							class="txtTexto" styleId="nombreImportador" size="40" onkeypress="alphabetic();" maxlength="60" value="<bean:write
							name='formulario-dian' property='nombreImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Otros nombres
						importador:</div>
						</td>
						<td><input name="otroNombreImportador" type="text"
							class="txtTexto" styleId="otroNombreImportador" size="40" onkeypress="alphabetic();" maxlength="60" value="<bean:write 
							name='formulario-dian' property='otroNombreImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Raz&oacute;n social
						importador:</div>
						</td>
						<td><html:textarea property="razonSocialImportador" cols="40" rows="4"
							styleClass="txtTexto" styleId="razonSocialImportador" onkeypress="alphabetic();validateLength(this, 450)"/></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Condiciones de pago:</div>
						</td>
						<td><html:select property="condicionesPago" styleClass="lstbox"
							styleId="condicionesPago">
							<html:option value="1">Si est&aacute; diligenciado</html:option>
							<html:option value="2">No est&aacute; diligenciado</html:option>


						</html:select></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Condiciones de despacho
						mercanc&iacute;a:</div>
						</td>
						<td><html:select property="condicionesDespachoMercancia"
							styleClass="lstbox" styleId="condicionesDespachoMercancia">
							<html:option value="1">Si est&aacute; diligenciado</html:option>
							<html:option value="2">No est&aacute; diligenciado</html:option>
						</html:select></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Observaciones:</div>
						</td>
						<td><html:select property="observaciones" styleClass="lstbox"
							styleId="observaciones">
							<html:option value="1">Si est&aacute; diligenciado</html:option>
							<html:option value="2">No est&aacute; diligenciado</html:option>
						</html:select></td>
					</tr>
					<tr>
						<td height="5" colspan="2"></td>
					</tr>
					<tr>
						<td><input name="txtvalidar" type="hidden" styleId="txtvalidar"
							value="tipoInformante,numeroDeclaracionCambio,condicionesDespachoMercancia,condicionesPago,observaciones,strFechaDeclaracionCambio"></td>
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



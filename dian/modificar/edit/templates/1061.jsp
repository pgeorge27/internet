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
	document.location="<html:rewrite page='/dian/modificar/1061.jsp'/>";
}
</script>
<html:form action="/dian/modificar/guardar" method="post"><input type="hidden"
	name="formulario" value="1061">
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
						<div align="center" class="txtTitulo">FORMULARIO 1061</div>
						</td>
						<td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
					</tr>
					<tr>
						<td height="5" colspan="2"></td>
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
						<div align="right" class="txtTexto">Tipo de Cambio:</div>
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
						<td><input name="codigoCuentaCompensacion" type="text" maxlength="10" 
							class="txtTexto" id="codigoCuentaCompensacion" size="40" value="<bean:write 
							name='formulario-dian' property='codigoCuentaCompensacion'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Fecha declaraci&oacute;n
						de cambio:</div>
						</td>
						<td><html:text property="strFechaDeclaracionCambio" maxlength="10" 
							styleClass="txtTexto" styleId="strFechaDeclaracionCambio" 
							size="20"/> <img
							src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>"  
							onclick="return showCalendar('strFechaDeclaracionCambio', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero
						declaraci&oacute;n cambio:</div>
						</td>
						<td><input name="numeroDeclaracionCambio" type="text" maxlength="5" 
							class="txtTexto" id="numeroDeclaracionCambio" size="40" value="<bean:write 
							name='formulario-dian' property='numeroDeclaracionCambio'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Fecha declaraci&oacute;n
						cambio anterior:</div>
						</td>
						<td><html:text property="strFechaDeclaracionCambioAnterior" maxlength="10" 
							styleClass="txtTexto" styleId="strFechaDeclaracionCambioAnterior" size="20"/>
						<img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>" 
							onclick="return showCalendar('strFechaDeclaracionCambioAnterior', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero
						declaraci&oacute;n cambio anterior:</div>
						</td>
						<td><input name="numeroDeclaracionCambioAnterior" type="text" maxlength="5" 
							class="txtTexto" id="numeroDeclaracionCambioAnterior" size="40" value="<bean:write 
							name='formulario-dian' property='numeroDeclaracionCambioAnterior'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero
						pr&eacute;stamo:</div>
						</td>
						<td><input name="numeroPrestamo" type="text" class="txtTexto"
							id="numeroPrestamo" size="40" maxlength="11"  value="<bean:write 
							name='formulario-dian' property='numeroPrestamo'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Tipo de
						Identificaci&oacute;n:</div>
						</td>
						<td>
						<html:select property="tipoIdentificacionImportador"
							styleClass="lstbox" styleId="tipoIdentificacionImportador">
							<bean:define id="cp" scope="session" name="{tipoIdentificacionImportador}" type="java.util.ArrayList"/>
				            <html:options collection="cp" property="code" labelProperty="value"/>
						</html:select>
						</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero
						identificaci&oacute;n:</div>
						</td>
						<td><input name="numeroIdentificacionImportador" type="text" maxlength="20" 
							class="txtTexto" id="numeroIdentificacionImportador" size="40" value="<bean:write 
							name='formulario-dian' property='numeroIdentificacionImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">DV:</div>
						</td>
						<td><input name="digitoVerificadorImportador" type="text" maxlength="1" 
							class="txtTexto" id="digitoVerificadorImportador" size="30" value="<bean:write 
							name='formulario-dian' property='digitoVerificadorImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer apellido del
						deudor o acreedor:</div>
						</td>
						<td><input name="primerApellido" type="text" class="txtTexto" maxlength="60" onkeypress="alphabetic();"
							id="primerApellido" size="40" value="<bean:write 
							name='formulario-dian' property='primerApellido'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">
						<p>Segundo apellido del deudor o acreedor:</p>
						</div>
						</td>
						<td><input name="segundoApellido" type="text" maxlength="60" onkeypress="alphabetic();" 
							class="txtTexto" id="segundoApellido" size="40" value="<bean:write 
							name='formulario-dian' property='segundoApellido'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer nombre del deudor
						o acreedor:</div>
						</td>
						<td><input name="nombre" type="text" class="txtTexto" maxlength="60" onkeypress="alphabetic();" 
							id="nombre" size="40" value="<bean:write 
							name='formulario-dian' property='nombre'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Otros nombres del deudor
						o acreedor:</div>
						</td>
						<td><input name="otroNombre" type="text" class="txtTexto" maxlength="60"  onkeypress="alphabetic();"
							id="otroNombre" size="40" value="<bean:write 
							name='formulario-dian' property='otroNombre'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Raz&oacute;n social del
						deudor o acreedor:</div>
						</td>
						<td><textarea name="razonSocial" cols="40" rows="4" onkeypress="alphabetic();validateLength(this, 450)"
							class="txtTexto" id="razonSocial">
							<bean:write name='formulario-dian' property='razonSocial'/>
							</textarea></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C&oacute;digo moneda
						contratada:</div>
						</td>
						<td>
						<html:select property="codigoMonedaContratada"
							styleClass="lstbox" styleId="codigoMonedaContratada">
							<bean:define id="cp2" scope="session" name="{codigoMonedaContratada}" type="java.util.ArrayList"/>
				            <html:options collection="cp2" property="code" labelProperty="value"/>
						</html:select>
						</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor moneda contratada:
						</div>
						</td>
						<td><input name="valorMonedaContratada" type="text" maxlength="22" onkeypress="__digit(this)"
							class="txtTexto" id="valorMonedaContratada" size="40" value="<bean:write 
							name='formulario-dian' property='valorMonedaContratada'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C&oacute;digo moneda
						negociaci&oacute;n:</div>
						</td>
						<td>
						<html:select property="codigoMonedaNegociacion"
							styleClass="lstbox" styleId="codigoMonedaNegociacion">
							<bean:define id="cp3" scope="session" name="{codigoMonedaNegociacion}" type="java.util.ArrayList"/>
				            <html:options collection="cp3" property="code" labelProperty="value"/>
						</html:select>
						</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor total moneda
						negociaci&oacute;n:</div>
						</td>
						<td><input name="valorTotal" type="text" class="txtTexto" maxlength="22"  onkeypress="__digit(this)"
							id="valorTotal" size="40" value="<bean:write 
							name='formulario-dian' property='valorTotal'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Tipo de cambio moneda de
						negociaci&oacute;n:</div>
						</td>
						<td><input name="tipoCambioNegociacion" type="text" maxlength="11" onkeypress="__digit(this)"
							class="txtTexto" id="tipoCambioNegociacion" size="40"
							value="<bean:write 
							name='formulario-dian' property='tipoCambioNegociacion'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor total USD:</div>
						</td>
						<td><input name="valorUSD" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="valorUSD" size="40" value="<bean:write 
							name='formulario-dian' property='valorUSD'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer apellido del
						acreedor (cr&eacute;ditos pasivos); o del deudor (cr&eacute;ditos
						activos):</div>
						</td>
						<td><input name="primerApellidoAcreedor" type="text" maxlength="60" onkeypress="alphabetic();" 
							class="txtTexto" id="primerApellidoAcreedor" size="50" value="<bean:write 
							name='formulario-dian' property='primerApellidoAcreedor'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Segundo apellido del
						acreedor (cr&eacute;ditos pasivos); o del deudor (cr&eacute;ditos
						activos):</div>
						</td>
						<td><input name="segundoApellidoAcreedor" type="text" maxlength="60" onkeypress="alphabetic();" 
							class="txtTexto" id="segundoApellidoAcreedor" size="50" value="<bean:write 
							name='formulario-dian' property='segundoApellidoAcreedor'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer nombre del
						acreedor (cr&eacute;ditos pasivos); o del deudor (cr&eacute;ditos
						activos):</div>
						</td>
						<td><input name="nombreAcreedor" type="text" class="txtTexto" maxlength="60" onkeypress="alphabetic();" 
							id="nombreAcreedor" size="50" value="<bean:write 
							name='formulario-dian' property='nombreAcreedor'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Otros nombres del
						acreedor (cr&eacute;ditos pasivos); o del deudor (cr&eacute;ditos
						activos):</div>
						</td>
						<td><input name="otroNombreAcreedor" type="text" maxlength="60" onkeypress="alphabetic();" 
							class="txtTexto" id="otroNombreAcreedor" size="50" value="<bean:write 
							name='formulario-dian' property='otroNombreAcreedor'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Raz&oacute;n social del
						acreedor (cr&eacute;ditos pasivos); o del deudor (cr&eacute;ditos
						activos):</div>
						</td>
						<td><textarea name="razonSocialAcreedor" cols="50" rows="4" onkeypress="alphabetic();validateLength(this, 450)"
							class="txtTexto" id="razonSocialAcreedor">
							<bean:write name='formulario-dian' property='razonSocialAcreedor'/>
							</textarea></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Total valor FOB:</div>
						</td>
						<td><input name="totalFOB" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="totalFOB" size="40" value="<bean:write 
							name='formulario-dian' property='totalFOB'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Total gastos (numeral
						1510):</div>
						</td>
						<td><input name="totalGastosNumeral1510" type="text" maxlength="22" onkeypress="__digit(this)"
							class="txtTexto" id="totalGastosNumeral1510" size="40" value="<bean:write 
							name='formulario-dian' property='totalGastosNumeral1510'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Deducciones (Numeral
						2016):</div>
						</td>
						<td><input name="deduccionesNumeral2016" type="text" maxlength="22" onkeypress="__digit(this)"
							class="txtTexto" id="deduccionesNumeral2016" size="40" value="<bean:write 
							name='formulario-dian' property='deduccionesNumeral2016'/>"></td>
					</tr>
					<tr>
						<td height="5" colspan="2"></td>
					</tr>
					<tr>
						<td><input name="txtvalidar" type="hidden" id="txtvalidar"
							value="tipoInformante,tipoOperacion,numeroDeclaracionCambio,valorUSD"></td>
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



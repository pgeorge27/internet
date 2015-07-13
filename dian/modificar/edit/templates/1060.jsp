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
	document.location="<html:rewrite page='/dian/modificar/1060.jsp'/>";
}
</script>
<html:form action="/dian/modificar/guardar" method="post">
<input type="hidden"
	name="formulario" value="1060">
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
						<div align="center" class="txtTitulo">FORMULARIO 1060</div>
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
						<td><html:text property="strFechaDeclaracionCambio" styleClass="txtTexto" styleId="strFechaDeclaracionCambio" maxlength="10" size="20"/> <img
							src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>" 
							onclick="return showCalendar('strFechaDeclaracionCambio', 'y-mm-dd');" alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
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
						<td><html:text property="strFechaDeclaracionCambioAnterior" styleClass="txtTexto" maxlength="10" styleId="strFechaDeclaracionCambioAnterior" size="20"/>
						<img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>" 
							onclick="return showCalendar('strFechaDeclaracionCambioAnterior', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
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
						Identificaci&oacute;n del exportador:</div>
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
						identificaci&oacute;n exportador:</div>
						</td>
						<td><input name="numeroIdentificacionImportador" type="text" maxlength="20" 
							class="txtTexto" id="numeroIdentificacionImportador" size="40" value="<bean:write 
							 name='formulario-dian' property='numeroIdentificacionImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">DV exportador:</div>
						</td>
						<td><input name="digitoVerificadorImportador" type="text" maxlength="1" 
							class="txtTexto" id="digitoVerificadorImportador" size="30" value="<bean:write 
							name='formulario-dian' property='digitoVerificadorImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer apellido
						exportador:</div>
						</td>
						<td><input name="primerApellidoImportador" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="primerApellidoImportador" size="40" value="<bean:write
							 name='formulario-dian' property='primerApellidoImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Segundo apellido
						exportador:</div>
						</td>
						<td><input name="segundoApellidoImpotador" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="segundoApellidoImpotador" size="40" value="<bean:write
							 name='formulario-dian' property='segundoApellidoImpotador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer nombre
						exportador:</div>
						</td>
						<td><input name="nombreImportador" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="nombreImportador" size="40" value="<bean:write
							 name='formulario-dian' property='nombreImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Otros nombres
						exportador:</div>
						</td>
						<td><input name="otroNombreImportador" type="text" maxlength="60"  onkeypress="alphabetic();"
							class="txtTexto" id="otroNombreImportador" size="40" value="<bean:write
							 name='formulario-dian' property='otroNombreImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Raz&oacute;n social
						exportador:</div>
						</td>
						<td><html:textarea property="razonSocialImportador" cols="40" rows="4"
							onkeypress="alphabetic();validateLength(this, 450)" styleClass="txtTexto" styleId="razonSocialImportador"/></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C&oacute;digo moneda de
						reintegro:</div>
						</td>
						<td>
						<html:select property="codigoMoneda"
							styleClass="lstbox" styleId="codigoMoneda">
							<bean:define id="cp2" scope="session" name="{codigoMoneda}" type="java.util.ArrayList"/>
				            <html:options collection="cp2" property="code" labelProperty="value"/>
						</html:select></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor moneda de
						reintegro:</div>
						</td>
						<td><input name="valorMonedaReintegro" type="text" maxlength="22" onkeypress="__digit(this)"
							class="txtTexto" id="valorMonedaReintegro" size="30" value="<bean:write
							 name='formulario-dian' property='valorMonedaReintegro'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Tipo de cambio a USD:</div>
						</td>
						<td><input name="tipoCambioUSD" type="text" class="txtTexto" maxlength="11" onkeypress="__digit(this)"
							id="tipoCambioUSD" size="30" value="<bean:write 
							name='formulario-dian' property='tipoCambioUSD'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Total valor FOB:</div>
						</td>
						<td><input name="totalFOB" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="totalFOB" size="30" value="<bean:write
							 name='formulario-dian' property='totalFOB'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Total gastos
						exportaci&oacute;n:</div>
						</td>
						<td><input name="totalGastosExportacion" type="text" maxlength="22" onkeypress="__digit(this)"
							class="txtTexto" id="totalGastosExportacion" size="30" value="<bean:write 
							name='formulario-dian' property='totalGastosExportacion'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Deducciones:</div>
						</td>
						<td><input name="deducciones" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="deducciones" size="30" value="<bean:write 
							name='formulario-dian' property='deducciones'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Total reintegro neto:</div>
						</td>
						<td><input name="totalReintegro" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="totalReintegro" size="30" value="<bean:write name='formulario-dian' 
							property='totalReintegro'/>"></td>
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
						<td><input name="txtvalidar" type="hidden" id="txtvalidar"
							value="tipoInformante,tipoOperacion,numeroDeclaracionCambio,numeroPrestamo,valorUSD"></td>
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



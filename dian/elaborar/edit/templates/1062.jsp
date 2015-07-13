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
	document.location="<html:rewrite page='/dian/elaborar/1062.jsp'/>";
}
</script>
<html:form action="/dian/elaborar/guardar" method="post"><input
	type="hidden" name="formulario" value="1062">
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
						<div align="center" class="txtTitulo">FORMULARIO 1062</div>
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
							styleClass="txtTexto" styleId="strFechaDeclaracionCambio" size="20"/> <img
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
							class="txtTexto" id="numeroDeclaracionCambio" size="40" value="<bean:write name='formulario-dian' property='numeroDeclaracionCambio'/>"></td>
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
							class="txtTexto" id="numeroIdentificacionImportador" size="40" value="<bean:write 
							name='formulario-dian' property='numeroIdentificacionImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">DV:</div>
						</td>
						<td><input name="digitoVerificadorImportador" type="text" maxlength="1" onkeypress="__digit(this);"
							class="txtTexto" id="digitoVerificadorImportador" size="30" value="<bean:write 
							name='formulario-dian' property='digitoVerificadorImportador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer apellido de quien
						compra o vende divisas:</div>
						</td>
						<td><input name="primerApellidoAcreedor" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="primerApellidoAcreedor" size="40" value="<bean:write 
							name='formulario-dian' property='primerApellidoAcreedor'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Segundo apellido de
						quien compra o vende divisas:</div>
						</td>
						<td><input name="segundoApellidoComprador" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="segundoApellidoComprador" size="40" value="<bean:write 
							name='formulario-dian' property='segundoApellidoComprador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer nombre de quien
						compra o vende divisas:</div>
						</td>
						<td><input name="nombreComprador" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="nombreComprador" size="40" value="<bean:write 
							name='formulario-dian' property='nombreComprador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Otros nombres de quien
						compra o vende divisas:</div>
						</td>
						<td><input name="otroNombreComprador" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="otroNombreComprador" size="40" value="<bean:write 
							name='formulario-dian' property='otroNombreComprador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Raz&oacute;n social de
						quien compra o vende divisas:</div>
						</td>
						<td><html:textarea property="razonSocial" cols="40" rows="4" onkeypress="alphabetic();validateLength(this, 450)"
							styleClass="txtTexto" styleId="razonSocial"/></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Direcci&oacute;n:</div>
						</td>
						<td><textarea name="direccion" cols="40" rows="3"onkeypress="alphabetic();validateLength(this, 200)"
							class="txtTexto" id="direccion">
							<bean:write name='formulario-dian' property='direccion'/>
							</textarea></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Cod Ciudad - Colombia:</div>
						</td>
						<td>
						<html:select property="codigoCiudad"
							styleClass="lstbox" styleId="codigoCiudad">
							<bean:define id="cp2" scope="session" name="{codigoCiudad}" type="java.util.ArrayList"/>
				            <html:options collection="cp2" property="code" labelProperty="value"/>
						</html:select>
						</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Nombre ciudad del
						exterior:</div>
						</td>
						<td><input name="nombreCiudadExterior" type="text" maxlength="80" onkeypress="alphabetic();"
							class="txtTexto" id="nombreCiudadExterior" size="40" value="<bean:write 
							name='formulario-dian' property='nombreCiudadExterior'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C&oacute;digo moneda
						giro o reintegro:</div>
						</td>
						<td>
						
						<html:select property="codigoMoneda"
							styleClass="lstbox" styleId="codigoMoneda">
							<bean:define id="cp3" scope="session" name="{codigoMoneda}" type="java.util.ArrayList"/>
				            <html:options collection="cp3" property="code" labelProperty="value"/>
						</html:select>
						</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor moneda giro o
						reintegro:</div>
						</td>
						<td><input name="nombreCiudadExterior2" type="text" maxlength="22" onkeypress="__digit(this)"
							class="txtTexto" id="nombreCiudadExterior2" size="40" value="<bean:write 
							name='formulario-dian' property='nombreCiudadExterior'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor total USD:</div>
						</td>
						<td><input name="valorUSD" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="valorUSD" size="40" value="<bean:write 
							name='formulario-dian' property='codigoCuentaCompensacion'/>"></td>
					</tr>
					<tr>
						<td height="5" colspan="2"></td>
					</tr>
					<tr>
						<td><input name="txtvalidar" type="hidden" id="txtvalidar"
							value="tipoInformante,tipoOperacion,numeroDeclaracionCambio,valorUSD,strFechaDeclaracionCambio"></td>
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



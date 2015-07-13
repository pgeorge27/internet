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
	document.location="<html:rewrite page='/dian/modificar/1063.jsp'/>";
}
</script>
<html:form action="/dian/modificar/guardar" method="post"><input
	type="hidden" name="formulario" value="1063">
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
						<div align="center" class="txtTitulo">FORMULARIO 1063</div>
						</td>
						<td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
					</tr>
					<tr>
						<td height="5" colspan="2"></td>
					</tr>

					<tr>
						<td width="50%">
						<div align="right" class="txtTexto">Tipo de operación:</div>
						</td>
						<td width="50%"><html:select property="tipoOperacion" styleClass="lstbox"
							styleId="tipoOperacion">
							<html:option value="1">Inicial</html:option>
							<html:option value="2">Devoluci&oacute;n</html:option>
							<html:option value="3">Cambio formulario</html:option>
							<html:option value="4">Modificaci&oacute;n</html:option>
						</html:select></td>
					</tr>

					<tr>
						<td>
						<div align="right" class="txtTexto">Fecha:</div>
						</td>
						<td><html:text property="strFecha" styleClass="txtTexto" maxlength="10" 
							styleId="strFecha" size="20"/> <img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>" 
							onclick="return showCalendar('strFecha', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero
						pr&eacute;stamo:</div>
						</td>
						<td><input name="numeroPrestamo" type="text" class="txtTexto" maxlength="11" 
							id="numeroPrestamo" size="40" value="<bean:write name='formulario-dian'
							property='numeroPrestamo'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero
						declaraci&oacute;n:</div>
						</td>
						<td><input name="numeroDeclaracion" type="text" maxlength="5" 
							class="txtTexto" id="numeroDeclaracion" size="40" value="<bean:write name='formulario-dian'
							property='numeroDeclaracion'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Numeral:</div>
						</td>
						<td><input name="numeral" type="text" class="txtTexto" maxlength="4" 
							id="numeral" size="40" value="<bean:write name='formulario-dian'
							property='numeral'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Codigo Ciudad:</div>
						</td>
						<td>
						<html:select property="codigoCiudad"
							styleClass="lstbox" styleId="codigoCiudad">
							<bean:define id="cp3" scope="session" name="{codigoCiudad}" type="java.util.ArrayList"/>
				            <html:options collection="cp3" property="code" labelProperty="value"/>
						</html:select>
						</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C&oacute;digo moneda de
						negociaci&oacute;n:</div>
						</td>
						<td>
						<html:select property="codigoMonedaNegociacion"
							styleClass="lstbox" styleId="codigoMonedaNegociacion">
							<bean:define id="cp" scope="session" name="{codigoMonedaNegociacion}" type="java.util.ArrayList"/>
				            <html:options collection="cp" property="code" labelProperty="value"/>
						</html:select>
						</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor total en la moneda
						de negociaci&oacute;n:</div>
						</td>
						<td><input name="valorTotal" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="valorTotal" size="40" value="<bean:write name='formulario-dian'
							property='valorTotal'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor USD:</div>
						</td>
						<td><input name="valorUSD" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="valorUSD" size="30" value="<bean:write name='formulario-dian'
							property='valorUSD'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Tipo de
						identificaci&oacute;n:</div>
						</td>
						<td>
						<html:select property="tipoIdentificacion"
							styleClass="lstbox" styleId="tipoIdentificacion">
							<bean:define id="cp2" scope="session" name="{tipoIdentificacion}" type="java.util.ArrayList"/>
				            <html:options collection="cp2" property="code" labelProperty="value"/>
						</html:select></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero de
						identificaci&oacute;n prestatario o deudor:</div>
						</td>
						<td><input name="numeroIdentificacionPrestatario" type="text" maxlength="20" 
							class="txtTexto" id="numeroIdentificacionPrestatario" size="40" value="<bean:write name='formulario-dian'
							property='numeroIdentificacionPrestatario'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">DV:</div>
						</td>
						<td><input name="digitoVerificador" type="text" maxlength="1" 
							class="txtTexto" id="digitoVerificador" size="40" value="<bean:write name='formulario-dian'
							property='digitoVerificador'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer apellido del
						prestatario o deudor:</div>
						</td>
						<td><input name="primerApellidoPrestatario" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="primerApellidoPrestatario" size="40" value="<bean:write name='formulario-dian'
							property='primerApellidoPrestatario'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Segundo apellido del
						prestatario o deudor:</div>
						</td>
						<td><input name="segundoApellidoPrestatario" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="segundoApellidoPrestatario" 
							size="40" value="<bean:write name='formulario-dian'
							property='segundoApellidoPrestatario'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Primer nombre del
						prestatario o deudor:</div>
						</td>
						<td><input name="nombrePrestatario" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="nombrePrestatario"  size="40" value="<bean:write name='formulario-dian'
							property='nombrePrestatario'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Otros nombres del
						prestatario o deudor:</div>
						</td>
						<td><input name="otroNombrePrestatario" type="text" maxlength="60" onkeypress="alphabetic();"
							class="txtTexto" id="otroNombrePrestatario" size="40" value="<bean:write name='formulario-dian'
							property='otroNombrePrestatario'/>"></td>
					</tr>
					<tr>
						<td>  
						<div align="right" class="txtTexto">Dirección:</div>
						</td>
						<td><html:textarea property="direccion" cols="40" onkeypress="alphabetic();validateLength(this, 450)"
							rows="4" styleClass="txtTexto" styleId="direccion"/></td>
					</tr>
					
					<tr>
						<td>
						<div align="right" class="txtTexto">Raz&oacute;n social del
						prestatario o deudor:</div>
						</td>
						<td><html:textarea property="razonSocialPrestatario" cols="40" onkeypress="alphabetic();validateLength(this, 450)"
							rows="4" styleClass="txtTexto" styleId="razonSocialPrestatario"/></td>
					</tr>
					<tr>
              <td><div align="right" class="txtTexto">C&oacute;digo prop&oacute;sito pr&eacute;stamo: </div></td>
              <td>
              <html:select property="codigoPropositoPrestamo"
					styleClass="lstbox" styleId="codigoPropositoPrestamo">
					<bean:define id="cp6" scope="session" name="{codigoPropositoPrestamo}" type="java.util.ArrayList"/>
		            <html:options collection="cp6" property="code" labelProperty="value"/>
				</html:select>
               </td>
            </tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C&oacute;digo moneda:</div>
						</td>
						<td>
						<html:select property="codigoMoneda"
							styleClass="lstbox" styleId="codigoMoneda">
							<bean:define id="cp4" scope="session" name="{codigoMoneda}" type="java.util.ArrayList"/>
				            <html:options collection="cp4" property="code" labelProperty="value"/>
						</html:select>
						</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Monto contratado:</div>
						</td>
						<td><input name="montoContratado" type="text" maxlength="22" onkeypress="__digit(this)"
							class="txtTexto" id="montoContratado"  size="30" value="<bean:write name='formulario-dian'
							property='montoContratado'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero de
						expedici&oacute;n dep&oacute;sito:</div>
						</td>
						<td><input name="numeroExpedicionDeposito" type="text" maxlength="20" 
							class="txtTexto" id="numeroExpedicionDeposito" size="30" value="<bean:write name='formulario-dian'
							property='numeroExpedicionDeposito'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor en d&oacute;lares
						o pesos colombianos del dep&oacute;sito:</div>
						</td>
						<td><input name="valorDeposito" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="valorDeposito" size="30" value="<bean:write name='formulario-dian'
							property='valorDeposito'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C&oacute;digo para la
						sustituci&oacute;n o fraccionamiento de cr&eacute;ditos:</div>
						</td>
						<td><html:select property="codigoSustitucionCreditos" styleClass="lstbox"
							styleId="codigoSustitucionCreditos">
							<html:option value="1">Sustituci&oacute;n</html:option>
							<html:option value="2">Fraccionamiento</html:option>
						</html:select></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">N&uacute;mero de
						identificaci&oacute;n cr&eacute;dito anterior:</div>
						</td>
						<td><input name="numeroIdentificacionCreditoAnterior" maxlength="20" 
							type="text" class="txtTexto"
							id="numeroIdentificacionCreditoAnterior" size="30" value="<bean:write name='formulario-dian'
							property='numeroIdentificacionCreditoAnterior'/>"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">C&oacute;digo moneda:</div>
						</td>
						<td>
						<html:select property="codigoMonedaNegociacion"
							styleClass="lstbox" styleId="codigoMonedaNegociacion">
							<bean:define id="cp5" scope="session" name="{codigoMonedaNegociacion}" type="java.util.ArrayList"/>
				            <html:options collection="cp5" property="code" labelProperty="value"/>
						</html:select>
						</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor a sustituir o
						fraccionar:</div>
						</td>
						<td><input name="valorSustituir" type="text" class="txtTexto" maxlength="22" onkeypress="__digit(this)"
							id="valorSustituir" size="30" value="<bean:write name='formulario-dian'
							property='valorSustituir'/>"></td>
					</tr>

					<tr>
						<td height="5" colspan="2"></td>
					</tr>
					<tr>
						<td><input name="txtvalidar" type="hidden" id="txtvalidar"
							value="tipoOperacion,strFecha,numeroPrestamo,numeral,valorUSD,montoContratado,direccion"></td>
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



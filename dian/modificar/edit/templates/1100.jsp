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
	document.location="<html:rewrite page='/dian/modificar/1100.jsp'/>";
}
</script>
<html:form action="/dian/modificar/guardar" method="post">
<input type="hidden" name="formulario" value="1100">
<html:hidden property="indice"/>
  <table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="cuadro">
    <tr>
      <td><table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr>
          <td><table width="100%" border="0" cellspacing="2" cellpadding="2">
            <tr>
              <td><div align="center" class="txtTitulo">FORMULARIO 1100</div></td>
              <td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
              </tr>
            <tr>
              <td height="5" colspan="2"/></td>
              </tr>
            <tr>
              <td width="50%"><div align="right" Class="txtTexto">Tipo negociaci&oacute;n: </div></td>
              <td width="50%"><html:select property="tipoNegociacion"
					styleClass="lstbox" styleId ="tipoNegociacion">
					<bean:define id="cp" scope="session" name="{tipoNegociacion}" type="java.util.ArrayList"/>
		            <html:options collection="cp" property="code" labelProperty="value"/>
				</html:select> </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">N�mero factura : </div></td>
              <td><html:text property="numeroFactura" styleClass="txtTexto" maxlength="20"  styleId="numeroFactura" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Tipo de documento del declarante comprador: </div></td>
              <td><html:select property="tipoDocumentoCliente"
					styleClass="lstbox" styleId ="formaPago">
					<bean:define id="cp2" scope="session" name="{tipoDocumentoCliente}" type="java.util.ArrayList"/>
		            <html:options collection="cp2" property="code" labelProperty="value"/>
				</html:select>  </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">N&uacute;mero documento de identificaci&oacute;n del declarante comprador: </div></td>
              <td><html:text property="numeroIdentificacion" styleClass="txtTexto" maxlength="20"  styleId="numeroIdentificacion" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">D&iacute;gito de Verificaci&oacute;n: </div></td>
              <td><html:text property="digitoVerificador" styleClass="txtTexto" maxlength="1"  styleId="digitoVerificador" size="30"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Primer apellido del declarante comprador: </div></td>
              <td><html:text property="primerApellido" maxlength="60" onkeypress="alphabetic();" styleClass="txtTexto" styleId="primerApellido" size="40"/>                </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Segundo apellido del declarante comprador: </div></td>
              <td><html:text property="segundoApellido" maxlength="60" onkeypress="alphabetic();" styleClass="txtTexto" styleId="segundoApellido" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Primer nombre del declarante comprador: </div></td>
              <td><html:text property="nombre" maxlength="60" onkeypress="alphabetic();" styleClass="txtTexto" styleId="nombre" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Otros nombres del declarante comprador: </div></td>
              <td><html:text property="otroNombre" maxlength="60" onkeypress="alphabetic();" styleClass="txtTexto" styleId="otroNombre" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Direcci&oacute;n del Declarante comprador: </div></td>
              <td><html:textarea property="direccion" onkeypress="alphabetic();validateLength(this, 200)" cols="40" rows="4" styleClass="txtTexto" styleId="direccion"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">C&oacute;digo Departamento/Municipio del Declarante comprador: </div></td>
              <td><html:select property="codigoMunicipio"
					styleClass="lstbox" styleId ="codigoMunicipio">
					<bean:define id="cp3" scope="session" name="{codigoMunicipio}" type="java.util.ArrayList"/>
		            <html:options collection="cp3" property="code" labelProperty="value"/>
				</html:select> </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Tel&eacute;fono del Declarante comprador: </div></td>
              <td><html:text property="telefonoComprador" maxlength="16"  styleClass="txtTexto" styleId="telefonoComprador" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Ocupaci&oacute;n o actividad econ&oacute;mica del declarante comprador: </div></td>
              <td><html:text property="ocupacionComprador" maxlength="4"  styleClass="txtTexto" styleId="ocupacionComprador" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Tipo de documento del Beneficiario: </div></td>
              <td><html:select property="tipoDocumentoBeneficiario"
					styleClass="lstbox" styleId ="tipoDocumentoBeneficiario">
					<bean:define id="cp4" scope="session" name="{tipoDocumentoBeneficiario}" type="java.util.ArrayList"/>
		            <html:options collection="cp4" property="code" labelProperty="value"/>
				</html:select> </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">N&uacute;mero documento de identificaci&oacute;n del Beneficiario: </div></td>
              <td><html:text property="numeroIdentificacionBeneficiario" maxlength="20"  styleClass="txtTexto" styleId="numeroIdentificacionBeneficiario" value="" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">D&iacute;gito de Verificaci&oacute;n: </div></td>
              <td><html:text property="digitoVerificadorBeneficiario" maxlength="1"  styleClass="txtTexto" styleId="digitoVerificadorBeneficiario" size="30"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Primer apellido del beneficiario: </div></td>
              <td><html:text property="primerApellidoBeneficiario" maxlength="60" onkeypress="alphabetic();" styleClass="txtTexto" styleId="primerApellidoBeneficiario" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Segundo apellido del beneficiario: </div></td>
              <td><html:text property="segundoApellidoBeneficiario" maxlength="60" onkeypress="alphabetic();" styleClass="txtTexto" styleId="segundoApellidoBeneficiario" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Primer nombre del beneficiario: </div></td>
              <td><html:text property="nombreBeneficiario" maxlength="60" onkeypress="alphabetic();" styleClass="txtTexto" styleId="nombreBeneficiario" value="" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Otros nombres del beneficiario: </div></td>
              <td><html:text property="otroNombreBeneficiario" maxlength="60" onkeypress="alphabetic();" styleClass="txtTexto" styleId="otroNombreBeneficiario" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Raz&oacute;n social del beneficiario: </div></td>
              <td><html:textarea property="razonSocialBeneficiario" cols="40" rows="4" onkeypress="alphabetic();validateLength(this, 450)" styleClass="txtTexto" styleId="razonSocialBeneficiario"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Direcci&oacute;n del Beneficiario: </div></td>
              <td><html:textarea property="direccionBeneficiario" cols="40" rows="4" onkeypress="alphabetic();validateLength(this,200)" styleClass="txtTexto" styleId="direccionBeneficiario"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">C&oacute;digo Departamento/Municipio del Beneficiario: </div></td>
              <td><html:select property="codigoMunicipioBeneficiario"
					styleClass="lstbox" styleId ="codigoMunicipioBeneficiario">
					<bean:define id="cp5" scope="session" name="{codigoMunicipioBeneficiario}" type="java.util.ArrayList"/>
		            <html:options collection="cp5" property="code" labelProperty="value"/>
				</html:select> </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Tel&eacute;fono del Beneficiario: </div></td>
              <td><html:text property="telefonoBeneficiario" styleClass="txtTexto" maxlength="16"  styleId="telefonoBeneficiario" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Ocupaci&oacute;n o actividad econ&oacute;mica del Beneficiario: </div></td>
              <td><html:text property="ocupacionBeneficiario" styleClass="txtTexto" maxlength="4"  styleId="ocupacionBeneficiario" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">C&oacute;digo Moneda: </div></td>
              <td><html:select property="codigoMoneda"
					styleClass="lstbox" styleId ="codigoMoneda">
					<bean:define id="cp6" scope="session" name="{codigoMoneda}" type="java.util.ArrayList"/>
		            <html:options collection="cp6" property="code" labelProperty="value"/>
				</html:select>   </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Monto moneda negociada (unidades): </div></td>
              <td><html:text property="montoNegociado" styleClass="txtTexto" maxlength="20" onkeypress="__digit(this)" onblur="__isValidNumber(this, 2);" styleId="montoNegociado" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Tasa de venta: </div></td>
              <td><html:text property="tasaVenta" styleClass="txtTexto" maxlength="10" onblur="__isValidNumber(this, 4);" onkeypress="__digit(this)" styleId="tasaVenta" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Valor en pesos: </div></td>
              <td><html:text property="valorPesos" styleClass="txtTexto" maxlength="20" onblur="__isValidNumber(this, 2);" onkeypress="__digit(this)" styleId="valorPesos" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Promedio compra d&iacute;a anterior: </div></td>
              <td><html:text property="promedioCompra" styleClass="txtTexto" maxlength="13" onblur="__isValidNumber(this, 4);" onkeypress="__digit(this)" styleId="promedioCompra" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Diferencia en tasa: </div></td>
              <td><html:text property="diferenciaTasa" styleClass="txtTexto" maxlength="13" onblur="__isValidNumber(this, 4);" onkeypress="__digit(this)" styleId="diferenciaTasa" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Base Liquidaci&oacute;n: </div></td>
              <td><html:text property="baseLiquidacion" styleClass="txtTexto" maxlength="13" onblur="__isValidNumber(this, 4);" onkeypress="__digit(this)" styleId="baseLiquidacion" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Valor Iva: </div></td>
              <td><html:text property="valorIVA" styleClass="txtTexto" maxlength="20" onkeypress="__digit(this)" styleId="valorIVA" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Rete. Iva: </div></td>
              <td><html:text property="reteIVA" styleClass="txtTexto" maxlength="20" onkeypress="__digit(this)" styleId="reteIVA" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Rete. Fte: </div></td>
              <td><html:text property="reteFte" styleClass="txtTexto" maxlength="20" onkeypress="__digit(this)" styleId="reteFte" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Rete. Ica: </div></td>
              <td><html:text property="reteICA" styleClass="txtTexto" maxlength="20" onkeypress="__digit(this)" styleId="reteICA" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Gravamen Movimientos Financieros: </div></td>
              <td><html:text property="gravamen" styleClass="txtTexto" styleId="gravamen" maxlength="20"  size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Valor Neto: </div></td>
              <td><html:text property="valorNeto" styleClass="txtTexto" maxlength="20" onblur="__isValidNumber(this, 2);" onkeypress="__digit(this)" styleId="valorNeto" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Forma de pago: </div></td>
              <td><html:select property="formaPago"
					styleClass="lstbox" styleId ="formaPago">
					<bean:define id="cp7" scope="session" name="{formaPago}" type="java.util.ArrayList"/>
		            <html:options collection="cp7" property="code" labelProperty="value"/>
				</html:select>  </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">C&oacute;digo Banco: </div></td>
              <td><html:text property="codigoBanco" styleClass="txtTexto" maxlength="3" styleId="codigoBanco" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">N&uacute;mero de cheque: </div></td>
              <td><html:text property="numeroCheque" styleClass="txtTexto" maxlength="16" styleId="numeroCheque" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">N&uacute;mero Declaraci&oacute;n de Cambio: </div></td>
              <td><html:text property="numeroDeclaracionCambio" styleClass="txtTexto" maxlength="5" styleId="numeroDeclaracionCambio" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Fecha declaraci&oacute;n de cambio: </div></td>
              <td><html:text property="strFecha" styleClass="txtTexto" maxlength="10" styleId="fecha" size="20"/>
                <img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>"  
							onclick="return showCalendar('strFecha', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
            </tr>
            <tr>
              <td height="5" colspan="2"/></td>
              </tr>
            <tr>
              <td><input name="txtvalidar" type="hidden" styleId="txtvalidar" value="tipoNegociacion,telefonoComprador,nombre,primerApellido,tipoDocumentoCliente,numeroIdentificacion,direccion,codigoMunicipio,codigoMoneda,montoNegociado,tasaVenta,valorPesos,promedioCompra,diferenciaTasa,baseLiquidacion,valorNeto,formaPago,fecha,strFechaDeclaracionCambio"/></td>
              <td><div align="right">
                  <input name="Button" type="button" class="cmdBoton" value="Aceptar" onclick="frmValida('formulario-dian','txtvalidar')">
              </div></td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    </tr>
  </table>
</html:form>


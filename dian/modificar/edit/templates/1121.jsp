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
	document.location="<html:rewrite page='/dian/modificar/1121.jsp'/>";
}
</script>
<html:form action="/dian/modificar/guardar" method="post">
<input type="hidden" name="formulario" value="1121">
<html:hidden property="indice"/>
  <table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="cuadro">
    <tr>
      <td><table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr>
          <td><table width="100%" border="0" cellspacing="2" cellpadding="2">
            <tr>
              <td><div align="center" class="txtTitulo">FORMULARIO 1121</div></td>
              <td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
              </tr>
            <tr>
              <td height="5" colspan="2"></td>
              </tr>
            <tr>
              <td width="50%"><div align="right" Class="txtTexto">C&oacute;digo concepto de la operaci&oacute;n: </div></td>
              <td width="50%"><html:select property="codigoConceptoOperacion"
					styleClass="lstbox" styleId ="codigoConceptoOperacion">
					<bean:define id="cp" scope="session" name="{codigoConceptoOperacion}" type="java.util.ArrayList"/>
		            <html:options collection="cp" property="code" labelProperty="value"/>
				</html:select>  </td>
            </tr>
            
            <tr>
              <td><div align="right" Class="txtTexto">Tipo de documento del cliente del profesional: </div></td>
              <td><html:select property="tipoDocumentoCliente"
					styleClass="lstbox" styleId ="tipoDocumentoCliente">
					<bean:define id="cp2" scope="session" name="{tipoDocumentoCliente}" type="java.util.ArrayList"/>
		            <html:options collection="cp2" property="code" labelProperty="value"/>
				</html:select>  </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">N&uacute;mero documento de identificaci&oacute;n del cliente del profesional: </div></td>
              <td><html:text property="numeroIdentificacion" styleClass="txtTexto" maxlength="20" styleId="numeroIdentificacion" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">D&iacute;gito de Verificaci&oacute;n del cliente del profesional: </div></td>
              <td><html:text property="digitoVerificador" styleClass="txtTexto" maxlength="1" styleId="digitoVerificador" size="30"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Primer apellido del cliente del profesional: </div></td>
              <td><html:text property="primerApellido" styleClass="txtTexto" maxlength="60" onkeypress="alphabetic();" styleId="primerApellido" size="40"/>                </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto"> Segundo apellido del cliente del profesional: </div></td>
              <td><html:text property="segundoApellido" styleClass="txtTexto" maxlength="60" onkeypress="alphabetic();" styleId="segundoApellido" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Primer nombre del cliente del profesional: </div></td>
              <td><html:text property="nombre" styleClass="txtTexto" maxlength="60" onkeypress="alphabetic();" styleId="nombre" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Otros nombres del cliente del profesional: </div></td>
              <td><html:text property="otroNombre" styleClass="txtTexto" maxlength="60" onkeypress="alphabetic();" styleId="otroNombre" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Raz&oacute;n social del cliente del profesional: </div></td>
              <td><html:textarea property="razonSocial" cols="40" rows="4" styleClass="txtTexto" onkeypress="alphabetic();validateLength(this, 450)" styleId="razonSocial"></html:textarea></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">C&oacute;digo Moneda negociada: </div></td>
              <td><html:select property="codigoMoneda"
					styleClass="lstbox" styleId ="codigoMoneda">
					<bean:define id="cp3" scope="session" name="{codigoMoneda}" type="java.util.ArrayList"/>
		            <html:options collection="cp3" property="code" labelProperty="value"/>
				</html:select>  </td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Monto moneda negociada: </div></td>
              <td><html:text property="montoNegociado" styleClass="txtTexto" maxlength="20" onblur="__isValidNumber(this, 2);" onkeypress="__digit(this)" styleId="montoNegociado" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Valor en pesos: </div></td>
              <td><html:text property="valorPesos" styleClass="txtTexto" maxlength="20" onblur="__isValidNumber(this, 2);" onkeypress="__digit(this)" styleId="valorPesos" size="40"/></td>
            </tr>
             <tr>
              <td><div align="right" Class="txtTexto">Valor Iva: </div></td>
              <td><html:text property="valorIVA" styleClass="txtTexto" maxlength="20" onkeypress="__digitOnly(this)" styleId="valorIVA" size="40"/></td>
            </tr>
          
            <tr>
              <td><div align="right" Class="txtTexto">C&oacute;digo clase de compra o venta: </div></td>
              <td><html:select property="codigoClaseCompraVenta"
					styleClass="lstbox" styleId ="codigoClaseCompraVenta">
					<bean:define id="cp4" scope="session" name="{codigoClaseCompraVenta}" type="java.util.ArrayList"/>
		            <html:options collection="cp4" property="code" labelProperty="value"/>
				</html:select></td>
            </tr>
              <tr>
              <td><div align="right" Class="txtTexto">N&uacute;mero del formulario: </div></td>
              <td><html:text property="numeroFormulario" styleClass="txtTexto" maxlength="13"  styleId="numeroFormulario" size="40"/></td>
            </tr>
            <tr>
              <td><div align="right" Class="txtTexto">Fecha de la operaci&oacute;n: </div></td>
              <td><html:text property="strFecha" styleClass="txtTexto" styleId="strFecha" maxlength="10"  size="20"/>
                <img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>"  
							onclick="return showCalendar('strFecha', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
            </tr>
            
            <tr>
              <td height="5" colspan="2"></td>
              </tr>
            <tr>
              <td><input name="txtvalidar" type="hidden" styleId="txtvalidar" value="codigoConceptoOperacion,numeroFormulario,valorIVA,tipoDocumentoCliente,numeroIdentificacion,codigoMoneda,montoNegociado,valorPesos,codigoClaseCompraVenta,strFecha"></td>
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
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
	document.location="<html:rewrite page='/dian/modificar/1070.jsp'/>";
}
</script>
<html:form action="/dian/modificar/guardar" method="post">
<input type="hidden" name="formulario" value="1070">
<html:hidden property="indice"/>
  <table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="cuadro">
    <tr>
      <td>
      <table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr>
          <td><table width="100%" border="0" cellspacing="2" cellpadding="2">
            <tr>
              <td>
              <div align="center" class="txtTitulo">FORMULARIO 1070</div></td>
						<td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
              </tr>
            <tr>
              <td height="5" colspan="2"></td>
              </tr>
            <tr>
              <td width="50%"><div align="right" class="txtTexto">Tipo de operaci&oacute;n: </div></td>
              <td width="50%"><html:select property="tipoOperacion" styleClass="lstbox" styleId="tipoOperacion">
                <html:option value="1">Inicial</html:option>
                <html:option value="2">Devoluci&oacute;n</html:option>
                <html:option value="3">Cambio formulario</html:option>
                <html:option value="4">Modificaci&oacute;n</html:option>
              </html:select></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">C&oacute;digo cuenta compensaci&oacute;n: </div></td>
              <td><input name="codigoCuentaCompensacion" type="text" class="txtTexto" maxlength="10"  id="codigoCuentaCompensacion" size="40" value="<bean:write name="formulario-dian" property="codigoCuentaCompensacion"/>"></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">N&uacute;mero de la cuenta corriente de compensaci&oacute;n: </div></td>
              <td><input name="numeroCuentaCorrienteCompensacion" type="text" class="txtTexto" maxlength="40"  id="numeroCuentaCorrienteCompensacion" size="40" value="<bean:write name="formulario-dian" property="numeroCuentaCorrienteCompensacion"/>"></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Nombre del banco: </div></td>
              <td><html:textarea property="nombreBanco" styleClass="txtTexto" styleId="nombreBanco"  onkeypress="alphabetic();validateLength(this, 450)"/></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">C&oacute;digo pa&iacute;s: </div></td>
              <td><html:select property="codigoPais"
					styleClass="lstbox" styleId="codigoPais">
					<bean:define id="cp" scope="session" name="{codigoPais}" type="java.util.ArrayList"/>
		            <html:options collection="cp" property="code" labelProperty="value"/>
				</html:select></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Nombre ciudad: </div></td>
              <td><input name="nombreCiudad" type="text" class="txtTexto"  maxlength="80" onkeypress="alphabetic();" id="nombreCiudad" size="40" value="<bean:write name="formulario-dian" property="nombreCiudad"/>"></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">C&oacute;digo moneda: </div></td>
              <td><html:select property="codigoMoneda"
					styleClass="lstbox" styleId="codigoMoneda">
					<bean:define id="cp2" scope="session" name="{codigoMoneda}" type="java.util.ArrayList"/>
		            <html:options collection="cp2" property="code" labelProperty="value"/>
				</html:select>     </td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Fecha de cancelaci&oacute;n de la cuenta en la entidad bancaria del exterior: </div></td>
              <td><input name="strFechaCancelacion" type="text" class="txtTexto" maxlength="10" id="strFechaCancelacion" size="20" value="<bean:write name="formulario-dian" property="strFechaCancelacion"/>">
                <img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>"  
							onclick="return showCalendar('strFechaCancelacion', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
            </tr>
            
            <tr>
              <td><div align="right" class="txtTexto">Fecha del reporte de cancelaci&oacute;n de la cuenta ante el Banco de la Rep&uacute;blica: </div></td>
              <td><input name="strFechaReporteCancelacion" type="text" class="txtTexto" maxlength="10" id="strFechaReporteCancelacion" size="20" value="<bean:write name="formulario-dian" property="strFechaReporteCancelacion"/>">
                <img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>"  
							onclick="return showCalendar('strFechaReporteCancelacion', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
            </tr>
            <tr>
              <td height="5" colspan="2"></td>
              </tr>
            <tr>
              <td><input name="txtvalidar" type="hidden" id="txtvalidar" value="tipoOperacion,numeroCuentaCorrienteCompensacion,nombreBanco,codigoPais,nombreCiudad,codigoMoneda,identificacionUnicaRegistro"></td>
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
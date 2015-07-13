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
	document.location="<html:rewrite page='/dian/modificar/1067.jsp'/>";
}
</script>
<html:form action="/dian/modificar/guardar" method="post">
<input type="hidden" name="formulario" value="1067">
<html:hidden property="indice"/>
  <table width="500" border="0" align="center" cellpadding="0" cellspacing="0" class="cuadro">
    <tr>
      <td><input type="hidden" name="formulario" value="1067">
      <table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr>
          <td><table width="100%" border="0" cellspacing="2" cellpadding="2">
            <tr>
              <td>
              <div align="center" class="txtTitulo">FORMULARIO 1067</div></td>
						<td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
              </tr>
            <tr>
              <td height="5" colspan="2"></td>
              </tr>
            <tr>
              <td width="50%"><div align="right" class="txtTexto">Tipo de Informante: </div></td>
              <td width="50%"><html:select property="tipoInformante" styleClass="lstbox" styleId="tipoInformante">
                <html:option value="1">Intermediario del mercado Cambiario &ndash; IMC</html:option>
                <html:option value="2">Usuario de Cuentas de Compensaci&oacute;n &ndash; CCC</html:option>
              </html:select>              </td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Fecha presentaci&oacute;n comunicaci&oacute;n u oficio: </div></td>
              <td><input name="strFecha" type="text" class="txtTexto" id="strFecha" maxlength="10" size="20" value="<bean:write name="formulario-dian" property="strFecha"/>">
                <img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>"  
							onclick="return showCalendar('strFecha', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Formulario de la Declaraci&oacute;n de cambio que se complementa: </div></td>
              <td><html:select property="procesamientoDeclaracion"
					styleClass="lstbox" styleId="procesamientoDeclaracion">
					<bean:define id="cp" scope="session" name="{procesamientoDeclaracion}" type="java.util.ArrayList"/>
		            <html:options collection="cp" property="code" labelProperty="value"/>
				</html:select>      </td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Fecha declaraci&oacute;n cambio complementada: </div></td>
              <td><input name="strFechaDeclaracionComplementada" type="text" class="txtTexto" maxlength="10" id="strFechaDeclaracionComplementada" size="20" value="<bean:write name="formulario-dian" property="strFechaDeclaracionComplementada"/>">
                  <img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>"  
							onclick="return showCalendar('strFechaDeclaracionComplementada', 'y-mm-dd');" 
							alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">N&uacute;mero declaraci&oacute;n cambio complementada: </div></td>
              <td><input name="numeroDeclaracionCambioComplementada" type="text" class="txtTexto" maxlength="5"  id="numeroDeclaracionCambioComplementada" size="40" value="<bean:write name="formulario-dian" property="numeroDeclaracionCambioComplementada"/>"></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Tipo de identificaci&oacute;n del importador o exportador: </div></td>
              <td><html:select property="tipoIdentificacion"
					styleClass="lstbox" styleId="tipoIdentificacion">
					<bean:define id="cp2" scope="session" name="{tipoIdentificacion}" type="java.util.ArrayList"/>
		            <html:options collection="cp2" property="code" labelProperty="value"/>
				</html:select>      </td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">N&uacute;mero de identificaci&oacute;n del importador o del exportador: </div></td>
              <td><input name="numeroIdentificacion" type="text" class="txtTexto" maxlength="20"  id="numeroIdentificacion" size="40" value="<bean:write name="formulario-dian" property="numeroIdentificacion"/>"></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">DV  del importador o exportador.: </div></td>
              <td><input name="digitoVerificador" type="text" class="txtTexto" maxlength="1"  id="digitoVerificador" size="30" value="<bean:write name="formulario-dian" property="digitoVerificador"/>"></td>
            </tr>
            
            <tr>
              <td><div align="right" class="txtTexto">Primer apellido importador o exportador: </div></td>
              <td><input name="primerApellido" type="text" class="txtTexto" id="primerApellido" maxlength="60" onkeypress="alphabetic();" size="40" value="<bean:write name="formulario-dian" property="primerApellido"/>"></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Segundo apellido importador o exportador: </div></td>
              <td><input name="segundoApellido" type="text" class="txtTexto" id="segundoApellido" maxlength="60" onkeypress="alphabetic();" size="40" value="<bean:write name="formulario-dian" property="segundoApellido"/>"></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Primer nombre importador o exportador: </div></td>
              <td><input name="nombre" type="text" class="txtTexto" id="nombre" maxlength="60" onkeypress="alphabetic();" size="40" value="<bean:write name="formulario-dian" property="nombre"/>"></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto">Otros nombres importador o exportador: </div></td>
              <td><input name="otroNombre" type="text" class="txtTexto" id="otroNombre" size="40" maxlength="60" onkeypress="alphabetic();" value="<bean:write name="formulario-dian" property="otroNombre"/>"></td>
            </tr>
            <tr>
              <td><div align="right" class="txtTexto"> Raz&oacute;n social importador o exportador: </div></td>
              <td><html:textarea property="razonSocial" cols="40" rows="4" styleClass="txtTexto" styleId="razonSocial" onkeypress="alphabetic();validateLength(this, 450)"/></td>
            </tr>
            <tr>
              <td height="5" colspan="2"></td>
              </tr>
            <tr>
              <td><input name="txtvalidar" type="hidden" id="txtvalidar" value="tipoInformante,formularioDeclaracion,strFechaDeclaracionComplementada,numeroDeclaracionCambioComplementada"></td>
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


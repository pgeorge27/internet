<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ include file="/dian/elaborar/edit/include/jspfunciones.inc.jsp" %>
<%@ include file="/head.jsp"  %>
	
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
	document.location="<html:rewrite page='/dian/elaborar/secundario/1063-3.jsp'/>";
}
</script>


<%@ include file="/body.jsp"%>
<html:form action="/dian/elaborar/guardar" method="post">
<html:hidden property="formulario" value="1063"/>
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
						<div align="center" class="txtTitulo">FORMULARIO 1067 Datos de la Importación</div>
						</td>
						<td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
					</tr>
					<tr>
						<td height="5" colspan="2" align="right"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Formulario de la Declaración de cambio que se complementa
						</div>
						</td>
						<td>
						<html:text property="formularioDeclaracion" styleId="formularioDeclaracion" 
							 size="20" maxlength="1"/></td>
					</tr>				
					<tr>
						<td>
						<div align="right" class="txtTexto">Fecha declaración cambio complementada</div>
						</td>
						<td nowrap>
						<html:text property="strFechaDeclaracionComplementada" styleId="fechaDeclaracionComplementada" 
						size="20" maxlength="10"/><img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>" 
						onclick="return showCalendar('fechaDeclaracionComplementada', 'y-mm-dd');" 
						alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Número declaración cambio complementada
						</div>
						</td>
						<td>
						<html:text property="numeroDeclaracionCambioComplementada" styleId="numeroDeclaracionCambioComplementada" 
							 size="20" maxlength="5"/></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Número declaración de importación
						</div>
						</td>
						<td>
						<html:text property="numeroDeclaracionImportacion" styleId="numeroDeclaracionImportacion" 
							 size="20" maxlength="16"/></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Año declaración importación
						</div>
						</td>
						<td>
						<html:text property="agnoDeclaracion" styleId="agnoDeclaracion" 
							 size="20" maxlength="4"/></td>
					</tr>

					<tr>
						<td>
						<div align="right" class="txtTexto">Valor USD pagado por declaración de importación
						</div>
						</td>
						<td>
						<html:text property="valorUSDDeclaracionImportacion" styleId="valorUSDDeclaracionImportacion" maxlength="22" onkeypress="__digit(this);" /></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Fecha documento de transporte</div>
						</td>
						<td nowrap>
						<html:text property="strFechaDocumentoTransporte" styleId="fechaDocumentoTransporte" 
						size="20" maxlength="10"/><img src="<html:rewrite page='/dian/elaborar/edit/images/cal.gif'/>" 
						onclick="return showCalendar('fechaDocumentoTransporte', 'y-mm-dd');" 
						alt="Calendario" width="16" height="16">[<b>yyyy-mm-dd</b>]</td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Número documento de transporte
						</div>
						</td>
						<td>
						<html:text property="numeroDocumentoTransporte" styleId="numeroDocumentoTransporte" 
							 size="20" maxlength="16"/></td>
					</tr>
					<tr>
						<td height="5" colspan="2"></td>
					</tr>
					<tr>
						<td><input name="txtvalidar" type="hidden" styleId="txtvalidar"
							value="valorUSD,fecha"></td>
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
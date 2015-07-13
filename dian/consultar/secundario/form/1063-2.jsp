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
	document.location="<html:rewrite page='/dian/elaborar/secundario/1063-1.jsp'/>";
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
						<div align="center" class="txtTitulo">FORMULARIO 1063 Información declaraciones de importación</div>
						</td>
						<td align="right"><INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></td>
					</tr>
					<tr>
						<td height="5" colspan="2" align="right"></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Número préstamo
						</div>
						</td>
						<td>
						<html:text property="numeroPrestamo" styleId="numeroPrestamo" 
							 size="20" maxlength="11"/></td>
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
						<div align="right" class="txtTexto">Numero declaración importación
						</div>
						</td>
						<td>
						<html:text property="numeroDeclaracionImportacion" styleId="numeroDeclaracionImportacion" 
							 size="20" maxlength="16"/></td>
					</tr>
					<tr>
						<td>
						<div align="right" class="txtTexto">Valor USD
						</div>
						</td>
						<td>
						<html:text property="valorUSD" styleId="valorUSD" maxlength="22" onkeypress="__digit(this);"/></td>
					</tr>
	
					<tr>
						<td height="5" colspan="2"></td>
					</tr>
					<tr>
						<td><input name="txtvalidar" type="hidden" styleId="txtvalidar"
							value="numeroPrestamo"></td>
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
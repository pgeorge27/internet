<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.struts.util.LabelValueBean"%>
<%@ page import="com.arango.common.util.StringUtilities" %>
<%!
private String getNombre(String text){
    if (text == null)
		return "";
    String temp = StringUtilities.replace(text, "\"","&#034;");
    temp = StringUtilities.replace(temp, "\n", "\\n");
    temp = StringUtilities.replace(temp, "\r", "\\r");
    temp = StringUtilities.replace(temp, "\"", "\\\"");
    temp = StringUtilities.replace(temp, "'", "\\'");
    temp = temp.replace('\n', ' ');
    temp = temp.replace('\r', ' ');

    return temp;
}
%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>

<script type="text/javascript">
	
	function validate()
	{
		var flag = false;
		
		var nombre = _trim(document.getElementById('nombreId').value);
		var banco = _trim(document.getElementById('bancoId').value);
		var cuenta = _trim(document.getElementById('cuentaId').value);
		
		if(nombre != "" && banco != "" && cuenta != ""){
			flag = true;			
		}
		return flag;
	}
	
	function send(){
		var msg = "<bean:message key="lbl.beneficiario.validacion.msg"/>";
		
		if(validate()){
			document.forms[0].submit();	
		}
		else{
			alert(msg);
		}
	}
	
	function _trim(str){
		while(''+str.charAt(0)==' ')
			str=str.substring(1,str.length);
		return str;	
	}
</script>

<script language="javascript">
	<%int i = 0;%>
    <csic:forEachCuentaPerfil producto="CC" formatAccount="C" mancomunada="true">
      	<%if ("true".equals(mancomunada)) {%>
	      accounts[<%=i++%>]=new Account('<%=numCtaCSIC%>', '<%=getNombre(nombreTitular)%>', '<%=moneda%>');
	    <%}%>
    </csic:forEachCuentaPerfil>
</script>
<%@ include file="../body.jsp" %>

<br>
<logic:messagesPresent>
	<table cellpadding="1" align="center" cellspacing="1" width="80%" class="tabla-acceso">
		<tr>
			<td>
			<table border="0" cellpadding="1" cellspacing="0" width="100%">
				<tr valign="top">
					<td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
					<td width="95%" class="msg">
						<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
						<span class="bienvenida">
							<table width="80%">
							<html:messages id="error">					
								<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
							</html:messages>
							</table>
						</span><br>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</logic:messagesPresent>
<div align="center"> 
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td><div align="left" class="login"><bean:message key="lbl.beneficiarios.general.mnu"/></div></td>
		  </tr>
		</table>
	</div></td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top">
	<html:form method="post" action="/grabar/beneficiario" onsubmit="document.forms[0].action.value='validate'">
	<html:hidden property="action" />
	<html:hidden property="mode" value="create"/>
	<html:hidden property="secuencia" />

	<table width="100%" border="0" cellpadding="5" cellspacing="1">
		<tr>
			<td colspan="3" height="20" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
		</tr>
		
		<tr>
			<td class="bienvenida"><b>1:</b> <bean:message key="lbl.beneficiario.nombre"/></td>  		
			<td class="bienvenida"><b>2:</b> <bean:message key="lbl.beneficiario.cuenta"/></td>
			<td class="bienvenida"><b>3:</b> <bean:message key="lbl.beneficiario.banco"/></td>
		</tr>
		
		<tr>
			<td><html:text property="nombre" size="50" styleId="nombreId" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			<td><html:text property="cuenta" size="50" styleId="cuentaId" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			<td><html:text property="banco" size="50"  styleId="bancoId" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
		</tr>
		
		<tr>
			<td colspan="3" align="center">
				<br><br>
				<input type="button" class="botton" onclick="send();" value="Aceptar"/>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" class="botton" onclick="document.location='<html:rewrite page='/mant/beneficiarios.do'/>'" value="Cancelar"/>
			</td>
		</tr>
		
	</table>
	</html:form>
	<script>
	function __initialize(){
		_refresh();
	}
	__initialize();
	</script>
<!-- Fin. Solicitud -->
	</td>
</tr>
</table></div>

<%@ include file="../footer.jsp"  %>
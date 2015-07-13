<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>

<script language="javascript">
function __retornar(){
	history.back();
}	
function __submit()
{
	if (document.forms[0].cuenta.value == "")
		{
		   alert("<bean:message key="msg.seleccionar.cuenta"/>");
		   document.forms[0].cuenta.focus();
		   return false;
		}
	if(ValidaFechas(document.forms[0].desde.value))	
		{
			alert("La fecha NO puede ser mayor al día de Hoy");
			document.forms[0].desde.focus();
			 return false;
		}	
		else
			document.forms[0].submit();
}
function ValidaFechas(date)
{
  var x=new Date();
      var fecha = date.split("-");
      x.setFullYear(fecha[2],fecha[1]-1,fecha[0]);
      var today = new Date();
 
      if (x <= today)
        return false;
      else
        return true;
}



</script>

<!--  Funcion para Rellenar de Ceros -->
<%! String valores(int numero)
{
	String cad = String.valueOf(numero);
	String resp = "0";
	if (cad.length() < 2)
	{
		resp += cad;
	}
	else
		resp = cad;
	return resp;
}
%>
<%
session.removeAttribute("representante.accion.nuevo");
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
Calendar cal = Calendar.getInstance();
int dia = cal.get(Calendar.DAY_OF_MONTH);
int ano = cal.get(Calendar.YEAR);
int mes = cal.get(Calendar.MONTH) + 1;
String anoCorto = String.valueOf(ano).substring(2,4);
%>
<%
SimpleDateFormat df = new SimpleDateFormat("yyyy");
Date pDate = new java.util.Date(System.currentTimeMillis());
String pYear = df.format(pDate);

df.applyPattern("MM");
String pMonth = df.format(pDate);

df.applyPattern("dd");
String pDay = df.format(pDate);

df.applyPattern("dd-MM-yyyy");

String fecha = df.format(pDate);

%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>
<%@ include file="../body.jsp" %>

<logic:messagesPresent>
  <table cellpadding="1" align="center" cellspacing="1" width="80%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
	<span class="bienvenida">
		<table width="80%">
		<html:messages id="error">					
			<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
		</html:messages>
		</table>
	</span><br>
								   </td></tr>
			 </table></td></tr>
		  </table>
</logic:messagesPresent>


<div align="center"> 
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
	<div> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
            <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>		  
			<td><div align="left" class="login">Helm Conexión</div></td>
		  </tr>
		</table>
	  </div>
	  </td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
	<html:form method="post" action="/multicash/links">
	  
  	  <%@ include file="../divHeader.jsp"%>
		<table  border="0" align="center" cellpadding="5" cellspacing="5">
		  <tr> 
			<td width="31%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cuentas"/></div></td>
			<td width="39%" nowrap><html:select property="cuenta" styleClass="botton-acceso">
									<logic:notEmpty name="cuentasMulticash">
											<html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
											<bean:define id="cp" scope="session" name="cuentasMulticash" type="java.util.ArrayList"/>
				                            <html:options collection="cp" property="codigoCSIC" labelProperty="tag"/>
										   
									</logic:notEmpty>
									<logic:empty name="cuentasMulticash">
										<html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
									</logic:empty>
									</html:select> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
		  <tr> 
			<td width="31%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.fecha"/></div></td>
			<td class="bienvenida" width="39%" nowrap><input name="desde" id="desde" type="text" class="botton-acceso" size="20" maxlength="12" value="<%=fecha%>">
	         <input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-y');" > [<b>dd-mm-yyyy</b>]
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
		  <tr> 
			<td colspan="2" align="center"><input name="botonEnviar" onclick="__submit();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
			  <input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
			</td>
		  </tr>
		</table>
		<%@ include file="../divFooter.jsp"%>
	  </html:form></td></tr>
	  <tr>
	  <td height="20" valign="middle" class="texto-acceso" align="center"><bean:message key="lbl.mensaje.campo.requerido"/></td>
          </tr>  
</table>
</div>
<%@ include file="../footer.jsp"  %>	
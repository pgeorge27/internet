<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.arango.internet.services.interfaces.ITransferencia"  %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
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
<%
String prod = "ALL";
if (request.getParameterValues("prod") != null)
{
  prod = request.getParameterValues("prod")[0];
}
String cuenta = "-1";
String tipo = "1";
if (request.getParameter("cuenta") != null && request.getParameter("cuenta").length() > 0)
{
 cuenta = request.getParameter("cuenta");
}
if (request.getParameterValues("tipo") != null)
{
  tipo = request.getParameterValues("tipo")[0];
}
String backPage = "seleccion";
if (request.getParameter("back") != null){
	backPage="consulta";	
}

%>
<%@ include file="/head.jsp"  %>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<style>
.lstbox {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	width: 400px;
	border: 1px solid #999999;
}
</style>
<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar.js'/>"></script>

<script language='javascript'>
var t;
function send(){
    if (document.forms['estadisticasForm'].cuenta.value == "")
	{
	   alert("<bean:message key="msg.seleccionar.cuenta"/>");
	   document.forms['estadisticasForm'].cuenta.focus();
	   return;
	}
	if (t == "3"){
		if (document.forms['estadisticasForm'].desde.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['estadisticasForm'].desde.focus();
			return;
		}
		if (document.forms['estadisticasForm'].hasta.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['estadisticasForm'].hasta.focus();
			return;
		}
	}
	
	document.forms['estadisticasForm'].submit();
}
function setValue(_value){
	t = _value;
}
function retornar(){
	history.back();
}
</script>

<script language="javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script language="javascript" src="<html:rewrite page='/scripts/objetoFecha.js'/>"></script>

<%@ include file="/body.jsp"%>
<logic:messagesPresent>
  <table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso">
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
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="center"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> <td width="50px"> <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
                        <td><div align="left" class="login">Estadístico de Transferencias</div></td>
                         </tr>
                    </table>
                  </div></td>
              </tr>
              <tr> 
                <td valign="top" align="center">
				<html:form method="get" action="/trans/activity/report.do"> 
				<html:hidden property="estado" value="ctaTrans" />
                   <%@ include file="../divHeader.jsp"%>
                    <table width="95%" border="0" align="center" cellpadding="5" cellspacing="5">
                      <tr> 
                        <td colspan="2"><div align="center" class="subtitulos"><bean:message key="lbl.movimiento.tipos"/></div></td>
					  </tr>
                      
					  <tr> 
                      
					  </tr>
                     <tr> 
                        <td width="41%" class="celda-clave1" colspan="1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.cuentas"/></div></td>
                        <td width="59%">
                            <html:select property="cuenta" styleClass="botton-acceso" value="">
										<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
										<csic:forEachCliente orderBy="NAME_ORDER">  
											<html:option value="<%=codigo%>" ><%=nombre%>&nbsp;<%=apellido%></html:option>	
										 </csic:forEachCliente>
								   </html:select> 
								    <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
                      </tr>
                      
                      <tr> 
                        <td class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.desde"/></div></td>
                        <td class="bienvenida" nowrap><html:text property="desde" styleClass="botton-acceso" size="20" maxlength="12"/>
                          <input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-y');" > [<b>dd-mm-yyyy</b>]
                         </td>
                      </tr>
                      <tr> 
                        <td class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.hasta"/></div></td>
                        <td class="bienvenida" nowrap><html:text property="hasta" styleClass="botton-acceso" size="20" maxlength="12"/>
                          <input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('hasta', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]</td>
                      </tr>
                      <tr>
                        <td>&nbsp;<br><br></td>
                        <td><input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
							<input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()"></td>
                      </tr>
                    </table>
                      <%@ include file="../divFooter.jsp"%>
                  </html:form></td>
              </tr>
              <tr>
                <td height="25" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
              </tr> 
            </table>



<%@ include file="/footer.jsp"  %>
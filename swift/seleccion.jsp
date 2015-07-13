<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Calendar"%>
<%
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
Calendar cal = Calendar.getInstance();

String hasta = df.format(cal.getTime());
cal.set(Calendar.DATE, 1);
String desde = df.format(cal.getTime());
%>
<%
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

%>
<%@ include file="../head.jsp"  %>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">
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
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar.js'/>"></script>

<script language='javascript'>
var t;
function send(){
    if (document.forms['swiftForm'].cuenta.value == "-1")
	{
	   alert("<bean:message key="msg.seleccionar.cuenta"/>");
	   document.forms['swiftForm'].cuenta.focus();
	   return;
	}
	if (t == "3"){
		if (document.forms['swiftForm'].desde.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['swiftForm'].desde.focus();
			return;
		}
		if (document.forms['swiftForm'].hasta.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['swiftForm'].hasta.focus();
			return;
		}
	}
	
	document.forms['swiftForm'].submit();
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

<%@ include file="../body.jsp"%>
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="center"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login">Consulta de Mensajes SWIFT</div></td>
                        <td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
                      </tr>
                    </table>
                  </div></td>
              </tr>
              <tr> 
                <td height="40" class="texto-acceso">&nbsp;</td>
              </tr>
              <tr> 
                <td valign="top">
				<html:form method="post" action="/consulta/swift">
                    <table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
                      <tr> 
                        <td colspan="2"><div align="center" class="subtitulos">Tipos de Mensajes</div></td>
                      </tr>
                      <tr> 
                        <td colspan="2"><table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
                            <tr> 
                              <td width="26%" height="15"><html:radio property="tipo" styleId="TipoOperacion" value="1" onclick="setValue(1);"/>
                                <span class="texto-acceso"><bean:message key="lbl.movimientos.dia"/> </span></td>
                              <td width="26%"><html:radio property="tipo" styleId="TipoOperacion" value="2" onclick="setValue(2);"/>
                                <span class="texto-acceso"><bean:message key="lbl.movimientos.mes"/></span></td>
                              <td width="26%"><html:radio property="tipo" styleId="TipoOperacion" value="3" onclick="setValue(3);"/>
                                <span class="texto-acceso"><bean:message key="lbl.movimientos.historicos"/></span></td>
                            </tr>
                          </table></td>
                      </tr>
                      <tr> 
                        <td width="41%" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cuentas"/></div></td>
                        <td width="59%">
                            <csic:ListaCuentas classname="lstbox" name="cuenta" acceso="CON" producto="CC" cuentaDefault="<%=cuenta%>"/> 	 <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
                            
                      </tr>
                      <tr> 
                        <td width="41%" class="celda-clave1"><div align="right" class="texto-acceso">Mensaje</div></td>
                        <td width="59%">
                            <html:select property="tipoMensaje" styleClass="lstbox">
									<html:option value="0">Todos</html:option>
									<html:option value="101">101</html:option>
									<html:option value="900">900</html:option>
									<html:option value="940">940</html:option>
									<html:option value="942">942</html:option>
							 </html:select>	 <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
                      </tr>
                      <tr> 
                        <td class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.desde"/></div></td>
                        <td class="bienvenida"><html:text property="desde" styleClass="botton-acceso" size="20" maxlength="12" value="<%=desde%>"/>
                          <input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-y');" > [<b>dd-mm-yyyy</b>]
                          
                        </td>
                      </tr>
                      <tr> 
                        <td class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.hasta"/></div></td>
                        <td class="bienvenida"><html:text property="hasta" styleClass="botton-acceso" size="20" maxlength="12" value="<%=hasta%>"/>
                          <input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('hasta', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]</td>
                      </tr>
                      <tr>
                        <td>&nbsp;<br><br></td>
                        <td><input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
							<input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()"></td>
                      </tr>
                    </table>
                  </html:form></td>
              </tr>
              <tr>
                <td height="25" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
              </tr>
            </table>

<%@ include file="../footer.jsp"  %>
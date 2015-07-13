<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
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
    if (document.forma.cuentas.value == "-1")
	{
	   alert("<bean:message key="msg.seleccionar.cuenta"/>");
	   document.forma.cuentas.focus();
	   return;
	}
	if (t == "3"){
		if (document.forma.desde.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forma.desde.focus();
			return;
		}
		if (document.forma.hasta.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forma.hasta.focus();
			return;
		}
	}
	
	document.forma.submit();
}
function setValue(_value){
	t = _value;
}
function retornar(){
	history.back();
}
</script>

<script language="javascript" src="../scripts/utilidades.js"></script>
<script language="javascript" src="../scripts/objetoFecha.js"></script>

<%@ include file="../body.jsp"%>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom">
                <div align="left"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                      <tr> <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
                        <td><div align="left" class="login"><bean:message key="tit.title.consulta.movimientos"/></div></td>
                      </tr>
                    </table>
                  </div></td>
              </tr>
              <tr> 
                <td width="80%" valign="top" align="center">
					<form name="forma" method="post" action="<html:rewrite page='/do.consulta'/>">
					<input type="hidden" name="tipo" value="MOV_EXT">
					<input type="hidden" name="prod" value="<%=prod%>">
					<input type="hidden" name="mesesAtras" value="1">
                    <%@ include file="../divHeader.jsp"%>
                    <table width="430px" border="0" align="center" >
                      <tr> 
                        <td>
                        <div align="center" class="subtitulos"><bean:message key="lbl.movimiento.tipos"/></div>
                        </td>
                      </tr>
                      <tr> 
                        <td>
                        <table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
                            <tr> 
                              <td width="26%" height="15" align="center"><input name="tipoMov" id="TipoOperacion" type="radio" value="1" checked onclick="setValue(1);">
                                <span class="texto-acceso"><bean:message key="lbl.movimientos.dia"/> </span></td>
                              <td width="26%"><input type="radio" name="tipoMov" id="TipoOperacion" value="2" onclick="setValue(2);">
                                <span class="texto-acceso"><bean:message key="lbl.movimientos.mes"/></span></td>
                              <td width="26%"><input type="radio" name="tipoMov" id="TipoOperacion" value="3" onclick="setValue(3);">
                                <span class="texto-acceso"><bean:message key="lbl.movimientos.historicos"/></span></td>
                            </tr>
                          </table>
                       </td>
                      </tr>
					  <tr>
						<td>
							<table>
<tr> 
	<td width="38%" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cuentas"/></div></td>
	<td width="62%">
		<csic:ListaCuentas classname="botton-acceso" name="cuentas" acceso="CON" producto="<%=prod%>" cuentaDefault="<%=cuenta%>"/> <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
</tr>
<tr> 
	<td class="celda-clave1" ><div align="right" class="texto-acceso"><bean:message key="lbl.desde"/></div></td>
	<td class="bienvenida" width="300px"><input name="desde" id="desde" type="text" class="botton-acceso" size="20" maxlength="12" value="<%=fecha%>">
	  <input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-y');" > [<b>dd-mm-yyyy</b>]
	  
	</td>
</tr>
<tr> 
	<td class="celda-clave1" ><div align="right" class="texto-acceso"><bean:message key="lbl.hasta"/></div></td>
	<td class="bienvenida" width="300px"><input name="hasta" id="hasta" type="text" class="botton-acceso" size="20" maxlength="12" value="<%=fecha%>">
	  <input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('hasta', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]</td>
</tr>
		<tr><td colspan="2" align="center"> &nbsp;<br></td></tr>
                      <tr>
                        <td colspan="2" align="center"><input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
							<input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()"></td>
                      </tr>
</table>
						</td>
					  </tr>
					</table>
					<%@ include file="../divFooter.jsp"%>
					</form>
				</td>
			</tr>
			<tr>
				<td height="20" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
			  </tr>
</table>
<%@ include file="../footer.jsp"  %>
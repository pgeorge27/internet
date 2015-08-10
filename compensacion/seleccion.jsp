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
    if (document.forms['movimientoForm'].cuenta.value == "")
	{
	   alert("<bean:message key="msg.seleccionar.cuenta"/>");
	   document.forms['movimientoForm'].cuenta.focus();
	   return;
	}
	if (t == "3"){
		if (document.forms['movimientoForm'].desde.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['movimientoForm'].desde.focus();
			return;
		}
		if (document.forms['movimientoForm'].hasta.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['movimientoForm'].hasta.focus();
			return;
		}
	}
	
	document.forms['movimientoForm'].submit();
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

<div class="container">
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-default" >
        <div class="panel-heading" >
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
            <bean:message key="lbl.compensacion.movimiento.titulo"/>
          </strong>
        </div>

        <div class="panel-body">
         <html:form method="post" action="/consulta">
         <html:hidden property="tipo" value="3"/>


          <div class="col-md-4">
            <p>
              <bean:message key="lbl.cuentas"/><span class="form-control"> (<font color="#FF0000">*</font>)</span>
            </p>
          </div>

          <div class="col-md-8">
            <p>
              <html:select property="cuenta" styleClass="lstbox">
                <logic:notEmpty name="cuentasCompensacion">
                  <html:option value="">
                    <bean:message key="lbl.seleccione.una.cuenta"/>
                  </html:option>
                  <bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
                  <html:options collection="cp" property="codigoCSIC" labelProperty="tag"/>
                </logic:notEmpty>
                <logic:empty name="cuentasCompensacion">
                  <html:option value="">
                  <bean:message key="lbl.seleccione.no.hay.cuentas"/>
                  </html:option>
                </logic:empty>
              </html:select>
            </p>
          </div>

          <div class="col-md-4">
            <p><bean:message key="lbl.desde"/></p>
          </div>

          <div class="col-md-4">
            <p>
              <html:text styleId="desde" property="desde" styleClass="form-control" size="20" maxlength="12"/>
            </p>
          </div>

          <div class="col-md-4">
            <p>
              <input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-y');" > [<b>dd-mm-yyyy</b>]
            </p>
          </div>
          <div class="row"> </div>
          <div class="col-md-4">
            <p>
              <bean:message key="lbl.hasta"/>
            </p>
          </div>

          <div class="col-md-4">
            <p>
              <html:text styleId="hasta" property="hasta" styleClass="form-control" size="20" maxlength="12"/>
            </p>
          </div>

          <div class="col-md-4">
            <p>
              <input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('hasta', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]
            </p>
          </div>

          <div class="row"> </div>

          <div align="center">
            <input name="botonEnviar" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.consultar"/>">
            <input TYPE="BUTTON" class="btn btn-default" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
          </div>

          <div align="center">
            <p><bean:message key="lbl.mensaje.campo.requerido"/></p>
          </div>

          </html:form>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="../footer.jsp"  %>
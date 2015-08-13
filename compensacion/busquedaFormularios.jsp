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
session.setAttribute("form.back","/consulta/estado");
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
    if (document.forms['consultaEstadoForm'].cuenta.value == "")
	{
	   alert("<bean:message key="msg.seleccionar.cuenta"/>");
	   document.forms['consultaEstadoForm'].cuenta.focus();
	   return;
	}
	if (t == "3"){
		if (document.forms['consultaEstadoForm'].desde.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['consultaEstadoForm'].desde.focus();
			return;
		}
		if (document.forms['consultaEstadoForm'].hasta.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['consultaEstadoForm'].hasta.focus();
			return;
		}
	}
	
	document.forms['consultaEstadoForm'].submit();
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

	<logic:present name="msg">
		<div align="center" class="well col-md-4 col-md-offset-4">
			<p><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>"></p>
			<p><b><bean:message key="errors.header"/></b></p>
			<html:messages id="error">
				<p class="bienvenida">- <bean:write name="error" /></p>
			</html:messages>
		</div>
	</logic:present>

    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-default" >
        <div class="panel-heading" >
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
            <bean:message key="lbl.compensacion.consulta.titulo"/>
          </strong>
        </div>

        <div class="panel-body">

		<html:form method="post" action="/busqueda/documentos">

          <div class="col-md-4">
            <p>
              <bean:message key="lbl.cuentas"/>
              <span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
            </p>
          </div>


          <div class="col-md-8">
            <p>
              <html:select property="cuenta" styleClass="form-control">
                <logic:notEmpty name="cuentasCompensacion">
                  <html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
                  <bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
                  <html:options collection="cp" property="codigoCSIC" labelProperty="tag"/>
                </logic:notEmpty>
                <logic:empty name="cuentasCompensacion">
                  <html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
                </logic:empty>
              </html:select>
            </p>
          </div>

          <div class="col-md-4">
            <p>
              Tipo Documento <span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
            </p>
          </div>

          <div class="col-md-8">
            <p>
				<html:select property="tipo" styleClass="form-control">
					<html:option value="1">1 - Datos de la Importación</html:option>                      	
					<html:option value="2">2 - Datos de la Exportación</html:option>
				</html:select>
            </p>
          </div>

          <div class="col-md-4">
            <p>
				<bean:message key="lbl.desde"/>
            </p>
          </div>

          <div class="col-md-4">
            <p>
				<html:text property="desde" styleId="desde" styleClass="form-control" size="20" maxlength="12"/>
            </p>
          </div>

          <div class="col-md-4">
            <p>
				<input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde','dd-mm-y');"/> [<b>dd-mm-yyyy</b>]
            </p>
          </div>

          <div class="col-md-4">
            <p>
				<bean:message key="lbl.hasta"/>
            </p>
          </div>

          <div class="col-md-4">
            <p>
				<html:text property="hasta" styleId="hasta" styleClass="form-control" size="20" maxlength="12"/>
            </p>
          </div>

          <div class="col-md-4">
            <p>
				<input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('hasta','dd-mm-y');"/> [<b>dd-mm-yyyy</b>]
            </p>
          </div>


		<div class="col-md-4">
            <p>
              Número Documento
            </p>
          </div>

          <div class="col-md-8">
            <p>
				<html:text property="NumDecla" styleClass="form-control"  styleId="NumDecla"  size="20" maxlength="16"/>
            </p>
          </div>

          <div align="center">
            <input name="botonEnviar" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.consultar"/>">
            <input TYPE="BUTTON" class="btn btn-default" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
            <p>
              <bean:message key="lbl.mensaje.campo.requerido"/>
            </p>
          </div>


          </html:form>

        </div>

      </div>
    </div>
  </div>
</div>


<logic:messagesPresent>
	<table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso">
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
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
	<tr> 
		<td height="40" valign="bottom">
			<div align="center"> 
				<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
					<tr>
						<td width="50px"> <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
						<td><div align="left" class="login"><bean:message key="lbl.compensacion.consulta.titulo"/></div></td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
    <tr> 
        <td valign="top" align="center">
			<html:form method="post" action="/busqueda/documentos">
			<%@ include file="../divHeader.jsp"%>
                <table width="450px" border="0" align="center" cellpadding="5" cellspacing="5">
                    <tr> 
                        <td width="35%" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cuentas"/></div></td>
                        <td width="65%">
                            <html:select property="cuenta" styleClass="lstbox">
								<logic:notEmpty name="cuentasCompensacion">
									<html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
									<bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
									<html:options collection="cp" property="tag" labelProperty="tag"/>
								</logic:notEmpty>
								<logic:empty name="cuentasCompensacion">
									<html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
								</logic:empty>
							</html:select>
						</td>
						<td><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
                    </tr>
                    <tr> 
						<td class="celda-clave1"><div align="right" class="texto-acceso">Tipo Documento</div></td>
						<td nowrap>
							<html:select property="tipo" styleClass="botton-acceso">
								<html:option value="1">1 - Datos de la Importación</html:option>                      	
								<html:option value="2">2 - Datos de la Exportación</html:option>
							</html:select>
						</td>
						<td><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
					</tr>
                    <tr> 
                        <td class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.desde"/></div></td>
                        <td class="bienvenida">
							<html:text property="desde" styleId="desde" styleClass="botton-acceso" size="20" maxlength="12"/>
							<input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde','dd-mm-y');"/> [<b>dd-mm-yyyy</b>]
                        </td>
                    </tr>
                    <tr> 
                        <td class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.hasta"/></div></td>
                        <td class="bienvenida">
							<html:text property="hasta" styleId="hasta" styleClass="botton-acceso" size="20" maxlength="12"/>
							<input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('hasta','dd-mm-y');"/> [<b>dd-mm-yyyy</b>]
						</td>
                    </tr>
					<tr> 
                        <td class="celda-clave1"><div align="right" class="texto-acceso">Número Documento</div></td>
                        <td class="bienvenida"><html:text property="NumDecla" styleId="NumDecla"  size="20" maxlength="16"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;<br><br></td>
                        <td>
							<input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
							<input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
						</td>
                    </tr>
                </table>
            <%@ include file="../divFooter.jsp"%>
			</html:form>
		</td>
	</tr>
	<tr>
		<td height="25" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
	</tr>
</table>

<%@ include file="../footer.jsp"  %>
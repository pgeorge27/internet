<% session.setAttribute("selected", "custodia"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@page import="com.arango.common.banking.Productos"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.common.beans.PerfilXML"%>
<%@ page import="com.arango.internet.banking.Custodia"%>
<%@page import="com.arango.common.delegate.cliente.drivers.arango.DrvNroCuenta"%>
<%@page import="com.arango.common.beans.Cuenta"%>
<%
ArrayList cuentas = new ArrayList();

if (session.getAttribute("ctaCustodia") == null || ((ArrayList)session.getAttribute("ctaCustodia")).isEmpty()){
	PerfilXML p3 = (PerfilXML)session.getAttribute("perfil.xml");
	if (p3 == null)
		pageContext.forward("/index.jsp");
		
	cuentas = p3.getCuentasPorProducto(new String[]{"12"}, null);
	if (cuentas != null && !cuentas.isEmpty()){
		Custodia cus = null;
		ArrayList custodias = new ArrayList();
		DrvNroCuenta	  nroCta = null;
		Cuenta c = null;
		for(int i = 0; i < cuentas.size(); i++){
			c = (Cuenta)cuentas.get(i);
			cus = new Custodia();
			
			nroCta = new DrvNroCuenta(c.getCodigoBanco());
			cus.setNroCuenta((int)nroCta.getNroCuenta());
			cus.setCodigo((int)nroCta.getNroCuenta());
			cus.setCodigoEmisor(Integer.parseInt(c.getTitular()));
			custodias.add(cus);
		}
		session.setAttribute("ctaCustodia", custodias);
	}
}
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
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
                        <td><div align="left" class="login">Consulta de Custodia</div></td>
                       </tr>
                    </table>
                  </td>
              </tr>
              <tr> 
                <td height="40" class="texto-acceso">&nbsp;</td>
              </tr>
              <tr align="center"> 
                <td valign="top">
				<html:form method="post" action="/custodia/consultas">
                   <%@ include file="../divHeader.jsp"%>
                    <table width="80%" border="0" align="center" cellpadding="5" cellspacing="5" align="center">
                      
                      <tr> 
                        <td width="41%" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cuentas"/></div></td>
                        <td width="53%">
                            <html:select property="cuenta" styleClass="lstbox">
									<logic:notEmpty name="ctaCustodia">
											<html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
											<bean:define id="cp" scope="session" name="ctaCustodia" type="java.util.ArrayList"/>
				                            <html:options collection="cp" property="nroCuenta" labelProperty="nroCuenta"/>
										   
									</logic:notEmpty>
									<logic:empty name="ctaCustodia">
										<html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
									</logic:empty>
							   	 </html:select></td>
							   	 	<td align="left"> <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
                      </tr>
                     
                      <tr>
                        <td>&nbsp;<br><br></td>
                        <td><input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
							<input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()"></td>
                      </tr>
                    </table>
                    <%@ include file="../divFooter.jsp"%>
                  </html:form>
                  </td>
              </tr> <tr>
                <td height="25" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
              </tr>
            </table>

<%@ include file="../footer.jsp"  %>
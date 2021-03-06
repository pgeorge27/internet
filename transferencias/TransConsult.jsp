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

<!DOCTYPE html>
<html:html>

<head>
<%@ include file="/head.jsp"  %>

</head>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
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

<body>

<div class="container">

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

		<div class="row">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong>Estadístico de Transferencias</strong></div>
					  <div class="panel-body">

	<html:form method="get" action="/trans/activity/report.do"> 
				<html:hidden property="estado" value="ctaTrans" />

	<div style="align: left">
	            		            								<label style="text-align:left">	<h5><strong style="align: left">
				
						<bean:message key="lbl.movimiento.tipos"/>:
					
						</strong></h5>
			</label>
					
				</div>

							<div>
						
						<label style="text-align:left">	<h5><strong>
				
						<font color="#FF0000" >*</font>&nbsp;<bean:message key="lbl.cuentas"/>:
					
						</strong></h5>
			</label>

							</div>

							<div class="row">
							
							 <div class="col-md-1"></div>

  <div class="col-md-10">     <html:select property="cuenta" styleClass="form-control" value="">
										<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
										<csic:forEachCliente orderBy="NAME_ORDER">  
											<html:option value="<%=codigo%>" ><%=nombre%>&nbsp;<%=apellido%></html:option>	
										 </csic:forEachCliente>
								   </html:select> </div>
							

							</div>
	
				<br>

							<div class="row">
  <div class="col-md-2">								<label style="text-align:left">	<h5><strong>
				
							<bean:message key="lbl.desde"/>:
					
						</strong></h5>
			</label></div>
  <div class="col-md-5" align="center"><html:text property="desde" styleClass="form-control" size="20" maxlength="12"/></div>
  <div class="col-md-5"><input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-y');" > [<b>dd-mm-yyyy</b>]</div>
					
								</div>

									<br>

													<div class="row">
  <div class="col-md-2">								<label style="text-align:left">	<h5><strong>
				
							<bean:message key="lbl.hasta"/>:
					
						</strong></h5>
			</label></div>
  <div class="col-md-5" align="center"><html:text property="hasta" styleClass="form-control" size="20" maxlength="12"/></div>
  <div class="col-md-5"><input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('hasta', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]</div>
					
								</div>	
							
							<br>

	<div align="center">
	
	<input name="botonEnviar" onclick="send();" type="button"  style="width: 100px" class="btn btn-default" value="<bean:message key="btn.consultar"/>">
	
	<input TYPE="BUTTON" class="btn btn-default" style="width: 100px" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
		
				</div>
				
				<br>
							
			
      <div align="center">
            
				<div style="color:#7f8c8d"><bean:message key="lbl.mensaje.campo.requerido"/></div>
  			</div>

	</html:form>


</div>


</div>

</div>

</div>

</div>

</div>
</body>
</html:html>
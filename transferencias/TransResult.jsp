<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@page import="com.arango.common.util.Format" %>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html:html>

<head>

<%@ include file="/head.jsp"  %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>

<%! Format f = Format.getFormat();%>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>
<script language=javascript>
var queryString = new Array();
    var query = document.location.search.replace("?","");
    var valores = query.split("&");
    for(var i = 0; i < valores.length; i++)
	   {  var subvalor = valores[i].split("=");
		  queryString[subvalor[0]] = subvalor[1]
	   }

function __retornar(){
	document.location="<html:rewrite page='/trans/activity/seleccion.do'/>";
}
function changeGraphit(tipo){
	if(tipo != "ctaTrans")
	{	tipo = "monto"	}
	
	document.forms['estadisticasForm'].cuenta.value = queryString["cuenta"];
	document.forms['estadisticasForm'].desde.value = queryString["desde"];
	document.forms['estadisticasForm'].hasta.value = queryString["hasta"];
	document.forms['estadisticasForm'].estado.value = tipo;
	document.forms['estadisticasForm'].submit();	
}

</script>
<%@ include file="/body.jsp"%>

<body>

<div class="container">

<br>

<div align="right">&nbsp;
							<INPUT class="btn btn-default" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>

<br>


	<div class="row">
		<div>
			<div class="panel panel-default" >
				<div class="panel-heading">
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>Reporte</strong>
				</div>

</div>

</div>

</div>

						<div id="no-more-tables">
<table class="col-md-12 table-bordered table-striped table-condensed cf">
  <thead class="cf">  
						<tr align="center">
							<td data-title="Desde"><div align="left" class="subtitulos"><bean:message key="lbl.desde"/></div></td>
							<td class="subtitulos" align="left"> <script type="text/javascript">document.write(queryString["desde"]);</script></td>
							<td data-title="Hasta"><div align="left" class="subtitulos"><bean:message key="lbl.hasta"/></div></td>
							<td  class="subtitulos" align="left"> <script type="text/javascript">document.write(queryString["hasta"]);</script></td>
						</tr></thead>

			</table>
			<br>
					<div align="center">
			
				
						<img class="img-responsive center-block" width="700" height="450" alt="Responsive image"  src="<html:rewrite page='/grafica'/>">
				
				</div>
			
			</div>
			
			<br>
			<br>
			
			<html:form method="get"  action="/trans/activity/report.do"   >
				<html:hidden property="estado" />
				<html:hidden property="cuenta" />
				<html:hidden property="desde" />
				<html:hidden property="hasta" />
			</html:form>
						
									<div id="no-more-tables">
<table class="col-md-12 table-bordered table-striped table-condensed cf">
  <thead class="cf">  
				<tr class="tabla-acceso">
					<td class="texto-acceso"  align="center">N°</td>
					<td class="texto-acceso"  align="center">Nombre Beneficiario</td>
					<td class="texto-acceso"  align="center"><INPUT class="botton" onclick="changeGraphit('ctaTrans');" type=button value="Cantidad transferencias"/></td>
					<td class="texto-acceso"  align="center">Moneda</td>
					<td class="texto-acceso"  align="center"><INPUT class="botton" onclick="changeGraphit('monto');" type=button value="Valor"/></td>                                                
				</tr></thead>
				<logic:present name="transf.activity">
				<logic:iterate name="transf.activity" id="row" type="com.arango.internet.banking.Movimiento" indexId="resultNo">
					<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					<logic:equal name="remainder" value="0">
					   <tr>
					</logic:equal>
					<logic:notEqual name="remainder" value="0">
					   <tr class="celda-clave1">
					</logic:notEqual>
							<td data-title="N°" class="bienvenida" align="center"><%=Integer.toString(resultNo.intValue()+1) %></td>
							<td data-title="Nombre Beneficiario" class="bienvenida" align="left"><bean:write name="row" property="nombre"/></td>
							<td data-title="Cantidad Transferencias" class="bienvenida" align="center"><bean:write name="row" property="secuenciaMov"/></td>
							<td class="Moneda" align="left"><bean:write name="row" property="moneda"/></td>
							<td class="Valor" align="right"><bean:write name="row" property="suma" format="##,###,###,##0.00"/></td>
						
				</logic:iterate>
				</logic:present>
			</table>
			
<br>	
		</div>	
			
			
	<br>
	<br>
		
		<div align="center">
							<a href="javascript:printPage3()">
								<img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0">
							</a>
						</div>	
						
						<br>

						<div align="center">
						<INPUT class="btn btn-default" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>">
						</div>

			<br>
</div>	
</body>
</html:html>
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

<%@ include file="/head.jsp"  %>

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

<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
	<tr> 
		<td height="40" valign="bottom">
			<div align="left"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
				<tr> 
					<td><div align="left" class="login">Reporte</div></td>
					<td width="8%">
						<div align="right">&nbsp;
							<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>">
						</div>
					</td>
				</tr>
			</table>
			</div>
		</td>
	</tr>
</table>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">     
    <tr> 
        <td valign="top">
			<table width="100%">
				<tr align="center" >
					<td>
						<table width="40%" border="0" cellpadding="0" cellspacing="0">
						<tr align="center">
							<td width="10%"><div align="left" class="subtitulos"><bean:message key="lbl.desde"/></div></td>
							<td width="30%" class="subtitulos" align="left"> <script type="text/javascript">document.write(queryString["desde"]);</script></td>
							<td width="10%"><div align="left" class="subtitulos"><bean:message key="lbl.hasta"/></div></td>
							<td width="30%" class="subtitulos" align="left"> <script type="text/javascript">document.write(queryString["hasta"]);</script></td>
						</tr>
						</table>
						<br/>
					</td>
				</tr>
				
				<tr align="center">
				<br/>
					<td>
						<img width="700" height="450" src="<html:rewrite page='/grafica'/>">
					</td>
				</tr>
			</table>
			<html:form method="get"  action="/trans/activity/report.do"   >
				<html:hidden property="estado" />
				<html:hidden property="cuenta" />
				<html:hidden property="desde" />
				<html:hidden property="hasta" />
			</html:form>
			<table width="60%" border="0" cellpadding="1" cellspacing="2" align="center">
				<tr class="tabla-acceso">
					<td class="texto-acceso" width="4%" align="center"></td>
					<td class="texto-acceso" width="50%" align="center">Nombre Beneficiario</td>
					<td class="texto-acceso" width="10%" align="center"><INPUT class="botton" onclick="changeGraphit('ctaTrans');" type=button value="Cantidad transferencias"/></td>
					<td class="texto-acceso" width="25%" align="center">Moneda</td>
					<td class="texto-acceso" width="20%" align="center"><INPUT class="botton" onclick="changeGraphit('monto');" type=button value="Valor"/></td>                                                
				</tr>
				<logic:present name="transf.activity">
				<logic:iterate name="transf.activity" id="row" type="com.arango.internet.banking.Movimiento" indexId="resultNo">
					<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					<logic:equal name="remainder" value="0">
					   <tr>
					</logic:equal>
					<logic:notEqual name="remainder" value="0">
					   <tr class="celda-clave1">
					</logic:notEqual>
							<td class="bienvenida" align="center"><%=Integer.toString(resultNo.intValue()+1) %></td>
							<td class="bienvenida" align="left"><bean:write name="row" property="nombre"/></td>
							<td class="bienvenida" align="center"><bean:write name="row" property="secuenciaMov"/></td>
							<td class="bienvenida" align="left"><bean:write name="row" property="moneda"/></td>
							<td class="bienvenida" align="right"><bean:write name="row" property="suma" format="##,###,###,##0.00"/></td>
						</tr>
				</logic:iterate>
				</logic:present>
			</table>
			<table width="100%" border="0" cellpadding="5" cellspacing="5">	
				<tr><br>
					<td colspan="2">
						<div align="center">
							<a href="javascript:printPage3()">
								<img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0">
							</a>
						</div>	
					</td>
				</tr>
				<tr> 
					<td valign="top" class="texto-acceso" colspan="2">
						<div align="center"><br>
						<INPUT class="botton" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>">
						</div>
					</td>
				</tr>
			</table>
		</td>
    </tr>
</table>
<%@ include file="/footer.jsp"  %>
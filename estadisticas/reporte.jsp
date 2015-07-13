<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>

<%@ include file="/head.jsp"  %>
<script language=javascript>

function __retornar(){
	document.location="<html:rewrite page='/est/seleccion.do'/>";
}

</script>
<%@ include file="/body.jsp"%>
<html:form action="/dian/elaborar/editar">
	<html:hidden property="indice"/>
</html:form>

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
				<tr align="center">
					<td>
						<img width="500" height="350"  src="<html:rewrite page='/grafica'/>">
					</td>
				</tr>
			</table>
			<table width="50%" border="0" cellpadding="1" cellspacing="2" align="center">
				<tr class="tabla-acceso">
					<td class="texto-acceso" width="10%" align="center">Código de Formulario</td>
					<td class="texto-acceso" width="10%" align="center">Código de Numeral</td>
					<td class="texto-acceso" width="50%" align="center">Descripción</td>
					<td class="texto-acceso" width="30%" align="center">Valor</td>                                                
				</tr>
				<logic:present name="mov.movimiento">
				<logic:iterate name="mov.movimiento" id="row" type="com.arango.internet.banking.Movimiento" indexId="resultNo">
					<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>
					<logic:equal name="remainder" value="0">
					   <tr>
					</logic:equal>
					<logic:notEqual name="remainder" value="0">
					   <tr class="celda-clave1">
					</logic:notEqual>
							<td class="bienvenida" align="center"><bean:write name="row" property="codFormulario"/></td>
							<td class="bienvenida" align="center"><bean:write name="row" property="codNumeral"/></td>
							<td class="bienvenida" align="left"><bean:write name="row" property="descripcion"/></td>
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
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>


<!DOCTYPE html>
<html:html>

<head>

<%@ include file="/head.jsp"  %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>
<script language=javascript>

function __retornar(){
	document.location="<html:rewrite page='/est/seleccion.do'/>";
}

</script>
<%@ include file="/body.jsp"%>
<body>

<div class="container">




	<div align="right">
						<INPUT class="btn btn-default" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>">
						</div>



<br>




	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong>Reporte</strong></div>

</div>

<br>













<html:form action="/dian/elaborar/editar">
	<html:hidden property="indice"/>
</html:form>

   
  

			
					<div>
						<img width="500" height="350" class="img-responsive center-block" alt="Responsive image" src="<html:rewrite page='/grafica'/>">
					</div>
					
					<br>
		
											<div id="no-more-tables">
<table class="col-md-12 table-bordered table-striped table-condensed cf">
  <thead class="cf">  
				<tr class="tabla-acceso">
					<td class="texto-acceso" align="center">Código de Formulario</td>
					<td class="texto-acceso"  align="center">Código de Numeral</td>
					<td class="texto-acceso"  align="center">Descripción</td>
					<td class="texto-acceso"  align="center">Valor</td>                                                
				</tr></thead>
				<logic:present name="mov.movimiento">
				<logic:iterate name="mov.movimiento" id="row" type="com.arango.internet.banking.Movimiento" indexId="resultNo">
					<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>
					<logic:equal name="remainder" value="0">
					   <tr>
					</logic:equal>
					<logic:notEqual name="remainder" value="0">
					   <tr class="celda-clave1">
					</logic:notEqual>
							<td data-title="Código Formulario" class="bienvenida" align="center"><bean:write name="row" property="codFormulario"/></td>
							<td data-title="Código de Numeral" class="bienvenida" align="center"><bean:write name="row" property="codNumeral"/></td>
							<td data-title="Descripción" class="bienvenida" align="left"><bean:write name="row" property="descripcion"/></td>
							<td data-title="Valor" class="bienvenida" align="right"><bean:write name="row" property="suma" format="##,###,###,##0.00"/></td>
						</tr>
				</logic:iterate>
				</logic:present>
			</table></div>
			<table width="100%" border="0" cellpadding="5" cellspacing="5">	
				<tr><br>
					<td colspan="2">
						<div class="visible-lg" align="center">
							<a href="javascript:printPage3()">
								<img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0">
							</a>
						</div>	
					</td>
				</tr>
				<tr>
					<td valign="top" class="texto-acceso" colspan="2">
						<div align="center"><br>
							<INPUT class="btn btn-default" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>">
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%@ include file="/footer.jsp"  %>

</div>
</body>
</html:html>
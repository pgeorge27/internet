<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>

<%@ include file="..//head.jsp"  %>


<%
 
 String tranferCounter =  (String)session.getAttribute("multipagos.transferencias.counters.total");
 String tranferInValid =  (String)session.getAttribute("multipagos.transferencias.counters.invalid");
 String tranferValid =    (String)session.getAttribute("multipagos.transferencias.counters.valid");
 
if (tranferCounter == null) {tranferCounter = "";}
if (tranferInValid == null) {tranferInValid = "";}
if (tranferValid == null) {tranferValid = "";}
	
%>

<style type="text/css">
.novalid {background #ffA500;}
.nueva {
		background-color: #F6C683; 
		color: white;
	}
</style> 
<script language=javascript>

function __retornar(){
	document.location="<html:rewrite page='/multipagos/CargaArchivo.jsp'/>";
}function send(){
	document.forms['cargaArchivo'].submit();
}


</script>
<script language="javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script language="javascript" src="<html:rewrite page='/scripts/objetoFecha.js'/>"></script>

<%@ include file="/body.jsp"%>
<br>
<div class="container">
	<div class="row">
		<div>
			<div class="panel panel-default" >
				<div class="panel-heading">
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>Validacion de Archivo</strong>
				</div>
				<div class="panel-body">
					<div align="right">
						<input class="botton btn btn-default" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>">
					</div>
					<p>Transferencias Por Archivo : <%=tranferCounter%></p>
					<p>Transferencias Válidas en el Archivo : <%=tranferValid%></p>
					<p>Transferencias no Válidas en el Archivo : <%=tranferInValid%></p>
				</div>
				<logic:notPresent name="error.formato.archivo">
					<html:form method="post" action="/multipagos/cargaArchivo" method="post" >
						<div class="row">
							<div class="col-xs-2 col-xs-offset-4">
								<input name="botonEnviar" style="text-align: right;" onclick="send();" type="button" class="botton btn btn-default visible-lg" value="Cargar">
							</div>
  							<div class="col-xs-2">
  								<input class="botton btn btn-default" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>">
  							</div>
						</div>
					</html:form>
				</logic:notPresent>
				<br>
			</div>
		</div>

		<div>
		<logic:present name="multipagos.transferencias.detalles">
			<div id="no-more-tables">
				<table class="col-md-12 table-bordered table-striped table-condensed cf">
					<thead class="cf">
						<tr class="tabla-acceso">
							<td class="texto-acceso" align="center">
								<div class="texto-acceso" title="Nuemero de Cuenta">Numero de Cuenta</div>
							</td>
							<td class="texto-acceso" align="center">
								<div class="texto-acceso" title="Fecha Valor">Fecha Valor</div>
							</td>
							<td class="texto-acceso" align="center">
								<div class="texto-acceso" title="Moneda">Moneda</div>
							</td>
							<td class="texto-acceso" align="center"> 
								<div class="texto-acceso" title="Monto">Monto</div>
							</td>
							<td class="texto-acceso" align="center">
								<div class="texto-acceso" title="SWIFT/ABA/OTROS">SWIFT/ABA/OTROS</div>
							</td>
							<td class="texto-acceso" align="center">
								<div class="texto-acceso" title="Banco Beneficiario">Banco Beneficiario</div>
							</td>
							<td class="texto-acceso" align="center">
								<div class="texto-acceso" title="Beneficiario">Beneficiario</div>
							</td>
							<td class="texto-acceso" align="center">
								<div class="texto-acceso" title="Cuenta Beneficiario">Cuenta Beneficiario</div>
							</td>
							<td class="texto-acceso" align="center">
								<div class="texto-acceso" title="Cuenta Beneficiario">Detalle de Error</div>
							</td>
						</tr>
					</thead>
					<logic:iterate name="multipagos.transferencias.detalles" id="row" type="com.arango.internet.beans.TranferenciaProcesada" indexId="resultNo" >
						<logic:equal name="row" property="error" value="0">
							<tr  class="novalid">
						</logic:equal>
						<logic:notEqual name="row" property="error" value="0">
							<tr class="nueva">
						</logic:notEqual>

						<logic:equal name="row" property="numeroCuenta" value="1000000001">
							<td data-title="Numero Cuenta no Valida" class="bienvenida">Numero Cuenta no Valida</td>
						</logic:equal>
						<logic:notEqual name="row" property="numeroCuenta" value="1000000001">
							<td data-title="Numero de Cuenta" class="bienvenida">
								<bean:write name="row" property="numeroCuenta"/>
							</td>
						</logic:notEqual>

						<td data-title="Fecha Valor" class="bienvenida">
							<bean:write name="row" property="fechaValor" formatKey="formato-fecha"/>
						</td>
						<td data-title="Moneda" class="bienvenida">
							<bean:write name="row" property="monedaString" />
						</td>
						<td data-title="Monto" class="bienvenida">
							<bean:write name="row" property="monto" format="######0.00"/>
						</td>
						<td data-title="SWIFT/ABA/OTROS" class="bienvenida">
							<bean:write name="row" property="codigoSwiftABA" />
						</td>
						<td data-title="Banco Beneficiario" class="bienvenida">
							<bean:write name="row" property="nonbrebancoBeneficiario" />
						</td>
						<td data-title="Beneficiario" class="bienvenida">
							<bean:write name="row" property="nombreBeneficiario" />
						</td>
						<td data-title="Cuenta Beneficiario" class="bienvenida">
							<bean:write name="row" property="cuentabancoBeneficiario" />
						</td>
						<logic:equal name="row" property="error" value="0">
							<td data-title="Detalle de Error" class="bienvenida"></td>
						</logic:equal>
						<logic:notEqual name="row" property="error" value="0">
							<td data-title="Detalle de Error" class="bienvenida">
								<bean:write name="row" property="error" />
							</td>	
						</logic:notEqual>
					</logic:iterate>
				</table>
			</div>

			<script>
			if (window.screen.width > 800)
			{
			if (document.getElementById){
			var obj = document.getElementById("record-view");
			obj.style.width=window.screen.width-35;
			}
			}
			</script>

		</logic:present>

		<logic:present name="error.formato.archivo">
			<div>
				<p>El formato del archivo no es valido para el sistema favor verificar su archivo</p>
			</div>
		</logic:present>

	</div>
</div>
</div>
<br><br>
<%@ include file="/footer.jsp"  %>
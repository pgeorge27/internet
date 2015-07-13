<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%
Object[] record = (Object[])session.getAttribute("arreglo.registro.dian");
if (record != null){
    if (record.length >= 1){
        session.setAttribute("registro.dian", record[0]);
    }
    if (record.length >= 2){
        session.setAttribute("registro.dian.secundario.1", record[1]);
    }
    if (record.length >= 3){
        session.setAttribute("registro.dian.secundario.2", record[2]);
    }
    if (record.length >= 4){
        session.setAttribute("registro.dian.secundario.3", record[3]);
    }
    if (record.length >= 5){
        session.setAttribute("registro.dian.secundario.4", record[4]);
    }
}
%>
<%@ include file="/head.jsp"  %>
<script language=javascript>
function __retornar(){
	document.location="<html:rewrite page='/dian/consultar/seleccion.do'/>";
}
function __edit(formulario){
	document.forms["formulario-dian"].indice.value = formulario;
	document.forms["formulario-dian"].submit();
}
var index = -1;
function __set(num){
	index = num;
}
function __editItem(){
	if (index == -1){
		alert("Debe seleccionar un registro");
	}
	else{
		__edit(index);
	}
}
function _submit(indice){

            openwin("<html:rewrite page='/dian/formulario4.jsp'/>?indice="+indice);

}

function openwin(url)

{

            nwin=window.open(url, "nwin",config="scrollbars=no,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no");

            nwin.focus();

}
</script>
<%@ include file="/body.jsp"%>
<html:form action="/dian/elaborar/editar">
	<html:hidden property="indice"/>
</html:form>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="center"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login">INFORME DE DATOS DE LA VENTA DE DIVISAS EN EFECTIVO Y CHEQUES DE VIAJERO - 1100</div></td>
                        <td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
                      </tr>
                    </table>
                  </div></td>
              </tr>
             
</table>         
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">               
              <tr> 
                <td valign="top">
                <logic:present name="registro.dian">
				
				<div id="record-view" style="overflow:auto;width:790;height:245">
                    <table cellpadding="1" style="overflow:scroll;width:100%">
                    <tr class="tabla-acceso">
	                   <td class="texto-acceso" align="center"><div class="texto-acceso" title="Estado">Estado</div></td>	                   
	                   <td class="texto-acceso" align="center"><div class="texto-acceso" title="Motivo del Rechazo">Motivo Rechazo</div></td>	                   
                       <td class="texto-acceso" align="center"><div class="texto-acceso"title="Tipo negociación">Tipo negociación</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Número factura">Número factura </div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Tipo de documento del declarante comprador">Tipo Doc. declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Número documento de identificación del declarante comprador"># Doc. identificación declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Dígito de Verificación">Dígito Verificación</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer apellido del declarante comprador">Primer apellido declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Segundo apellido del declarante comprador">Segundo apellido declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer nombre del declarante comprador">Primer nombre declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Otros nombres del declarante comprador">Otros nombres declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Dirección del Declarante comprador">Dirección Declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Código Departamento/Municipio del Declarante comprador">Código Departamento/Municipio Declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Teléfono del Declarante comprador">Teléfono Declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Ocupación o actividad económica del declarante comprador">Ocupación o actividad económica declarante comprador</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Tipo de documento del Beneficiario">Tipo de Doc. Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Número documento de identificación del Beneficiario">Número documento identificación Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Dígito de Verificación">Dígito Verificación</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer apellido del beneficiario">Primer apellido beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Segundo apellido del beneficiario">Segundo apellido beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer nombre del beneficiario">Primer nombre beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Otros nombres del beneficiario">Otros nombres beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Razón social del beneficiario">Razón social beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Dirección del Beneficiario">Dirección  Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Código Departamento/Municipio del Beneficiario">Código Departamento/Municipio Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Teléfono del Beneficiario">Teléfono Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Ocupación o actividad económica del beneficiario">Ocupación económica beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Código Moneda">Código Moneda</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Monto moneda negociada (unidades)">Monto moneda negociada(unidades)</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Tasa de venta">Tasa venta</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Valor en pesos">Valor pesos</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Promedio compra día anterior">Promedio compra día anterior</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Diferencia en tasa">Diferencia en tasa</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Base Liquidación">Base Liquidación</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Valor Iva">Valor Iva</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Rete. Iva">Rete. Iva</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Rete. Fte">Rete. Fte</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Rete. Ica">Rete. Ica</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Gravamen Movimientos Financieros">Gravamen Movimientos Financieros</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Valor Neto">Valor Neto</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Forma de pago">Forma  pago</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Código Banco">Código Banco</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Número de cheque">Número cheque</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Número Declaración de Cambio">Número Declaración Cambio</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Fecha declaración de cambio">Fecha declaración cambio</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Identificación única del registro">Identificación única registro</div></td>                     
                    </tr>
                    <logic:iterate name="registro.dian" id="row"
								   type="com.arango.internet.banking.dian.Formulario" 
								   indexId="resultNo" >
			     		<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
					     <td class="bienvenida">
						    <logic:equal name="row" property="estado" value="1">
						       Pendiente
						    </logic:equal>
						    <logic:equal name="row" property="estado" value="2">
						       Por aprobar
						    </logic:equal>
						    <logic:equal name="row" property="estado" value="3">
						       Aprobados
						    </logic:equal>
						    <logic:equal name="row" property="estado" value="4">
						       Rechazados
						    </logic:equal>
						    <logic:equal name="row" property="estado" value="5">
						       Generado el XML
						    </logic:equal>
					    </td>					    
					    <td class="bienvenida"><bean:write name="row" property="motivo"/>
					    <td class="bienvenida"><bean:write name="row" property="tipoNegociacion"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroFactura"/>
						 <td class="bienvenida"><bean:write name="row" property="tipoDocumentoCliente"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroIdentificacion"/>
						 <td class="bienvenida"><bean:write name="row" property="digitoVerificador"/>
						 <td class="bienvenida"><bean:write name="row" property="primerApellido"/>
						 <td class="bienvenida"><bean:write name="row" property="segundoApellido"/>
						 <td class="bienvenida"><bean:write name="row" property="nombre"/>
						 <td class="bienvenida"><bean:write name="row" property="otroNombre"/>
						 <td class="bienvenida"><bean:write name="row" property="direccion"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoMunicipio"/>
						 <td class="bienvenida"><bean:write name="row" property="telefonoComprador"/>
						 <td class="bienvenida"><bean:write name="row" property="ocupacionComprador"/>
						 <td class="bienvenida"><bean:write name="row" property="tipoDocumentoBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroIdentificacionBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="digitoVerificadorBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="primerApellidoBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="segundoApellidoBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="nombreBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="otroNombreBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="razonSocialBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="direccionBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoMunicipioBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="telefonoBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="ocupacionBeneficiario"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoMoneda"/>
						 <td class="bienvenida"><bean:write name="row" property="montoNegociado" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="tasaVenta" />
						 <td class="bienvenida"><bean:write name="row" property="valorPesos" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="promedioCompra" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="diferenciaTasa" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="baseLiquidacion" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="valorIVA" />
						 <td class="bienvenida"><bean:write name="row" property="reteIVA"/>
						 <td class="bienvenida"><bean:write name="row" property="reteFte"/>
						 <td class="bienvenida"><bean:write name="row" property="reteICA"/>
						 <td class="bienvenida"><bean:write name="row" property="gravamen"/>
						 <td class="bienvenida"><bean:write name="row" property="valorNeto" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="formaPago"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoBanco"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroCheque"/>
						 <td class="bienvenida"><a href="javascript:_submit(<%=resultNo%>)"><bean:write name="row" property="numeroDeclaracionCambio"/></a>
						 <td class="bienvenida"><bean:write name="row" property="fecha" formatKey="formato-fecha"/>
						 <td class="bienvenida"><bean:write name="row" property="identificacionUnicaRegistro"/>
						 
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
			<logic:notPresent name="registro.dian">
			<table width="80%" border="0" cellpadding="0" cellspacing="2">
			  <tr class="tabla-acceso">
				<TD class="texto-acceso" width="15%">
				<bean:message key="msg.sin.movimentos"/></td></tr></table>
			</logic:notPresent>
			</td></tr></table>
			<table width="80%" border="0" cellpadding="0" cellspacing="2">
	
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
		
			  
				<INPUT class="botton" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>
<%@ include file="/footer.jsp"  %>
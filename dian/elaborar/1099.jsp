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
	document.location="<html:rewrite page='/dian/elaborar/seleccion.do'/>";
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
function __aprobar(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizacionMultipleForm'].elements;
	  for(var i = 0; i < elements.length; i++)
	  {
	  	 	if (elements[i].name == "indice")
	  	 	{
			   if (elements[i].checked)
			   {
			  	flag = true;
				index = elements[i].value;
			  	count++;
			   }
			}
	  }

	if (count > 1){
		document.forms['autorizacionMultipleForm'].submit();  
	}		
	else{
		alert("Debe seleccionar un registro para enviar a aprobaci�n");
	}
}
function __create(){
	document.location="<html:rewrite page='/dian/elaborar/edit/1099.jsp'/>";
}
function __editItem(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizacionMultipleForm'].elements;
	  for(var i = 0; i < elements.length; i++)
	  {
	  	 	if (elements[i].name == "indice")
	  	 	{
			   if (elements[i].checked)
			   {
			  	flag = true;
				index = elements[i].value;
			  	count++;
			   }
			}
	  }

	if (count == 1){
		__edit(index);
	}
	else if (count == 0){
		alert("Debe seleccionar un registro");
	}
	else{
		alert("Debe seleccionar un s�lo registro");
	}	
}
function __checkAll(element)
{
	var elements = document.forms['autorizacionMultipleForm'].elements;
  	for(var i = 0; i < elements.length; i++)
 	{
  	 	if (elements[i].name == "indice")
  	 	   elements[i].checked = element.checked;
    }
}
function __submit(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizacionMultipleForm'].elements;
	  for(var i = 0; i < elements.length; i++)
	  {
	  	 	if (elements[i].name == "indice")
	  	 	{
			   if (elements[i].checked)
			   {
			  	flag = true;
				index = elements[i].value;
			  	count++;
			   }
			}
	  }

	if (count > 0){
		document.forms['autorizacionMultipleForm'].submit();  
	}		
	else{
		alert("Debe seleccionar al menos un registro para enviar a aprobaci�n");
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
                        <td><div align="left" class="login">Informe De Datos De La Compra De Divisas En Efectivo y Cheques de Viajero - 1099</div></td>
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
				<table cellpadding="1" width="40%" border="0">
                <tr>
					<td><input type="button" class="botton" name="btncreate" onclick="__create()" value="Crear"/></td>
                    <td><input type="button" class="botton" name="btnedit" onclick="__editItem()" value="<bean:message key='lbl.compensacion.parametro.editar' />"/></td>
                <td><input type="button" class="botton" name="btnedit" onclick="__submit()" value="Enviar a Aprobaci�n"/></td></tr>
                  </table>
                <table width="100%" border="0" cellpadding="1" cellspacing="2">
	<tr><td><input type="checkbox" name="_all" onclick="__checkAll(this);">&nbsp;<bean:message key="lbl.compensacion.autorizar.seleccionar.todos"/></td></tr>
</table>
				<div id="record-view" style="overflow:auto;width:790;height:265">
				<html:form action="/dian/enviar/aprobar" method="post">
                    <table cellpadding="1" style="overflow:scroll;width:100%">
                    <tr class="tabla-acceso">
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo negociaci�n">Tipo negociaci�n</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Estado">Estado</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="N�mero factura o doc. Equivalente"># factura Equivalente</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de documento del declarante vendedor">Tipo Doc. declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="N�mero documento de identificaci�n del declarante vendedor"># Doc. identificaci�n declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="D�gito de Verificaci�n">D�gito Verificaci�n</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer apellido del declarante vendedor">Primer apellido declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Segundo apellido del declarante vendedor">Segundo apellido declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer nombre del declarante vendedor">Primer nombre declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Otros nombres del declarante vendedor">Otros nombres declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Direcci�n del Declarante vendedor">Direcci�n Declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="C�digo Departamento/Municipio del Declarante vendedor">C�digo Departamento/Municipio Declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Tel�fono del Declarante vendedor">Tel�fono Declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Ocupaci�n o actividad econ�mica del declarante vendedor">Ocupaci�n o actividad econ�mica declarante vendedor</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de documento del Beneficiario">Tipo Doc. Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="N�mero documento de identificaci�n del Beneficiario"># Doc. identificaci�n  Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="D�gito de Verificaci�n">D�gito Verificaci�n</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer apellido del beneficiario">Primer apellido beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Segundo apellido del beneficiario">Segundo apellido beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer nombre del beneficiario">Primer nombre beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Otros nombres del beneficiario">Otros nombres beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Raz�n social del beneficiario">Raz�n social beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Direcci�n del Beneficiario">Direcci�n Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="C�digo Departamento/Municipio del Beneficiario">C�digo Departamento/Municipio Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Tel�fono del Beneficiario">Tel�fono Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Ocupaci�n o actividad econ�mica del Beneficiario">Ocupaci�n o actividad econ�mica  Beneficiario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="C�digo Moneda">C�digo Moneda</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Monto moneda negociada (unidades)">Monto moneda negociada(unidades)</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Tasa de compra">Tasa compra</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor en pesos">Valor pesos</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor Iva">Valor Iva</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Rete. Iva">Rete. Iva</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Rete. Fte">Rete. Fte</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Rete. Ica">Rete. Ica</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Gravamen Movimientos Financieros">Gravamen Movimientos Financieros</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor Neto">Valor Neto</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Forma de pago">Forma pago</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="C�digo Banco">C�digo Banco</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="N�mero de cheque">N�mero cheque</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="N�mero Declaraci�n de Cambio"># Declaraci�n Cambio</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha declaraci�n de cambio">F. declaraci�n cambio</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Identificaci�n �nica del registro">Identificaci�n �nica registro</div></td>
                       <td class="texto-acceso" width="5%"></td>
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
					     <logic:notEqual name="row" value="0" property="estado">
						   <input type="checkbox" name="indice" onclick="__set(<%=resultNo%>)" value="<%=resultNo%>"/><bean:write name="row" property="tipoNegociacion"/>
						   <td class="bienvenida" align="center"><div>Pendiente x Elaborar</div>
						   
						   </logic:notEqual>
						   <logic:equal name="row" value="0" property="estado">
						   <input type="checkbox" disabled="true" name="indice" onclick="__set(<%=resultNo%>)" value="<%=resultNo%>"/><bean:write name="row" property="tipoNegociacion"/>
						   <td class="bienvenida" align="center"><div>Ingresado</div>
						   </logic:equal>
				
							 <td class="bienvenida"><bean:write name="row" property="numeroFactura"/>
							 <td class="bienvenida"><bean:write name="row" property="tipoDocumentoVendedor"/>
							 <td class="bienvenida"><bean:write name="row" property="numeroIdentificacion"/>
							 <td class="bienvenida"><bean:write name="row" property="digitoVerificador"/>
							 <td class="bienvenida"><bean:write name="row" property="primerApellido"/>
							 <td class="bienvenida"><bean:write name="row" property="segundoApellido"/>
							 <td class="bienvenida"><bean:write name="row" property="nombre"/>
							 <td class="bienvenida"><bean:write name="row" property="otroNombre"/>
							 <td class="bienvenida"><bean:write name="row" property="direccion"/>
							 <td class="bienvenida"><bean:write name="row" property="codigoMunicipio"/>
							 <td class="bienvenida"><bean:write name="row" property="telefonoVendedor"/>
							 <td class="bienvenida"><bean:write name="row" property="ocupacionVendedor"/>
							 <td class="bienvenida"><bean:write name="row" property="tipoDocumentoBeneficiario"/>
							 <td class="bienvenida"><bean:write name="row" property="numeroIdentificacionBeneficiario"/>
							 <td class="bienvenida"><bean:write name="row" property="digitoVerificadorCliente"/>
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
							 <td class="bienvenida"><bean:write name="row" property="tasaCompra" format="######0.00"/>
							 <td class="bienvenida"><bean:write name="row" property="valorPesos" format="######0.00"/>
							 <td class="bienvenida"><bean:write name="row" property="valorIVA"/>
							 <td class="bienvenida"><bean:write name="row" property="reteIVA"/>
							 <td class="bienvenida"><bean:write name="row" property="reteFte"/>
							 <td class="bienvenida"><bean:write name="row" property="reteICA"/>
							 <td class="bienvenida"><bean:write name="row" property="gravamen"/>
							 <td class="bienvenida"><bean:write name="row" property="valorNeto" format="######0.00"/>
							 <td class="bienvenida"><bean:write name="row" property="formaPago"/>
							 <td class="bienvenida"><bean:write name="row" property="codigoBanco"/>
							 <td class="bienvenida"><bean:write name="row" property="numeroCheque"/>
							 <td class="bienvenida"><bean:write name="row" property="numeroDeclaracionCambio"/>
							 <td class="bienvenida"><bean:write name="row" property="fechaDeclaracionCambio" formatKey="formato-fecha"/>
							 <td class="bienvenida"><bean:write name="row" property="identificacionUnicaRegistro"/>
							<td class="bienvenida"><input type="button" class="botton" name="btnedit" onclick="__edit(<%=resultNo.intValue()%>)" value="<bean:message key='lbl.compensacion.parametro.editar' />"/>
                    </logic:iterate>
                    </table>
                    </html:form>
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
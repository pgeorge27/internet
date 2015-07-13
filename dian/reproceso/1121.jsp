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
	document.location="<html:rewrite page='/dian/reproceso/seleccion.do'/>";
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
	  var elements = document.forms['genForm'].elements;
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
		document.forms['genForm'].submit();  
	}		
	else{
		alert("Debe seleccionar un registro para enviar a aprobación");
	}
}
function __create(){
	document.location="<html:rewrite page='/dian/elaborar/edit/1121.jsp'/>";
}
function __editItem(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['genForm'].elements;
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
		alert("Debe seleccionar un sólo registro");
	}	
}
function __checkAll(element)
{
	var elements = document.forms['genForm'].elements;
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
	  var elements = document.forms['genForm'].elements;
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

	
		document.forms['genForm'].submit();  
	
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
                        <td><div align="left" class="login">Informe Datos Compra y Venta De Divisas En Efectivo y Cheques De Viajero Zona De Frontera - Montos inferiores a USD 500.00 - 1121</div></td>
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
				<table cellpadding="1" width="100%" border="0">
                <tr><td><input type="button" class="botton" name="btnedit" onclick="__submit()" value="Generar XML"/></td></tr>
                  </table>
                <table width="100%" border="0" cellpadding="1" cellspacing="2">
	
</table>
				<div id="record-view" style="overflow:auto;width:790;height:245">
				<html:form action="/dian/reproceso/xml" method="post">
                    <table cellpadding="1" style="overflow:scroll;width:100%">
                    <tr class="tabla-acceso">
                                                <td class="texto-acceso" align="center"><div class="texto-acceso" title="Código concepto de la operación">Código concepto de operación</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Tipo de documento del cliente del profesional">Tipo documento cliente del profesional</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Número documento de identificación del cliente del profesional"># Doc. identificación del cliente del profesional</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Dígito de Verificación del cliente del profesional">Dígito Verificación cliente del profesional</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer apellido del cliente del profesional">Primer apellido cliente del profesional</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Segundo apellido del cliente del profesional">Segundo apellido cliente del profesional</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer nombre del cliente del profesional">Primer nombre cliente del profesional</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Otros nombres del cliente del profesional">Otros nombres cliente del profesional</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Razón social del cliente del profesional">Razón social cliente del profesional</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Código Moneda negociada">Código Moneda negociada</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Monto moneda negociada">Monto moneda negociada</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Valor en pesos">Valor pesos</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Código clase de compra o venta">Código clase compra o venta</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Número del formulario">Número formulario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Fecha de la operación">Fecha de operación</div></td>
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
					     <td class="bienvenida"><bean:write name="row" property="codigoConceptoOperacion"/>
						 <td class="bienvenida"><bean:write name="row" property="tipoDocumentoCliente"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroIdentificacion"/>
						 <td class="bienvenida"><bean:write name="row" property="digitoVerificador"/>
						 <td class="bienvenida"><bean:write name="row" property="primerApellido"/>
						 <td class="bienvenida"><bean:write name="row" property="segundoApellido"/>
						 <td class="bienvenida"><bean:write name="row" property="nombre"/>
						 <td class="bienvenida"><bean:write name="row" property="otroNombre"/>
						 <td class="bienvenida"><bean:write name="row" property="razonSocial"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoMoneda"/>
						 <td class="bienvenida"><bean:write name="row" property="montoNegociado"/>
						 <td class="bienvenida"><bean:write name="row" property="valorPesos"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoClaseCompraVenta"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroFormulario"/>
						 <td class="bienvenida"><bean:write name="row" property="fecha" formatKey="formato-fecha"/>
						 <td class="bienvenida"><bean:write name="row" property="identificacionUnicaRegistro"/>
						
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
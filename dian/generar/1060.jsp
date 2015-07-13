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
var index = -1;
function __retornar(){
	document.location="<html:rewrite page='/dian/generar/seleccion.do'/>";
}
function __edit(formulario){
	document.forms["formulario-dian"].indice.value = formulario;
	document.forms["formulario-dian"].submit();
}
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
function __submitSecundario(obj)
{
	if(obj.value!="")
		document.forms['secundarioForm'].submit();
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
                        <td><div align="left" class="login">Declaración De Cambio Por Exportación De Bienes - Formulario NO 2 - 1060</div></td>
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
               
                <tr><td>&nbsp;</td></tr>
                <tr><td><input type="button" class="botton" name="btnedit" onclick="__submit()" value="Generar XML"/></td></tr>
                  </table>
                <table width="100%" border="0" cellpadding="1" cellspacing="2">
	
</table>
				<div id="record-view" style="overflow:auto;width:790;height:245">
				<html:form action="/dian/generar/xml" method="post">
                    <table cellpadding="1" style="overflow:scroll;width:100%">
                    <tr class="tabla-acceso">
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de informante"><bean:message key="formulario.1059.tipo.informante"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de operación"><bean:message key="formulario.1059.tipo.operacion"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Código cuenta compensación"><bean:message key="formulario.1059.codigo.comprensacion"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha declaración de cambio"><bean:message key="formulario.1059.fecha.declaracion.cambio"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número declaración cambio"><bean:message key="formulario.1059.numero.declaracion.cambio"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha declaración cambio anterior"><bean:message key="formulario.1059.fecha.declaracion.cambio.anterior"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número declaración cambio anterior"><bean:message key="formulario.1059.numero.declaracion.cambio.anterior"/></div></td>                      
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de identificación del exportador"><bean:message key="formulario.1060.tipo.identificacion.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número identificación exportador"><bean:message key="formulario.1060.numero.identificacion.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="DV Exportador"><bean:message key="formulario.1060.dv.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer apellido exportador"><bean:message key="formulario.1060.primer.apellido.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Segundo apellido exportador"><bean:message key="formulario.1060.segundo.apellido.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer nombre exportador"><bean:message key="formulario.1060.primer.nombre.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Otros nombres exportador" ><bean:message key="formulario.1060.otros.nombres.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Razón social exportador"><bean:message key="formulario.1060.razon.social.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Código moneda de reintegro"><bean:message key="formulario.1060.codigo.moneda.reintegro"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor moneda de reintegro"><bean:message key="formulario.1060.valor.moneda.reintegro"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de cambio a USD"><bean:message key="formulario.1060.tipo.cambio.usd"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Total valor FOB"><bean:message key="formulario.1060.total.valor.fob"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Total gastos exportación"><bean:message key="formulario.1060.total.gastos.exportacion"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Deducciones"><bean:message key="formulario.1060.deducciones"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Total reintegro neto"><bean:message key="formulario.1060.total.reintegro.neto"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Condiciones de pago"><bean:message key="formulario.1059.condiciones.pago"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Condiciones de despacho mercancía"><bean:message key="formulario.1059.condiciones.despacho.mercancia"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Observaciones"><bean:message key="formulario.1059.observaciones"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Identificación única del registro"><bean:message key="formulario.1059.identificacion.unica.registro"/></div></td>                                             
                      
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
					    <td class="bienvenida"><bean:write name="row" property="tipoInformante"/>
						
						<td class="bienvenida"><bean:write name="row" property="tipoOperacion"/>
						<td class="bienvenida"><bean:write name="row" property="codigoCuentaCompensacion"/>
						<td class="bienvenida"><bean:write name="row" property="fechaDeclaracionCambio" formatKey="formato-fecha"/>
						<td class="bienvenida"><a href="javascript:_submit(<%=resultNo%>)"><bean:write name="row" property="numeroDeclaracionCambio"/></a>
						<td class="bienvenida"><bean:write name="row" property="fechaDeclaracionCambioAnterior" formatKey="formato-fecha"/>
						<td class="bienvenida"><bean:write name="row" property="numeroDeclaracionCambioAnterior"/>
						<td class="bienvenida"><bean:write name="row" property="tipoIdentificacionImportador"/>
						<td class="bienvenida"><bean:write name="row" property="numeroIdentificacionImportador"/>
						<td class="bienvenida"><bean:write name="row" property="digitoVerificadorImportador"/>
						<td class="bienvenida"><bean:write name="row" property="primerApellido"/>
						<td class="bienvenida"><bean:write name="row" property="segundoApellido"/>
						<td class="bienvenida"><bean:write name="row" property="nombre"/>
						<td class="bienvenida"><bean:write name="row" property="otroNombre"/>
						<td class="bienvenida"><bean:write name="row" property="razonSocial"/>
						<td class="bienvenida"><bean:write name="row" property="codigoMoneda"/>
						<td class="bienvenida"><bean:write name="row" property="valorMonedaReintegro" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="tipoCambioUSD" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="totalFOB" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="totalGastosExportacion" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="deducciones" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="totalReintegro" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="condicionesPago"/>
						<td class="bienvenida"><bean:write name="row" property="condicionesDespachoMercancia"/>
						<td class="bienvenida"><bean:write name="row" property="observaciones"/>
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
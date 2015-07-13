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
	document.location="<html:rewrite page='/dian/exportar/seleccion.do'/>";
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

	 alert("Estimado cliente HELM BANK [PANAMA] no se hace responsable de los cambios que usted efectue al documento generado");
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
                        <td><div align="left" class="login">Declaración De Cambio por Servicios. Transferencias y Otros Conceptos - Formulario NO 5  - 1062</div></td>
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
				
                <tr><td>&nbsp;</td></tr>
                <tr><td><input type="button" class="botton" name="btnedit" onclick="__submit()" value="Exportar Excel"/></td></tr>
                  </table>
                <table width="100%" border="0" cellpadding="1" cellspacing="2">
	
</table>
				<div id="record-view" style="overflow:auto;width:790;height:245">
                <html:form action="/dian/exportar/excel" method="post">    
                    <table cellpadding="1" style="overflow:scroll;width:100%">
                    <tr class="tabla-acceso">
                        <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de Informante">Tipo Informante</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de operación">Tipo operación</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Código cuenta  compensación">Código cuenta compensación</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha  declaración de cambio">Fecha declaración cambio</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Número  declaración de cambio">Número declaración cambio</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha  declaración cambio anterior">Fecha declaración cambio anterior</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Número  declaración cambio anterior">Número declaración cambio anterior</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de  identificación">Tipo identificación</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Número  de identificación">Número identificación</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="DV">DV</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer  apellido de quien compra o vende divisas.">Primer apellido quien compra o vende</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Segundo  apellido de quien compra o vende divisas.">Segundo apellido quien compra o vende</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer  nombre de quien compra o vende divisas.">Primer nombre quien compra o vende</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Otros  nombres de quien compra o vende divisas.">Otros nombres quien compra o vende</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Razón  social de quien compra o vende divisas.">Razón social quien compra o vende</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Dirección">Dirección</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Cod  Ciudad - Colombia">Cod Ciudad -Colombia</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Nombre  ciudad del exterior">Nombre ciudad exterior</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Código  moneda giro o reintegro">Código moneda giro</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor moneda  giro o reintegro">Valor moneda  giro</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor total USD">Valor total USD</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Identificación única del registro">Identificación única registro</div></td>     
						
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
						 <td class="bienvenida"><bean:write name="row" property="numeroDeclaracionCambio"/>
						 <td class="bienvenida"><bean:write name="row" property="fechaDeclaracionCambioAnterior" formatKey="formato-fecha"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroDeclaracionCambioAnterior"/>
						 <td class="bienvenida"><bean:write name="row" property="tipoIdentificacionImportador"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroIdentificacionImportador"/>
						 <td class="bienvenida"><bean:write name="row" property="digitoVerificadorImportador"/>
						 <td class="bienvenida"><bean:write name="row" property="primerApellidoAcreedor"/>
						 <td class="bienvenida"><bean:write name="row" property="segundoApellidoComprador"/>
						 <td class="bienvenida"><bean:write name="row" property="nombreComprador"/>
						 <td class="bienvenida"><bean:write name="row" property="otroNombreComprador"/>
						 <td class="bienvenida"><bean:write name="row" property="razonSocial"/>
						 <td class="bienvenida"><bean:write name="row" property="direccion"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoCiudad"/>
						 <td class="bienvenida"><bean:write name="row" property="nombreCiudadExterior"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoMoneda"/>
						 <td class="bienvenida"><bean:write name="row" property="valorMonedaReintegro" format="#,###,#0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="valorUSD" format="#,###,#0.00"/>
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
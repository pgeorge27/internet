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
	document.location="<html:rewrite page='/dian/generar/seleccion.do'/>";
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
		alert("Debe seleccionar un registro para enviar a aprobaci�n");
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
		alert("Debe seleccionar un s�lo registro");
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
                        <td><div align="left" class="login">Endeudamiento Externo Otorgados a Residentes -  FORMULARIO NO 6   - 1063</div></td>
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
                        <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de operaci�n">Tipo operaci�n</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha">Fecha</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="N�mero pr�stamo">N�mero pr�stamo</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="N�mero declaraci�n">N�mero declaraci�n </div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Numeral">Numeral</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="C�digo moneda de negociaci�n">C�digo moneda negociaci�n</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Valor total en la moneda de negociaci�n">Valor total moneda negociaci�n </div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Valor USD">Valor USD</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Tipo de identificaci�n">Tipo identificaci�n</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="N�mero de identificaci�n prestatario o deudor">N�mero identificaci�n prestatario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="DV">DV</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer apellido del prestatario o deudor">Primer apellido prestatario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Segundo apellido del prestatario o deudor">Segundo apellido prestatario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer nombre del prestatario o deudor">Primer nombre prestatario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Otros nombres del prestatario o deudor">Otros nombres prestatario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Raz�n social del prestatario o deudor">Raz�n social prestatario</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="C�digo ciudad">C�digo ciudad</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Direcci�n">Direcci�n</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer apellido del prestamista o acreedor">Primer apellido prestamista</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Segundo apellido del prestamista o acreedor">Segundo apellido prestamista</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Primer nombre del prestamista o acreedor">Primer nombre prestamista</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Otros nombres del prestamista o acreedor">Otros nombres prestamista</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Raz�n social del prestamista o acreedor">Raz�n social prestamista</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="C�digo prop�sito pr�stamo">C�digo prop�sito pr�stamo</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="C�digo moneda">C�digo moneda</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Monto contratado">Monto contratado</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="N�mero de expedici�n dep�sito">N�mero expedici�n dep�sito</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Valor en d�lares o pesos colombianos del dep�sito">Valor d�lares o pesos colombianos dep�sito</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="C�digo para la sustituci�n o fraccionamiento  de cr�ditos">C�digo para sustituci�n cr�ditos</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="N�mero de identificaci�n cr�dito anterior">N�mero identificaci�n cr�dito anterior</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="C�digo moneda">C�digo moneda</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Valor a sustituir o fraccionar">Valor sustituir o fraccionar</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Identificaci�n �nica del registro">Identificaci�n �nica registro</div></td>                                        
						
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
					     <td class="bienvenida"><bean:write name="row" property="tipoOperacion"/>
						 <td class="bienvenida"><bean:write name="row" property="fecha" formatKey="formato-fecha"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroPrestamo"/>
						 <td class="bienvenida"><a href="javascript:_submit(<%=resultNo%>)"><bean:write name="row" property="numeroDeclaracion"/></a>
						 <td class="bienvenida"><bean:write name="row" property="numeral"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoMonedaNegociacion"/>
						 <td class="bienvenida"><bean:write name="row" property="valorTotal" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="valorUSD" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="tipoIdentificacion"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroIdentificacionPrestatario"/>
						 <td class="bienvenida"><bean:write name="row" property="digitoVerificador"/>
						 <td class="bienvenida"><bean:write name="row" property="primerApellidoPrestatario"/>
						 <td class="bienvenida"><bean:write name="row" property="segundoApellidoPrestatario"/>
						 <td class="bienvenida"><bean:write name="row" property="nombrePrestatario"/>
						 <td class="bienvenida"><bean:write name="row" property="otroNombrePrestatario"/>
						 <td class="bienvenida"><bean:write name="row" property="razonSocialPrestatario"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoCiudad"/>
						 <td class="bienvenida"><bean:write name="row" property="direccion"/>
						 <td class="bienvenida"><bean:write name="row" property="primerApellidoPrestamista"/>
						 <td class="bienvenida"><bean:write name="row" property="segundoApellidoPrestamista"/>
						 <td class="bienvenida"><bean:write name="row" property="nombrePrestamista"/>
						 <td class="bienvenida"><bean:write name="row" property="otroNombrePrestamista"/>
						 <td class="bienvenida"><bean:write name="row" property="razonSocialPrestamista"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoPropositoPrestamo"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoMoneda"/>
						 <td class="bienvenida"><bean:write name="row" property="montoContratado" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroExpedicionDeposito"/>
						 <td class="bienvenida"><bean:write name="row" property="valorDeposito" format="######0.00"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoSustitucionCreditos"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroIdentificacionCreditoAnterior"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoMonedaNegociacion"/>
						 <td class="bienvenida"><bean:write name="row" property="valorSustituir" format="######0.00"/>
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
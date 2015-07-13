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
	document.location="<html:rewrite page='/dian/consultar/seleccion.do'/>";
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
                        <td><div align="left" class="login">DECLARACI�N DE CAMBIO POR EXPORTACI�N DE BIENES - FORMULARIO NO 2 - 1060</div></td>
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
                
				<div id="record-view" >
                    <table cellpadding="1" style="overflow:scroll;width:100%">
                   <script>
                          function __submitSecundario(obj)
							{
								if(obj.value!="")
									document.forms['secundarioForm'].submit();
							}
                   </script>
                   <tr>
                   <td>
                     <html:form action="/dian/consultar/secundarios" method="post">
                     <html:hidden property="formulario" value="1060"/>
                      <html:select property="formulariosSecundario" onclick="__submitSecundario(this)" styleClass="lstbox">
                        <html:option value="">Seleccione un Secundario</html:option>
                      	<html:option value="1">1 - Informaci�n Declaraciones de exportaci�n definitivas</html:option>
                      	
                      </html:select>
                     
                      </html:form>
                   </td>                   
                </tr>
                <tr><td>&nbsp;</td></tr>
				  <table cellpadding="1" width="100%" border="0">   
                    <tr class="tabla-acceso">
	                   <td class="texto-acceso" align="center"><div class="texto-acceso" title="Estado">Estado</div></td>
	                   <td class="texto-acceso" align="center"><div class="texto-acceso" title="Motivo del Rechazo">Motivo Rechazo</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de informante"><bean:message key="formulario.1059.tipo.informante"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de operaci�n"><bean:message key="formulario.1059.tipo.operacion"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="C�digo cuenta compensaci�n"><bean:message key="formulario.1059.codigo.comprensacion"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha declaraci�n de cambio"><bean:message key="formulario.1059.fecha.declaracion.cambio"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="N�mero declaraci�n cambio"><bean:message key="formulario.1059.numero.declaracion.cambio"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha declaraci�n cambio anterior"><bean:message key="formulario.1059.fecha.declaracion.cambio.anterior"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="N�mero declaraci�n cambio anterior"><bean:message key="formulario.1059.numero.declaracion.cambio.anterior"/></div></td>                      
                       <!--td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de identificaci�n del exportador"><bean:message key="formulario.1060.tipo.identificacion.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="N�mero identificaci�n exportador"><bean:message key="formulario.1060.numero.identificacion.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="DV Exportador"><bean:message key="formulario.1060.dv.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer apellido exportador"><bean:message key="formulario.1060.primer.apellido.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Segundo apellido exportador"><bean:message key="formulario.1060.segundo.apellido.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Primer nombre exportador"><bean:message key="formulario.1060.primer.nombre.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Otros nombres exportador" ><bean:message key="formulario.1060.otros.nombres.exportador"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Raz�n social exportador"><bean:message key="formulario.1060.razon.social.exportador"/></div></td-->
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="C�digo moneda de reintegro"><bean:message key="formulario.1060.codigo.moneda.reintegro"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor moneda de reintegro"><bean:message key="formulario.1060.valor.moneda.reintegro"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de cambio a USD"><bean:message key="formulario.1060.tipo.cambio.usd"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Total valor FOB"><bean:message key="formulario.1060.total.valor.fob"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Total gastos exportaci�n"><bean:message key="formulario.1060.total.gastos.exportacion"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Deducciones"><bean:message key="formulario.1060.deducciones"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Total reintegro neto"><bean:message key="formulario.1060.total.reintegro.neto"/></div></td>
                       <!--td class="texto-acceso" align="center"><div class="texto-acceso" title="Condiciones de pago"><bean:message key="formulario.1059.condiciones.pago"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Condiciones de despacho mercanc�a"><bean:message key="formulario.1059.condiciones.despacho.mercancia"/></div></td-->
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Observaciones"><bean:message key="formulario.1059.observaciones"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Identificaci�n �nica del registro"><bean:message key="formulario.1059.identificacion.unica.registro"/></div></td>                                             
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
					    <td class="bienvenida"><bean:write name="row" property="tipoInformante"/>
						
						<td class="bienvenida"><bean:write name="row" property="tipoOperacion"/>
						<td class="bienvenida"><bean:write name="row" property="codigoCuentaCompensacion"/>
						<td class="bienvenida"><bean:write name="row" property="fechaDeclaracionCambio" formatKey="formato-fecha"/>
						<td class="bienvenida"><a href="javascript:_submit(<%=resultNo%>)"><bean:write name="row" property="numeroDeclaracionCambio"/></a>
						<td class="bienvenida"><bean:write name="row" property="fechaDeclaracionCambioAnterior" formatKey="formato-fecha"/>
						<td class="bienvenida"><bean:write name="row" property="numeroDeclaracionCambioAnterior"/>
					
						<td class="bienvenida"><bean:write name="row" property="codigoMoneda"/>
						<td class="bienvenida"><bean:write name="row" property="valorMonedaReintegro" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="tipoCambioUSD" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="totalFOB" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="totalGastosExportacion" format="######0.00"/>
						<td class="bienvenida"><bean:write name="row" property="deducciones"/>
						<td class="bienvenida"><bean:write name="row" property="totalReintegro" format="######0.00"/>
						
						<td class="bienvenida"><bean:write name="row" property="observaciones"/>
						<td class="bienvenida"><bean:write name="row" property="identificacionUnicaRegistro"/><td class="bienvenida">
                    </logic:iterate>
                    </table>
                    </div>
                    
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
<td colspan="2" valign="top" class="texto-acceso"><div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
                </td>
</tr>
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
		
			  
				<INPUT class="botton" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>					
<%@ include file="/footer.jsp"  %>
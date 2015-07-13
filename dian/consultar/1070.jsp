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
                        <td><div align="left" class="login">INFORME DE DATOS CUENTA CORRIENTE COMPENSACION - 1070</div></td>
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
                        <td class="texto-acceso" align="center"><div class="texto-acceso" title="Tipo de operaci�n">Tipo operaci�n </div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="C�digo cuenta compensaci�n">C�digo cuenta compensaci�n</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="N�mero de la cuenta corriente de compensaci�n"># cuenta corriente de compensaci�n</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Nombre del banco">Nombre banco</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="C�digo pa�s">C�digo pa�s</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Nombre ciudad">Nombre ciudad</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="C�digo moneda">C�digo moneda</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Fecha de cancelaci�n de la cuenta en la entidad bancaria del exterior">F. cancelaci�n de Cta. entidad bancaria del exterior</div></td>
						<td class="texto-acceso" align="center"><div class="texto-acceso"title="Fecha del reporte de cancelaci�n de la cuenta ante el Banco de la Rep�blica">F. reporte cancelaci�n Cta. ante Banco de la Rep�blica</div></td>
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
					    <td class="bienvenida"><bean:write name="row" property="tipoOperacion"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoCuentaCompensacion"/>
						 <td class="bienvenida"><bean:write name="row" property="numeroCuentaCorrienteCompensacion"/>
						 <td class="bienvenida"><bean:write name="row" property="nombreBanco"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoPais"/>
						 <td class="bienvenida"><bean:write name="row" property="nombreCiudad"/>
						 <td class="bienvenida"><bean:write name="row" property="codigoMoneda"/>
						 <td class="bienvenida"><bean:write name="row" property="fechaCancelacion" formatKey="formato-fecha"/>
						 <td class="bienvenida"><bean:write name="row" property="fechaReporteCancelacion" formatKey="formato-fecha"/>
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
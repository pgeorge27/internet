<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>

<%@ include file="/head.jsp"  %>
<script language=javascript>

function __retornar(){
	document.location="<html:rewrite page='/dian/consultar/1059.jsp'/>";
}
</script>
<%@ include file="/body.jsp"%>

<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="left"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login">Declaración De Cambio Por Importación De Bienes - Formulario NO 1 - 1059 <br> Información de los Documentos de Importación</div></td>
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
                <logic:present name="registro.dian.secundario.2">
                <table cellpadding="1" width="30%" border="0">
                <tr>
                
                </tr></table>
                
				<div id="record-view" >
				     <table cellpadding="1" width="100%" border="0">                    
                    <tr class="tabla-acceso">
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número de identificación del registro principal"># identificación del registro principal</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha declaración de cambio"><bean:message key="formulario.1059.fecha.declaracion.cambio"/></div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número declaración cambio"><bean:message key="formulario.1059.numero.declaracion.cambio"/></div></td>                       
                       <!-- td class="texto-acceso" align="center"><div class="texto-acceso" title="Año declaración importación">Año declaración importación</div></td--> 
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número declaración importación">Número declaración importación</div></td> 
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor USD declaración importación">Valor USD declaración importación</div></td> 
                       <!--td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha documento de transporte">Fecha documento de transporte</div></td> 
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número documento de transporte">Número documento de transporte</div></td--> 
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Identificación única del registro"><bean:message key="formulario.1059.identificacion.unica.registro"/></div></td>
                      
                    </tr>
                    <logic:iterate name="registro.dian.secundario.2" id="row"
								   type="com.arango.internet.banking.dian.Formulario" 
								   indexId="resultNo" >
			     		<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
					    <td class="bienvenida"><bean:write name="row" property="identificacionUnicaRegistroPrincipal"/></td>
						<td class="bienvenida"><bean:write name="row" property="fechaDeclaracionCambio" formatKey="formato-fecha"/>
						<td class="bienvenida"><bean:write name="row" property="numeroDeclaracionCambio"/>
																							
						<logic:notEqual name="row" property="numeroDeclaracionImportacion" value="0">
							<td class="bienvenida"><bean:write name="row" property="numeroDeclaracionImportacion"/></td>
						</logic:notEqual>	
						<logic:equal name="row" property="numeroDeclaracionImportacion" value="0">
							<td class="bienvenida">&nbsp;</td>
						</logic:equal>			
						
						<logic:notEqual name="row" property="valorUSDDeclaracionImportacion" value="0">
							<td class="bienvenida"><bean:write name="row" property="valorUSDDeclaracionImportacion" format="######0.00"/></td>
						</logic:notEqual>	
						<logic:equal name="row" property="valorUSDDeclaracionImportacion" value="0">
							<td class="bienvenida">&nbsp;</td>
						</logic:equal>	
						<!--td class="bienvenida"><bean:write name="row" property="fechaDocumentoTransporte" formatKey="formato-fecha"/></td>
						<td class="bienvenida"><bean:write name="row" property="numeroDocumentoTransporte"/></td-->
						<td class="bienvenida"><bean:write name="row" property="identificacionUnicaRegistro"/>				    
						
                    </logic:iterate>
                    </table>
                    </div>
                   
			</logic:present>
			<logic:notPresent name="registro.dian.secundario.2">
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
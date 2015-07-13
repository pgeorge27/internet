<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%@ page import="com.arango.internet.banking.Vencimiento" %>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>
<%
String tipoVencimiento = session.getAttribute("tipo.vencimiento").toString();
ArrayList arreglo = (ArrayList)session.getAttribute("vencimiento");
Vencimiento v = new Vencimiento();    
int[] dias = (int[])session.getAttribute("cant.dias.vencimientos");
%>
<%@ include file="/head.jsp"  %>

<script language=javascript>
function __retornar(){
	document.location="<html:rewrite page='/vencimiento/seleccion.do'/>";
}
function openwin(url)
{
            nwin=window.open(url, "nwin",config="scrollbars=no,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no");
            nwin.focus();
}
</script>
<%@ include file="/body.jsp"%>

<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="left"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login">Vencimiento de Importación y Exportación</div></td>
                        <td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
                      </tr>
                    </table>
                  </div></td>
              </tr>
            
		</table>         
			<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">     
          
              <logic:equal name="tipo.vencimiento" value="1">
              <tr> 
                <td valign="top">               

                 
				
				
				<table width="100%" border="0" cellpadding="1" cellspacing="2" align="center">
					<tr>
						<td colspan="6">
							<div align="center" class="texto-acceso">INFORMACIÓN DE IMPORTACIÓN</div>
						</td>				
					</tr>
	                 <tr class="tabla-acceso">
                        <td class="texto-acceso" width="20%" align="center">Documento Transporte No.</td>
                        <td class="texto-acceso" width="20%" align="center">Fecha Transporte</td>
                        <td class="texto-acceso" width="20%" align="center">Importación No.</td>
                        <td class="texto-acceso" width="20%" align="center">Valor USD</td>
                        <td class="texto-acceso" width="20%" align="center">Proveedor</td>
                        <td class="texto-acceso" width="20%" align="center">Vencimiento (<%=dias!=null?""+dias[0]:"" %> días)</td>
                        
					 </tr>					 
                     <logic:present name="vencimiento">
                     <logic:iterate name="vencimiento" id="row"
                     type="com.arango.internet.banking.Vencimiento" indexId="resultNo">
                     <bean:define id="remainder0" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder0" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder0" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
                        <td class="bienvenida" align="center"><bean:write name="row" property="docTransporte" /></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="fecha" format="dd/MM/yyyy" /></td>
                        <td class="bienvenida" align="center">&nbsp;<bean:write name="row" property="numImportacion" /></td>
						<td class="bienvenida" align="center"><bean:write name="row" property="valor" format="##,###,###,##0.00"/></td>
                        <td class="bienvenida" align="left"><bean:write name="row" property="proveedor" /></td>						
                        <td class="bienvenida" align="center"><bean:write name="row" property="fechaVencimiento" format="dd/MM/yyyy" /></td>
                    </tr>
					    
                     </logic:iterate>
                     </logic:present>
				</table>
			  </td>
			</tr>
			</logic:equal>	
			<% if("2".equals(tipoVencimiento)){%>
			<tr> 
                <td valign="top">               									
				<table width="100%" border="0" cellpadding="1" cellspacing="2" align="center">
					<tr>
						<td colspan="5">
							<div align="center" class="texto-acceso">INFORMACIÓN DE EXPORTACIÓN ORDINARIA</div>
						</td>				
					</tr>
	                 <tr class="tabla-acceso">
                        <td class="texto-acceso" width="20%" align="center">Número Dex Definitivo</td>
                        <td class="texto-acceso" width="20%" align="center">Fecha Dex Definitivo</td>
                        <td class="texto-acceso" width="20%" align="center">Exportación No.</td>                       
                        <td class="texto-acceso" width="20%" align="center">Valor USD</td>  
                         <td class="texto-acceso" width="20%" align="center">Comprador</td>
                        <td class="texto-acceso" width="20%" align="center">Vencimiento (<%=dias[1] %> días)</td>                                                                      
                     </tr>
                     <logic:present name="vencimiento">
                     <logic:iterate name="vencimiento" id="row"
                     type="com.arango.internet.banking.Vencimiento" indexId="resultNo">
                     <bean:define id="remainder1" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder1" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder1" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
                        <td class="bienvenida" align="center"><bean:write name="row" property="numDex"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="fechaDex" format="dd/MM/yyyy"/></td>
                        <td class="bienvenida" align="center">&nbsp;<bean:write name="row" property="numExportacion"/></td>						
                        <td class="bienvenida" align="right"><bean:write name="row" property="valor" format="##,###,###,##0.00"/></td>
                        <td class="bienvenida" align="left"><bean:write name="row" property="comprador"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="fechaVencimiento" format="dd/MM/yyyy"/></td>
                        
                    </tr>
                     </logic:iterate>                   
                     </logic:present>
				</table>
				</td>
			   </tr>
			<% } else if("3".equals(tipoVencimiento)){ %>
			<tr> 
                <td valign="top">               					
				<table width="100%" border="0" cellpadding="1" cellspacing="2" align="center">
					<tr>
						<td colspan="6">
						<div align="center" class="texto-acceso">INFORMACIÓN DE EXPORTACIÓN DE ANTICIPOS</div>
						</td>				
					</tr>
	                 <tr class="tabla-acceso">
                        <td class="texto-acceso" width="20%" align="center">Consecutivo de Declaración</td>
                        <td class="texto-acceso" width="20%" align="center">Fecha Reintegro</td>
                        <td class="texto-acceso" width="20%" align="center">Valor USD</td>
                        <td class="texto-acceso" width="20%" align="center">Comprador</td>
                        <td class="texto-acceso" width="20%" align="center">Vencimiento (<%=dias[2] %> días)</td>                                            
                     </tr>
                     <logic:present name="vencimiento">
                     <logic:iterate name="vencimiento" id="row"
                     type="com.arango.internet.banking.Vencimiento" indexId="resultNo">
                     <bean:define id="remainder2" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder2" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder2" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
                        <td class="bienvenida" align="center"><bean:write name="row" property="numeroDeclaracion" /></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="fechaReintegro" format="dd/MM/yyyy"/></td>
						<td class="bienvenida" align="center"><bean:write name="row" property="valor" format="##,###,###,##0.00"/></td>
                        <td class="bienvenida" align="left"><bean:write name="row" property="comprador" /></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="fechaVencimiento" format="dd/MM/yyyy" /></td>
                    </tr>
                     </logic:iterate>                  
                     </logic:present>                     
				</table>								
				<% } %>
</td>
</tr>
</table>
					
<table width="80%" border="0" cellpadding="0" cellspacing="2">	
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
		
				<INPUT class="botton" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>			
<%@ include file="/footer.jsp"  %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>

<%@ include file="..//head.jsp"  %>


<%
 
 String tranferCounter =  (String)session.getAttribute("multipagos.transferencias.counters.total");
 String tranferInValid =  (String)session.getAttribute("multipagos.transferencias.counters.invalid");
 String tranferValid =    (String)session.getAttribute("multipagos.transferencias.counters.valid");
 
if (tranferCounter == null) {tranferCounter = "";}
if (tranferInValid == null) {tranferInValid = "";}
if (tranferValid == null) {tranferValid = "";}
	
%>

<style type="text/css">
.novalid {background #ffA500;}
.nueva {
		background-color: #F6C683; 
		color: white;
	}
</style> 
<script language=javascript>

function __retornar(){
	document.location="<html:rewrite page='/multipagos/CargaArchivo.jsp'/>";
}function send(){
	document.forms['cargaArchivo'].submit();
}


</script>
<script language="javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script language="javascript" src="<html:rewrite page='/scripts/objetoFecha.js'/>"></script>

<%@ include file="/body.jsp"%>
				
					
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="left"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login"> Validacion de Archivo <br> </div></td>
							<td width="8%"><div align="right">&nbsp;
								<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
							</td>
                        </tr>
                    </table>
                  </div>
				  </td>
			  </tr> 
			    <tr>
					<td>
						<div align="left">&nbsp;<a class="mnu"> Transferencias Por Archivo  : <%=tranferCounter%></a>	</div>
				
						<div align="left">&nbsp; <a class="mnu"> Transferencias Válidas en el Archivo  : <%=tranferValid%></a>	</div>

						<div align="left">&nbsp; <a class="mnu"> Transferencias no Válidas en el Archivo   : <%=tranferInValid%>	</a></div>
					</td>
			   </tr> 
</table>  
     
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">     
              <tr> 
                <td valign="top">
                <logic:present name="multipagos.transferencias.detalles">
                <table cellpadding="1" width="30%" border="0">
                <tr>
                </tr></table>
                
				<div id="record-view" style="overflow:auto;width:780;height:265">
				    <table cellpadding="1" width="100%" border="0">                    
                    <tr class="tabla-acceso">
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Nuemero de Cuenta">Nuemero de Cuenta</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha Valor">Fecha Valor</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Moneda">Moneda</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Monto">Monto</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="SWIFT/ABA/OTROS">SWIFT/ABA/OTROS</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Banco Beneficiario">Banco Beneficiario</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Beneficiario">Beneficiario</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Cuenta Beneficiario">Cuenta Beneficiario</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Cuenta Beneficiario">Detalle de Error</div></td>
                    </tr>
                    <logic:iterate name="multipagos.transferencias.detalles" id="row"
								   type="com.arango.internet.beans.TranferenciaProcesada" 
								   indexId="resultNo" >
			     	    <logic:equal name="row" property="error" value="0">
						        <tr  class="novalid"> 
						</logic:equal>
					    <logic:notEqual name="row" property="error" value="0">
						       <tr class="nueva"> 
						</logic:notEqual>
							
					   <logic:equal name="row" property="numeroCuenta" value="1000000001">
						       <td class="bienvenida">numeroCuenta no Valida</td>
						</logic:equal>
					 <logic:notEqual name="row" property="numeroCuenta" value="1000000001">
						       <td class="bienvenida"><bean:write name="row" property="numeroCuenta"/></td>
						</logic:notEqual>
					 
						<td class="bienvenida"><bean:write name="row" property="fechaValor" formatKey="formato-fecha"/>	</td>
	                    <td class="bienvenida"><bean:write name="row" property="monedaString" /></td>
	                    <td class="bienvenida"><bean:write name="row" property="monto" format="######0.00"/></td>
	                    <td class="bienvenida"><bean:write name="row" property="codigoSwiftABA" />	</td>
	                    <td class="bienvenida"><bean:write name="row" property="nonbrebancoBeneficiario" />	</td>
	                    <td class="bienvenida"><bean:write name="row" property="nombreBeneficiario" />		</td>
	                    <td class="bienvenida"><bean:write name="row" property="cuentabancoBeneficiario" />		</td>	    
						<logic:equal name="row" property="error" value="0">
						      <td class="bienvenida"></td>
						</logic:equal>
						 <logic:notEqual name="row" property="error" value="0">
						     <td class="bienvenida"><bean:write name="row" property="error" />		</td>	
						</logic:notEqual>
						    
					
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
			<logic:present name="error.formato.archivo">
			<table width="80%" border="0" cellpadding="0" cellspacing="2">
			  <tr class="tabla-acceso">
				<TD class="texto-acceso" width="15%">
				El formato del archivo no es valido para el sistema favor verificar su archivo</td></tr></table>
			</logic:present>
			</td></tr>
			<logic:notPresent name="error.formato.archivo">
			<tr><td>
			<div align="center">
			<html:form method="post" action="/multipagos/cargaArchivo" method="post" >
			<input name="botonEnviar" onclick="send();" type="button" class="botton" value="Cargar">
		 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
		 <INPUT class="botton" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>"></div>
			 </html:form></td></tr>
			</logic:notPresent>
			</table>
		
<%@ include file="/footer.jsp"  %>
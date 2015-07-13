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
	document.location="<html:rewrite page='/dian/aprobar/1066.jsp'/>";
}
</script>
<%@ include file="/body.jsp"%>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="left"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login">Informe De Aclaraciones De Datos Para Fines Estadisticos - Declaraciones De Cambio 1, 2, 3 y 5 - 1066 <br> Datos - Declaración cambio 5</div></td>
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
                <logic:present name="registro.dian.secundario.4">
                <table cellpadding="1" width="30%" border="0">
                <tr>
                </tr></table>
               
				<div id="record-view" style="overflow:auto;width:790;height:265">
				    <table cellpadding="1" width="100%" border="0">                    
                    <tr class="tabla-acceso">
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número de identificación del registro principal"># identificación del registro principal</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número declaración cambio aclarada">Número declaración cambio aclarada</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Numeral">Numeral</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor USD">Valor USD</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Identificación única del registro"><bean:message key="formulario.1059.identificacion.unica.registro"/></div></td>
                      
                    </tr>
                    <logic:iterate name="registro.dian.secundario.4" id="row"
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
	                    <td class="bienvenida"><bean:write name="row" property="numeroDeclaracionCambioAclarada"/>	
	                    <td class="bienvenida"><bean:write name="row" property="numeral"/>
	                    <td class="bienvenida"><bean:write name="row" property="valorUSD" format="######0.00"/>
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
			<logic:notPresent name="registro.dian.secundario.4">
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
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Locale"%>
<%@ page import="com.arango.internet.banking.CuentaCorriente"%>
<%@ page import="java.util.Date"%>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>
<%
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
CuentaCorriente cta = (CuentaCorriente) session.getAttribute("resumen.registro.dian.cta");
if (cta == null){
    response.sendRedirect(request.getContextPath()+ "/dian/mo/seleccion.do");
}
String strFechaDesde = "";
String strFechaHasta = "";
String estado = (String)session.getAttribute("estado") ;
Date desde = (Date)session.getAttribute("fecha.desde");
Date hasta = (Date)session.getAttribute("fecha.hasta");
if (desde != null){
    strFechaDesde = df.format(desde);
}
if (hasta != null){
    strFechaHasta = df.format(hasta);
}
%>
<%@ include file="/head.jsp"  %>
<script language=javascript>
function __retornar(){
	document.location="<html:rewrite page='/dian/modificar/seleccion.do'/>";
}
</script>

<%@ include file="/body.jsp"%>
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="center"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                         <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
                        <td><div align="left" class="login">Resumen</div></td>
                        <td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
                      </tr>
                    </table>
                  </div></td>
              </tr>
              <tr> 
                   <td height="5" class="texto-acceso">&nbsp;</td>
              </tr>
              <tr >
              <td width="100%" align="center">
              <%@ include file="../../divHeader.jsp"%>
              <table width="500px">
              <tr> 
                <td height="40" class="texto-acceso">
					<table width="80%" border="0" cellpadding="2" cellspacing="2" align="center">
					<tr> 
						<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.cc.numero.cuenta"/></div></td>
						<td></td>
						<td align="right"><span class="bienvenida"><%=f.formatCuenta(cta.getNumeroCuenta())%></span></td>
					  </tr>
					  <tr> 
						<td height="15" class="celda-clave1"><div align="right" class="texto-acceso">Saldo Inicial</div></td>
						<td></td>                
						<td class="bienvenida" align="right"><%=f.formatMonto(cta.getSaldoDisponible())%></td>
					  </tr>
					 
					  <tr> 
						<td height="15" class="celda-clave1"><div align="right" class="texto-acceso">Saldo Final</div></td>
						<td></td>
						<td class="bienvenida" align="right"><%=f.formatMonto(cta.getSaldoTotal())%></td>
					  </tr>   
					</table></td>
              </tr>
              
              <tr> 
                <td valign="top">
                <%double totalSuma = 0.0;
                int totalCant = 0;%>
                <logic:present name="resumen.registro.dian">
                    <table width="80%" align="center">
                    <tr class="tabla-acceso">
                       <td class="texto-acceso" align="center" width="60%"><div class="texto-acceso">Informe</div></td>
                       <td class="texto-acceso" align="center" width="2%"><div class="texto-acceso">Cantidad de Movimientos</div></td>
                       <td class="texto-acceso" align="center" width="20%"><div class="texto-acceso">Monto</div></td>
                    </tr>
                    <logic:iterate name="resumen.registro.dian" id="row"
								   type="com.arango.internet.banking.dian.Resumen" 
								   indexId="resultNo" >
			     		<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual> 
					    <%totalCant+=row.getCantidad(); 
					    totalSuma+=row.getSuma(); %>
					    <td align="center" class="bienvenida">
					    <%  if("6".equals(estado)&& "1059".equals(row.getPropio()) || "1060".equals(row.getPropio()) || "1061".equals(row.getPropio())
					    		|| "1062".equals(row.getPropio()) || "1063".equals(row.getPropio())) { %>
					                 <a href="javascript:__detail(<bean:write name='row' property='propio'/>)"><bean:write name="row" property="descripcion"/></a>
									 <td align="right" class="bienvenida"><bean:write name="row" property="cantidad"/></td>
                       <td  align="right" class="bienvenida"><a href="javascript:__activity()"><bean:write name="row" property="suma" format="##,###,###,##0.00"/></a></td>
					         <%}else  if ("1059".equals(row.getPropio()) || "1060".equals(row.getPropio()) || "1061".equals(row.getPropio())
					    		|| "1062".equals(row.getPropio()) || "1063".equals(row.getPropio())){ %>
					         <a href="javascript:__detail(<bean:write name='row' property='propio'/>)"><bean:write name="row" property="descripcion"/></a>
							 <td align="right" class="bienvenida"><bean:write name="row" property="cantidad"/></td>
                       <td  align="right" class="bienvenida"><a href="javascript:__activity()"><bean:write name="row" property="suma" format="##,###,###,##0.00"/></a></td>
					         <%} %></td>
                                             
                    </tr>
                    </logic:iterate>
                    
                    <tr>
                    	<td  class="bienvenida" align="right"><b>Total</b></td>
                    	<td  class="bienvenida" align="right"><b><%=totalCant %></b></td>
                    	<td  class="bienvenida" align="right"><b><%=com.arango.common.util.Format.getFormat().formatMonto(totalSuma) %></b></td>
                    </tr>
                    <tr>
                         <td><div>&nbsp;</div></td>
                    </tr>
                    </table>
                    <table width="80%" align="center">
                    <tr class="tabla-acceso" width="80%"><td class="bienvenida"><div class="texto-acceso">Formularios Informativos</div></td></tr>
                    
		                  <logic:iterate name="resumen.registro.dian" id="r"
								   type="com.arango.internet.banking.dian.Resumen" 
								   indexId="resulNo" >
			     		<bean:define id="remainder1" value="<%=Integer.toString(resulNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder1" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder1" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>    
                       <%if ("1099".equals(r.getPropio()) || "1100".equals(r.getPropio()) ||"1121".equals(r.getPropio())
                    		   || "1064".equals(r.getPropio()) || "1066".equals(r.getPropio()) ||"1070".equals(r.getPropio())
                    		   ||"1067".equals(r.getPropio())) { %>
                                                              
                       <td align="center" class="bienvenida"><a href="javascript:__detail(<bean:write name='r' property='propio'/>)"><bean:write name="r" property="descripcion"/></a></td>
                       <td align="right" class="bienvenida"><bean:write name="r" property="cantidad"/></td>
                       <td  align="right" class="bienvenida"><bean:write name="r" property="suma" format="##,###,###,##0.00"/></td>                      
                    </tr>
                      <% } %>
                        </logic:iterate>
                     <tr>
                         <td><div>&nbsp;</div></td>
                    </tr>
                    </table>
                    <script>
                    	function __detail(formulario){
	                    	document.forms["movimientoForm"].formulario.value = formulario;
                    		document.forms["movimientoForm"].submit();
                    	}
                    	function __activity(){
                    		document.forms["consulta"].submit();
                    	}
                    </script>
                    <form name="consulta" method="post" action="<html:rewrite page='/do.consulta'/>">
	                    <input type="hidden" name="tipo" value="MOV_EXT">
	                    <input type="hidden" name="prod" value="CC">
	                    <input type="hidden" name="mesesAtras" value="1">
	                    <input type="hidden" name="tipoMov" value="3">
						<input type="hidden" name="desde" value="<%=strFechaDesde%>">
						<input type="hidden" name="hasta" value="<%=strFechaHasta%>">
	                    <input type="hidden" name="backPage" value="<html:rewrite page='/dian/elaborar/Resumen.jsp'/>" >
	                    <input type="hidden" name="cuentas" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
                    </form>
                    <html:form method="post" action="/dian/modificar"> 
						<html:hidden property="estado" value="<%=estado%>"/>
						<html:hidden property="tipo" value="3"/>
						<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
						<html:hidden property="formulario"/>
						<html:hidden property="desde" value="<%=strFechaDesde%>"/>
						<html:hidden property="hasta" value="<%=strFechaHasta%>"/>
					</html:form>
                    </logic:present>
                    <logic:notPresent name="resumen.registro.dian">
					<table width="80%" border="0" cellpadding="0" cellspacing="2">
					  <tr class="tabla-acceso">
						<TD class="texto-acceso" width="15%">
						<bean:message key="msg.sin.movimentos"/></td></tr></table>
					</logic:notPresent>
										</tr>
                   </table>
                  <%@ include file="../../divFooter.jsp"%>
		              </tr>
              
            </table>
<table width="100%" border="0" cellpadding="0" cellspacing="2">
	
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
		
			  
				<INPUT class="botton" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>	
<%@ include file="/footer.jsp"  %>
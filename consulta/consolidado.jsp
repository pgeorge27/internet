<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="com.arango.common.banking.Productos"%>
<%@ page import="java.util.Hashtable"%>
<%@page import="com.arango.common.util.Format"%>
<%! Format f = Format.getFormat();%>
<%@ include file="../head.jsp"  %>

<script language="javascript">
function consulta(cta, tipo, producto){
	if (tipo == 'CON_SO'){
		document.frmConsulta.tipo.value="CON_SO";
		document.frmConsulta.producto.value=producto
	}
	
	document.frmConsulta.cuentas.value=cta;
	document.frmConsulta.submit();
}
</script>

<%@ include file="../body.jsp"  %>

            
<%
String nroCliente = null;
String selected = "";
if ( request.getParameter("clte") != null)
{
   nroCliente = request.getParameter("clte");    
}
else{
   nroCliente = (String)session.getAttribute("cliente.activo.consolidado");
}  
boolean showLista = cltes != null && cltes.size() > 1;
Hashtable tarjetas = new Hashtable();
String styleClass="";
%>
<form action="<html:rewrite page='/do.consulta'/>" method="post" name="frmConsulta">
	<input type="hidden" name="tipo" value="CON"/>
	<input type="hidden" name="cuentas"/>
	<input type="hidden" name="moneda"/>
	<input type="hidden" name="producto"/>
	<input type="hidden" name="backPage" value="<html:rewrite page='/consulta/consolidado.jsp'/>"/>
</form>


<table width="80%" border="0" cellpadding="0" cellspacing="0" >
            <tr><td>
  <form action="<html:rewrite page='/consolidado.view'/>" name="forma" onsubmit="return (document.clte.value != '-1')">
	 
            <table class="mainTable" width="100%" border="0" cellpadding="1" cellspacing="1" >
            <tr><td colspan="2" class="login">
			<div align="center"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			  <tr> 
				<td width="92%"><div align="left" class="login">Posición Consolidada</div></td>
				<td width="8%"><div align="right">&nbsp;</div></td>
			  </tr>
			</table>
		  </div></td>
		     <tr> <td nowrap class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cc.cliente"/></div><td class="bienvenida">
		     <%if (showLista){%>
					<select name="clte" onchange="document.forma.submit();" class="botton-acceso">
			  		<option value="-1"><bean:message key="lbl.cc.cliente"/></option>
					  <csic:forEachCliente>        
					       <%if ( codigo.equals(nroCliente))
					        {
					                selected = " SELECTED";                
					        }
					        else{
					                selected = "";
					        }%>
				        <option value="<%=codigo%>"<%=selected%>><%=nombre%>&nbsp;<%=apellido%></option>
					  </csic:forEachCliente>  
				  </select> 
					<%}
					else{
						if (cltes != null && cltes.size()> 0)
							{
							out.println(((com.arango.common.beans.Cliente)cltes.get(0)).getNombreCompleto());
							
							}
					}
					%>
					
		    	  
				</td>
	      </tr>
       </table>
  </form>
  	<tr><td>
	<csic:consolidado mostrarNoRegistradas="false" formatCuenta="A-S-C">
       		<table width="100%" border="0" cellpadding="1" cellspacing="1" >
                <tr >
                   <td><table width="100%" cellspacing="1" cellpadding="1" border="0">
                          <%if (!"0".equals(cons_cant_cc)){%>
                            <tr class="tabla-acceso"><td class="texto-acceso"><bean:message key="lbl.cuenta.corriente"/></td></tr>
                             <tr><td colspan="4">
                                 <div id="acct0" style="display:">
                                    <table class="level3" width="100%" cellspacing="1" cellpadding="1" border="0">
                                      <tr>
                                          <td class="texto-acceso" width="10%"><bean:message key="lbl.est.cta.cuenta"/></td> 
                                          <td class="texto-acceso" width="5%"><bean:message key="lbl.moneda"/></td> 
	                                      <td class="texto-acceso" align="right" width="15%"><bean:message key="lbl.saldo.total"/></td>
	                                      <td class="texto-acceso" align="right" width="15%"><bean:message key="lbl.saldo.disponible"/></td>
                                      </tr>
	                                  <csic:cuentas-consolidado producto="<%=Productos.CUENTA_CORRIENTE%>">         
	                                    <tr <%="0".equals(cons_class_item)?"":"class=\"celda-clave1\""%>>
	                                        <td class="bienvenida"><%=cons_cuenta%> <%=cons_nickname==null?"":cons_nickname %></td>                                      
	                                        <td class="bienvenida"><%=cons_moneda%></td> 
	                                        <td class="bienvenida" align="right"><%=cons_sado_total%></td>
										    <td class="bienvenida" align="right"><%=cons_saldo_disponible%></td>
	                                    </tr>
	                                  </csic:cuentas-consolidado>        
                                   </table>
                                 </div><br>   
                                </td>
                             </tr></td></tr> 
                      <%}%> 
                      
                    <%if (!"0".equals(cons_cant_dp)){%>
                    <tr class="tabla-acceso"><td class="texto-acceso"><bean:message key="lbl.deposito.plazo"/></td></tr>
                    <tr><td colspan="4">
                        <div id="acct2" style="display:">
                          <table class="level3" width="100%" cellspacing="1" cellpadding="1" border="0">
                            <tr>
                                <td class="texto-acceso" width="10%"><bean:message key="lbl.est.cta.cuenta"/></td>
                                <td class="texto-acceso" width="5%"><bean:message key="lbl.moneda"/></td> 
                                <td class="texto-acceso" align="right" width="15%"><bean:message key="lbl.capital"/></td>
                                <td class="texto-acceso" align="right" width="15%"><bean:message key="lbl.saldo.disponible"/></td>
                            </tr>
                            <csic:cuentas-consolidado producto="<%=Productos.PLAZO_FIJO%>">         
                                <tr <%="0".equals(cons_class_item)?"":"class=\"celda-clave1\""%>>
                                    <td class="bienvenida"><a class="link" onmouseover="window.status='<%=f.formatCuenta(cons_cuenta_banco, "A-S-C") %>';return true;" onmouseout="window.status='';return true;" href="javascript:consulta('<%=cons_cuenta_banco%>~<%=nroCliente %>' , 'CON_SO', 'DP');" title="Consulta de Saldo"><%=f.formatCuenta(cons_cuenta_banco, "A-S-C") %></a>
                                    <%=cons_nickname==null?"":cons_nickname %></td>
                                    <td class="bienvenida"><%=cons_moneda%></td>
                                    <td class="bienvenida" align="right"><%=cons_sado_total%></td>
                                    <td class="bienvenida" align="right"><%=cons_saldo_disponible%></td>
                                </tr>
                            </csic:cuentas-consolidado>        
                        </table>
                                 </div><br>   
                                </td>
                             </tr></td></tr> 
                <%}%>    
                    <%if (!"0".equals(cons_cant_pr)){%>
                    <tr class="tabla-acceso"><td class="texto-acceso"><bean:message key="lbl.cuenta.prestamo"/></td></tr>                    
                        <tr><td colspan="4">
                            <div id="acct3" style="display:"><table class="level3" width="100%" cellspacing="1" cellpadding="1" border="0">
                                <tr>
                                    <td class="texto-acceso" width="10%"><bean:message key="lbl.est.cta.cuenta"/></td>                                    
                                    <td class="texto-acceso" width="5%"><bean:message key="lbl.moneda"/></td>
                                    <td class="texto-acceso" align="right" width="15%"><bean:message key="lbl.saldo.total"/></td>
                                </tr>
                                <csic:cuentas-consolidado producto="<%=Productos.PRESTAMO%>">         
                                    <tr <%="0".equals(cons_class_item)?"":"class=\"celda-clave1\""%>>
                                        <td class="bienvenida"><%=cons_cuenta%> <%=cons_nickname==null?"":cons_nickname %></td>                                       
                                        <td class="bienvenida"><%=cons_moneda%></td>
                                        <td class="bienvenida" align="right"><%=cons_sado_total%></td>
                                    </tr>
                                </csic:cuentas-consolidado>        
                            </table>
                                 </div><br>   
                                </td>
                             </tr> </td></tr> 
                    <%}%>
                    
                </table></td></tr>
            </table>
            </td>
            </tr>    
        </table>
            </td></tr></table>
	</csic:consolidado> 
	</td></tr>
	</table>
<%@ include file="../footer.jsp"  %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@page import="com.arango.internet.banking.CuentaCorriente"%>
<%@ page import="java.util.Locale" %>

<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>

<%
CuentaCorriente cta = (CuentaCorriente)session.getAttribute("consulta");
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (cta == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/ib/systemError2.jsp");   
}

String backPage="";
if (request.getParameter("backPage") != null)
  backPage=(String)request.getParameter("backPage");  
else
  backPage="../servicios/seleccion.jsp?prod=CC";


/* Parametros del request  */

String cuentaReq="";
String tipo="";

if (session.getAttribute("cuenta.csic")!= null)
  cuentaReq = (String)session.getAttribute("cuenta.csic");

if (request.getParameterValues("tipo")!= null)
  tipo =request.getParameterValues("tipo")[0];

String back="do.consulta?cuentas="+cuentaReq+"&tipo="+tipo;  
session.setAttribute("saldo.back.page", back);
session.setAttribute("asi.session", session.getId());


%>
<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
		<td height="30" class="texto-acceso"><div id=bankdiv align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>"></div></td>
		<td class="texto-acceso"><div align="right">&nbsp;</div></td>
	  </tr>
	  <tr> 
		<td height="40" colspan="2" valign="bottom"><div align="center"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
			  <tr> 
            <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
				<td width="100%"><div align="left" class="login"><bean:message key="tit.consulta.saldo.cc"/></div></td>
			  </tr>
			</table>
		  </div></td>
	  </tr>
	  <tr> 
		<td valign="top" align="center">
		<%@ include file="../divHeader.jsp"%>
			<table width="400" border="0" cellspacing="1" cellpadding="0" >                   
				<tr align="center"> 
				  <td width="400" height="20" class="catra-texto" align="center"  colspan="2" >
					<table width="400" border="0" cellpadding="2" cellspacing="2">
					  <tr> 
						<td width="40%" height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cc.fecha"/></div></td>
						<!-- td width="1%">&nbsp;</td-->
						<td width="60%" height="15" class="bienvenida" align="right"><%=f.formatFecha(cta.getFecha(), locale)%></td>
					  </tr>
					  <tr> 
						<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.cc.numero.cuenta"/></div></td>
						
						<td align="right"><span class="bienvenida"><%=f.formatCuenta(cta.getNumeroCuenta())%></span></td>
					  </tr>
					  <tr> 
						<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cc.cliente"/></div></td>
						
						<td class="bienvenida" align="right"><%=cta.getNombre()%></td>
					  </tr>
					  <tr> 
						<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cc.moneda"/></div></td>
						
						<td class="bienvenida" align="right" nowrap><%=cta.getMoneda()%></td>
					  </tr>
					  <tr> 
						<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cc.saldo.total"/></div></td>
						
						<td class="bienvenida" align="right"><%=f.formatMonto(cta.getSaldoTotal())%></td>
					  </tr>
					  <tr> 
						<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.cc.saldo.reserva"/></div></td>
						
						<td class="bienvenida" align="right"><%=f.formatMonto(cta.getSaldoReserva())%></td>
					  </tr>
					  <tr> 
						<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cc.saldo.disponible"/></div></td>
						
						<td class="bienvenida" align="right"><%=f.formatMonto(cta.getSaldoDisponible())%></td>
					  </tr>                         
                    </table></td>
                </tr>
				<tr> 
					<td colspan="2"  valign="top">&nbsp;</td>
				</tr>
				<tr> 
					<td colspan="2" valign="top" class="texto-acceso"><div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div></td>
				</tr>
				<tr> 
					<td colspan="2"  valign="top">&nbsp;</td>
				</tr>
				<tr> 
					<td valign="top" class="texto-acceso" width="50%"  align="center">
							<INPUT class="botton" onclick="verMovimientos();" type=button value=<bean:message key="lbl.movimientos"/>>
					 </td>
					<td valign="top" class="texto-acceso" width="50%"  align="CENTER">
							<INPUT class="botton" onclick="retornar()" type=button value="<bean:message key="lbl.retroceder"/>">
					 </td></tr>
            </table>
            <%@ include file="../divFooter.jsp"%>
</td></tr></table>
<SCRIPT language="Javascript">
  function verMovimientos (){
    window.location.href="<html:rewrite page='/servicios/movimiento.jsp?prod=CC&cuenta='/><%=cuentaReq%>&back=1";
  }

  function retornar(){
    window.location.href="<%=backPage%>";
  }
  
</script>

<%@ include file="../footer.jsp"  %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.util.Locale" %>
<%@page import="com.arango.internet.banking.CuentaPlazoFijo"%>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>
<%
CuentaPlazoFijo cta = (CuentaPlazoFijo)session.getAttribute("consulta");
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (cta == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/ib/systemError2.jsp");   
}

String backPage="";
if (request.getParameter("backPage") != null)
  backPage=(String)request.getParameter("backPage");  
%>

<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>


<div align="center"> 
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
	<div> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
		  <tr>
            <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>		  
			<td><div align="left" class="login">
			<bean:message key="tit.consulta.saldo.dp.2"/>
			</div></td>
		  </tr>
		</table>
	  </div>
	  </td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
<!-- aqui -->
			<%@ include file="../divHeader.jsp"%>
			
		<table width="350" border="0" cellspacing="1" cellpadding="0" align="center">                   
			  <tr> 
				<td width="40%" height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.numero.deposito"/></div></td>
				<td width="20%">&nbsp;&nbsp;</td>
				<td width="40%"height="15" align="right" class="bienvenida"><%=f.formatCuenta(cta.getNumeroCuenta())%></td>
			</TR>
			
			<!-- Moneda -->
	        <tr> 
			  <td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.cc.moneda"/></div></td>
			  <td></td>
	          <td align="right" height="15" class="bienvenida" nowrap>&nbsp;&nbsp;&nbsp;&nbsp;<%=cta.getMoneda()%></TD>
	        </TR>
						
			<!-- Fecha Emision -->
			<tr> 
				<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.fecha.apertura"/></div></td>
				<td></td>
			    <td height="15" align="right" class="bienvenida"><%=f.formatFecha(cta.getFechaApertura(), locale)%></td>
			    
			<!-- Fecha Vencimiento -->
			<tr> 
				<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.fecha.vencimiento"/></div></td>
				<td></td>
			    <td height="15" align="right" class="bienvenida"><%=f.formatFecha(cta.getFechaVencimiento(), locale)%></td>
			</TR>
						    
			<!-- No. Dias -->
			<tr> 
				<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.plazo"/></div></td>
				<td></td>
			    <td height="15" align="right" class="bienvenida"><%=cta.getPlazo()%></td>
			</TR>
			
			<!-- Tasa Interes -->    
			<tr> 
				<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.tasa.interes"/></div></td>
				<td></td>
			    <td height="15" align="right" class="bienvenida"><%=f.formatPorcentaje(cta.getTasaInteres())%></td>
			</TR>
			
			<!-- Principal-Capital -->    
			<tr> 
				<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.capital"/></div></td>
				<td></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getCapital())%></td>
			</TR>
			    
			<!-- Intereses -->    
			<tr> 
				<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.interes"/></div></td>
				<td></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getInteresesPagados())%></td>
			</TR>
			
			<!-- Total al Vencimiento -->
			<tr> 
				<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.interes.vencimiento"/></div></td>
				<td></td>				
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getInteresesVencimiento())%></td>                                    
			</TR>
			
			<!-- Pignorado -->
			<tr> 
				<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.saldo.pignorado"/></div></td>
				<td></td>				
			    <td height="15" class="bienvenida" align="right"><%="SI".equals(cta.getCtaPignorada()) ? com.arango.internet.tag.TagUtil.getString(pageContext, "lbl.afirmacion"):com.arango.internet.tag.TagUtil.getString(pageContext, "lbl.negacion")%></td>
			</TR>
						    
			<tr> 
				<td valign="top">&nbsp;</td>
				<td></td>
				<td></td>
				</tr>
			<tr> 
				<td valign="top" class="texto-acceso" colspan="3"><div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div></td>
				</tr>
				<tr> 
					<td valign="top" class="texto-acceso" colspan="3"><div align="center"><br>
							<INPUT class="botton" onclick="retornar()" type=button value="<bean:message key="lbl.retroceder"/>"> </td></tr>
            </table>		  

			<%@ include file="../divFooter.jsp"%>

	  </form></td>
  </tr>
  
  
</table>
</div>			
<SCRIPT language="Javascript">
  function retornar()
  {
   window.location.href="<html:rewrite page='/servicios/seleccionso.jsp?prod=DP'/>";
  }
</script>

<%
	cta = null;
%>

<%@ include file="../footer.jsp"  %>
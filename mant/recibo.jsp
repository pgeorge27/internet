<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.arango.internet.banking.Transferencia"%>
<%@ page import="com.arango.common.banking.Productos"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.common.beans.*"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Calendar"%>


<%
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
Calendar cale = Calendar.getInstance();
cale.setTime(new java.util.Date());
java.util.Date hasta = cale.getTime();
cale.set(Calendar.DATE, 1);
java.util.Date desde = cale.getTime();
String fechaDesde = df.format(desde);
String fechaHasta = df.format(hasta);

java.util.Locale locale_consolidado = (java.util.Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);

%>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>
<% 
 String fecha=""; 
 String secuencia= "";
%>

<%@ include file="../head.jsp"%>
<%
   Transferencia transf = (Transferencia)session.getAttribute("transfer"); 
   secuencia = (String)session.getAttribute("secuencia");  
   Locale locale2 = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
   Date today = new Date();
%>
<%@ include file="../body.jsp"%>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
		<td height="30" class="texto-acceso"><div id=bankdiv align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>"></div></td>
		<td class="texto-acceso"><div align="right">&nbsp;</div></td>
	  </tr>
	  <tr> 
		<td height="40" colspan="2" valign="bottom"><div align="center"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			  <tr> 
				<td width="92%"><div align="left" class="login"><bean:message key="mnu.transferencia.internas"/></div></td>
				<td width="8%"><div align="right">&nbsp;
							</div></td>
			  </tr>
			</table>
		  </div></td>
	  </tr>
	  <tr> 
		<td valign="top" align="center">
			<table width="70%" border="0" cellspacing="1" cellpadding="0">                   
				<tr> 
				  <td width="68%" height="20" class="catra-texto" align="center">
  	  
					<table width="80%" border="0" cellpadding="2" cellspacing="2">
                <tr class="Stripe0">
                   <td width="40%" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.transferencia.recibo.fecha"/></div></td>
                   <td class="bienvenida" width="60%"><%=f.formatFechaLong(today, locale2)%></td></tr>
                <tr class="Stripe1">
                   <td class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.recibo.cuenta.debito"/></div></td>
                   <td class="bienvenida"><%=f.formatCuenta(transf.getCuentaOrigenBanco(), "A-S-C")%> <%=transf.getCuentaOrigen().getNombreTitular() %></td></tr>
                <tr class="Stripe0">
                   <td class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.transfer.monto"/></div></td>
                   <td class="bienvenida"><%=f.formatMontoColor(transf.getMontoDb())%></td></tr>     
                <tr class="Stripe1">
                   <td class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.recibo.cuenta.credito"/></div></td>
                   <td class="bienvenida"><%=f.formatCuenta(transf.getCuentaDestinoBanco(), "A-S-C")%> <%=transf.getCuentaDestino().getNombreTitular() %></td></tr>
                <tr class="Stripe0">
                   <td class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.transfer.secuencia"/></div></td>
                   <td class="bienvenida"><%=secuencia%></td></tr>
<tr> 
					<td valign="top" class="texto-acceso" colspan="2"><div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div></td>
				</tr>
</table>
</table>
  </td></tr>
</TABLE>
<%@ include file="../footer.jsp" %>
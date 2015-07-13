<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>
<% 
 String fecha=""; 
 String secuencia= "";
%>

<%@ include file="../head.jsp"%>

<%

TransferenciaInternacional transf = (TransferenciaInternacional)session.getAttribute("transfer");
   
secuencia = (String)session.getAttribute("secuencia");
   
Locale locale2 = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
Date today = new Date();

%>
<%@ include file="../body.jsp"%>

<div align="center"> 
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
			<td><div align="left" class="login"><bean:message key="lbl.transf.inter.titulo"/></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  
<tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
	<%@ include file="../divHeader.jsp"%>       
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr><td>
            <table cellpadding=4 width=100% border=0 cellspacing=2>        
                <tr valign="middle"  class="celda-clave1">
        			<td class="bienvenida" width="40%"><bean:message key="lbl.transf.inter.fecha.efectiva"/></td>
                    <td class="bienvenida" width="60%"><%=f.formatFecha(transf.getFecha())%></td></tr>
                <tr valign="middle">
        			<td class="bienvenida"><bean:message key="lbl.transf.inter.fecha.elaboracion"/></td>
                    <td class="bienvenida"><%=f.formatFechaLong(today, locale2)%></td></tr>
                <tr valign="middle" class="celda-clave1">
                   <td class="bienvenida"><bean:message key="lbl.transf.inter.secuencia"/></td>
                   <td class="bienvenida"><%=StringUtilities.replace(f.formatCuenta(secuencia, "A-S-C"), "-", "")%></td></tr>                      
                <tr  valign="middle">
                   <td class="bienvenida"><bean:message key="lbl.transf.inter.cuenta"/></td>
                   <td class="bienvenida"><%=f.formatCuenta(transf.getCuenta().getCodigoBanco())%> <%=transf.getCuenta().getNombreProducto()%></td></tr>
                <tr valign="middle" class="celda-clave1">
                   <td class="bienvenida"><bean:message key="lbl.transf.inter.cantidad"/></td>
                   <td class="bienvenida"><%=f.formatMonto(transf.getMonto())%></td></tr>     
                <tr  valign="middle">
                   <td class="bienvenida"><bean:message key="lbl.transf.inter.moneda"/></td>
                   <td class="bienvenida"><%=transf.getDescMoneda()%></td></tr>                   
                <tr valign="middle" class="celda-clave1">
                   <td class="bienvenida"><bean:message key="lbl.transf.inter.cuentaBeneficiario"/></td>
                   <td class="bienvenida"><%=transf.getCuentaBeneficiario()%> <%=transf.getNombreBeneficiario()%></td></tr>                                
               
				<%if (transf.getNotaHoraCorte() != null){%>
				<tr valign="middle" class="celda-clave1">
                   <td class="interes-vencido"><%if (transf.getNota() == null){%>
                   			<strong><bean:message key="lbl.transf.inter.nota"/></strong>
                   			<%} %></td>
                   <td class="interes-vencido"><strong><bean:message key="<%=transf.getNotaHoraCorte() %>"/></strong></td></tr>
				<%} %>
<tr>
<td colspan="2" align="right"><br><br>

<div align="center"><a href="javascript:printPage2()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
</td>
</tr>
</table>
</td></tr>
</table>
<%@ include file="../divFooter.jsp"%>
</td></tr></table>
</div>


<%@ include file="../footer.jsp" %>
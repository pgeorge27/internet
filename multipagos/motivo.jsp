<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.arango.internet.beans.TranferenciaProcesada"%>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="com.arango.internet.services.interfaces.ITransferencia"  %>

<%@ page import="org.apache.struts.action.ActionError"%>
<%@ page import="org.apache.struts.action.ActionErrors"%>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>

<%
int index = -1;
Object obj = session.getAttribute("indice.transferencia.rechazo");
String s = null;
if (obj != null)
    s = obj.toString();
if (s != null){
    try{
        index = Integer.parseInt(s);
    }
    catch(NumberFormatException e){
        index = -1;
    }
}
if (index < 0)
    response.sendRedirect("aprobacion.jsp");
ArrayList data = (ArrayList)session.getAttribute("transferencias");
if (data == null)
    response.sendRedirect("aprobacion.jsp");
if (data.size() < index)
    response.sendRedirect("aprobacion.jsp");
TranferenciaProcesada transf = (TranferenciaProcesada)data.get(index);
String fecha=""; 
String secuencia= "";
Locale locale2 = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
Date today = new Date();
%>
<%@ include file="../head.jsp"%>
<script language="javascript">
function validateLength(obj, size){
    var str = _trim(obj.value);
	if (str.length >= size){
		event.returnValue = false;
	}
}
function __back(){
	<%
		String tieneToken = (String) session.getAttribute("tieneToken");
		if(tieneToken != null && tieneToken.equals("S")){
	%>
			document.location = "<html:rewrite page='/multipagos/aprobacion.jsp'/>";
			
	<%} else{ %>
			
			document.location = "<html:rewrite page='/multipagos/aprobacion.jsp'/>";
	
	<% } %>
}
function __continue(){
    var rechazo = "<bean:message key="lbl.transf.inter.confirma.rechazar"/>";
    var msg = "";
    msg = rechazo;
    if (confirm(msg)){
		document.forms[0].tipo.value="<%=ITransferencia.RECHAZADA %>";
		document.forms[0].submit();
	}
	else{
		__back();
	}
}
</script>
<%@ include file="../body.jsp"%>

<div align="center"> 
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="96%"><div align="left" class="login"><bean:message key="lbl.transf.inter.recibo.rechazo"/></div></td>
			<td width="4%" align="right">&nbsp;</td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  
<tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top">       
        <table width="70%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr><td>
          <html:form method="post" action="/multipago/autoriza">   
				<html:hidden property="tipo" value="<%=ITransferencia.RECHAZADA%>" />
				<html:hidden property="indice" value="<%=String.valueOf(index)%>"/>
          <table width="70%" border="0" align="center" cellpadding="0" cellspacing="2">
		  <tr valign="middle">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.fecha"/></td>
					<td class="bienvenida" width="70%"><%=f.formatFechaLong(today, locale2)%></td></tr>
            <tr valign="middle" class="celda-clave1">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.secuencia"/></td>
                   <td class="bienvenida"><%=StringUtilities.replace(f.formatCuenta(transf.getNumeroDocumento(), "A-S-C"), "-", "")%></td></tr>                      
            <tr valign="middle">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.cuenta"/></td>
                   <td class="bienvenida"><%=StringUtilities.getValue(transf.getCuentaAbanks())%></td></tr>
             <tr valign="middle" class="celda-clave1">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.cantidad"/></td>
                   <td class="bienvenida"><%=f.formatMonto(transf.getMonto())%></td></tr>     
             <tr valign="middle">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.moneda"/></td>
                   <td class="bienvenida"><%=StringUtilities.getValue(transf.getMonedaAbanks())%></td></tr>                   
            <tr valign="middle" class="celda-clave1">
		           <td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.cuentaBeneficiario"/></td>
                   <td class="bienvenida"><%=StringUtilities.getValue(transf.getCuentabancoBeneficiario())%> <%=StringUtilities.getValue(transf.getNombreBeneficiario())%></td></tr>
            <tr valign="middle">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.motivo"/></td>
                    <td class="bienvenida" width="70%"><html:textarea property="motivo" styleId="motivo" cols="35" rows="5"  styleClass="botton-acceso"/></td></tr>
            </table>    
            </html:form>
<tr>
<td colspan="2" align="right"><br><br>

<div align="center">
<input type="button" class="botton" value="<bean:message key="lbl.transf.inter.rechazar"/>" onclick="__continue();">
			
			
<input class="botton" onclick="__back()" type="button" value="<bean:message key="lbl.retroceder"/>">
</div>
<tr>
<td colspan="2" align="center"><br><br>

<div align="center"></div>

</td></tr></table></td></tr></table></div>



<%@ include file="../footer.jsp" %>
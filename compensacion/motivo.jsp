<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="com.arango.internet.services.interfaces.ITransferencia"  %>

<!DOCTYPE html>
<html>


<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">





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
TransferenciaInternacional transf = (TransferenciaInternacional)data.get(index);
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
			document.location = "<html:rewrite page='/transferencias/aprobacionMasiva.jsp'/>";
			
	<%} else{ %>
			
			document.location = "<html:rewrite page='/transferencias/aprobacion.jsp'/>";
	
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

<body>

<div align="center" class="container"> 


 <div class="row">
 
 <div class="col-md-2"></div>

          <div class="col-md-8"><div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.transf.inter.recibo.rechazo"/></strong></div>
  <div class="panel-body">

         <html:form method="post" action="/autoriza">   
				<html:hidden property="tipo" value="<%=ITransferencia.RECHAZADA%>" />
				<html:hidden property="indice" value="<%=String.valueOf(index)%>"/>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.fecha"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatFechaLong(today, locale2)%></div>
  <div class="col-md-1"></div>

 </div>

<br>



<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.secuencia"/>:</strong></div>
    <div class="col-md-3" align="left"><%=StringUtilities.replace(f.formatCuenta(transf.getNumeroDocumento(), "A-S-C"), "-", "")%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.cuenta"/>:</strong></div>
    <div class="col-md-3" align="left"><%=transf.getCuenta() != null ? f.formatCuenta(transf.getCuenta().getCodigoBanco()) : ""%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.cantidad"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(transf.getMonto())%></div>
  <div class="col-md-1"></div>

 </div>

<br>



<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.moneda"/>:</strong></div>
    <div class="col-md-3" align="left"><%=StringUtilities.getValue(transf.getMoneda())%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.cuentaBeneficiario"/>:</strong></div>
    <div class="col-md-3" align="left"><%=StringUtilities.getValue(transf.getCuentaBeneficiario())%> <%=StringUtilities.getValue(transf.getNombreBeneficiario())%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.motivo"/>:</strong></div>
    <div class="col-md-3" align="left"><html:textarea property="motivo" styleId="motivo" cols="35" rows="5"  styleClass="form-control"/></div>
  <div class="col-md-1"></div>

 </div>

<br>


  	<div align="center">

	<input type="button" class="btn btn-default" style="width: 100px" value="<bean:message key="lbl.transf.inter.rechazar"/>" onclick="__continue();">

<input class="btn btn-default" style="width: 100px" onclick="__back()" type="button" value="<bean:message key="lbl.retroceder"/>">

				</div>
							

       </html:form>
       
 
 </div>
  </div>
   </div>
 </div>



<%@ include file="../footer.jsp" %>
</div>
</body>
</html>
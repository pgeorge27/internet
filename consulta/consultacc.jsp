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

<!DOCTYPE html>
<html:html>

<head>
<%@ include file="../head.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
</head>
<%@ include file="../body.jsp"%>
<body>



<div align="center" class="container"> 




 <div class="row">
 
 <div class="col-md-2"></div>

          <div class="col-md-8"><div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.consulta.saldo.cc"/></strong></div>
  <div class="panel-body">




<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.cc.fecha"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatFecha(cta.getFecha(), locale)%></div>
  <div class="col-md-1"></div>

 </div>

<br>

<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.cc.numero.cuenta"/>:</strong></div>
    <div class="col-md-3" align="left" ><%=f.formatCuenta(cta.getNumeroCuenta())%></div>
  <div class="col-md-1"></div>

 </div>




<br>

<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.cc.cliente"/>:</strong></div>
    <div class="col-md-3" align="left"><%=cta.getNombre()%></div>
  <div class="col-md-1"></div>

 </div>





<br>

<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.cc.moneda"/>:</strong></div>
    <div class="col-md-4" align="left"><%=cta.getMoneda()%></div>
  <div class="col-md-1"></div>

 </div>






<br>

<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.cc.saldo.total"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(cta.getSaldoTotal())%></div>
  <div class="col-md-1"></div>

 </div>




<br>

<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.cc.saldo.reserva"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(cta.getSaldoReserva())%></div>
  <div class="col-md-1"></div>

 </div>





<br>

<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.cc.saldo.disponible"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(cta.getSaldoDisponible())%></div>
  <div class="col-md-1"></div>

 </div>





	<br> 
					
					
					<div class="visible-lg" align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
	


	<br> 



  	<div align="center">
	<INPUT class="btn btn-default" style="width: 100px" onclick="verMovimientos();" type=button value=<bean:message key="lbl.movimientos"/>>
		
<INPUT class="btn btn-default" style="width: 100px" onclick="retornar()" type=button value="<bean:message key="lbl.retroceder"/>">
				</div>
							










 </div>


 </div>

 </div>

 </div>




<SCRIPT language="Javascript">
  function verMovimientos (){
    window.location.href="<html:rewrite page='/servicios/movimiento.jsp?prod=CC&cuenta='/><%=cuentaReq%>&back=1";
  }

  function retornar(){
    window.location.href="<%=backPage%>";
  }
  
</script>


<%@ include file="../footer.jsp"  %>
</div>
</body>
</html:html>
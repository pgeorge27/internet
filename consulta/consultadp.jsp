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
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.consulta.saldo.dp.2"/></strong></div>
  <div class="panel-body">


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.numero.deposito"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatCuenta(cta.getNumeroCuenta())%></div>
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
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.fecha.apertura"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatFecha(cta.getFechaApertura(), locale)%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.fecha.vencimiento"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatFecha(cta.getFechaVencimiento(), locale)%></div>
  <div class="col-md-1"></div>

 </div>

<br>

<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.plazo"/>:</strong></div>
    <div class="col-md-3" align="left"><%=cta.getPlazo()%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.tasa.interes"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatPorcentaje(cta.getTasaInteres())%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.capital"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(cta.getCapital())%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.interes"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(cta.getInteresesPagados())%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.interes.vencimiento"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(cta.getInteresesVencimiento())%></div>
  <div class="col-md-1"></div>

 </div>

<br>



<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.saldo.pignorado"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(cta.getInteresesVencimiento())%></div>
  <div class="col-md-1"></div>

 </div>

<br>



			<tr> 
				<td valign="top" class="texto-acceso" colspan="3"><div class="visible-lg" align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div></td>
				</tr>
				<tr> 
					<td valign="top" class="texto-acceso" colspan="3"><div align="center"><br>
							<INPUT class="btn btn-default" onclick="retornar()" type=button value="<bean:message key="lbl.retroceder"/>"> </td></tr>


</div>


</div>


</div>




















<div align="center"> 
		
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
</div> 
</div>









</div> 

</body>
</html:html>
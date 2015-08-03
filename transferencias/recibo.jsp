<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
<%@ page import="com.arango.common.util.StringUtilities"%>

<!DOCTYPE html>
<html>


<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>
<% 
 String fecha=""; 
 String secuencia= "";
%>
<head>
<%@ include file="../head.jsp"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">



<%

TransferenciaInternacional transf = (TransferenciaInternacional)session.getAttribute("transfer");
   
secuencia = (String)session.getAttribute("secuencia");
   
Locale locale2 = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
Date today = new Date();

%>
</head>
<%@ include file="../body.jsp"%>

<body>


<div align="center" class="container"> 







 <div class="row">
 
 <div class="col-md-2"></div>

          <div class="col-md-8"><div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.transf.inter.titulo"/></strong></div>
  <div class="panel-body">




<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.fecha.efectiva"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatFecha(transf.getFecha())%></div>
  <div class="col-md-1"></div>

 </div>

<br>






<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.fecha.elaboracion"/>:</strong></div>
    <div class="col-md-4" align="left"><%=f.formatFechaLong(today, locale2)%></div>
  <div class="col-md-1"></div>

 </div>

<br>







<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.secuencia"/>:</strong></div>
    <div class="col-md-3" align="left"><%=StringUtilities.replace(f.formatCuenta(secuencia, "A-S-C"), "-", "")%></div>
  <div class="col-md-1"></div>

 </div>

<br>












<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.cuenta"/>:</strong></div>
    <div class="col-md-4" align="left"><%=f.formatCuenta(transf.getCuenta().getCodigoBanco())%> <%=transf.getCuenta().getNombreProducto()%></div>
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
    <div class="col-md-4" align="left"><%=transf.getDescMoneda()%></div>
  <div class="col-md-1"></div>

 </div>

<br>






<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.cuentaBeneficiario"/>:</strong></div>
    <div class="col-md-3" align="left"><%=transf.getCuentaBeneficiario()%> <%=transf.getNombreBeneficiario()%></div>
  <div class="col-md-1"></div>

 </div>

<br>




<div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong></strong></div>
    <div class="col-md-3" align="left">	<%if (transf.getNotaHoraCorte() != null){%>
				
                   <div><%if (transf.getNota() == null){%>
                   			<strong><bean:message key="lbl.transf.inter.nota"/></strong>
                   			<%} %></div>
                   <div><strong><bean:message key="<%=transf.getNotaHoraCorte() %>"/></strong></div>
				<%} %></div>
  <div class="col-md-1"></div>

 </div>

<br>





</div>










  





<div class="prueba visible-lg" align="center"><a href="javascript:printPage2()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>









<%@ include file="../footer.jsp" %>




</div>

</div>
</div>
</div>
</body>

</html>
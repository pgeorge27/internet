<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
<%@ page import="java.util.Locale" %>

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

<%

TransferenciaInternacional transf = (TransferenciaInternacional)session.getAttribute("transfer");

session.setAttribute("transfer", null);
secuencia = (String)session.getAttribute("secuencia");
   
Locale locale2 = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
Date today = new Date();

String titulo = "lbl.transf.inter.recibo.aprobacion";
if (session.getAttribute("titulo.recibo") != null){
    titulo = (String)session.getAttribute("titulo.recibo");
}
%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>
<%@ include file="../body.jsp"%>


<body>

<div align="center" class="container"> 


<html:form method="post" action="/query2">
<html:hidden property="estado" /> 
<%
   String strConsultaTrans = session.getAttribute("consulta.transfer.cliente").toString();
 %>
<html:hidden property="cliente" value="<%=strConsultaTrans%>"/>
</html:form>





<div align="right">&nbsp;
							<INPUT class="btn btn-default" onclick="document.forms[0].submit();" type="button" value="<bean:message key="lbl.retroceder"/>"></div>


 <div class="row">
 
 <div class="col-md-2"></div>

          <div class="col-md-8"><div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="<%=titulo%>"/></strong></div>
  <div class="panel-body">
  
  
  
  
  
  
  
  <div class="row">
  <div class="col-md-3"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.transf.inter.fecha"/>:</strong></div>
    <div class="col-md-4" align="left"><%=f.formatFechaLong(today, locale2)%></div>
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
    <div class="col-md-4" align="left"><%=StringUtilities.getValue(transf.getMoneda())%></div>
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







<div class="prueba visible-lg" align="center"><a href="javascript:printPage2()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>

<br>


<div align="center">
<INPUT class="btn btn-default" onclick="document.forms[0].submit();" type="button" value="<bean:message key="lbl.retroceder"/>">

 </div>






<br>

  


 </div>
  </div>
   </div>
   





        

               
   
 
                 
           






<logic:present name="mensaje.final">
	        <script type="text/javascript">
	        	alert("<bean:message key='lbl.transf.inter.mensaje.final'/>");
	        </script>
        </logic:present>	
        		
        <logic:present name="transferencia.pendiente.aprobacion">
	        <script type="text/javascript">
	        	alert("<bean:message key='lbl.transf.inter.mensaje.transferencia.pendiente.aprobar'/>");
	        </script>        
        </logic:present>
<%@ include file="../footer.jsp" %>
 </div>
</div>
</body>
</html>
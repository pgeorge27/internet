<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html:html>

<head>
<%
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");

String strFechaDesde = "";
String strFechaHasta = "";
Date desde = (Date)session.getAttribute("fecha.desde");
Date hasta = (Date)session.getAttribute("fecha.hasta");
if (desde != null){
    strFechaDesde = df.format(desde);
}
if (hasta != null){
    strFechaHasta = df.format(hasta);
}
%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
</head>
<%@ include file="/head.jsp"%> 
<script language=javascript>
function __retornar(){
	document.forms["consultaEstadoForm"].submit();
}
</script>
<body>
<%@ include file="/body.jsp"%> 

<div class="container">
<html:form method="post" action="/consulta/estado/autorizar"> 
	<html:hidden property="estado" value="T"/>
	<html:hidden property="tipo" value="3"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>    
	<html:hidden property="desde" value="<%=strFechaDesde%>"/>
	<html:hidden property="hasta" value="<%=strFechaHasta%>"/>
	
</html:form>

   	<div class="row" style="padding-top: 20px; padding-right: 3%; padding-left: 3%;">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">
		
				<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong>Operación realizada</strong></div>
					 
					 <br>
					 <div class="row" align="center">
					   <div class="col-md-1"></div>
  <div class="col-md-2" align="center"><img src="<html:rewrite page='/images/success.gif'/>"></div>
  <div class="col-md-8" align="center">Formulario(s) aprobado(s) exitósamente</div>
  <div class="col-md-1"></div>
  
                        </div>
					 
					 <br>
					 
					 <div align="center">
							<INPUT class="btn btn-default" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
					 
					 
					 
						 <br>
						
					</div>
				
						</div>
							</div>

                </div>

<%@ include file="/footer.jsp" %>
</div>
</body>
</html:html>
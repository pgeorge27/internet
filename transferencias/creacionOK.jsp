<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<!DOCTYPE html>
<html:html>

<head>
<%@ include file="../head.jsp"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>

<%@ include file="../body.jsp" %>

<body>

<div align="center" class="container"> 


		<div class="row">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong>Mensaje</strong></div>
					  <div class="panel-body">
				
				
				
				<div align="center"><img src="<html:rewrite page='/images/success.gif'/>"></div>
				
				<br>
				
				<div class="" align="center">Plantilla creada satisfactoriamente</div>
				
				<br>
				
				<div align="center">
<INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/transferencias/crearPlantilla.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>"></div>


					</div>

		</div>
	
	</div>
	</div>
	
		</div>


</div>
</body>
</html:html>

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

<div class="container">


          <div class="row" style="padding-left: 3%; padding-right: 3%; padding-top: 30px;">

		  <div class="row"><div class="col-md-4 col-md-offset-4">
		
				<div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong>Mensaje</strong></div>
					 
					 <br>
                  					 <div class="row" align="center">
                                        <div class="col-md-4"></div>
 <div class="col-md-4"> <img src="<html:rewrite page='/images/success.gif'/>"></div>
                                       <div class="col-md-4"></div>
                  </div>
                  <br>
					 <div class="row" style="padding-right: 3%; padding-left: 3%;">
                       
					 
  <div class="col-md-2"></div>
  <div class="col-md-8" align="center">Plantilla modificada satisfactoriamente</div>
  <div class="col-md-2"></div>
  <br>
   <br>
  <br>
<div align="center">

<INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/mant/plantilla.do'/>';" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
  
   <br>
                        </div>
					 
					 
						 <br>
						
					</div>
				
						</div>
							</div>

                </div>

     <br>

<%@ include file="../footer.jsp" %>
</div>
</body>
</html:html>
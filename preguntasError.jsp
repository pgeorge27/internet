<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<!DOCTYPE html>
<html:html>
<head>
<%@ include file="head.jsp"  %>
<%@ include file="body.jsp"  %>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
</head>
<body>

  <div class="container" style="padding-top:20px">

  <div class="row" style="padding-left: 3%; padding-right: 3%; padding-top: 40px;">

		  <div class="row"><div class="col-md-4 col-md-offset-4">
		
				<div class="panel panel-default">
					 <div class="panel-heading" align="left" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong>Alerta!</strong></div>
					 
					 <br>
                  					 <div class="row" align="center">
                                        <div class="col-md-4"></div>
 <div class="col-md-4"><img src="<html:rewrite page='/images/error.gif'/>"></div>
                                       <div class="col-md-4"></div>
                  </div>
                  <br>
					 <div class="row" style="padding-right: 3%; padding-left: 3%;">
                       
					 
  <div class="col-md-2"></div>
  <div class="col-md-8" align="justify"><bean:message key="lbl.preg.secreta.nota"/></div>
  <div class="col-md-2"></div>
  
                        </div>
					 
					 
						 <br>
						
					</div>
				
						</div>
							</div>

                </div>
  
			</div>
			
			
<footer>
 <br>
    
  <br><br>
    
    <br><br>
  <br><br>

<%@ include file="footer.jsp"  %>
</footer>


</body>
</html:html>	

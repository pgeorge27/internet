<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados" : "msg.derechos.reservados2";
%>


<!DOCTYPE html>
<html:html>

<head>
<link rel="stylesheet" type="text/css" 	href="<html:rewrite page='/style/flujos.css'/>" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<SCRIPT language="Javascript">
var mensaje = "<bean:message key='<%=copyrigth %>' arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>";
function noViewSource(btnClick)
{
	if (navigator.appName == "Netscape" && btnClick.which == 3)
	{   alert(mensaje);
		return false;
	}
	else if (navigator.appName =="Microsoft Internet Explorer" && event.button == 2)
	{	alert(mensaje);
		return false;
	}
}
document.onmousedown = noViewSource;
if (navigator.appName =="Microsoft Internet Explorer")
   document.oncontextmenu = noViewSource;
</SCRIPT>

<SCRIPT language="JavaScript">
function protect(evt){
 if (navigator.appName != "Microsoft Internet Explorer"){
 if (evt.which != 3)
 return true;
};
return false;
}

function trap(){
 if(document.images){
 if(navigator.appName != "Microsoft Internet Explorer"){
 document.onmousedown = protect;}
 else{
document.oncontextmenu = protect;}}}

function close(){
	window.close();
}


function makeSubmit(){
	
	var campo = document.getElementById('mark');
	if(campo.value ==  ""){
		alert("Debe darle un nombre a la imagen");
	}
	else{
		 document.getElementById('marca').value = campo.value; 
		 document.forms[0].submit();
	}
	
}

</SCRIPT>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<LINK REL="stylesheet" TYPE="text/css" HREF="./style/estilo.css">
<script type="text/javascript">
<!--
if (typeof window.event != 'undefined') // IE
document.onkeydown = function() // IE
 {
 var t=event.srcElement.type;
 var kc=event.keyCode;
 return ((kc != 8 ) || ( t == 'text'  ) ||
          (t == 'textarea') || ( t == 'submit' ) || (t =='password')) 
 }
else
document.onkeypress = function(e)  // FireFox/Others 
 {
 var t=e.target.type;
 var kc=e.keyCode;
 if ((kc != 8 ) || ( t == 'text'  ) ||
     (t == 'textarea') || ( t == 'submit' ) || (t =='password'))
     return true
 else {
     return false
 }
}
//-->
</script>

</head>
<body>
<div class="container">

  	 <header style="padding-top: 20px;">
			<img border="0" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/>
		    </header>


		  <div class="row" style="padding-top: 110px;">
		<div class="col-md-4 col-md-offset-4">
		
				<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.confirmar.imagen.indicacion"/></strong></div>
									<div class="panel-body">

<div><img class="img-responsive" alt="Responsive image" src="<html:rewrite page='/do.GetImage'/>"></div>

<br>
<div class="row">

  <div class="col-md-6"><strong><bean:message key="lbl.token.cambio.imagen.nombreImagen" />:</strong></div>
  <div class="col-md-6"><input id="mark" class="form-control" type="text" maxlength="12" style="text-transform: uppercase"></div>


	</div>

			</div>

										</div>
										
											
										<div align="center">
										
								
										
										<div class="row" style="margin-left: 2em;">
  <div class="col-md-5">	<div align="center">
                                        <form name="formConfirma" action="<html:rewrite page='/saveImg.jsp'/>" >
                                        	<input type="hidden" name="marca"  id="marca" value=""/>
                                        	<input name="baceptar"  onclick="makeSubmit();" type="button" class="btn btn-default" style="width: 110px;" value="<bean:message key="btn.confirmar"/>"> 
			  							</form >
			  							
			  							</div></div>
  <div class="col-md-5">	<div align="center" >
			  						
			  							<form name="cancelacion" action="<html:rewrite page='/firstLogInSC.jsp'/>">
										<input name="btCancelar" onclick="submit();" type="button" class="btn btn-default" style="width: 110px;" value="<bean:message key="btn.cancelar"/>"  > 
										</form>
										
										</div></div>
										
							</div>			
			
								
			  							
			  						
								
										</div>
														
										</div>
										
										
									
							
	
										
										</div>
										</div>
								

</body>

</html:html>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="com.arango.internet.beans.IBAfiliacion" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ page import="com.arango.common.beans.Usuario" %>
<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>
<%@ page import="java.util.ArrayList" %>
<%! 
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();

%>
<% 
String descripcion = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "lbl.mant.imagen.obs3" :  "lbl.mant.imagen.obs4";
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
%>
<%@ include file="head.jsp"  %>
<style type="text/css">
#derechos{
	width: 100%;	 
	background-color:#4D4F53;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #FFFFFF;
	position: fixed; 
	bottom:0;	
	vertical-align: middle;
	padding-bottom: 8px;
	padding-top: 8px;
	text-align: center;
}
</style>

<!DOCTYPE html>
<html:html>

<head>
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
<script language="javascript" src="./scripts/campos.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<SCRIPT language="Javascript">
var mensaje = "<bean:message key='msg.derechos.reservados' arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>";
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
window.statusbar=' ';

var imgRe = /^.+\.(jpg|jpeg|gif|png)$/i;
function previewImage(pathField, previewName)
{       
    var path = pathField.value;
    if (path.search(imgRe) != -1)
    {   
        document[previewName].src = 'file://'+path;
    }       
    else    
    {   
        alert("JPG, PNG, and GIFs only!");
    }   
}

var imgRe = /^.+\.(jpg|jpeg|gif|png)$/i;
function previewImage(pathField, previewName)
{       
    var path = pathField.value;
    if (path.search(imgRe) != -1)
    {   
        document[previewName].src = 'file://'+path;
    }       
    else    
    {   
        alert("JPG, PNG, and GIFs only!");
    }   
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


function userElection()
{


}
var login = <%=Integer.parseInt(session.getAttribute("flag").toString())%>
function cancelar(){

	window.location.href = "<html:rewrite page='/mant/AdminIMG.jsp'/>";
}
</script>




<style type="text/css">


  
@media (min-width: 1200px){
         .col-md-3{
          
                margin-right: 1em;
            }
            
            
 
            


}

@media screen and (min-width: 800px) and (max-width: 1195px) {
   .col-md-1{
               
              margin-left: -1em;
              
            }
            
       



}






@media screen and (min-width: 610px) and (max-width: 800px) {
   .col-md-3{
               
            
                
              
            }
            

}


@media only screen and (max-width : 1024px) {
   .col-md-3{
               
            
                
              
            }
}




</style>






</head>

<link rel="stylesheet" type="text/css" 	href="<html:rewrite page='/style/flujos.css'/>" />

<%@ include file="body.jsp"  %>

<body>

<div class="container">

		  <div class="row" style="padding-top: 20px;">
		<div class="col-md-4 col-md-offset-4">
		
				<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.confirmar.imagen.indicacion"/></strong></div>
									<div class="panel-body">

<div><img class="img-responsive center-block" alt="Responsive image" src="<html:rewrite page='/do.GetImage'/>"></div>

<br>
<div class="row">

  <div class="col-md-6"><strong><bean:message key="lbl.token.cambio.imagen.nombreImagen" />:</strong></div>
  <div class="col-md-6"><input size="35" id="mark" class="form-control" type="text" maxlength="12" style="text-transform: uppercase"></div>


	</div>
	
	<br>
	

			
										
										<div align="center">
										
								
										
										<div class="row">
										 <div class="col-md-1"></div>	
  <div class="col-md-3">	<div align="center">
                                  <form name="formConfirma" action="<html:rewrite page='/saveImg.jsp'/>" >
                                        	<input type="hidden" name="marca"  id="marca" value=""/>
                                        	<div ><input name="baceptar"  onclick="makeSubmit();" type="button"  class="btn btn-default" style="width: 110px;" value="<bean:message key="btn.confirmar"/>"></div> 
			  							</form >
			  							
			  							</div></div>
			  							
			  							 <div class="col-md-2"></div>	
			  							
			  							
  <div class="col-md-3">	<div align="center">
			  						
			  							<form name="cancelacion" action="<html:rewrite page='/do.cancelImage'/>">
										<input name="btCancelar" onclick="submit();" type="button"  class="btn btn-default" style="width: 110px;" value="<bean:message key="btn.cancelar"/>"  > 
										</form>
										
										</div></div>
										
										 <div class="col-md-2"></div>	
										
							</div>			
			
								
			  							
			  						
								
										</div>
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										
										

			</div>

										</div>
										
											

														
										</div>

										</div>

	</div>
	
</body>
</html:html> 
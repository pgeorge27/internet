<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.aplicar.regla.password", "true");
%>

<!DOCTYPE html>
<html:html>

<head>




<style type="text/css">


  
@media (min-width: 1200px){
         .col-md-3{
          
               
            }
            
            
 
            


}

@media screen and (min-width: 800px) and (max-width: 1195px) {
   .col-md-2{
               
               margin-right: 1em;
              
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






<script type="text/javascript"	src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script language="javascript" src="./scripts/campos.js"></script>
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
window.statusbar=' ';
</SCRIPT>

<script language="javascript">
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
</script>
<script language="javascript">
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
</script>
<script language="javascript">
function userElection()
{


}
var login = <%=Integer.parseInt(session.getAttribute("flag").toString())%>
function cancelar(){

	if (login >= 8)
	{
		window.location.href = "<html:rewrite page='/firstLogInSC.jsp'/>";
	}
	if (login == 7)
	{window.location.href = "<html:rewrite page='/mant/AdminIMG.jsp'/>";
		}
}

$(document).ready(function()
{
	$("#forma").submit(function(event) 
	{
		if ($('#file').val() == "") 
		{
			alert("<bean:message key="msg.imagen.carga"/>"); 
			return false; 
		}
	});
});
</script>
<script type="text/javascript" src="imageGallery.js"></script>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
</head>
<body>

<div class="container">


 	 <header style="padding-top: 20px;">
			<img border="0" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/>
		    </header>








<div class="row visible-lg" style="padding-top:110px;">

  <div class="col-md-2"></div>
  <div class="col-md-8">



<div class="panel panel-default">
					 <div class="panel-heading" align="left" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.seleccion.marca.indentidad.personal"/></strong></div>
						 <div class="panel-body" style="">
						 
	  
	  
	  
	        <div class="row">
  <div class="col-md-2"></div>
<div class="col-md-2"><strong><bean:message key="lbl.seleccion.marca.nombre.imagen"/> :</strong></div>

  <div class="col-md-6"><input class="btn btn-default btn-xs"  type="file" name="file" id="file" style=" "/></div>
  <div class="col-md-2"></div>


  
  
  </div>
  
   <br>
	  
	  
	  
	  <logic:present name="msg">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabla-acceso">
	<tr> 
		<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
		<td valign="top">
			<table>
				<tr><td class="bienvenida3"><b><bean:message key="errors.header"/></b></td></tr>
				<tr><td class="bienvenida3">
		        <%String error = session.getAttribute("msg").toString();%>
					<bean:message key="<%=error%>"/></td></tr>
			</table>
		</td>
	</tr>
</table>   
</logic:present>
<%
   session.removeAttribute("msg");
%>

	<br>	

<form id="forma" action='<html:rewrite page="/do.SetImage"/>' method="post" enctype="multipart/form-data" 
           name="productForm" id="productForm">
	  
	  
	  
	  
	  
	  					<div align="center">
										
								
										
										<div class="row">
									
										<div class="col-md-4"></div>
  <div class="col-md-2">	
                                      	<input type="submit" style="width: 110px;" class="btn btn-default" name="Submit" value="<bean:message key="lbl.seleccion.marca.subir"/>">
			  							
			  							</div>
  <div class="col-md-2">	
			  						
			  		
			  <input type="button" class="btn btn-default" style="width: 110px;" onclick="cancelar();" value="<bean:message key='btn.cancelar'/>">
		
									</div>
										<div class="col-md-4"></div>
										
							</div>			

										</div>
										
										<br>
	  
	  
	   <div align="center">
            
				<div style="color:#7f8c8d"><bean:message key="lbl.mensaje.campo.requerido"/></div>
  			</div>
  			<br>
	  
	   </form> 
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
 
						 </div>
				
					</div>
					   <br> 
	
				</div>

<div class="col-md-2"></div>
</div>






 <br>
    
  <br><br>
    
    <br><br>
  <br><br>
  <br>
    
  <br><br>
    
    <br><br>


</div>
</body>

</html:html>
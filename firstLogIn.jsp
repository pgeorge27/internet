<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import = "com.arango.common.beans.UserInfo"%>

<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.aplicar.regla.password", "true");
String role = session.getAttribute("role.user").toString();
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";

%>

<!DOCTYPE html>
<html:html>

<head>

<script language="javascript" src="./scripts/campos.js"></script>
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
<script language="javascript">
function campoChange(campo){
	if(1 == campo){
		Foco = "claveold"
	}else if(2 == campo){
		Foco = "clavenew"
	}else if(3 == campo){
		Foco = "claveconf"
	}
 }


function send(){
    if(validatePass())
    {
      document.forma.oldPassw.value=encripta2(document.forma.oldPassw.value);
	  document.forma.newPassw.value=encripta2(document.forma.newPassw.value);
	  document.forma.confirmPassw.value=encripta2(document.forma.confirmPassw.value);
	  document.forma.submit();
    }
}
function validatePass(){
  if (document.forma.newPassw.value.length < 8 || document.forma.newPassw.value.length > 11){
      alert("<bean:message key="lbl.cambio.clave.observacion1"/>");
      return false;
  }
  return true;    				 
}

function clear(){
      document.forma.oldPassw.value='';
	  document.forma.newPassw.value='';
	  document.forma.confirmPassw.value='';
}

function validateQuestion(){
  	if (document.forma.respuesta1.value == "")
  	{
     	 alert("El campo de respuesta 1 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.respuesta2.value == "")
  	{
     	 alert("El campo de respuesta 2 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.pregunta3.value == "")
  	{
     	 alert("El campo de pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.respuesta3.value == "")
  	{
     	 alert("El campo de respuesta 3 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.pregunta1.value == document.forma.pregunta2.value)
  	{
     	 alert("Las preguntas 1 y 2 deben ser diferentes");
     	 return false;
  	}
  	return true;    				 
}


function validatePreg(campo) {
    var RegExPattern = /([a-zA-Z0-9]{4,10})$/;
    var resp = false;
    var errorMessage = 'Los campos solo pueden contener caracteres alfanumericos y deben poseer mas de 4 caracteres.';
    if ((campo.value.match(RegExPattern)) && (campo.value!='')) {
        resp = true;
    } else {
        alert(errorMessage);
        resp = false;
    }
    return resp;
}


function visita()
{
	document.location = "startv.jsp";
}

var Foco = "claveold";
</script>
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
window.statusbar=' ';
</SCRIPT>
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/teclado.css'/>">
<script type="text/javascript" src="<html:rewrite page='/scripts/tecladoUpdate.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>
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
<body onLoad="reset();" >

<div class="container">






	 <header style="">
			<img border="0" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/>
		    </header>





<logic:present name="msg">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabla-acceso">
	<tr> 
		<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
		<td valign="top">
			<table>
				<tr><td class="bienvenida"><b><bean:message key="errors.header"/></b></td></tr>
				<tr><td class="bienvenida">
		        <%String error = session.getAttribute("msg").toString();%>
					<bean:message key="<%=error%>"/></td></tr>
			</table>
		</td>
	</tr>
</table>   
</logic:present>
<%
   session.removeAttribute("msg");
   UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
%>



<form method="post" action="<html:rewrite page='/do.changefirstpwd'/>" name="forma">


	<div class="row" style="padding-top:110px;">

  <div class="col-md-1"></div>
  <div class="col-md-4">
    
				<div class="panel panel-default" >
					 <div class="panel-heading" align="left" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.token.cambio.usuario.recuerde"/></strong></div>
						 <div class="panel-body" style="padding-right: 12%">
						 
	    <div align="justify">
	          <UL>
	          	<li><bean:message key="lbl.cambio.clave.obs1" /></li>
	          	<li><bean:message key="lbl.cambio.clave.obs2" /></li>
	          	<li><bean:message key="lbl.cambio.clave.obs3" /></li>
	          </UL>
	       </div>
 
						 </div>
				
					</div>
					   <br> 
	
				</div>





  <div class="col-md-1"></div>
  <div class="col-md-4">

  			<div class="panel panel-default" >
					 <div class="panel-heading" align="left" ><img  src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.title.cambio_clave"/></strong></div>
	
			  <html:form action="/change/psw" method="post">	
			   <br>	

						 <div  style="width: 90%; padding-left: 10%;"> 
		 
		               <div class=""><strong><span class="" style="magin-left: 2em;">(<font color="#FF0000">*</font>)</span>&nbsp;<bean:message key="lbl.clave_usuario_anterior"/>:</strong></div>
		 
		
			 <div><html:password property="oldPassw" styleClass="form-control" maxlength="15"   styleId="claveold" /> 
			 </div>
		  </div>
		  <br>

		  
		  	  <div  style="width: 90%; padding-left: 10%;"> 
		  		               <div class=""><strong><span class="texto-acceso" style="magin-left: 2em;">(<font color="#FF0000">*</font>)</span>&nbsp;<bean:message key="lbl.clave_usuario_nueva"/>:</strong></div>
		  
		
			 <div><html:password property="newPassw" styleClass="form-control" maxlength="11"  styleId="clavenew" />
			  
			  
		  </div>
		    </div>
		    
		    
		  <br>

		  	 <div  style="width: 90%; padding-left: 10%;"> 
		 
		               <div class=""><strong><span class="texto-acceso" style="magin-left: 2em;">(<font color="#FF0000">*</font>)</span>&nbsp;<bean:message key="lbl.reescriba_clave_usuario"/>:</strong></div>
		 
		
			 <div><html:password property="confirmPassw" styleClass="form-control" maxlength="11"  styleId="claveconf" /> 
			 </div>
		  </div>
		

					 </html:form>	
					  <br>
					 
					 		   <div align="center">
	<div><bean:message key="lbl.mensaje.campo.requerido"/></div>
  </div>
   <br>
  
   
   
     			<div align="center"> 
<input name="button" onclick="send();" type="button"   class="btn btn-default" style="width: 100px; "  value="<bean:message key="btn.enviar"/>"> 
	  <input name="limpiar" type="reset" onclick="clear();"  class="btn btn-default" style="width: 100px; "  value="<bean:message key="btn.limpiar"/>"> 
	
</div>
 <br>
  <br>
					   </div>
					   </div>
					   </div>
					 
			 <br>
		  		 
					 
					 
			 
					 

		  



		 
		</form>			 
	
	</div>
<footer class="footer">
      <div class="container">
       <%@ include file="footer.jsp" %>
      </div>
    </footer></body></html:html>

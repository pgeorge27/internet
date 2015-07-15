<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import = "com.arango.common.beans.UserInfo"%>

<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
String role = session.getAttribute("role.user").toString();
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";

%>

<!DOCTYPE html>
<html:html>

<head>
<link rel="stylesheet" type="text/css"
	href="<html:rewrite page='/style/flujos.css'/>" />
<script language="javascript" src="./scripts/campos.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
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


function containBlank(){
	var name = document.getElementById("nuevoUsuario").value;
	if(name.indexOf(" ") >=0 ){
		alert("<bean:message key="lbl.token.cambio.usuario.obs5"/>");		
	}
	else{
		document.forms[0].submit();
	}		
}

function validatePass(){
  if (document.forma.newPassw.value.length < 6 || document.forma.newPassw.value.length > 16){
      alert("<bean:message key="lbl.token.cambio.usuario.obs5"/>");
      return false;
  }
  return true;    				 
}

function clear(){
	  document.getElementById("usuarioActual").value="";
	  document.getElementById("nuevoUsuario").value="";
	  document.getElementById("nuevoUsuarioConfirmacion").value="";
}

function send(){
    if(validatePass())
    {
    	document.forms[0].submit();
	}  
}
function validatePass(){
  	if ((document.getElementById("nuevoUsuario").value.length < 6) || (document.getElementById("nuevoUsuario").value.length > 16))
  	{
     	alert("<bean:message key="lbl.token.cambio.usuario.obs5"/>");
     	return false;
  	}
  	else
  	{
  		return true;
  	}
  	 				 
}
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
</head>
<body onLoad="reset();" >

<div class="container">

<html:form method="post"  action="/cambioUsuarioBasico.do">

  	 <header style="padding-top: 20px;">
			<img border="0" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/>
		    </header>


		<div class="row" style="padding-top:110px;">

  <div class="col-md-1"></div>
  <div class="col-md-4">
    
				<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.token.cambio.usuario.recuerde"/></strong></div>
						 <div class="panel-body">
						 
						 
						       <td colspan="2" class="fuente-principal">
	          <UL>
	          	<li><bean:message key="lbl.token.cambio.usuario.obs4"/></li>
	          	<li><bean:message key="lbl.token.cambio.usuario.obs5"/></li>
	          </UL>
	       </td>
 
						 </div>
				
					</div>
					   <br> 
	
				</div>
			
  <div class="col-md-1"></div>
  <div class="col-md-4">

  			<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.token.introduccion.cambioUsuario"/></strong></div>
						
									
					 <br> 
					       <div  style="width: 90%; padding-left: 10%;"> 
            	
              <div class=""><strong><span class="texto-acceso" style="magin-left: 2em;">(<font color="#FF0000">*</font>)</span>&nbsp;<bean:message key="lbl.token.cambio.usuario.usuarioActual"/>:</strong></div>
                <div><html:text property="usuarioActual" styleClass="form-control" maxlength="16"   styleId="usuarioActual" value=""/> 
                </div>
            </div>
            <br>
            <div  style="width: 90%; padding-left: 10%;"> 
          
              <div class=""><strong><span class="texto-acceso" style="magin-left: 2em;">(<font color="#FF0000">*</font>)</span>&nbsp;<bean:message key="lbl.token.cambio.usuario.nuevoUsuario"/>:</strong></div>
                <div><html:text property="nuevoUsuario" styleClass="form-control" maxlength="16"  styleId="nuevoUsuario" value=""/>

            </div>
            </div>
             <br>
         
           <div  style="width: 90%; padding-left: 10%;">  
         
                <div>
	                <div>
	                	 <div><strong><span class="texto-acceso" style="magin-left: 2em;">(<font color="#FF0000">*</font>)</span>&nbsp;<bean:message key="lbl.token.cambio.usuario.confirmeUsuario"/>:</strong></div>
	                </div>
                </div>
                <div><html:text property="nuevoUsuarioConfirmacion" styleClass="form-control" maxlength="16"  styleId="nuevoUsuarioConfirmacion" value=""/> 
           
            </div>
            </div>
              <br> 
            <div align="center">
            
				<div style="color:#7f8c8d"><bean:message key="lbl.mensaje.campo.requerido"/></div>
  			</div>
  			<br>
					</div>
					 <br> 

					</div>
  <div class="col-md-1"></div>

                </div>

<logic:present name="msg">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabla-acceso">
	<tr> 
		<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
		<td valign="top">
			<table>
				<tr><td class="fuente-principal"><b><bean:message key="errors.header"/></b></td></tr>
				<tr><td class="fuente-principal">
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


<br> 
<br> 
	<div align="center">
        <html:hidden  property="pantalla" value="cambioUsuarioSuccess"/>   
        <input name="button" type="button" onClick="containBlank()" class="btn btn-default" style="width: 100px;"  value="<bean:message key="btn.enviar"/>"> 
        <input name="limpiar" type="reset" onClick="clear();" class="btn btn-default" style="width: 100px; margin-left: 2em;"  value="<bean:message key="btn.limpiar"/>"> 
	</div>



</html:form>
</div></div> <br>  <br> </body></html:html>

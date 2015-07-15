<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%
session.setAttribute("flag", "11");
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
<script language="javascript" src="./scripts/ValidaFirmaDigital.js"></script>
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
 return ((kc != 8 ) || ( t == 'text'  ) ||  (t == 'textarea')|| (t =='password') ) 
 }
else
document.onkeypress = function(e)  // FireFox/Others 
 {
 var t=e.target.type;
 var kc=e.keyCode;
 if ((kc != 8 ) || ( t == 'text'  ) ||  (t == 'textarea') || (t =='password'))
     return true
 else {
     return false
 }
}
//-->
</script>

<script language="javascript">
function campoChange(campo){
 if(2 == campo){
document.forma.Foco.value = "clavenew"
}else if(3 == campo){
document.forma.Foco.value = "claveconf"
}
}
function send(){
    if(validatePass())
    {
    	document.forma.submit();
	}  
}

function checkLength(field){
	alert(field);	
}

function validatePass(){
  	if ((document.forma.newPassw.value.length < 4) || (document.forma.newPassw.value.length > 4))
  	{
     	 alert("<bean:message key="lbl.cambio.clave.especial.observacion1"/>");
     	 return false;
  	}else if(!checkVal(document.forma.newPassw.value)){
  		 alert("<bean:message key="lbl.cambio.clave.especial.observacion3"/>");
    	 return false;
  	}
  	return true;    				 
}
var option = "0"; // Solamente teclado numerico   
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




<body onLoad="reset();"  style="padding-top: 30px;" >




  <div class="row">
  <div class="col-md-4"></div>
  <div class="col-md-7"><img border="0" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/></div>
<div class="col-md-1"></div>
  </div>


		

<div class="container" style="padding-top: 10px;" >
<br> 




	

<logic:present name="msg">
<table width="100%" border="0" cellspacing="1" cellpadding="1" class="tabla-acceso" >
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
%>




<br>


		<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.title.cambio.clave.especial"/></strong></div>
  <div class="panel-body">
  
  
  
  
  
  
   <form method="post" action="<html:rewrite page='/do.claveespecial'/>" name="forma">
  
  
  <div class="row">
  <div class="col-md-1"></div>

  <div class="col-md-4"><strong><bean:message key="lbl.clave_anterior"/>:</strong></div>
  <div class="col-md-3"><td align="left"><html:password property="oldPassw" styleClass="form-control" redisplay="false" maxlength="4" styleId="claveold"  /> 
			  </td></div>
  <div class="col-md-4"><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>&nbsp;<td>Utilice el teclado de su computador</td></div>

  
  
  
  </div>
  
  <br>
  

  
  

  
  
  
    <input type="hidden" name="Foco" value="newPassw" id="Foco" >
  
  
      <div class="row">
  <div class="col-md-1"></div>
<div class="col-md-4"><strong>Ingrese su nueva segunda clave o firma virtual:</strong></div>

  <div class="col-md-3"><td><html:password onchange="checkLength(this)" property="newPassw" styleClass="form-control" redisplay="false" onclick="campoChange(2);" styleId="clavenew" onkeypress="javascript: return false;" onkeydown="javascript: return false;" maxlength="4"/> 
			  </td></div>
  <div class="col-md-4"><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>&nbsp;<td>Utilice el teclado virtual de la pantalla</td></div>

  
  
  
  </div>
  


  <br>
  
  
  
  
        <div class="row">
  <div class="col-md-1"></div>

  <div class="col-md-4"><strong><bean:message key="lbl.reescriba_clave"/>:</strong></div>
  <div class="col-md-3"><td><html:password onchange="checkLength(this)" property="confirmPassw" styleClass="form-control" redisplay="false" onclick="campoChange(3);" styleId="claveconf" onkeypress="javascript: return false;" onkeydown="javascript: return false;" maxlength="4"/> 
			</td></div>
  <div class="col-md-4"><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>&nbsp;<td> Utilice el teclado virtual de la pantalla </td></div>

  
  
  
  </div>
    
			<td  align="center"class="texto-acceso">
						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
				</td>

			
		 	

		

		

				<div>
			    	<div  align="left"  colspan="3" >
				    	<div id="teclado">
							<div id="lower" style="display: none;" ></div>
							<div id="upper"></div>
							<div id="cls" align="center"></div>		
						</div>
					</div>
			     </div>
			
		  <tr> 
			<td>&nbsp;</td>
			<td colspan="2"><input name="button" onclick="send();" type="button" class="botton" value="<bean:message key="btn.enviar"/>"> 
			  <input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>"> 
			</td>
		  </tr>
		</table>
	  </form>




  
  </div>
</div>






		<div class="panel panel-default">
 <div class="panel-heading" align="justify" ></div>
  <div class="panel-body">



<div align="center">
<table width="100%" align="left">
<tr>
	<td height="40" valign="bottom" colspan="2">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="100%"><div align="left" class="login"></div></td>
		  </tr>
		</table>
	  </div></td>
</tr>
<tr><td>
<table width="90%" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr> 

  </tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr valign="top">
     <td>
     <!--  Tabla con Cajas -->

     </td>
   <td>
	<!--  Tabla con Tips -->
	<%@ include file="divHeader.jsp"%>
	  <table  cellspacing="3"  >
        <tr valign="top">
      	  <td colspan="2">
      	  <table><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><p class="bienvenida_2"><B><bean:message key="lbl.firma.digital.tips.titulo"/></B></p></td>
	      </tr>
	      </table>
	      </td>
	    </tr>
	    <tr valign="top">
	       <td colspan="2" class="bienvenida_2">
	          <UL>
	          	<li><bean:message key="lbl.cambio.clave.especial.obs1" /></li>
	          	<li><bean:message key="lbl.cambio.clave.especial.obs2" /></li>
	            <li><bean:message key="lbl.cambio.clave.especial.obs3" /></li>
	            <li><bean:message key="lbl.cambio.clave.especial.obs4" /></li>
	          </UL>
	       </td>
	    </tr>
	  </table>

	</td>
     </tr>
  <tr>
	<td height="20" valign="middle" align="center" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table></td></tr>
 <tr>
    <td height="31" colspan="6" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">&copy; 
        <bean:message key="<%=copyrigth %>"  arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div></td>
  </tr>
</table></td></tr></table></div>




  
  </div>
</div>


















</div></body></html:html>
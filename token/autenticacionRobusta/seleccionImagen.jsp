<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.aplicar.regla.password", "true");
session.setAttribute("flag", "9");
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
String descripcion = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "lbl.mant.imagen.obs3" :  "lbl.mant.imagen.obs4";

%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

<style type="text/css">
.texto-acceso2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: normal;
	color:#E96B10;
}
</style>

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
function send(){
//     if(validatePass()){
//       document.forma.oldPassw.value=encripta2(document.forma.oldPassw.value);
// 	  document.forma.newPassw.value=encripta2(document.forma.newPassw.value);
// 	  document.forma.confirmPassw.value=encripta2(document.forma.confirmPassw.value);
// 	  document.forma.submit();
// 	}  
	document.forma.submit();
}

function refreshImage(categoria){
	//location.reload(true);
	//console.info(categoria);
	var target = document.getElementById("imageRefresh").value;
	document.forma.action = target;
	document.getElementById("categoria").value = categoria;
	document.forma.submit();
}

function visita()
{
	document.location = "start.jsp";
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
<script language="JavaScript1.2">
function openVentana(page, name)
{
window.open(page,name,"toolbar=no,location=no,directories=no,status=yes,menubar=no,left=0,scrollbars=yes,resizable=no,copyhistory=no,width=780,height=525")
}
</script>

<script language="javascript">
function userElection()
{


} 
 
</script>

<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>

<jsp:useBean id="marcas" class="com.arango.internet.beans.MarcasIdentidad" scope="page"/>
<%
	int emp = Integer.parseInt(session.getAttribute("codigo.empresa").toString());
	//marcas.setEmpresa(Integer.parseInt(session.getAttribute("codigo.empresa").toString()));
	String pais = "";
	String categoria = "";
	String sessCat = (String)session.getAttribute("categoria");
	if(emp == 1){
		   pais = "Panam&aacute;";
		   categoria = "pa";
	}
	else{
		   pais = "Cayman";
		   categoria = "cay";
	}
	
	 //verificamos si existe categoria en la session
	   if(sessCat == null || sessCat.equals("")){
		   session.setAttribute("categoria", categoria);
		   marcas.setCategoria(categoria);	   
	   }
	   else{
		   session.setAttribute("categoria", null);
		   marcas.setCategoria(sessCat);
	   }   
	
	marcas.carga();
%>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
</head>
<body>

<table id="Table_01" width="95%" height="100%" border="0" cellpadding="0" cellspacing="0">
   <tr> 
        <td><br>
		<table width="100%" border="0" cellpadding="10" cellspacing="0">
			<tr><td align="right" ><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
			<br></td>
    <td>&nbsp;</td>
     
  </tr>
  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF;"><div  class="fuente-principal"><bean:message key="tit.title.atenticacion.paso3"/></div></td>
  </tr>
  <tr valign="top"> 
    <td colspan="4">
    
<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td height="300" valign="middle"><table border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td>
 <br>

<logic:present name="msg">
 <div align="center" class="well">
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
</div>
</logic:present>

<%
   session.removeAttribute("msg");
%>


<div class="container" style="padding-top: 30px;">

<table width="100%" border="0"  cellpadding="0" cellspacing="0">
  
  <tr align="center"> 
  
	<td valign="top" colspan="2" width="100%">
	<table width="100%" align="center"><tr><td>
	<form method="post" action="<html:rewrite page='/token/autenticacionRobusta/UploadPageAutenticacion.jsp'/>" name="forma">
      	<input type="hidden" name="categoria" id="categoria" value="" />
      	<input type="hidden" name="imageRefresh" id="imageRefresh" value="<html:rewrite page='/seleccionImagen'/>.do" />
      	<input type="hidden" name="pantalla" value="seleccionImagen" />
      	

	<div class="panel panel-default" >

		<div class="panel-heading" >
			<img src="<html:rewrite page='/images/logo_icon.png' />" />
			<strong>
				<bean:message key="lbl.imagen.tips.titulo"/>
			</strong>
		</div>

		<div class="panel-body">
			<UL>
				<li><bean:message key="lbl.mant.imagen.obs1" /></li>
				<li><bean:message key="<%=descripcion %>" /></li>
			</UL>
		</div>
	</div>

	
	<!-- Inicio del Div -->
<table width="100%"  border="0" cellpadding="0" cellspacing="0">

  <tr>

	<td>
	<!-- Colocar Contenido Aqui -->	
	<div class="panel panel-default">
	  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	   <tr>
	   	<td valign="top" width="19%">
	   		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	   			<tr>
	   				<td colspan="2">&nbsp;</td>
	   			</tr>
	   			<tr>
	   				<td width="10%">&nbsp;</td>
	   				<td width="90%">
	   					<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('<%=categoria %>');">
				   						<div class="texto-acceso2" align="left"><%=pais %></div>
			   						</a>
			   					</td>
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('ani');">
				   						<div class="texto-acceso2" align="left">Animales</div>
				   					</a>	
		   						</td>			   					
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('arq');">
				   						<div class="texto-acceso2" align="left">Arquitectura</div>
			   						</a>
			   					</td>
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('dep');">
				   						<div class="texto-acceso2" align="left">Deportes</div>
			   						</a>
			   					</td>
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('nat');">
				   						<div class="texto-acceso2" align="left">Naturaleza</div>
			   						</a>
			   					</td>
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="send()">
				   						<div align="left" class="texto-acceso2">Personalizar</div>
			   						</a>
<%-- 			   					<input name="Personaliza"  type="button" class="botton" value="<bean:message key="btn.seleccion.marca.identidad.personal"/>"  onclick="submit();"> --%>
			   					</td>
				   			</tr>
	   					</table>
	   				</td>
	   			</tr>	   			
	   		</table>
	   		
	   	</td>
	   	<td width="1%" background="<html:rewrite page='/images/div/left-center.gif'/>">&nbsp;</td>	   
	    <td width="80%" colspan="2">
		    <table width="100%" border="0" cellpadding="0">
			  <tr align="center">
					<c:forEach var="imagen" items="${marcas.imagenes}" varStatus="rowCounter">
						<c:if test="${rowCounter.count % 4 == 1 && rowCounter.count>1}">			    
							</tr>
							<c:if test="${rowCounter.count <= marcas.total}">
							   <tr align="center">
							</c:if>
						</c:if>
						<td width="20">
						  <a href="do.SetImageAutenticacion?id=<c:out value='${imagen}'/>">
						   <img class="img-responsive" src="do.GetImage?id=<c:out value="${imagen}"/>&img=ch" width="100" height="100" border="0" />
						   </a>
						</td>
					</c:forEach>
		   </tr>
		   </table>
		</td>
	   </tr>
<!-- 	   <tr> -->
			
<!-- 			<td  align="center" style=" width : 350px;"> -->
<%-- 			<input name="Personaliza"  type="button" class="botton" value="<bean:message key="btn.seleccion.marca.identidad.personal"/>"  onclick="submit();"> --%>
<!-- 			</td>  -->
			   
<!--   </tr> -->
		</table>
		
		

		
	  </form></td></tr>
	  </table>  
	  </td>
  </tr>
  <tr>
	<td height="20" valign="middle" class="texto-acceso"></td>
  </tr>
</table></div>
</td></tr></table>
</div>
</td></tr>


</table></td></tr></table>

</body></html>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.aplicar.regla.password", "true");
String role = session.getAttribute("role.user").toString();
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
String clienteExiste = (String)session.getAttribute("cliente.existe");
%>


<html>
<head>

<script language="javascript" src="./scripts/campos.js"></script>
<script type="text/javascript">

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


	function evaluar()
	{       
		var radioButtons = document.getElementsByName("selection");

		for (var i=0; i < radioButtons.length; i++)
		   {           
		   if (radioButtons[i].checked)
		      {
			   document.forms[0].action = radioButtons[i].value;
			   document.getElementById("pantalla").value = radioButtons[i].id

		      }
		   }	   
	}  


</script>

<script language="javascript">


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

<script type="text/javascript" src="imageGallery.js"></script>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>

<jsp:useBean id="marcas" class="com.arango.internet.beans.MarcasIdentidad" scope="page"/>
<%
   marcas.setEmpresa(Integer.parseInt(session.getAttribute("codigo.empresa").toString()));
   marcas.carga();
%>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
   <tr> 
        <td><br>
		<table width="100%" border="0" cellpadding="10" cellspacing="0">
			<tr><td align="right" ><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
			<br></td>
    <td>&nbsp;</td>
     
  </tr>
  <tr>
  <% if(clienteExiste.equals("n")) { %> 
    	<td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF;"><div  class="fuente-principal"><bean:message key="tit.title.atenticacion.paso2"/></div></td>
  <% } else { %>
  		<td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF;"><div  class="fuente-principal"><bean:message key="lbl.login.cliente.existente2"/></div></td>
  <%} %>  
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
<div > 
<table width="100%" border="0"  cellpadding="0" cellspacing="0">

  <tr><td height="20" > </td></tr>
  <tr align="center"> 
  
	<td valign="top" colspan="2" width="80%">
	<table width="100%" align="center"><tr><td>
	<html:form method="post" action="/personalizarUsuario.do">	
		<table cellspacing="3" cellpading="3" align="center" width="90%">
			<tr>
				<td>
					<img src="<html:rewrite page='/images/gancho.gif'/>" border="0">
				</td>
				<td align="left" class="fuente-titulo">
					<bean:message key="lbl.token.introduccion.cambioUsuario"/>
				</td>
			</tr>
			<tr>
				<td></td>
				<td class="fuente-principal">
					<bean:message key="lbl.token.cambio.usuario.obs1"/><br/>
					<bean:message key="lbl.token.cambio.usuario.obs2"/><br/>
					<input checked="checked" type="radio" value="do" name="seleccion" /> <bean:message key="lbl.afirmacion"/> 
					<input type="radio" value="skip" name="seleccion" /> <bean:message key="lbl.negacion"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<html:hidden styleId="pantalla" property="pantalla" value="personalizarUsuario" />
					<input type="submit" class="botton" value='<bean:message key="lbl.token.cambio.usuario.boton1" />'/>	  		
				</td>
			</tr>
		</table>
	</html:form>
	  </td></tr>
	  </table>
	  </td>
  </tr>
  <tr>
	<td height="20" valign="middle" class="texto-acceso"></td>
  </tr>
</table></div>
</td></tr></table></td></tr>






</table></td></tr>
<tr>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;">
		<div align="center" class="derechos">
			<bean:message key="<%=copyrigth %>" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
		</div>
	</td>
 </tr>
</table></body></html>


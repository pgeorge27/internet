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
		var radioButtons = document.getElementsByName("cambiarUsuario");

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
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">



<div class="container" style="padding-top:20px">

   	 <header>
			<img border="0" class="img-responsive" alt="Responsive image" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/>
		    </header>
<br>
<br>


<br>

		<div class="row" style="padding-top: 10%; padding-left: 3%; padding-right: 3%;">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.token.introduccion.cambioUsuario"/></strong></div>

					  <div class="panel-body">

	<logic:present name="msg">
	<div>
	
			<div valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></div>
			<div>
				<div>
					<div class="fuente-principal"><b><bean:message key="errors.header"/></b></div>
					<div class="fuente-principal">
					<%String error = session.getAttribute("msg").toString();%>
						<bean:message key="<%=error%>"/></div>
				</div>
			</div>

	</div>   
	</logic:present>
	<%
	   session.removeAttribute("msg");
	%>
	<div> 

								<html:form method="post" action="/cambioUsuarioBasico.do">
								
														
													<div>
												
														<div>
															<bean:message key="lbl.token.cambio.usuario.obs1"/><br/>
															<br>
															<div style="text-align: center;"><strong><bean:message key="lbl.token.cambio.usuario.obs2"/><br/></strong></div>
															<br>
															
																<div style="text-align: center;">
															<input type="radio" value="<html:rewrite page='/cambioUsuarioBasico.do' />" id="cambioUsuarioForm" name="cambiarUsuario" onclick="evaluar();" checked="checked"/> <bean:message key="lbl.afirmacion"/> 
															<input type="radio" value="<html:rewrite page='/cambioUsuarioBasico.do' />"	   id="cambioImagen"  name="cambiarUsuario" onclick="evaluar();"/> <bean:message key="lbl.negacion"/>
															</div>
														</div>
													</div>
													<div>
													<br>
													<br>
														<div align="center">
															<html:hidden styleId="pantalla" property="pantalla" value="cambioUsuarioForm"/>
															<input type="submit" value='<bean:message key="lbl.token.cambio.usuario.boton1"/>' class="btn btn-default"/>	  		
														</div>
															
									</div>
								</html:form>
	



</div>
</div>
</div>
</div>
</div>
</div>
</div>






<footer class="footer">
      <div class="container">
       <%@ include file="footer.jsp" %>
      </div>
    </footer>



</body>

</html:html>



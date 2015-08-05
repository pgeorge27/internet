<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.aplicar.regla.password", "true");
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

<script type="text/javascript"	src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script language="javascript" src="<html:rewrite page='/scripts/campos.js'/>"></script>
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

// 	if (login >= 8)
// 	{
// 		window.location.href = "<html:rewrite page='/firstLogInSC.jsp'/>";
// 	}
// 	if (login == 7)
// 	{window.location.href = "<html:rewrite page='/mant/AdminIMG.jsp'/>";
// 		}
	document.forma.action =  "<html:rewrite page='/seleccionImagen.do'/>";
	document.forma.submit();
	

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
<!--<script type="text/javascript" src="imageGallery.js"></script>-->
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
</head>
<body>

	<div class="container"> 
		<div class="row" style="padding-right: 3%; padding-left: 3%;">

			<div align="right">
				<img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
			</div>
			<br>
			<br>
			<div height="26" width="100%" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
				<div  class="fuente-principal">
					<bean:message key="tit.title.atenticacion.paso3"/>
				</div>
			</div>
			<br>
			<br>
			<logic:present name="msg">
				<div align="center" class="well col-md-4">
					<p><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>"></p>
					<p><b><bean:message key="errors.header"/></b></p>
					<p class="fuente-principal">
						<%String error = session.getAttribute("msg").toString();%>
					<bean:message key="<%=error%>"/></p>
				</div>
			</logic:present>
			<%
				session.removeAttribute("msg");
			%>

			<div class="col-md-4 col-md-offset-4">
				<div class="panel panel-default" >
					<div class="panel-heading">
						<img src="<html:rewrite page='/images/logo_icon.png' />" />
						<strong>
							<bean:message key="tit.seleccion.marca.indentidad.personal"/>
						</strong>
					</div>
					<div class="panel-body">
						<p>
							<bean:message key="lbl.token.cambio.usuario.obs3" />
						</p>

						<div align="center">
							<form name="forma" id="forma" action='<html:rewrite page="/do.SetImageAutenticacion"/>' method="post" enctype="multipart/form-data">
								<bean:message key="lbl.seleccion.marca.nombre.imagen"/>
								<input  class="btn " type="file" name="file" id="file"/>
								<input type="submit" class="btn btn-default" name="Submit" value="<bean:message key="lbl.seleccion.marca.subir"/>">
								<input type="button" class="btn btn-default" onclick="cancelar();" value="<bean:message key='btn.cancelar'/>">
							</form>
							<p><bean:message key="lbl.mensaje.campo.requerido"/></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>
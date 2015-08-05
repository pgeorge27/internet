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


<html>
<head>
	<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> -->
	<script type="text/javascript" src="<html:rewrite page='/scripts/jquery-latest.min.js'/>"></script>
	<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
	<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

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
   
setTimeout("window.close()", 5000);
   
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
<body>

<div class="container">
	<div class="row" style="padding-right: 3%; padding-left: 3%;">

		<div align="right">
			<img class="img-responsive" border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
		</div>

		<div class="col-md-4 col-md-offset-4">
			<div class="panel panel-default" >
				<div class="panel-heading">
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>Operaci&#243;n realizada</strong>
				</div>
				<div class="panel-body">
					<logic:present name="msg">

					<p class="bienvenida3">
						<b><bean:message key="errors.header"/></b>
					</p>
					<p class="bienvenida3">
						<%String error = session.getAttribute("msg").toString();%> <bean:message key="<%=error%>"/>
					</p>
					</logic:present>
					<%
						session.removeAttribute("msg");
					%>

					<html:form method="post" action="/preguntaSeguridad.do">
						<p class="bienvenida_2">
							<bean:message key="lbl.token.mensage.logout"/>
						</p>
					</html:form>

				</div>
			</div>
		</div>

	</div>
</div>

</body>
</html>


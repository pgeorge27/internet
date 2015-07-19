<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%@ page import="com.arango.common.util.valueList.KeyValuePair" %>
<%@ page import="com.arango.common.delegate.Manager" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>

<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.aplicar.regla.password", "true");
String role = session.getAttribute("role.user").toString();
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
Manager man = new Manager();
String  paso		 = man.getUserFlag(session.getAttribute("user.id").toString())==ConstantesGlobales.ACTUALIZACION_INFORMACION ? "tit.title.first.login.paso6" :  "tit.title.atenticacion.paso7";
%>


<html>
<head>
<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> -->
	<script type="text/javascript" src="<html:rewrite page='/scripts/jquery-latest.min.js'/>"></script>
	<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
	<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">


<link rel="stylesheet" type="text/css"
	href="<html:rewrite page='/style/flujos.css'/>" />
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
<body>
<div class="container">
	<div class="row">

		<div align="right">
			<img class="img-responsive" border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
		</div>

		</br>
		</br>
		<div height="26" width="100%" align="right" style="height:26;background-color:#EFEFEF;">
			<bean:message key="<%=paso%>"/>
		</div>

		</br>
		</br>

		<div class="col-md-4 col-md-offset-4">
			<div class="panel panel-default" >
				<div class="panel-heading">
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<!-- TItulo del panel header -->
					</strong>
				</div>
				<div class="panel-body">

				<logic:present name="msg">
				<div>
					<img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8">
					<p><b><bean:message key="errors.header"/></b></p>
					<p>
						<%String error = session.getAttribute("msg").toString();%>
						<bean:message key="<%=error%>"/>
					</p>
				</div>

				</logic:present>
				<%
					session.removeAttribute("msg");
				%>
				<html:form method="post" action="/cargaInformacion.do">
					<p><bean:message key="lbl.actualiza.datos.usuario.titulo" /></p>
					<p><bean:message key="lbl.actualiza.datos.usuario.intro" /></p>
					<p><html:hidden  property="pantalla" value="formulario"/></p>
					<div align="center">
						<input type="submit" class="btn btn-default" value='<bean:message key="lbl.token.cambio.usuario.boton2" />' />
					</div>
				</html:form>
			</div>
        </div>
	</div>
</div>

		<!-- empieza cinta con derechos reservados -->
<div align="center" class="derechos" style="width:100%;height:31;background-color:#4D4F53;">
	<bean:message key="<%=copyrigth %>" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
</div>


</body>
</html>


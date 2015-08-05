<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import = "com.arango.common.beans.UserInfo"%>
<%@ page import = "com.arango.common.services.ManagerBean"%>
<%@ page import = "com.arango.common.beans.PreguntaUsuario"%>
<%@ page import = "java.util.ArrayList"%>

<!-- esto es lo que venia de head.jsp -->

<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
java.util.Calendar cal2 =  java.util.Calendar.getInstance();

%>


<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

<SCRIPT LANGUAGE="JavaScript">
<!--
var da = (document.all) ? 1 : 0;
var pr = (window.print) ? 1 : 0;
var mac = (navigator.userAgent.indexOf("Mac") != -1);

function printPage2() {  
  if (pr){ // NS4, IE5    
	window.print();
  }	
  else if (da && !mac){ // IE4 (Windows)    
    vbPrintPage();
  }
}

function hideElement(){    
    if (document.getElementById){
    	var obj = document.getElementById("bankdiv"); 
    	var bdj = document.getElementById("bk2");
		if (obj)
			obj.style.display = 'none';
		if (bdj)
			bdj.style.display = 'none';
    }
    else{
        name.style.display = 'none';
    }

}
function showElement(){
    if (document.getElementById){    
    	var obj = document.getElementById("bankdiv");
    	var bdj = document.getElementById("bk2"); 
		if (obj)
			obj.style.display = '';
		if (bdj)
			bdj.style.display = '';
    }
    else{
        name.style.display = '';
    }
}

function printPage3() {
  var obj;
  if (document.getById){
	obj = document.getElementById("printHeader1");
  }    
  else{
    obj = printHeader1;
  }
  
  if (obj){
	obj.style.display ="none";
  }
  hideMenu();
	showElement();
  if (pr){ // NS4, IE5    
	window.print();
  }	
  else if (da && !mac){ // IE4 (Windows)    
    vbPrintPage();
  }
  if (obj){
    obj.style.display = "";
  }
  showMenu();
	hideElement();
}

if (da && !pr && !mac) with (document) {
  writeln('<OBJECT ID="WB" WIDTH="0" HEIGHT="0" CLASSID="clsid:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>');
  writeln('<' + 'SCRIPT LANGUAGE="VBScript">');
  writeln('Sub window_onunload');
  writeln('  On Error Resume Next');
  writeln('  Set WB = nothing');
  writeln('End Sub');
  writeln('Sub vbPrintPage');
  writeln('  OLECMDID_PRINT = 6');
  writeln('  OLECMDEXECOPT_DONTPROMPTUSER = 1');
  writeln('  OLECMDEXECOPT_PROMPTUSER = 2');
  writeln('  On Error Resume Next');
  writeln('  WB.ExecWB OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER');
  writeln('End Sub');
  writeln('<' + '/SCRIPT>');
}

// -->
</SCRIPT>

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
</SCRIPT>
<script language="JavaScript">

function ventanaAyuda(texto)
{
     link=texto+".htm";
     win1=open(link,'AYUDA', 'toolbar=no menubar=no personalbar=no locationbar=no resizable statusbar=no scrollbars=yes width=240 height=480');
     if (!win1.closed)
       {
         win1.focus();
       }
}
function regresar(){
	window.history.back(1);
}
</script>


<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/estilo.css'/>">
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/newlf.css '/>">
<script src="<html:rewrite page='/scripts/xaramenu.js' />"></script>


<!-- termina lo de head -->

<%
	session.setAttribute("no.aplicar.regla.password", "true"); 
	UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
%>


<script language="javascript" src="../../scripts/campos.js"></script>
<script language="javascript">
function send(){
    if(validateQuestion())/* && validatePreg(document.forma.respuesta1)
    		&& validatePreg(document.forma.respuesta2) && validatePreg(document.forma.respuesta3) && validatePreg(document.forma.pregunta3))*/
    {
  		document.forma.submit();
    }  
}

function validateQuestion(){
	var tem1;
	var tem2;
	/*if (document.forma.pregunta1.value == "-1")
	{
		alert("Debe seleccionar la pregunta 1");
		return false;
	}*/
  	if (document.forma.respuesta1.value == "")
  	{
     	 alert("El campo de respuesta 1 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirma1.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 1 no puede estar vacio");
     	 return false;
  	}  	
  	tem1 =document.forma.respuesta1.value;
  	tem2 =document.forma.confirma1.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
		 alert("La respuesta a la pregunta 1 no coincide con la confirmación");
		 return false;
	}
	/*if (document.forma.pregunta2.value == "-1")
	{
		alert("Debe seleccionar la pregunta 1");
		return false;
	}*/
  	if (document.forma.respuesta2.value == "")
  	{
     	 alert("El campo de respuesta 2 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirma2.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 2 no puede estar vacio");
     	 return false;
  	}
  	
  	tem1 =document.forma.respuesta2.value;
  	tem2 =document.forma.confirma2.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
		 alert("La respuesta a la pregunta 2 no coincide con la confirmación");
		 return false;
  	}
  	if (document.forma.pregunta3.value == "")
  	{
     	 alert("El campo de pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirmapreg3.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	
  	tem1 =document.forma.confirmapreg3.value;
  	tem2 =document.forma.pregunta3.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
     	 alert("La pregunta 3 y su confirmación no contienen los mismos valores, verifique.");
     	 return false;
  	}
  	if (document.forma.respuesta3.value == "")
  	{
     	 alert("El campo de respuesta 3 no puede estar vacio");
     	 return false;
  	}
  	
  	if (document.forma.confirma3.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	tem1 =document.forma.respuesta3.value;
  	tem2 =document.forma.confirma3.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
		 alert("La respuesta a la pregunta 3 no coincide con la confirmación");
		 return false;
  	}
	 	
  	return true;    				 
}
</script>

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
					<bean:message key="tit.title.atenticacion.paso6"/>
				</div>
			</div>
			<br>
			<br>
			<logic:present name="msg">
				<div align="center" class="well col-md-4">
					<p><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>"></p>
					<p><b><bean:message key="errors.header"/></b></p>
					<p class="fuente-principal">
						<%
						String errors[] = session.getAttribute("msg").toString().split(";");
						for(int i=0; i<errors.length; i++){
						%>
						- <bean:message key="<%=errors[i] %>"/>

						<% out.println("<BR>"); }
						%>
					</p>
				</div>
			</logic:present>
			<%
			session.removeAttribute("msg");
			ManagerBean mb = new ManagerBean();
			%>

			<div class="col-md-4 col-md-offset-1">
				<div class="panel panel-default" >
					<div class="panel-heading">
						<img src="<html:rewrite page='/images/logo_icon.png' />" />
						<strong><bean:message key="lbl.pregunta.tips.titulo"/></strong>
					</div>
					<div class="panel-body">
						<ul>
							<li><bean:message key="lbl.preg.secreta.obs1"/></li>
							<li><bean:message key="lbl.preg.secreta.obs2"/></li>
							<li><bean:message key="lbl.preg.secreta.obs3"/></li>
							<li><bean:message key="lbl.preg.secreta.obs6"/></li>
							<li><bean:message key="lbl.preg.secreta.obs7"/></li>
						</ul>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="panel panel-default" >
					<div class="panel-heading">
						<img src="<html:rewrite page='/images/logo_icon.png' />" />
						<strong>
							<bean:message key="lbl.preg.secreta.titulo1b"/>
						</strong>
					</div>
					<div class="panel-body">

						<form name="forma" action="<html:rewrite page='/do.preguntastoken'/>" method="post">
							<%
								if (session.getAttribute("pregOK") != null)
								{
							%>
							<%
									session.removeAttribute("pregOK");
								}
							%>
							<p>
								1. <bean:message key="lbl.preg.secreta1"/>
							</p>
							<p>
								<select class="form-control" name="pregunta1">
									<option value="-1"><bean:message key="lbl.seleccion.pregunta"/></option>
									<%
									ArrayList lista = mb.getPreguntasCuestionario(userInfo);
									PreguntaUsuario pregunta = null;
									int preg1 = Integer.parseInt((request.getParameter("pregunta1")==null || request.getParameter("pregunta1").equals(""))?"0":request.getParameter("pregunta1"));
									int preg2 = Integer.parseInt((request.getParameter("pregunta2")==null || request.getParameter("pregunta2").equals(""))?"0":request.getParameter("pregunta2"));
									String preg3 = (request.getParameter("pregunta3")!=null)?request.getParameter("pregunta3"):"";
									String respuesta1 = (request.getParameter("respuesta1")!=null)?request.getParameter("respuesta1"):"";
									String respuesta2 = (request.getParameter("respuesta2")!=null)?request.getParameter("respuesta2"):"";
									String respuesta3 = (request.getParameter("respuesta3")!=null)?request.getParameter("respuesta3"):"";


									for (int i=0; i<10; i++)
									{
									pregunta = (PreguntaUsuario)lista.get(i);
									String selected = (preg1==pregunta.getCodigoPregunta()) ? " selected " : "";
									out.println("<option value=\"" + pregunta.getCodigoPregunta() + "\""+ selected + ">");
									if (pregunta.getNombreEtiqueta() != null){
									%>	
									<bean:message key="<%=pregunta.getNombreEtiqueta() %>"/>
									<%
									}else
									out.print(pregunta.getDescripcionPregunta());
									out.print("</option>");
									}
									%>
								</select>
							</p>
							<p>
								<bean:message key="lbl.resp.secreta1"/>
							</p>
							<p>
								<input name="respuesta1" type="text" class="caja-acceso form-control" size="20" maxlength="50" value="<%=respuesta1 %>" >
							</p>
							<p>
								<bean:message key="lbl.preg.secreta.conf.resp"/>
							</p>
							<p>
								<input name="confirma1" type="text" class="caja-acceso form-control" size="20" maxlength="50" value="<%=respuesta1 %>" >
							</p>
							<p>
								<span class="texto-acceso">
									<bean:message key="lbl.preg.secreta.rango"/>
								</span>
							</p>
							<p>
								2. <bean:message key="lbl.preg.secreta2"/>
							</p>
							<p>
								<select class="form-control" name="pregunta2">
									<option value="-1"><bean:message key="lbl.seleccion.pregunta"/></option>
									<%
									for (int i=0; i<10; i++)
									{
									pregunta = (PreguntaUsuario)lista.get(i+10);
									String selected = (preg2==pregunta.getCodigoPregunta()) ? " selected " : "";
									out.println("<option value=\"" + pregunta.getCodigoPregunta() + "\""+ selected + ">");
									if (pregunta.getNombreEtiqueta() != null){
									%>	
									<bean:message key="<%=pregunta.getNombreEtiqueta() %>"/>
									<%
									}else
									out.println(pregunta.getDescripcionPregunta());
									out.print("</option>");
									}
									%>
								</select>
							</p>

							<p>
								<bean:message key="lbl.resp.secreta2"/>
							</p>
							<p>
								<input name="respuesta2" type="text" class="caja-acceso form-control" size="20" maxlength="50" value="<%=respuesta2 %>">
							</p>
							<p>
								<bean:message key="lbl.preg.secreta.conf.resp"/>
							</p>
							<p>
								<input name="confirma2" type="text" class="caja-acceso form-control" size="20" maxlength="50" value="<%=respuesta2 %>">
							</p>
							<p>
								<span class="texto-acceso">
									<bean:message key="lbl.preg.secreta.rango"/>
								</span>
							</p>
							<p>
								3. <bean:message key="lbl.preg.secreta3"/>
								<span class="texto-acceso">
									<bean:message key="lbl.preg.secreta.rango"/>
								</span>
							</p>
							<p>
								<bean:message key="lbl.preg.secreta3.texto"/>
							</p>
							<p>
								<input name="pregunta3" type="text" class="caja-acceso form-control" size="40" maxlength="50" value="<%=preg3 %>">
							</p>
							<p>
								<bean:message key="lbl.preg.secreta3.confirm"/>
							</p>
							<p>
								<input name="confirmapreg3" type="text" class="caja-acceso form-control" size="40" maxlength="50" value="<%=preg3 %>">
							</p>
							<p>
								<bean:message key="lbl.resp.secreta3"/>
							</p>
							<p>
								<input name="respuesta3" type="text" class="caja-acceso form-control" size="20" value="<%=respuesta3 %>">
							</p>
							<p>
								<bean:message key="lbl.preg.secreta.conf.resp"/>
							</p>
							<p>
								<input name="confirma3" type="text" class="caja-acceso form-control" size="20" value="<%=respuesta3 %>">
							</p>

							<div align="center">
								<input name="button" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.enviar"/>">
								<input name="Submit2" type="reset" class="btn btn-default" value="<bean:message key="btn.limpiar"/>">
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>



</body>
</html>
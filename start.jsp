<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales"%>
<%@ page import="com.arango.common.beans.PerfilXML"%>
<%@ page import="com.arango.common.beans.Cliente"%>
<%@ page import="com.arango.common.beans.ClaveEspecial"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.arango.common.sql.*"%>
<%@ page import="com.arango.internet.beans.*" %>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.arango.common.beans.Cuenta"%>
<%@ page import="com.arango.internet.banking.Vencimiento"%>
<%@page import="com.arango.common.beans.Parametro"%>
<%@page import="com.arango.common.delegate.Manager"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.arango.internet.banking.dian.Formulario"%>
<%!com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();%>
<%
	Parametro paran = new Parametro();
	paran = paran.getParametros();
	
	PerfilXML p2 = (PerfilXML) session.getAttribute("perfil.xml");
	if (p2 == null)
		pageContext.forward("/index.jsp");
	String nom = "";
	nom = p2.getNombre();
	
	session.setAttribute("selected", "inicio");
%>

<%
	try {
%> <%@ include file="head.jsp"%> <%
 	} catch (Exception e) {
 		;
 	}
%>

<!DOCTYPE html>
<html:html>
<head>

<style>
a.ln, a.ln:active,a.ln:link,a.ln:visited, a.ln:hover {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #004284;
	text-decoration: none;
}
a.ln:hover {
	text-decoration: underline;
}
.infoMensaje {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #ff4d5d;
	font-weight:bold;
	text-align: justify;
	}
.messagesstyle {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight:bold;
	text-align: justify;
	}
</style>

<STYLE type="text/css">
.okButton {
	background-color: #D4D4D4;
	font-color: #000000;
	font-size: 9pt;
	font-family: arial;
	width: 70px;
	height:	20px;  
}
.alertTitle {
	background-color: #3C56FF;
	font-family: arial;
	font-size: 9pt;
	color: #FFFFFF;
	font-weight: bold;
}
.alertMessage {
	font-family: arial;
	font-size: 9pt;
	color: #000000;
	font-weight: normal;
}
.alertBoxStyle {
	cursor: default;
	filter: alpha(opacity=90);
	background-color: #f9f9f9;
	position: absolute;
	top: 200px;
	left: 200px;
	width: 100px;
	height: 50px;
	visibility:hidden; z-index: 999;
	border-style: groove;
	border-width: 5px;
	border-color: #FFFFFF;
	text-align: center;
}
</STYLE>

<div id="alertLayer" class=alertBoxStyle></div>
<SCRIPT LANGUAGE="JavaScript">

function BrowserCheck() {

	var b = navigator.appName;
	if (b == "Netscape") this.b = "NS";
	else if (b == "Microsoft Internet Explorer") this.b = "IE";
	else this.b = b;
	this.v = parseInt(navigator.appVersion);
	this.NS = (this.b == "NS" && this.v>=4);
	this.NS4 = (this.b == "NS" && this.v == 4);
	this.NS5 = (this.b == "NS" && this.v == 5);
	this.IE = (this.b == "IE" && this.v>=4);
	this.IE4 = (navigator.userAgent.indexOf('MSIE 4')>0);
	this.IE5 = (navigator.userAgent.indexOf('MSIE 5')>0);
	if (this.IE5 || this.NS5) this.VER5 = true; else this.VER5 = false;
	if (this.IE4 || this.NS4) this.VER4 = true; else this.VER4 = false;
	this.OLD = (! this.VER5 && ! this.VER4) ? true : false;
	this.min = (this.NS||this.IE);
}

function hideAlert(){
	alertBox.visibility = "hidden";
}

function makeAlert(aTitle,aMessage){

	is = new BrowserCheck();
	alertBox = (is.VER5) ? document.getElementById("alertLayer").style
	: (is.NS) ? document.layers["alertLayer"]
	:document.getElementById("alertLayer").style;
	
	document.all.alertLayer.innerHTML = "<table border=0 width=100% height=100%>" +
	"<tr><td width=3></td><td width=10 align=left></td><td align=left class=alertMessage>" + aMessage + "<BR></td><td width=5></td></tr>" + 
	"<tr height=5><td width=5></td></tr>" +
	"<tr><td width=3></td><td colspan=2 align=center><input type=button value='Aceptar' onClick='hideAlert()' class=okButton><BR></td><td width=5></td></tr>" +
	"<tr height=3><td width=5></td></tr></table>";
	
	thisText = aMessage.length;
	if (aTitle.length > aMessage.length){ thisText = aTitle.length; }
	
	aWidth = 500;
	aHeight = 270;
	
	var w=window.innerWidth
	|| document.documentElement.clientWidth
	|| document.body.clientWidth;

	var h=window.innerHeight
	|| document.documentElement.clientHeight
	|| document.body.clientHeight;

	alertBox.width = aWidth;
	alertBox.height = aHeight;

	alertBox.left = (w- aWidth)/2;
	alertBox.top = (h - aHeight)/2;

	alertBox.visibility = "visible";
}
</SCRIPT>

</head>

<body>



<%
	try {
%> <%@ include file="body.jsp"%> <%
 	} catch (Exception e) {
 		;
 	}
 %>




<div class="container">

<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
<tr valign="top">
	<td width="500px" height="40">
        <div class="row">
        
          <div class="col-md-8"><bean:message key="tit.bienvenida"/><strong>: <%=nom%></strong></div>
          <div class="col-md-4"></div>
    
		</div>
			<br>
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
		<%
		String var = session.getAttribute("validacion.dias") != null ? session
			.getAttribute("validacion.dias").toString() : "1";
		
		String diasDian = session.getAttribute("validacion.dias.dian") != null ? session
			.getAttribute("validacion.dias.dian").toString() : "d";
		
		if (var != "1") {
		%>
	

				
				
				
			     <div class="row">
        
          <div class="col-md-8"><div class="panel panel-default">
 <div class="panel-heading" align="justify" ></div>
  <div class="panel-body">


   <h6 align="justify"><strong><bean:message key="lbl.compensacion.leyenda"/>: &nbsp;<%=var.substring(1, var.length() - 1)%></strong></h6>
  
  </div>
</div></div>
          
          
          <div class="col-md-4">
          
          
          
          <div class="panel panel-default">
 <div class="panel-heading" align="justify" ></div>
  <div class="panel-body">


   <h6 align="justify"><%=paran.getmensage_postit() != null ? paran.getmensage_postit() : ""%></h6>
  
  </div>
</div>
          
          
          
          
          
          
          </div>
    
		</div>	
				
		
		
		<%
	  	}
	  	if (diasDian != "d") {
		%>
			<tr>
				<td>
				<div align="center">     
					<table width="100%" border="0" cellspacing="2" cellpadding="2" class="tabla-acceso1">
						<tr> 
							<td width="100%" rowspan="2">
							<div align="center"> 
							<table width="100%" border="0" cellspacing="2" cellpadding="2" aling="center">                               
								<tr> 
									<td width="68%" class="bienvenida"><b><%=diasDian.substring(1, diasDian.length() - 1)%></b></td>	 
								</tr> 
							</table>
							</div>
							</td>
						</tr>
					</table>
				</div>
				</td>
			</tr>
		<%
	  	}	
		%>
		

		<csic:clave-especial/>
		<%
		if ("true".equals(session.getAttribute("mostrar.mensaje.clave.especial"))
			&& session.getAttribute("clave.secundaria") != null) {
			
			ClaveEspecial clave = (ClaveEspecial) session.getAttribute("clave.secundaria");
			if (ConstantesGlobales.PRIMER_LOGIN == clave.getFlag()) {
		%>
			<tr>
				<td class="bienvenida_3" colspan="2"><bean:message key="lbl.clave.especial.cambiar"/>
					<a href="<html:rewrite page='/ib/cambioClaveEspecial.jsp'/>">
					<bean:message key="lbl.clave.especial.click.aqui"/></a>
				</td>
			</tr>
		<%
			} else if (ConstantesGlobales.CLAVE_BLOQUEADA.equals(clave.getEstado())) {
		%>
			<tr>
				<td class="bienvenida" colspan="2">
					<table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
						<tr>
							<td>
							<table border="0" cellpadding="1" cellspacing="0" width="100%">
								<tr valign="top">
									<td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
									<td width="95%" class="bienvenida">
										<bean:message key="lbl.clave.especial.bloqueada"/><br>
										<bean:message key="lbl.clave.especial.mensaje"/>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		<%
	 	 	} else if (ConstantesGlobales.CLAVE_EXPIRADA.equals(clave.getEstado())) {
	 	%>
			<tr>
				<td class="bienvenida" colspan="2">
					<table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
						<tr>
							<td>
								<table border="0" cellpadding="1" cellspacing="0" width="100%">
									<tr valign="top">
										<td width="5%"></td>
										<td width="95%" class="bienvenida">
											<bean:message key="lbl.clave.especial.expirada"/><br>
											<bean:message key="lbl.clave.especial.mensaje"/>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		<%
			}
	 	}
		%>
		
		
		<div class="panel panel-default">
 <div class="panel-heading" align="justify" ></div>
  <div class="panel-body">


   <h6 align="justify"><strong>	Estimado cliente,</strong><br><br>
						Nos permitimos informarle que hemos sido notificados por parte de la Superintendencia 
						de Bancos de Panamá sobre la circulación de correos electrónicos a través de los cuales 
						se solicita a clientes de bancos de la región, información personal, supuestamente por 
						parte del Departamento del Tesoro de los Estados Unidos de America en atención a la 
						entrada en vigencia del FATCA.
						<br><br>
						Les solicitamos se abstengan de brindar información que le sea requerida por vía de correo 
						electrónico sin haber verificado previamente la idoneidad del solicitante.
						<br><br>
						Les recordamos que nuestro banco no solicita información del cliente a través de correos electrónicos.
						<br><br>
						Atentamente,<br>Servicio al Cliente<br><strong>Helm Bank Panamá.</strong><br></h6>
  
  </div>
</div>
	
		
		<div class="panel panel-default">
 <div class="panel-heading" align="justify" ></div>
  <div class="panel-body">


   <h6 align="justify">
						<strong>ALERTA !</strong><br>
						La Reserva Federal de los Estados Unidos ha emitido una alerta advirtiendo 
						 una infiltración fraudulenta en los correos electrónicos, particularmente  
						con las operaciones de transferencia a países asiáticos como China y Japón. 
						<br><br>
						Es de suma importancia revisar las direcciones de los correo electrónicos 
						provenientes de estos países para asegurarse que sean legítimos.<br>
						Cuando un proveedor le indique el cambio en instrucciones de transferencias 
						es recomendable comunicarse con el mismo para verificar la autenticidad
						del cambio.<br></h6>
  
  </div>
</div>
		
		
		
		
		


			<tr><td height="30" class="texto-acceso"><br><br></td></tr>
			<tr height="60%"><td>&nbsp;</td></tr>
		</table>
	</td>


</tr>
</table>

<br>
<%@ include file="footer.jsp" %>

</div>

</body>

</html:html>
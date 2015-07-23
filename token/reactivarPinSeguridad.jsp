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

<head>

	<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> -->
	<script type="text/javascript" src="<html:rewrite page='/scripts/jquery-latest.min.js'/>"></script>
	<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
	<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

	<script type="text/javascript" src="<html:rewrite page='/scripts/campos.js'/>"></script>
	<script type="text/javascript" src="<html:rewrite page='/scripts/ValidaFirmaDigital.js'/>"></script>
	<script type="text/javascript" src="<html:rewrite page='/scripts/tecladoUpdate.js'/>"></script>
	<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/teclado.css'/>">
	<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" /> 
	<script type="text/javascript" src="<html:rewrite page='/token/firstLogin/tokenPinValidation.js'/>"></script>  

	<script language="javascript">
		function IsNumeric(input)
		{
		    var RE = /^-{0,1}\d*\.{0,1}\d+$/;
		    return (RE.test(input));
		}
		
		function campoChange(campo){
			if(1 == campo){
				document.getElementById("Foco").value = "claveold"
			}
			else if(2 == campo){
				document.getElementById("Foco").value = "clavenew"
			}
			else if(3 == campo){
				document.getElementById("Foco").value = "claveconf"
			}
		}
		
		function send(){
		    if(validatePass())
		    {
		    	document.forms[0].submit();
			}  
		}
		
		function validatePass(){
				
			//primero validamos si los campos son iguales
			campo1 = document.getElementById("clavenew").value;
			campo2 = document.getElementById("claveconf").value;
			
			if(campo1 != campo2){
				alert("<bean:message key="error.token.activarPin.confirmacion"/>");
				return false;
			}
			else{
				//validamos que sean del tamaño adecuado y sin sequencias
				if(!tokenLenValidation(6,campo1)) 
				{
					alert("<bean:message key="error.token.activarPin"/>");
					return false;
				}
				else if(!IsNumeric(campo1))
				{
					alert("<bean:message key="error.token.activarPin"/>");
					return false;
				}
				else if(!tokenSeqValidation(campo1))
				{
					alert("<bean:message key="error.token.activarPin"/>");
					return false;
				}
				else
				{
					return true;
				}
						
			}
			
		}
		var option = "0"; // Solamente teclado numerico 
	</script>
	<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/estilo.css'/>">
</head>

<body onLoad="reset();">

<div class="container">
	<div class="row">

		<div align="right">
			<img class="img-responsive" border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
		</div>

		</br>
		</br>

		<div height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
			<div  class="fuente-principal">
				<bean:message key="tit.title.atenticacion.paso4"/>
			</div>
		</div>

		<logic:present name="msg">
		 <div align="center" class="well col-md-4 col-md-offset-4">
			<p><b><bean:message key="errors.header"/></b></p>
			<p>
				<%String error = session.getAttribute("msg").toString();%>
				<bean:message key="<%=error%>"/>
			</p>
		</div>
		</logic:present>
		<% session.removeAttribute("msg");	%>
		</br>
		</br>
		<div class="col-md-4 col-md-offset-1">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.cambio.pin.tips.titulo"/>
					</strong>
				</div>

				<div class="panel-body">
					<p><bean:message key="lbl.cambio.pin.obs2" /></p>
					<p><bean:message key="lbl.cambio.pin.obs3" /></p>
					<p><bean:message key="lbl.cambio.pin.obs5" /></p>
				</div>
			</div>
		</div>

		<div class="col-md-6">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.token.introduccion.activarPin"/>
					</strong>
				</div>

				<div class="panel-body">
					<html:form method="post" action="/reactivaPinToken.do">
						<input type="hidden" name="Foco" value="claveold" id="Foco" >
						<p>
							<bean:message key="lbl.activar.pin.seguridad.explicacion"/>
						</p>
						<p>
							<bean:message key="lbl.activar.pin.msg2"/>
						</p>
						<p>
							<bean:message key="lbl.nuevo.pin"/>
							<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
						</p>
						<p>
							<html:password property="nuevoPin" styleClass="caja-acceso form-control" redisplay="false" onclick="campoChange(2);" styleId="clavenew" maxlength="6"/>
						</p>
						<p>
							<bean:message key="lbl.confirme.nuevo.pin"/>
							<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
						</p>
						<p>
							<html:password property="nuevoPinConfirmacion" styleClass="caja-acceso form-control" redisplay="false" onclick="campoChange(3);" styleId="claveconf" maxlength="6"/>
						</p>
						<p>
							<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
						</p>
						<br>
						<br>
						<div align="center">
							<input name="button" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.enviar"/>">
							<input name="Submit2" type="reset" class="btn btn-default" value="<bean:message key="btn.limpiar"/>">
							<html:hidden  property="pantalla" value="perfilActualizado"/>
							<h6 style="color:#95A5A6 ">
								<bean:message key="lbl.mensaje.campo.requerido" />
							</h6>
						</div>

						<div id="teclado" style=" visibility: hidden;">
						<div id="lower" style="display: none;" ></div>
						<div id="upper"></div>
						<div id="cls" align="bo"></div>

					</html:form>
				</div>
			</div>
		</div>

	</div>
</div>

		<!-- empieza cinta con derechos reservados -->
<div align="center" class="derechos" style="width:100%;height:31;background-color:#4D4F53;">
	<bean:message key="<%=copyrigth %>" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
</div>


</body>


<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"
	prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic"
	prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>

<%
	response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
	session.setAttribute("no.aplicar.regla.password", "true");
	java.util.Calendar cal2 =  java.util.Calendar.getInstance();
	String role = session.getAttribute("role.user").toString();
	String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
	Object sessFlag = session.getAttribute("flag");
	String paso		= "";
	String action= "";
	if(sessFlag != null){
		int flag = Integer.parseInt(sessFlag.toString());
		if(flag >= 81 && flag <= 89){
			action  = response.encodeRedirectURL(request.getContextPath() + "/token/autenticacionRobusta/preguntasSeguridadForm.jsp");
			paso= "tit.title.atenticacion.paso5";

		}
		else if(flag >= 90 && flag <= 99){
			action = response.encodeRedirectURL(request.getContextPath() + "/token/firstLogin/preguntasSeguridad.jsp");
			paso= "tit.title.first.login.paso4";
		}
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%>
<title><bean:message key="tit.title.banco" /></title>
<%}   else {%>
<title><bean:message key="tit.title.banco2" /></title>
<%} %>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" type="text/css"
	href="<html:rewrite page='/style/flujos.css'/>" />
<link rel="stylesheet" type="text/css"
	href="<html:rewrite page='/style/estilo.css'/>">
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/newlf.css '/>">
<link rel="stylesheet" type="text/css"
	href="<html:rewrite page='/style/activarDispositivo.css'/>">
<script type="text/javascript"
	src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script type="text/javascript"
	src="<html:rewrite page='/scripts/jquery.blockUI.js'/>"></script>
<script src="<html:rewrite page='/scripts/jquery.numeric.js'/>" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> -->
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

<script type="text/javascript">
			$(document).ready(function(){
				$('#clave1').focus();
				$("#clave1").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
				$("#clave2").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
			});

			var activo = "<bean:message key="lbl.activar.error.token.activo"/>";
			var incorrecto = "<bean:message key="error.token.incorrecto"/>";
			var error = "<bean:message key="lbl.registro.token.error"/>";

			function send(){
				var cual = $('#sender').attr('cual');
				if(cual == 1){
					var flag = validar($('#clave1'));
					if(flag){
						var dim = $('*[blockable=false]').position(); 
						var width = $('*[blockable=false]').width();
						var dim2 = $('*[blockable=true]').position();
						var height = dim2.top - dim.top;

						// $('body').append('<div id="block" class="wraper"></div>');
						$('#block').css('left',dim.left -10);
						$('#block').css('top',dim.top -5);
						$('#block').css('width',width +10);
						$('#block').css('height',height +15);
						// $('tr').removeClass('hidden');
						$('div').removeClass('hidden');
						$('.hidden-later').addClass('hidden');

//						$('#derechos').css('position','absolue');
//						$('#derechos').css('bottom','0px');

						$('#sender').attr('cual',2);
					}
				}
				else if(cual == 2){
					var flag = validar($('#clave2'));
					if(flag){
						enviar();
					}
				}
				else{
					//no debe pasar
				}

			}

			function empezar(){
				$.unblockUI({});
				limpiar();
				// $('tr[class="dummy"]').addClass('hidden');
				$('div[class="dummy"]').addClass('hidden');
				$('.hidden-later').removeClass('hidden');
				$("#messages").empty();
				$('#sender').attr('cual',1);
				limpiar();
			}

			function limpiar(){
				var cual = $('#sender').attr('cual');
				if(cual == 1){
					$('#clave1').val('');
				}
				else if(cual == 2){
					$('#clave2').val('');
				}
				else{
					//no debe pasar
				}
			}

			function IsNumeric(input){
				var RE = /^-{0,1}\d*\.{0,1}\d+$/;
				return (RE.test(input));
			}

			function validar(field){
				var cadena = field.val();
				cadena = $.trim(cadena);
				if(cadena.length == 8){
					if(IsNumeric(cadena)){
						return true;
					}
					else{
						alert("<bean:message key="error.token.activarToken.numeric"/>");
					}
				}
				else{
					alert("<bean:message key="error.token.activarToken.largo"/>");
					return false;
				}
			}

			function enviar(){
				var clave1 = $('#clave1').val();
				var clave2 = $('#clave2').val();
				$('#block').remove();
				// $.blockUI({ message: $('#esperar'), css: { width: '400px' } });
				$.blockUI({ message: $('#esperar'), css: { width: '200px' } });
				$.ajax({
					type: "POST",
					url: "<html:rewrite page='/do.activarDispositivo'/>",
					dataType: 'json',
					timeout: 40000,
					data: { clave1: clave1, clave2: clave2},
					success: function(data,x,y){
						//console.info(data.status);

						if(data.status == "success"){
							$.unblockUI({
								onUnblock: function(){
									$.blockUI({ message: $('#msgExito'), css: { width: '200px' } });
								}
							});
						}
						else if(data.status == "activo"){
							empezar();
							$("#mensajes").css('display','inline')
							$("#messages").append(activo);
						}
						else if(data.status == "error"){
							empezar();
							$("#mensajes").css('display','inline')
							$("#messages").append(error);
						}
						else if(data.status == "incorrecto"){
							empezar();
							$("#mensajes").css('display','inline')
							$("#messages").append(incorrecto);
						}
						else{
							empezar();
							$("#mensajes").css('display','inline')
							$("#messages").append(error);
						}
					},
					error: function(data,x,y){
						empezar();
						$("#messages").append(error);
					}
				});
			}

			function exito(){
				$.unblockUI({});
				//console.info('submit');
				$("#formulario").submit();
			}

		</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="fuente-principal">
					<bean:message key="<%=paso%>"/>
				</div>

				<div class="panel panel-default" >
					<div class="panel-heading" >
						<img src="<html:rewrite page='/images/logo_icon.png' />" />
						<strong>
							<bean:message key="tit.title.registro.token" />
						</strong>
					</div>

					<div class="panel-body">
						<!-- Mensajes de espera para send -->
						<%@ include file="blockDiv.jsp"%>

						<div class="row" style="display: none;" id="mensajes" >
							<div class="well">
								<p><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></p>
								<p><b><bean:message key="errors.header"/></b></p>
								<p id="messages" class="fuente-principal"></p>
							</div>
						</div>

						<!-- Div que contiene el primer paso - este div se bloquea al enviar la primera clave -->
						<div id="block-one" align="center">
							<form action="<%=action %>" id="formulario" method="post">
								<div class="hidden-later">
									<p><b><bean:message key="lbl.activar.dispositivo.instruccion1" /></b></p>
									<p>
										<b>
											<bean:message key="lbl.pasos.sincronizar.token.paso1" />
										</b>
										<img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15">
									</p>
									<p>
										<b>
											<bean:message key="lbl.pasos.sincronizar.token.paso2" />
										</b>
										<img src="<html:rewrite page='/images/TokenClave.png'/>" height="15">
									</p>
									<p>
										<b>
											<bean:message key="lbl.activar.dispositivo.paso3" />
										</b>
									</p>
									<p>
										<b>
											<bean:message key="lbl.activar.dispositivo.paso4" />
										</b>
									</p>
									<div align="center">
										<p>
											<bean:message key="lbl.activar.dispositivo.label1" />
											<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
										</p>
										<p>
											<input type="text" name="clave1" class="inputf form-control" maxlength="8" id="clave1" />
										</p>

										<input id="sender" name="button" cual="1" onclick="send();" type="button" class="botton btn btn-default" value="<bean:message key="btn.enviar"/>" />

										<input name="Submit2" onclick="limpiar();" type="button" class="botton btn btn-default" value="<bean:message key="btn.limpiar"/>" />
									</div>

								</div>

									<!-- Empieza los campos ocultos -->
									<div class="hidden dummy">
										<p><bean:message key="lbl.activar.dispositivo.instruccion2" /></p>
										<p>
											<bean:message key="lbl.pasos.sincronizar.token.paso1" />
											<img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15">
										</p>
										<p>
											<bean:message key="lbl.pasos.sincronizar.token.paso2" />
											<img src="<html:rewrite page='/images/TokenClave.png'/>" height="15">
										</p>
										<p>
											<bean:message key="lbl.activar.dispositivo.paso3" />
										</p>
										<p>
											<bean:message key="lbl.activar.dispositivo.paso4" />
										</p>
										<div align="center">
											<p>
												<bean:message key="lbl.activar.dispositivo.label2" />
												<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
											</p>
											<p>
												<input type="text" name="clave2" class="inputf form-control" maxlength="8" id="clave2" />
											</p>

											<input id="sender" name="button" cual="1" onclick="send();" type="button" class="botton btn btn-default" value="<bean:message key="btn.enviar"/>" />

											<input name="Submit2" onclick="limpiar();" type="button" class="botton btn btn-default"	value="<bean:message key="btn.limpiar"/>" />
										</div>

									</div>
									<!-- Terminan los campos ocultos -->

									<h6 style="color:#95A5A6 ">
										<bean:message key="lbl.mensaje.campo.requerido" />
									</h6>
							</form>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	<!-- Div que contiene el primer paso - este div se bloquea al enviar la primera clave -->
	<div id="block-one" style="display:none" align="center">
		<form action="<%=action %>" id="formulario" method="post">

			<!-- Tabla con el contenido -->
			<table width="50%" style="border: 0px; border-spacing: 0px">

				<tr align="center">
					<td width="50px"><img border="0"
						src="<html:rewrite page='/images/gancho.gif' />" /></td>
					<td class="padd-title" colspan="2"><div align="left"
							class="fuente-titulo">
							<bean:message key="tit.title.registro.token" />
						</div></td>
				</tr>

				<tr blockable="false">
					<td class="padd-title">&nbsp;</td>
					<td colspan="2"><div align="left" class="fuente-principal">
							<bean:message key="lbl.activar.dispositivo.instruccion1" />
						</div></td>
				</tr>

				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2"><div align="left"
							class="fuente-principal steps">
							<bean:message key="lbl.pasos.sincronizar.token.paso1" /><img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15">
						</div></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td colspan="2"><div align="left"
							class="fuente-principal steps">
							<bean:message key="lbl.pasos.sincronizar.token.paso2" /><img src="<html:rewrite page='/images/TokenClave.png'/>" height="15">
						</div></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td colspan="2"><div align="left"
							class="fuente-principal steps">
							<bean:message key="lbl.activar.dispositivo.paso3" />
						</div></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td colspan="2"><div align="left"
							class="fuente-principal steps">
							<bean:message key="lbl.activar.dispositivo.paso4" />
						</div></td>
				</tr>

				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>


				<tr>
					<td>&nbsp;</td>
					<td width="45%"><div
							style="padding-right: 25px; padding-left: 50px"
							class="fuente-obligatorio" align="left">
							<bean:message key="lbl.activar.dispositivo.label1" />
						</div></td>
					<td><input type="text" name="clave1" class="inputf"
						maxlength="8" id="clave1" /><span class="texto-acceso">(<font
							color="#FF0000">*</font>)
					</span></td>
				</tr>

				<tr blockable="true">
					<td colspan="3">&nbsp;</td>
				</tr>

				<!-- Empieza los campos ocultos -->

				<tr class="hidden dummy">
					<td class="padd-title">&nbsp;</td>
					<td colspan="2"><div align="left" class="fuente-principal">
							<bean:message key="lbl.activar.dispositivo.instruccion2" />
						</div></td>
				</tr>

				<tr class="hidden dummy">
					<td colspan="3">&nbsp;</td>
				</tr>

				<tr class="hidden dummy">
					<td>&nbsp;</td>
					<td colspan="2"><div align="left"
							class="fuente-principal steps">
							<bean:message key="lbl.pasos.sincronizar.token.paso1" /><img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15">
						</div></td>
				</tr>

				<tr class="hidden dummy">
					<td>&nbsp;</td>
					<td colspan="2"><div align="left"
							class="fuente-principal steps">
							<bean:message key="lbl.pasos.sincronizar.token.paso2" /><img src="<html:rewrite page='/images/TokenClave.png'/>" height="15">
						</div></td>
				</tr>

				<tr class="hidden dummy">
					<td>&nbsp;</td>
					<td colspan="2"><div align="left"
							class="fuente-principal steps">
							<bean:message key="lbl.activar.dispositivo.paso3" />
						</div></td>
				</tr>

				<tr class="hidden dummy">
					<td>&nbsp;</td>
					<td colspan="2"><div align="left"
							class="fuente-principal steps">
							<bean:message key="lbl.activar.dispositivo.paso4" />
						</div></td>
				</tr>

				<tr class="hidden dummy">
					<td colspan="3">&nbsp;</td>
				</tr>



				<tr class="hidden dummy">
					<td>&nbsp;</td>
					<td width="45%"><div
							style="padding-right: 25px; padding-left: 50px"
							class="fuente-obligatorio" align="left">
							<bean:message key="lbl.activar.dispositivo.label2" />
						</div></td>
					<td><input type="text" name="clave2" class="inputf"
						maxlength="8" id="clave2" /><span class="texto-acceso">(<font
							color="#FF0000">*</font>)
					</span></td>
				</tr>

				<tr class="hidden dummy">
					<td colspan="3">&nbsp;</td>
				</tr>

				<!-- Terminan los campos ocultos -->


				<tr>
					<td colspan="3" align="center">
					<input id="sender"
						name="button" cual="1" onclick="send();" type="button"
						class="botton" value="<bean:message key="btn.enviar"/>" /> 
						<input
						name="Submit2" onclick="limpiar();" type="button" class="botton"
						value="<bean:message key="btn.limpiar"/>" />
						</td>
				</tr>

				<tr>
					<td colspan="3" height="20" valign="middle"
						class="fuente-obligatorio" align="center"><bean:message
							key="lbl.mensaje.campo.requerido" /></td>
				</tr>

				<tr class="hidden dummy">
					<td colspan="3">&nbsp;</td>
				</tr>

				<tr class="hidden dummy">
					<td colspan="3">&nbsp;</td>
				</tr>

			</table>
		</form>
	</div>



	<!-- Div que contiene el cintillo de los derechos reservados -->
	<div id="derechos">
		<bean:message key="<%=copyrigth %>"
			arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>' />
	</div>


</body>
</html>
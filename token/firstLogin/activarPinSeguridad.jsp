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

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="reset();">
	<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		
		<tr> 
			<td colspan="2" style="padding: 15px">
			
				<table width="100%" border="0" cellpadding="10" cellspacing="0">
					<tr>
						<td align="right" ><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td>
					</tr>
				</table>
			
			</td>
			
		</tr>
	  	
	  	<tr> 
			<td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
				<div  class="fuente-principal"><bean:message key="tit.title.first.login.paso3"/></div>
			</td>
	  	</tr>
	  
	  	<tr valign="top"> 
	    	<td width="50%">	
				<logic:present name="msg">
					<table width="100%" border="0" cellspacing="1" cellpadding="1" class="tabla-acceso" >
						<tr> 
							<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
							<td valign="top">
								<table>
									<tr><td class="fuente-principal"><b><bean:message key="errors.header"/></b></td></tr>
									<tr><td class="fuente-principal">
							        <%String error = session.getAttribute("msg").toString();%>
										<bean:message key="<%=error%>"/></td></tr>
								</table>
							</td>
						</tr>
					</table>   
				</logic:present>
			 
			 	<% session.removeAttribute("msg");	%>
			 
				<div align="center">
					
					<table width="100%" align="left">
						<html:form method="post" action="/activarPinToken.do">
	     					<input type="hidden" name="Foco" value="claveold" id="Foco" >
	     			  
	  					<tr>
	  						<td>	
	  							<table>
	  
				  					<tr> 
										<td  height="40" valign="top" >
											<div style="padding-left: 50px" align="left"> 
												<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
						  							<tr> 
														<!-- td width="92%"><div align="left" class="login"><bean:message key="tit.title.cambio.clave.especial"/></div></td>
														<td width="8%"><div align="right"></div></td-->
														<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
														<td width="100%"><div align="left" class="fuente-titulo"><bean:message key="lbl.token.introduccion.activarPin"/></div></td>
														<td width="8%"><div align="right"></div></td>
						  							</tr>
						  
						  							<tr><td colspan="3">&nbsp;</td></tr>
						  
													<tr>
														<td>&nbsp;</td>
														<td  align="left" class="fuente-principal"><bean:message key="lbl.activar.pin.seguridad.explicacion"/></td>
														<td>&nbsp;</td>
													</tr>
						  
						  							<tr><td colspan="3">&nbsp;</td></tr>
						  
												    <tr>
												  		<td>&nbsp;</td>
												  		<td  align="left" class="fuente-principal"><bean:message key="lbl.activar.pin.msg2"/></td>
												  		<td>&nbsp;</td>
												    </tr>
												    
												    <tr><td colspan="3">&nbsp;</td></tr>
						  
						  							<tr valign="top">
					     								<td>&nbsp;</td>
					     								<td>	
						     									<table>
						     										<tr>
						     											<td  class="celda-clave1">
						     												<div  class="fuente-obligatorio">
						     													<bean:message key="lbl.nuevo.pin"/>
						     												</div>
						     											</td>
						     											
						     											<td style="padding-left: 60px">
						     												<html:password property="nuevoPin" styleClass="caja-acceso" redisplay="false" onclick="campoChange(2);" styleId="clavenew" maxlength="6"/>
						     												<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
						     											</td>
						     										</tr>
						     										
						     										<tr> 
																		<td  height="20" class="fuente-obligatorio"><div  class="fuente-obligatorio"><bean:message key="lbl.confirme.nuevo.pin"/></div></td>
																		<td style="padding-left: 60px"><html:password property="nuevoPinConfirmacion" styleClass="caja-acceso" redisplay="false" onclick="campoChange(3);" styleId="claveconf" maxlength="6"/> 
						  													<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
						  												</td>
						  											</tr>		
						  										</table>
					     								</td>
					     								<td>&nbsp;</td>		
					     							</tr>
						  
						  							
						  
						  							<tr>
						  								
														<td colspan="3"  align="center"class="texto-acceso">
															<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
														</td>
						  							</tr>
						  							
						  							<tr><td colspan="3">&nbsp;</td></tr>
						  
						  							<tr> 
														<td>&nbsp;</td>
														<td colspan="2">
															<div align="center">
							  									<input name="button" onclick="send();" type="button" class="botton" value="<bean:message key="btn.enviar"/>"> 
							  									<input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>">
							  									<html:hidden  property="pantalla" value="primeraActivacionDispositivo"/>
						  									</div>  
														</td>
						  							</tr>
						  							
						  							
						  							
						  	
						  							<tr>
						  									
														<td style="padding-top: 60px" colspan="3" height="20" valign="middle" class="fuente-obligatorio" align="center"><bean:message key="lbl.mensaje.campo.requerido"/></td>
														
				  									</tr>
						  
						  							<tr>
														<td>&nbsp;</td>
								    					<td>
									    					<div id="teclado" style=" visibility: hidden;">
																<div id="lower" style="display: none;" ></div>
																<div id="upper"></div>
															<div id="cls" align="bo"></div>		
															</div>
														</td>
														<td>&nbsp;</td>
						  							</tr>
						  
						  							
						  
												</table>
					  						</div>
										</td>	  
				  					</tr>  
				
								</table>
							</td>
		
						</div>
					</tr>
					
				</html:form>
				</table>
			</td>
					
			<!-- 		empieza el cuadro de indicaciones -->
			
			<td style="padding-top: 75px"  width="50%">
				<%@ include file="../../divHeader.jsp"%>
				<table  cellspacing="3" cellpading="3" >
			        <tr valign="top">
						<td colspan="2">
							<table>
								<tr>
									<td>
										<img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
									<td class="fuente-recuadro-titulo"><p ><bean:message key="lbl.cambio.pin.tips.titulo"/></p></td>
								</tr>
							</table>
						</td>
				    </tr>
				    
				    <tr valign="top">
				       <td colspan="2"  class="fuente-principal">
				          <UL>
				          	<li><bean:message key="lbl.cambio.pin.obs1" /></li>
				          	<li><bean:message key="lbl.cambio.pin.obs2" /></li>
				            <li><bean:message key="lbl.cambio.pin.obs3" /></li>
				            
				            <li><bean:message key="lbl.cambio.pin.obs5" /></li>
				          </UL>
				       </td>
				    </tr>
			    
				</table>
				<%@ include file="../../divFooter.jsp"%>
			</td>		
		   
			<!-- 	   termina cuadro de indicaciones -->
		   
		</tr>
		
	  
		<!-- empieza cinta con derechos reservados -->
		<tr>
			<td height="31" colspan="2" style="width:100%;height:31;background-color:#4D4F53;">
				<div align="center" class="derechos">
					<bean:message key="<%=copyrigth %>" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
				</div>
			</td>
		</tr>
	
		<!-- termina cinta con derechos reservados -->
	
	</table>


</body>


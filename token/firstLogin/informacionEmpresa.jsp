<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ page import="com.arango.common.util.valueList.KeyValuePair" %>
<%@ page import="com.arango.common.delegate.Manager" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>
<%@ include file="../../head.jsp"%>
<% 
UserInfo userInfo = new UserInfo();
Manager man = new Manager();
String  introduccion = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "lbl.introduccion.formulario.actualizacion.panama"  : "lbl.introduccion.formulario.actualizacion.cayman";
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
String  paso		 = man.getUserFlag(session.getAttribute("user.id").toString())==ConstantesGlobales.ACTUALIZACION_INFORMACION ? "tit.title.first.login.paso6" :  "tit.title.atenticacion.paso7";
%>
<style>

.textfield, .textfield-fecha, .text, .textfield2, .text2, .textfield3 {
	height: 22px;
	font-weight: bold;	
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #EFEFEE;
	color:black;
	border: 1px solid #000000;
}
.textfield, .text, .text2, .textfield2{
	width: 230px;
}
.textfield-fecha{
width: 200px;
}
.text,.text2{
	height: 22px;
	color:#808080;
	padding:1;
}
.text2, .textfield2{
	height: 40px;
}
.text2{
	height: 40px;
	overflow: auto;
}

.celdas, .celdas-border{
	height: 22px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #3E3E3E;
}
.celdas-border{
	border-bottom:1px solid #A4A4A4;
}
.textfield-error{
	background-color: #FF;
	border:1px red solid;
}
.marco, .marco-titulo{
	width:90%;
	text-aling:center;
 }
.marco-titulo{
	width:60%;
} 
</style>
<script type="text/javascript">


<!--
if (typeof window.event != 'undefined') // IE
document.onkeydown = function() // IE
 {
 var t=event.srcElement.type;
 var kc=event.keyCode;
 return ((kc != 8 ) || ( t == 'text'  ) ||
          (t == 'textarea') || ( t == 'submit' ) || (t =='password'));
 }
else
document.onkeypress = function(e)  // FireFox/Others 
 {
 var t=e.target.type;
 var kc=e.keyCode;
 if ((kc != 8 ) || ( t == 'text'  ) ||
     (t == 'textarea') || ( t == 'submit' ) || (t =='password')) 
     return true;
 else {
     return false;
 }
}
//-->
</script>
<script type="text/javascript">
function limitText(limitField, limitNum) {
	if (limitField.value.length > limitNum) {
		limitField.value = limitField.value.substring(0, limitNum);
	} 
}

function imposeMaxLength(Event, Object, MaxLen)
{
        return (Object.value.length < MaxLen)||(Event.keyCode == 8 ||Event.keyCode==46||(Event.keyCode>=35&&Event.keyCode<=40))
}

function __submit(){
	document.getElementById('actualizar').disabled = 'true';
	document.forms['frmPersona'].submit();
  	
	
//	if (confirm("<bean:message key='lbl.actualiza.mensaje.confirmacion'/>")){
//	}
}
var __textfields = new Array();
var __index = 0;
function __changeColor(){
	var __obj;
	for (i =0; i < __index; i++){
		__obj = __textfields[i];
		if (__obj){
			__obj.style.borderColor = "red";
		}		
	}
}
function __setChangeColor(__element){
	var __obj;
	if (document.getElementById){
		__obj = document.getElementById(__element);
	}
	else{
		eval("__obj="+__element);
	}
	if (__obj){
		__textfields[__index++] = __obj;
	}
}

function __changeCiudad(){
	__changeSelect("ciudad");
}
function __changeCiudadEmpresa(){
	__changeSelect("ciudadEmpresa");
}
function __changeSelect(__element){
	var __obj;
	if (document.getElementById){
		__obj = document.getElementById(__element);
	}
	else{
		eval("__obj="+__element);
	}
	if (__obj){
		__obj.options.length = 0;
		__obj.options.add(new Option("[Seleccione un valor]", 0));
	}
}
function __show(__element){
	__(__element, "");	
}
function __hide(__element){
	__(__element, "none");
}
function __(__element, __option){
	var __obj;
	if (document.getElementById){
		__obj = document.getElementById(__element);
	}
	else{
		eval("__obj="+__element);
	}
	if (__obj){
		__obj.style.display=__option;
	}
}
function __changeTipoEnvio(__element){
	switch(__element.value){
	case "D": __hide("__correoElectronico");
			  __show("__direccionFisica");
			  document.forms['frmPersona'].tipoCorreoElectronico.value="none";
			  document.forms['frmPersona'].tipoDireccionFisica.value="";
			  break;
	case "C": __hide("__direccionFisica");
			  __show("__correoElectronico");
			  document.forms['frmPersona'].tipoCorreoElectronico.value="";
			  document.forms['frmPersona'].tipoDireccionFisica.value="none";
	  		  break;
	case "R": __hide("__correoElectronico");
			  __hide("__direccionFisica");
			  document.forms['frmPersona'].tipoCorreoElectronico.value="none";
			  document.forms['frmPersona'].tipoDireccionFisica.value="none";
			  break;
	}
}

</script>
<script type="text/javascript">
	window.onload = __changeColor;
</script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar-es.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-update.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/subModal.css'/>" />
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/style.css'/>" />
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<script type="text/javascript" src="<html:rewrite page='/scripts/common.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/subModal.js'/>"></script>

<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">


</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
   <tr> 
        <td><br>
		<table width="100%" border="0" cellpadding="10" cellspacing="0">
			<tr><td align="right"><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
			<br></td>
    <td>&nbsp;</td>
     
  </tr>
  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF;"><div  class="fuente-principal"><bean:message key=<%=paso%>/></div></td>
  </tr>
  <tr valign="top"> 
    <td colspan="4">
    
<logic:messagesPresent>
<table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso">
  <tr><td>
	 <table border="0" cellpadding="1" cellspacing="0" width="100%">
		  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
						   <td width="95%" class="msg">
								<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
			<div class="bienvenida">
				<table width="80%">
					<html:messages id="error">					
						<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
					</html:messages>
				</table>
			</div><br>
		</td></tr>
		</table>
	</td></tr>
</table>
</logic:messagesPresent>
	<div align="center"> 
	    <html:form action="/salvaInformacionEmpresa.do">
	    	 <table class="marco-titulo" border="0" cellspacing="1" cellpadding="1">
	    	   <tr>
				<td height="20" valign="top" class="texto-acceso">
					<img src="<html:rewrite page='/images/gancho.gif'/>" border="0" hspace="8">
				<FONT size="2"><bean:message key="lbl.actualiza.juridico.titulo"/> </FONT></td>
			  </tr>
			   <tr>
				<td height="10" valign="middle" class="bienvenida"></td>
			  </tr>
			  <tr>
				<td height="30" valign="bottom" class="bienvenida">
					<UL>	<li><bean:message key="<%=introduccion %>" /></li>	</UL>
				</td>
			  </tr>
	    	   <tr>
				<td height="20" valign="middle" class="bienvenida"><bean:message key="lbl.actualiza.juridico.leyenda"/></td>
			  </tr>
	    	 </table>
	    	 <%@ include file="/WEB-INF/marco/inicio.jsp"%>
	    	 <table class="marco" border="0" cellspacing="1" cellpadding="1">
				<tr>

	    	 		<td class="celdas" width="5%"><font color="#FF0000">*</font></td>
					<td class="celdas-border" width="30%"><bean:message key="lbl.actualiza.juridico.razon.social"/></td>
					<td class="celdas" width="65%"><div class="text"><bean:write property="nombreEmpresa" name="frmPersona"/></div>
					<html:hidden property="nombreEmpresa"/></td>
					<td align="left" width="5%">
					</td></tr>

	    	 	<tr valign="top">	    	 		
					<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.ruc"/></td>
					<td class="celdas"><div class="text"><bean:write property="ruc" name="frmPersona"/></div>
					<html:hidden property="ruc"/></td>
					<td>
					</td></tr>


				<tr>

	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border" ><bean:message key="lbl.actualiza.juridico.actividad.economica"/></td>
					<td class="celdas" ><html:select property="actividadEconomica"
													styleClass="textfield" styleId="actividadEconomica">
													<html:option value="0">[Seleccione un valor]</html:option>
												<bean:define id="cp0" scope="session" name="list_actividad_laboral" type="java.util.List"/>
									            <html:options collection="cp0" property="key" labelProperty="value"/>
											</html:select></td>

					<td align="left">
						<logic:messagesPresent name="msg_actividadEconomica">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("actividadEconomica");
							</script>
						</logic:messagesPresent>
					</td></tr>


				<tr>

	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.actividad.ciiu"/></td>
					<td class="celdas"><html:select property="actividadCIIU"
													styleClass="textfield2" styleId="actividadCIIU">
													<html:option value="">[Seleccione un valor]</html:option>
													<%
													Object bean = request.getAttribute("frmPersona");
													String key = "";
													Object value = null;
													if (bean != null)
													{
														value = org.apache.commons.beanutils.PropertyUtils.getSimpleProperty(bean, "actividadCIIU");
														if (value != null){
															key = value.toString();
														}
													}
													String currentValue=null;
													java.util.ArrayList data = (java.util.ArrayList)session.getAttribute("list_tipos_clases_sectores_economicos");
													KeyValuePair item = null;
										            if (data != null) {
										                for (int i = 0; i < data.size(); i++){
										                    item = (KeyValuePair)data.get(i);
										                    if (key.equals(item.getKey()))
										                    {
										                    	currentValue="selected";
										                    }
										                    else{
										                    	currentValue="";
										                    }
													%>
														<option title="<%=item.getValue() %>" value="<%=item.getKey() %>" <%=currentValue %>> <%=item.getValue() %></option>
													<%}
										            }
													%>
											</html:select></td>
					<td align="left">
						<logic:messagesPresent name="msg_actividadCIIU">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("actividadCIIU");
							</script>
						</logic:messagesPresent>
					</td></tr>


				<tr>

	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border" ><bean:message key="lbl.actualiza.juridico.direccion.empresa"/></td> <!--  onclick="showPopWin(this, 450, 280, null,false);" readonly="true" -->
					<td class="celdas" ><html:textarea styleId="direccionEmpresa" property="direccionEmpresa" cols="45" rows="3" styleClass="textfield2" onkeypress="return imposeMaxLength(event, this, 200);"/></td>
					<td align="left">
						<logic:messagesPresent name="msg_direccionEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("direccionEmpresa");
							</script>
						</logic:messagesPresent>
					</td></tr>
					<tr>




	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.pais.empresa"/></td>
					<td class="celdas"><html:select property="paisEmpresa"
													styleClass="textfield" styleId="paisEmpresa">
													<html:option value="0">[Seleccione un valor]</html:option>
												<bean:define id="cp2" scope="session" name="list_paises" type="java.util.List"/>
									            <html:options collection="cp2" property="key" labelProperty="value"/>
											</html:select></td>
					<td align="left">
						<logic:messagesPresent name="msg_paisEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("paisEmpresa");
							</script>
						</logic:messagesPresent>
					</td></tr>
					


				<tr>


	    	 		<td></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.departamento.empresa"/></td>
					<td class="celdas"><html:select property="departamentoEmpresa"
													styleClass="textfield" styleId="departamentoEmpresa">
													<html:option value="0">[Seleccione un valor]</html:option>
												<bean:define id="cp4" scope="session" name="list_departamentos_emp" type="java.util.List"/>
									            <html:options collection="cp4" property="key" labelProperty="value"/>
									            </html:select></td>
					<td align="left"></td></tr>
				<tr>

	    	 		<td></td>
					<td class="celdas-border" ><bean:message key="lbl.actualiza.juridico.ciudad.empresa"/></td>
					<td class="celdas"> <html:select property="ciudadEmpresa"
													styleClass="textfield" styleId="ciudadEmpresa">
													<html:option value="0">[Seleccione un valor]</html:option>
												<bean:define id="cp3" scope="session" name="list_ciudades_emp" type="java.util.List"/>
									            <html:options collection="cp3" property="key" labelProperty="value"/>
											</html:select></td>
					</tr>
									
				<tr>


	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.telefono.empresa"/></td>
					<td class="celdas"><html:text styleId="telefonoEmpresa" property="telefonoEmpresa" styleClass="textfield" size="45" maxlength="20"/></td>
					<td align="left">
						<logic:messagesPresent name="msg_telefonoEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("telefonoEmpresa");
							</script>
						</logic:messagesPresent>
					</td></tr>


				<tr>

	    	 		<td class="celdas"></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.fax.empresa"/></td>
					<td class="celdas"><html:text styleId="faxEmpresa" property="faxEmpresa" styleClass="textfield" size="45" maxlength="20"/></td>
					<td align="left">
						<logic:messagesPresent name="msg_faxEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("faxEmpresa");
							</script>
						</logic:messagesPresent></td></tr>


				<tr valign="top">
	    	 		<td class="celdas" width="5%"><font color="#FF0000">*</font></td>

					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.envio.correspondencia"/></td>
					<td class="celdas">
						<html:select property="envioCorrespondencia" styleClass="textfield" onchange="__changeTipoEnvio(this)">
							<html:option value="">[Seleccione un valor]</html:option>
						<!--  	<html:option value="D">Direcci�n F�sica</html:option> -->
							<html:option value="C">Correo Electr�nico</html:option>
							<html:option value="R">No Env�ar - Consulta Por Internet</html:option>
						</html:select>

					</td>
					<td align="left">










						<logic:messagesPresent name="msg_envioCorrespondencia">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("envioCorrespondencia");
							</script>
						</logic:messagesPresent>
					</td>
				</tr>

					<tr><td colspan="4">
					<html:hidden property="tipoCorreoElectronico" />
					<html:hidden property="tipoDireccionFisica" />


					<div id="__correoElectronico" style="display:<bean:write name='frmPersona' property='tipoCorreoElectronico'/>">
					<table width="100%" border="0" cellspacing="1" cellpadding="1">	
						<tr valign="top">
			    	 		<td class="celdas" width="5%"><font color="#FF0000">*</font></td>
							<td class="celdas-border" width="30%"><bean:message key="lbl.actualiza.juridico.correo.empresa"/></td>
							<td class="celdas" width="60%"><html:text property="correoElectronicoEmpresa" styleId="correoElectronicoEmpresa"  maxlength="50" styleClass="textfield"/></td>
							<td width="5%">
								<logic:messagesPresent name="msg_correoElectronicoEmpresa">
									<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
									<script type="text/javascript">
										__setChangeColor("correoElectronicoEmpresa");
									</script>
								</logic:messagesPresent>
							</td></tr>
						</table>
					</div>
					</td></tr>


				<tr>

	    	 		<td class="celdas"></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.pagina.web"/></td>
					<td class="celdas"><html:text styleId="paginaWeb" property="paginaWeb" styleClass="textfield" size="45" maxlength="50"/></td>
					<td align="left"></td></tr>

				<tr valign="top">
	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.natural.email.contacto"/></td>
					<td class="celdas"><html:text property="emailContacto" styleId="emailContacto" styleClass="textfield" maxlength="50"/></td>
					<td>
								<logic:messagesPresent name="msg_emailContacto">
									<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
									<script type="text/javascript">
										__setChangeColor("emailContacto");
									</script>
								</logic:messagesPresent></td>
				</tr>
					<tr valign="top">
	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.natural.confirmar.email.contacto"/></td>
					<td class="celdas"><html:text property="emailContacto2" styleId="emailContacto2" styleClass="textfield" maxlength="50"/></td>
					<td>
								<logic:messagesPresent name="msg_emailContacto2">
									<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
									<script type="text/javascript">
										__setChangeColor("emailContacto2");
									</script>
								</logic:messagesPresent></td>
				</tr>						
				</table>
			<%@ include file="/WEB-INF/marco/fin.jsp"%>
			
	    	 <%@ include file="/WEB-INF/marco/inicio.jsp"%>
	    	 <table class="marco" border="0" cellspacing="1" cellpadding="1">
				<tr>
	    	 		<td class="celdas" width="5%"><font color="#FF0000">*</font></td>
					<td class="celdas-border" width="30%"><bean:message key="lbl.actualiza.juridico.apoderado.legal.nombre"/></td>
					<td class="celdas" width="65%"><html:text styleId="nombre" property="nombre" styleClass="textfield" size="45" maxlength="40"/></td>
					<td align="left" width="5%">
						<logic:messagesPresent name="msg_nombre">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("nombre");
							</script>
						</logic:messagesPresent>
					</td></tr>


					
				<tr>
	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.identificacion"/></td>
					<td class="celdas"><html:text styleId="identificacion" property="identificacion" styleClass="textfield" size="45" maxlength="20"/></td>
					<td align="left">
						<logic:messagesPresent name="msg_identificacion">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("identificacion");
							</script>
						</logic:messagesPresent>
					</td></tr>
				<tr>
	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.nacionalidad"/></td>
					<td class="celdas"><html:select property="nacionalidad"
													styleClass="textfield" styleId="nacionalidad">
												<bean:define id="cp10" scope="session" name="list_nacionalidad" type="java.util.List"/>
													<html:option value="-1">[Seleccione un valor]</html:option>
									            <html:options collection="cp10" property="key" labelProperty="value"/>
											</html:select></td>
					<td align="left">
						<logic:messagesPresent name="msg_nacionalidad">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("nacionalidad");
							</script>
						</logic:messagesPresent>
					</td>
				</tr>
				<tr>
	    	 		<td class="celdas"></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.nacionalidad.2"/></td>
					<td class="celdas"><html:select property="nacionalidadSecundaria"
													styleClass="textfield" styleId="nacionalidadSecundaria">
												<bean:define id="cp8" scope="session" name="list_nacionalidad" type="java.util.List"/>
													<html:option value="-1">[Seleccione un valor]</html:option>
									            <html:options collection="cp8" property="key" labelProperty="value"/>
											</html:select></td>
					<td align="left"></td></tr>
				<tr>
	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.direccion"/></td>
					<td class="celdas"><html:textarea styleId="direccion" property="direccion" styleClass="textfield2" onkeypress="return imposeMaxLength(event, this, 100);" /></td>
					<td align="left">
						<logic:messagesPresent name="msg_direccion">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("direccion");
							</script>
						</logic:messagesPresent>
					</td></tr>
						<tr>
	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.pais"/></td>
					<td class="celdas"><html:select property="pais"
													styleClass="textfield" styleId="pais">
													<html:option value="0">[Seleccione un valor]</html:option>
												<bean:define id="cp6" scope="session" name="list_paises" type="java.util.List"/>
									            <html:options collection="cp6" property="key" labelProperty="value"/>
											</html:select></td>
					<td align="left">
						<logic:messagesPresent name="msg_pais">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("pais");
							</script>
						</logic:messagesPresent>
					</td></tr>
				<tr>
	    	 		<td></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.departamento"/></td>
					<td class="celdas"><html:select property="departamento"
													styleClass="textfield" styleId="departamento">
													<html:option value="0">[Seleccione un valor]</html:option>
												<bean:define id="cp5" scope="session" name="list_departamentos" type="java.util.List"/>
									            <html:options collection="cp5" property="key" labelProperty="value"/>
											</html:select></td>
					</tr>
				<tr>
	    	 		<td></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.ciudad"/></td>
					<td class="celdas"> <html:select property="ciudad"
													styleClass="textfield" styleId="ciudad">
													<html:option value="0">[Seleccione un valor]</html:option>
												<bean:define id="cp7" scope="session" name="list_ciudades" type="java.util.List"/>
									            <html:options collection="cp7" property="key" labelProperty="value"/>
											</html:select></td>
					
					</tr>
					
			
				<tr>
	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.telefono"/></td>
					<td class="celdas"><html:text styleId="telefono" property="telefono" styleClass="textfield" size="45" maxlength="20"/></td>
					<td align="left">
						<logic:messagesPresent name="msg_telefono">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("telefono");
							</script>
						</logic:messagesPresent>
					</td></tr>
				<tr>
	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.celular"/></td>
					<td class="celdas"><html:text styleId="celular" property="celular" styleClass="textfield" size="45" maxlength="20"/></td>
					<td align="left">
						<logic:messagesPresent name="msg_celular">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("celular");
							</script>
						</logic:messagesPresent></td></tr>
				<tr>
	    	 		<td class="celdas"><font color="#FF0000">*</font></td>
					<td class="celdas-border"><bean:message key="lbl.actualiza.juridico.correo"/></td>
					<td class="celdas"><html:text styleId="correoElectronico" property="correoElectronico" styleClass="textfield" size="45" maxlength="50"/></td>
					<td align="left">
						<logic:messagesPresent name="msg_correoElectronico">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("correoElectronico");
							</script>
						</logic:messagesPresent></td></tr>
			


				</table>
			  <%@ include file="/WEB-INF/marco/fin.jsp"%>
			
				<table class="marco-titulo" border="0" cellspacing="1" cellpadding="1">
				<tr>
			       <td align=center><br><br>
				   <input type="button" class="botton" onclick="__submit();" id='actualizar' value="<bean:message key='lbl.actualiza.boton.actualizar'/>"/>
	    	 	</table>
	    </html:form> 
   </div></td></tr>
  <tr>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">
        <bean:message key="<%=copyrigth %>" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div>
     </td>
  </tr>
   
   </table>
			    <ajax:select
  baseUrl="${pageContext.request.contextPath}/populate/departamento"
  source="pais"
  target="departamento"
  parameters="pais={pais},t=1"
  postFunction="__changeCiudad"/> 
	    <ajax:select
  baseUrl="${pageContext.request.contextPath}/populate/ciudad"
  source="departamento"
  target="ciudad"
  parameters="pais={pais},departamento={departamento},t=1"/> 
		<ajax:select
  baseUrl="${pageContext.request.contextPath}/populate/departamento"
  source="paisEmpresa"
  target="departamentoEmpresa"
  parameters="pais={paisEmpresa},t=2"
  postFunction="__changeCiudadEmpresa"/>  
	    <ajax:select
  baseUrl="${pageContext.request.contextPath}/populate/ciudad"
  source="departamentoEmpresa"
  target="ciudadEmpresa"
  parameters="pais={paisEmpresa},departamento={departamentoEmpresa},t=2"/> 					
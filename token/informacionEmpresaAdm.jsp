<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>

<% 
String  introduccion = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "lbl.introduccion.formulario.actualizacion.panama"  : "lbl.introduccion.formulario.actualizacion.cayman";
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
<script type="text/javascript" src="<html:rewrite page='/scripts/common.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/subModal.js'/>"></script>

<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">




<div class="container">
	<div class="row" style="padding-right: 3%; padding-left: 3%;">

		<logic:messagesPresent>
			<div class="well col-md-4 col-md-offset-4">
				<img src="<html:rewrite page='/images/warning.gif'/>" border="0" hspace="8">
				<p><b><bean:message key="errors.header"/></b></p>
				<html:messages id="error">
					<p class="bienvenida">- <bean:write name="error" /></p>
				</html:messages>
			</div>
		</logic:messagesPresent>

		<div class="col-md-8 col-md-offset-2">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.actualiza.juridico.titulo"/>
					</strong>
				</div>

				<div class="panel-body">
					<html:form action="/salvaInformacionEmpresa.do">
						<ul>
							<li><bean:message key="<%=introduccion %>" /></li>
						</ul>
						<p>
							<bean:message key="lbl.actualiza.leyenda"/>
						</p>

						<p>
							<b><bean:message key="lbl.actualiza.juridico.titulo.2"/></b>
						</p>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font><bean:message key="lbl.actualiza.juridico.razon.social"/>
							</p>
						</div>
						<div class="col-md-8">
							<p style="form-control">
								<bean:write property="nombreEmpresa" name="frmPersona"/>
								<html:hidden property="nombreEmpresa"/>
							</p>
						</div>
						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font><bean:message key="lbl.actualiza.juridico.ruc"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<bean:write property="ruc" name="frmPersona"/>
								<html:hidden property="ruc"/>
							</p>
						</div>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font><bean:message key="lbl.actualiza.juridico.actividad.economica"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:select property="actividadEconomica" styleClass="form-control" styleId="actividadEconomica">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp0" scope="session" name="list_actividad_laboral" type="java.util.List"/>
									<html:options collection="cp0" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<logic:messagesPresent name="msg_actividadEconomica">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("actividadEconomica");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.actividad.ciiu"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:select property="actividadCIIU"
													styleClass="form-control" styleId="actividadCIIU">
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
											</html:select>
							</p>
						</div>
						<logic:messagesPresent name="msg_actividadCIIU">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("actividadCIIU");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.direccion.empresa"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:textarea styleId="direccionEmpresa" property="direccionEmpresa" cols="45" rows="3" styleClass="form-control" onkeypress="return imposeMaxLength(event, this, 200);"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_direccionEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("direccionEmpresa");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<bean:message key="lbl.actualiza.juridico.pais.empresa"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:select property="paisEmpresa" styleClass="form-control" styleId="paisEmpresa">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp2" scope="session" name="list_paises" type="java.util.List"/>
									<html:options collection="cp2" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>
						<logic:messagesPresent name="msg_paisEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("paisEmpresa");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<bean:message key="lbl.actualiza.juridico.departamento.empresa"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:select property="departamentoEmpresa" styleClass="form-control" styleId="departamentoEmpresa">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp4" scope="session" name="list_departamentos_emp" type="java.util.List"/>
									<html:options collection="cp4" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<p>
								<bean:message key="lbl.actualiza.juridico.ciudad.empresa"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:select property="ciudadEmpresa" styleClass="form-control" styleId="ciudadEmpresa">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp3" scope="session" name="list_ciudades_emp" type="java.util.List"/>
									<html:options collection="cp3" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.telefono.empresa"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:text styleId="telefonoEmpresa" property="telefonoEmpresa" styleClass="form-control" size="45" maxlength="20"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_telefonoEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("telefonoEmpresa");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<bean:message key="lbl.actualiza.juridico.fax.empresa"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:text styleId="faxEmpresa" property="faxEmpresa" styleClass="form-control" size="45" maxlength="20"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_faxEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("faxEmpresa");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.envio.correspondencia"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:select property="envioCorrespondencia" styleClass="form-control" onchange="__changeTipoEnvio(this)">
									<html:option value="">[Seleccione un valor]</html:option>
									<!--  	<html:option value="D">Dirección Física</html:option> -->
									<html:option value="C">Correo Electrónico</html:option>
									<html:option value="R">No Envíar - Consulta Por Internet</html:option>
								</html:select>
							</p>
						</div>
						<logic:messagesPresent name="msg_envioCorrespondencia">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("envioCorrespondencia");
							</script>
						</logic:messagesPresent>

						<div class="row">
							<html:hidden property="tipoCorreoElectronico" />
							<html:hidden property="tipoDireccionFisica" />
							<div id="__correoElectronico" style="display:<bean:write name='frmPersona' property='tipoCorreoElectronico'/>"></div>
						</div>


						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font><bean:message key="lbl.actualiza.juridico.correo.empresa"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:text property="correoElectronicoEmpresa" styleId="correoElectronicoEmpresa"  maxlength="50" styleClass="form-control"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_correoElectronicoEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("correoElectronicoEmpresa");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<bean:message key="lbl.actualiza.juridico.pagina.web"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:text styleId="paginaWeb" property="paginaWeb" styleClass="form-control" size="45" maxlength="50"/>
							</p>
						</div>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.natural.email.contacto"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:text property="emailContacto" styleId="emailContacto" styleClass="form-control" maxlength="50"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_emailContacto">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("emailContacto");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.natural.confirmar.email.contacto"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:text property="emailContacto2" styleId="emailContacto2" styleClass="form-control" maxlength="50"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_emailContacto2">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("emailContacto2");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.apoderado.legal.nombre"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:text styleId="nombre" property="nombre" styleClass="form-control" size="45" maxlength="40"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_nombre">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("nombre");
							</script>
						</logic:messagesPresent>
						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.identificacion"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:text styleId="identificacion" property="identificacion" styleClass="form-control" size="45" maxlength="20"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_identificacion">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("identificacion");
							</script>
						</logic:messagesPresent>
						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.nacionalidad"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:select property="nacionalidad" styleClass="form-control" styleId="nacionalidad">
									<bean:define id="cp10" scope="session" name="list_nacionalidad" type="java.util.List"/>
									<html:option value="-1">[Seleccione un valor]</html:option>
									<html:options collection="cp10" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>
						<logic:messagesPresent name="msg_nacionalidad">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("nacionalidad");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.nacionalidad.2"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:select property="nacionalidadSecundaria" styleClass="form-control" styleId="nacionalidadSecundaria">
									<bean:define id="cp8" scope="session" name="list_nacionalidad" type="java.util.List"/>
									<html:option value="-1">[Seleccione un valor]</html:option>
									<html:options collection="cp8" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>
						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.direccion"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:textarea styleId="direccion" property="direccion" styleClass="form-control" onkeypress="return imposeMaxLength(event, this, 100);" />
							</p>
						</div>

						<logic:messagesPresent name="msg_direccion">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("direccion");
							</script>
						</logic:messagesPresent>


						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font><<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.pais"/>
							</p>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="pais" styleClass="form-control" styleId="pais">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp6" scope="session" name="list_paises" type="java.util.List"/>
									<html:options collection="cp6" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>
						<logic:messagesPresent name="msg_pais">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("pais");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<bean:message key="lbl.actualiza.juridico.departamento"/>
							</p>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="departamento"
								styleClass="form-control" styleId="departamento">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp5" scope="session" name="list_departamentos" type="java.util.List"/>
									<html:options collection="cp5" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<p>
								<bean:message key="lbl.actualiza.juridico.ciudad"/>
							</p>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="ciudad" styleClass="form-control" styleId="ciudad">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp7" scope="session" name="list_ciudades" type="java.util.List"/>
									<html:options collection="cp7" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.telefono"/>
							</p>
						</div>

						<div class="col-md-8">
							<p>
								<html:text styleId="telefono" property="telefono" styleClass="form-control" size="45" maxlength="20"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_telefono">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("telefono");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.celular"/>
							</p>
						</div>

						<div class="col-md-8">
							<p>
								<html:text styleId="celular" property="celular" styleClass="form-control"  maxlength="20"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_celular">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("celular");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<p>
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.juridico.correo"/>
							</p>
						</div>

						<div class="col-md-8">
							<p>
								<html:text styleId="correoElectronico" property="correoElectronico" styleClass="form-control" maxlength="50"/>
							</p>
						</div>
						<logic:messagesPresent name="msg_correoElectronico">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("correoElectronico");
							</script>
						</logic:messagesPresent>

						<div class="col-md-12">
							<div align="center">
								<input type="button" class="btn btn-default" onclick="__submit();" id='actualizar' value="<bean:message key='lbl.actualiza.boton.actualizar'/>"/>
							</div>
						</div>

					</html:form> 
				</div>
			</div>
		</div>
	</div>
</div>

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

<%@ include file="../footer.jsp" %>
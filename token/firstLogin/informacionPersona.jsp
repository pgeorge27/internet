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
String  copyrigth 	 = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
String  paso		 = man.getUserFlag(session.getAttribute("user.id").toString())==ConstantesGlobales.ACTUALIZACION_INFORMACION ? "tit.title.first.login.paso6" :  "tit.title.atenticacion.paso7";
%>

<style>

.textfield, .textfield-fecha, .text, .textfield2, .text2, .textfield3, .textfield-m,.textfield-y {
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
.textfield-y{
width: 70px;
}
.textfield-m{
width: 50px;
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
function imposeMaxLength(Event, Object, MaxLen)
{
        return (Object.value.length < MaxLen)||(Event.keyCode == 8 ||Event.keyCode==46||(Event.keyCode>=35&&Event.keyCode<=40))
}
function __submit(){
	document.getElementById('actualizar').disabled = 'true';
	document.forms['frmPersona'].submit();
	//if (confirm("<bean:message key='lbl.actualiza.mensaje.confirmacion'/>")){
	//}
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
	updateDay(null);
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
            var d = new Date();
			
               function updateYear(year){
            	document.forms['frmPersona'].month.options.selectedIndex=0;
            	updateMonth(document.forms['frmPersona'].month);
            }

            function updateMonth(month){
                loadDay();
                updateDay(document.forms['frmPersona'].day);
            	document.forms['frmPersona'].day.options.selectedIndex=0;
            }
            function isLeapYear(year){
                var flag = 1;
            	Last2Digits = year % 100;
            	if (Last2Digits == 0){
            		flag = year % 400;
            	}
            	else{
            		flag = year % 4;
            	}
            	return flag==0;
            }
            function loadDay(){
                day = document.getElementById("day");                
                var len = 0;
                if (document.forms['frmPersona'].month.value!=""){
                	  switch(document.forms['frmPersona'].month.value){
	                    case '02':
	                        if (isLeapYear(parseInt(document.forms['frmPersona'].year.value))){
	                            len = 29;
	                        }else{
	                      		len = 28;
	                        }
	                      break;
	                    case '01': case '03': case '05': case '07': case '08': case '10': case '12':
	                      len = 31;
	                      break;
	                    default:
	                      len = 30;
	                      break;
	                }
	                var i = 0;
	                clearSelect(document.forms['frmPersona'].day);
	                var option = document.createElement('option');
	            	option.appendChild(document.createTextNode('  '));
                    document.forms['frmPersona'].day.appendChild(option);
	            	option.value='';
	                for(i=1; i<=len; i++){
	                    option = document.createElement('option');
	                    if (i < 10){
	                    	option.appendChild(document.createTextNode("0"+i));
	                    }
	                    else{
	                    	option.appendChild(document.createTextNode(i));
	                    }
	                    option.value = i;
	                    document.forms['frmPersona'].day.appendChild(option);
	                }
                }
            }

            function updateDay(day){
               if (document.forms['frmPersona'].day.options.length>0){
               	 var selectedDate = document.getElementById("selectedDate");
               	 var tem;
               	 switch(document.forms['frmPersona'].day.value){ 
               	 case '1' :	tem ='01';	break;
               	 case '2' : tem ='02';	break;
               	 case '3' :	tem ='03';  break;
                 case '4' :	tem ='04';  break;
                 case '5' :	tem ='05';  break;
                 case '6' :	tem ='06';  break;
                 case '7' :	tem ='07';  break;
                 case '8' :	tem ='08';	break;
                 case '9' :	tem ='09';	break;
                 default :tem = document.forms['frmPersona'].day.value;	break;
                 }
                 
               	   selectedDate.innerHTML= tem +'/'+
               					   document.forms['frmPersona'].month.value+'/'+
               					   document.forms['frmPersona'].year.value;
                 document.forms['frmPersona'].fechaNacimientoStr.value = tem +'/'+
												   document.forms['frmPersona'].month.value+'/'+
							   					   document.forms['frmPersona'].year.value;
               }
            }

            function clearSelect(select){
                select.options.length = 0;
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
				<bean:message key="<%=paso%>"/>
			</div>
		</div>
		<br>
		<br>

		<logic:present name="msg">
			<div align="center" class="well col-md-4 col-md-offset-4">
				<p><img src="<html:rewrite page='/images/warning.gif'/>"></p>
				<p><b><bean:message key="errors.header"/></b></p>
				<p class="fuente-principal">
					<%String error = session.getAttribute("msg").toString();%>
				<bean:message key="<%=error%>"/></p>
			</div>
		</logic:present>
		<% session.removeAttribute("msg");	%>

		<div class="col-md-8 col-md-offset-2">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.actualiza.titulo.persona"/>
					</strong>
				</div>
				<div class="panel-body">
					<html:form action="/salvaInformacionPersona.do">
						<ul>
							<li><bean:message key="<%=introduccion %>" /></li>
						</ul>
						<p><bean:message key="lbl.actualiza.leyenda"/></p>
						<p><b><bean:message key="lbl.actualiza.natural.titulo.2"/></b></p>

						<div class="col-md-4">
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.nombre"/>
						</div>
						<div class="col-md-8">
							<p class="form-control" >
								<bean:write property="nombre" name="frmPersona" />
								<html:hidden property="nombre"/>
							</p>
						</div>


						<div class="col-md-4">
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.primer.apellido"/>
						</div>
						<div class="col-md-8">
							<p class="form-control" >
								<bean:write property="primerApellido" name="frmPersona"/>
								<html:hidden property="primerApellido"/>
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.segundo.apellido"/>
						</div>
						<div class="col-md-8">
							<p class="form-control" >
								<bean:write property="segundoApellido" name="frmPersona"/>
								<html:hidden property="segundoApellido"/>
							</p>
						</div>

						<div class="col-md-4">
							<p>
								<bean:message key="lbl.actualiza.natural.apellido.casada"/>
							</p>
						</div>
						<div class="col-md-8">
							<p>
								<html:text property="apellidoCasada" styleClass="form-control" maxlength="25"/>
								<html:hidden property="segundoApellido"/>
							</p>
						</div>

						<div class="col-md-4">
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.identificacion"/>
						</div>
						<div class="col-md-8">
							<p class="form-control" >
								<bean:write property="identificacion" name="frmPersona"/>
								<html:hidden property="identificacion"/>
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.estado.civil"/>
						</div>
						<div class="col-md-8">
							<p>
								<html:select property="estadoCivil" styleClass="form-control">
									<html:option value="">[Seleccione un valor]</html:option>
									<html:option value="S">Soltero (a)</html:option>
									<html:option value="C">Casado (a)</html:option>
									<html:option value="D">Divorciado (a)</html:option>
									<html:option value="V">Viudo (a)</html:option>
									<html:option value="U">Unión Libre</html:option>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
								<font color="#FF0000">*</font>
								<bean:message key="lbl.actualiza.natural.fecha.nacimiento"/>
						</div>

						<div class="col-md-8">
							<p>
								<div class="col-md-4">
									<html:select property="year" styleClass="form-control" styleId="year" onchange="updateYear(this)">
										<bean:define id="cpYears" scope="session" name="list_years" type="java.util.List"/>
										<html:option value=""></html:option>
										<html:options collection="cpYears" property="key" labelProperty="value"/>
									</html:select>
								</div>

								<div class="col-md-4">
									<html:select styleClass="form-control" styleId="month" property="month" onchange="updateMonth(this)">
										<html:option value=""></html:option>
										<html:option value="01">01</html:option>
										<html:option value="02">02</html:option>
										<html:option value="03">03</html:option>
										<html:option value="04">04</html:option>
										<html:option value="05">05</html:option>
										<html:option value="06">06</html:option>
										<html:option value="07">07</html:option>
										<html:option value="08">08</html:option>
										<html:option value="09">09</html:option>
										<html:option value="10">10</html:option>
										<html:option value="11">11</html:option>
										<html:option value="12">12</html:option>
									</html:select>
								</div>

								<div class="col-md-4">
									<html:select styleClass="form-control" styleId="day" property="day" onchange="updateDay(this)">
										<bean:define id="cpDays" scope="session" name="list_days" type="java.util.List"/>
										<html:option value=""></html:option>
										<html:options collection="cpDays" property="key" labelProperty="value"/>
									</html:select>
								</div>

							</p>
						</div>
						<div class="col-md-8 col-md-offset-4">
							<p>
								Fecha: <span id="selectedDate"></span>
								<html:hidden property="fechaNacimientoStr" />
							</p>
						</div>

						<logic:messagesPresent name="msg_fechaNacimientoStr">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
								__setChangeColor("fechaNacimientoStr");
							</script>
						</logic:messagesPresent>



						<div class="col-md-4">
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.nacionalidad.1"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="nacionalidad"
								styleClass="form-control" styleId="nacionalidad">
									<bean:define id="cp1" scope="session" name="list_nacionalidad" type="java.util.List"/>
									<html:option value="">[Seleccione un valor]</html:option>
									<html:options collection="cp1" property="key" labelProperty="value"/>
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
							<bean:message key="lbl.actualiza.natural.nacionalidad.2"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="nacionalidadSecundaria"
									styleClass="form-control" styleId="nacionalidadSecundaria">
									<bean:define id="cp11" scope="session" name="list_nacionalidad" type="java.util.List"/>
									<html:option value="">[Seleccione un valor]</html:option>
									<html:options collection="cp11" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.actividad.laboral"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="actividadLaboral" styleClass="form-control" styleId="actividadLaboral">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp2" scope="session" name="list_actividad_laboral" type="java.util.List"/>
									<html:options collection="cp2" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
								<bean:message key="lbl.actualiza.natural.profesion"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="profesion" styleClass="form-control" styleId="profesion">
									<html:option value="">[Seleccione un valor]</html:option>
									<bean:define id="cp4" scope="session" name="list_profesiones" type="java.util.List"/>
									<html:options collection="cp4" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<p><b><bean:message key="lbl.actualiza.natural.titulo.3"/></b></p>

						<div class="col-md-4">
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.direccion"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:textarea property="direccion" styleId="direccion" cols="45" rows="3" styleClass="form-control" onkeypress="return imposeMaxLength(event, this, 200);" />
							</p>
						</div>

						<logic:messagesPresent name="msg_direccion">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
							__setChangeColor("direccion");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.pais"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="pais" styleClass="form-control" styleId="pais">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp5" scope="session" name="list_paises" type="java.util.List"/>
									<html:options collection="cp5" property="key" labelProperty="value"/>
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
							<bean:message key="lbl.actualiza.natural.departamento"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="departamento"
								styleClass="form-control" styleId="departamento">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp7" scope="session" name="list_departamentos" type="java.util.List"/>
									<html:options collection="cp7" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.ciudad"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="ciudad" styleClass="form-control" styleId="ciudad">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp6" scope="session" name="list_ciudades" type="java.util.List"/>
									<html:options collection="cp6" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.telefono.residencial"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:text property="telefono" styleId="telefono" styleClass="form-control"  maxlength="20"/>
							</p>
						</div>

						<logic:messagesPresent name="msg_telefono">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
							__setChangeColor("telefono");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.telefono.movil"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:text property="celular" styleId="celular" styleClass="form-control" maxlength="20"/>
							</p>
						</div>

						<logic:messagesPresent name="msg_celular">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
							__setChangeColor("celular");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.email.contacto"/>
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
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.confirmar.email.contacto"/>
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
							<font color="#FF0000">*</font>
							<bean:message key="lbl.actualiza.natural.envio.correspondencia"/>
						</div>

						<div class="col-md-8">
							<p>
							<html:select property="envioCorrespondencia" styleClass="form-control" onchange="__changeTipoEnvio(this)">
								<html:option value="">[Seleccione un valor]</html:option>
								<!--<html:option value="D">Dirección Física</html:option>-->
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

							<div id="__correoElectronico" style="display:<bean:write name='frmPersona' property='tipoCorreoElectronico'/>">
								<div class="col-md-4">
									<font color="#FF0000">*</font>
									<bean:message key="lbl.actualiza.natural.correo.electronico"/>
								</div>

								<div class="col-md-8">
									<html:text property="correoElectronico" styleId="correoElectronico" styleClass="textfield" maxlength="50"/>
								</div>

								<logic:messagesPresent name="msg_correoElectronico">
									<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
									<script type="text/javascript">
										__setChangeColor("correoElectronico");
									</script>
								</logic:messagesPresent>

							</div>
						</div>

						<p><b><bean:message key="lbl.actualiza.natural.titulo.4"/></b></p>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.nombre.empresa"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:text property="nombreEmpresa" styleClass="form-control"  maxlength="120"/>
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.cargo"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:text property="cargo" styleClass="form-control"  maxlength="50"/>
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.direccion.laboral"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:textarea property="direccionEmpresa" cols="45" rows="3" styleClass="form-control" onkeypress="return imposeMaxLength(event, this, 200);" />
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.pais.laboral"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="paisEmpresa" styleClass="form-control" styleId="paisEmpresa">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp12" scope="session" name="list_paises" type="java.util.List"/>
									<html:options collection="cp12" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.departamento.laboral"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="departamentoEmpresa" styleClass="form-control" styleId="departamentoEmpresa">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp10" scope="session" name="list_departamentos_emp" type="java.util.List"/>
									<html:options collection="cp10" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.ciudad.laboral"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:select property="ciudadEmpresa" styleClass="form-control" styleId="ciudadEmpresa">
									<html:option value="0">[Seleccione un valor]</html:option>
									<bean:define id="cp9" scope="session" name="list_ciudades_emp" type="java.util.List"/>
									<html:options collection="cp9" property="key" labelProperty="value"/>
								</html:select>
							</p>
						</div>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.telefono.oficina"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:text styleId="telefonoEmpresa" property="telefonoEmpresa" styleClass="form-control" maxlength="20"/>
							</p>
						</div>

						<logic:messagesPresent name="msg_telefonoEmpresa">
						<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
						<script type="text/javascript">
						__setChangeColor("telefonoEmpresa");
						</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.fax"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:text property="faxEmpresa" styleId="faxEmpresa" styleClass="form-control" maxlength="20"/>
							</p>
						</div>

						<logic:messagesPresent name="msg_faxEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
							__setChangeColor("faxEmpresa");
							</script>
						</logic:messagesPresent>

						<div class="col-md-4">
							<bean:message key="lbl.actualiza.natural.correo.electronico.laboral"/>
						</div>

						<div class="col-md-8">
							<p>
								<html:text property="correoElectronicoEmpresa" styleId="correoElectronicoEmpresa" styleClass="form-control" maxlength="50"/>
							</p>
						</div>

						<logic:messagesPresent name="msg_correoElectronicoEmpresa">
							<img src="<html:rewrite page='/images/warning_sml.gif'/>"/>
							<script type="text/javascript">
							__setChangeColor("correoElectronicoEmpresa");
							</script>
						</logic:messagesPresent>

						<div align="center">
							<input type="button" class="btn btn-default" onclick="__submit();" id='actualizar' value="<bean:message key='lbl.actualiza.boton.actualizar'/>"/>
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
  parameters="pais={pais},departamento={departamento}, t=1"/> 
		<ajax:select
  baseUrl="${pageContext.request.contextPath}/populate/departamento"
  source="paisEmpresa"
  target="departamentoEmpresa"
  parameters="pais={paisEmpresa}, t=2"
  postFunction="__changeCiudadEmpresa"/>  
	    <ajax:select
  baseUrl="${pageContext.request.contextPath}/populate/ciudad"
  source="departamentoEmpresa"
  target="ciudadEmpresa"
  parameters="pais={paisEmpresa},departamento={departamentoEmpresa}, t=2"/> 
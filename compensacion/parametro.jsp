<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>

<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>

<script language="javascript">
	function show(name)
	{
		var obj;
		obj = document.getElementById(name);
		obj.style.display = "block";
	}
	
	function hide(name)
	{
		var obj;
		obj = document.getElementById(name);
		obj.style.display = "none";
	}
	
	function showForm(name)
	{
		if (name == "parametro")
		{
			show("parametro");
			hide("representante");
		}
		else
		{
			show("representante");
			hide("parametro");
		}
	}
	function obSecuencia(tipo) 
	{
		
		if (tipo == "D")
		{
			document.forms['parametroForm'].secuenciaInicial.value = document.forms['parametroForm'].dia.value;
			document.forms['parametroForm'].secuencia.value = "";
			document.forms['parametroForm'].secuencia.maxLength = 3;
		}
		else
		if (tipo == "M")
		{
			document.forms['parametroForm'].secuenciaInicial.value = document.forms['parametroForm'].mes.value;
			document.forms['parametroForm'].secuencia.value = "";
			document.forms['parametroForm'].secuencia.maxLength = 3;
		}
		else
		if (tipo == "A")
		{
			document.forms['parametroForm'].secuenciaInicial.value = document.forms['parametroForm'].ano.value;
			document.forms['parametroForm'].secuencia.value = "";
			document.forms['parametroForm'].secuencia.maxLength = 3;
		}
		else
		{
			document.forms['parametroForm'].secuenciaInicial.value = "";
			document.forms['parametroForm'].secuencia.value = "";
			document.forms['parametroForm'].secuencia.maxLength = 5;
		}
	}
	
</script>

<!--  Funcion para Rellenar de Ceros -->
<%! String valores(int numero)
{
	String cad = String.valueOf(numero);
	String resp = "0";
	if (cad.length() < 2)
	{
		resp += cad;
	}
	else
		resp = cad;
	return resp;
}
%>
<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
Calendar cal = Calendar.getInstance();
int dia = cal.get(Calendar.DAY_OF_MONTH);
int ano = cal.get(Calendar.YEAR);
int mes = cal.get(Calendar.MONTH) + 1;
String anoCorto = String.valueOf(ano).substring(2,4);
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>
<%@ include file="../body.jsp" %>

<br>
<logic:messagesPresent>
  <table cellpadding="1" align="center" cellspacing="1" width="80%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
	<span class="bienvenida">
		<table width="80%">
		<html:messages id="error">					
			<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
		</html:messages>
		</table>
	</span><br>
								   </td></tr>
			 </table></td></tr>
		  </table>
</logic:messagesPresent>

<div align="center"> 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td	height="40"	valign="bottom">
		<div align="center">
		<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			<tr>
				<td class="bienvenida">
				<div align="left" class="login"><bean:message key="lbl.compensacion.parametro.titulo" /></div>
				</td>
				<td width="8%"><div align="right">&nbsp;
				<INPUT class="botton" onclick="document.location='<html:rewrite page='/mant/parametro.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td class="texto-acceso">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top">
			<html:form
			method="post"
			action="/grabar/parametro">
			<input type="hidden" name="dia" value="<%= valores(dia) %>" />
			<input type="hidden" name="mes" value="<%=valores(mes) %>" />
			<input type="hidden" name="ano" value="<%=anoCorto %>" />
			<html:hidden styleId="nuevo" property="nuevo"/>
			<html:hidden styleId="cuenta" property="cuenta"/>
			<input type="hidden" name="codigoCliente" id="codigoCliente"/>
			<div id="parametro" style="display:block">
			<table width="100%" border="0" cellpadding="5" cellspacing="1">
				<tr>
					<td colspan="2" height="20" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido" /></td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.cuenta" /></td>
					<td class="bienvenida"><div id="cuentaBanco" class="textbox" style="width:300px"><bean:write name="parametroForm" property="cuentaBanco"/></div></td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.cliente" /></td>
					<td class="bienvenida"><div id="nombreCliente" class="textbox" style="width:300px"><bean:write name="parametroForm" property="nombreCliente"/></div></td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.tipo.numeracion" />(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida" align="left">
					<input type="hidden" id="tipoNumeracion" name="tipoNumeracion2"/>
					<table width="100%" cellpadding="0" cellspacing="0" align="left">
						<tr><td align="left" class="bienvenida"><html:radio property="tipoNumeracion" styleId="_G" value="G" onclick="hide('form1')"/> <bean:message key="lbl.compensacion.parametro.tipo.numeracion.global" /></td>
							<td></td></tr>
						<tr><td align="left" class="bienvenida"><html:radio property="tipoNumeracion" styleId="_F" value="F" onclick="show('form1')"/> <bean:message key="lbl.compensacion.parametro.tipo.numeracion.por.formulario" /></td>
							<td align="left">
								<div id="form1" style="display:none">
								<table width="100%">
									<tr><td class="bienvenida"><bean:message key="lbl.compensacion.parametro.formulario" /></td>
									<td class="bienvenida"><html:select styleId="formulario" property="formulario" styleClass="botton-acceso">									
											<bean:define id="cp1" scope="session" name="formularios" type="java.util.ArrayList"/>
				                            <html:options collection="cp1" property="codigo" labelProperty="descripcion"/>
										</html:select></td></tr>
								</table>
								</div>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.tipo.periodo" />(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida">
					<input type="hidden" name="tipoPeriodo2" id="tipoPeriodo"/>
						<table width="100%">
						<tr><td class="bienvenida"><html:radio property="tipoPeriodo" styleId="_A" value="A" onclick="obSecuencia('A')" /> <bean:message key="lbl.compensacion.parametro.tipo.periodo.anual" /></td>
							<td class="bienvenida"><html:radio property="tipoPeriodo" styleId="_S" value="S" onclick="obSecuencia('S')" /> <bean:message key="lbl.compensacion.parametro.tipo.periodo.semestral" /></td>
							<td class="bienvenida"><html:radio property="tipoPeriodo" styleId="_T" value="T" onclick="obSecuencia('T')" /> <bean:message key="lbl.compensacion.parametro.tipo.periodo.trimestral" /></td></tr>
						<tr><td class="bienvenida"><html:radio property="tipoPeriodo" styleId="_B" value="B" onclick="obSecuencia('B')" /> <bean:message key="lbl.compensacion.parametro.tipo.periodo.bimestral" /></td>
							<td class="bienvenida"><html:radio property="tipoPeriodo" styleId="_M" value="M" onclick="obSecuencia('M')" /> <bean:message key="lbl.compensacion.parametro.tipo.periodo.mensual" /></td>
							<td class="bienvenida"><html:radio property="tipoPeriodo" styleId="_D" value="D" onclick="obSecuencia('D')" /> <bean:message key="lbl.compensacion.parametro.tipo.periodo.diario" /></td></tr>
						</table>
					</td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.secuencia.actual" />(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida">
						<table width="100%">
							<tr>
								<td class="bienvenida" align="left">
									<html:text styleId="secuenciaInicial" property="secuenciaInicial" size="4" styleClass="botton-acceso" readonly="true" />
									&nbsp;<html:text styleId="secuenciaActual" property="secuenciaActual" size="7" styleClass="botton-acceso" maxlength="5" readonly="true"/>
								</td>
								<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.secuencia.inicial" /></td>
								<td class="bienvenida"> <!-- <div id="secuencia" class="textbox" style="width:75px"><bean:write name="parametroForm" property="secuencia"/></div> -->
											<html:text styleId="secuencia" property="secuencia" size="7" styleClass="botton-acceso" maxlength="5"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida">Dias para Aviso Banco de la República(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida">&nbsp;<html:text styleId="diasAviso" property="diasAviso" size="6" maxlength="5" styleClass="botton-acceso" /></td>
					<td class="bienvenida">Dias para Aviso Dian(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida">&nbsp;<html:text styleId="diasAvisoDian" property="diasAvisoDian" size="6" maxlength="5" styleClass="botton-acceso" /></td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.cuenta.compensacion" />(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida"><input type="hidden" name="mostrarNit" id="mostrarNit" value="C">
					<input type="hidden" name="mostrarNit2" id="mostrarNit">
					<html:text property="ctaCompensacion" maxlength="12" styleId="ctaCompensacion" styleClass="botton-acceso"/>
					</td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida">Saldo de Inversión</td>
					<td class="bienvenida">
					<html:text property="saldoMesAnt" maxlength="11" styleId="cuentaCompensacion" styleClass="botton-acceso"/>
					</td>
				</tr>				
			 </table>
		   </div>
		</td>
	</tr>
	<tr>
		<td align="right">
		<html:submit styleClass="botton">Aceptar</html:submit>&nbsp;&nbsp;
		<INPUT class="botton" onclick="document.location='<html:rewrite page='/mant/parametro.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
	</tr>
</table>
</html:form></div>
<script type="text/javascript">
	function __init(){
		var field = "_F";
		var obj;
		if (document.getElementById){
			obj = document.getElementById(field);
		}
		else{
			eval("obj="+field);
		}
		if (obj){
			if (obj.checked == true){
				show('form1');
			}
			else{
				hide('form1');
			}
		}
	}
	function __refresh(){
		var obj;
		var field = "_G";
		if (document.forms['parametroForm'].tipoNumeracion2.value == "G"){
			field = "_G";
			hide('form1');
		}
		else{
			field = "_F";
			show('form1');
		}
		_setCheckBox(field);
		var field2 = "";
		if (document.forms['parametroForm'].tipoPeriodo2.value == "A"){
			field = "_A";
			field2 = "A";
		}
		else if (document.forms['parametroForm'].tipoPeriodo2.value == "S"){
			field = "_S";
			field2 = "S";
		}
		else if (document.forms['parametroForm'].tipoPeriodo2.value == "T"){
			field = "_T";
			field2 = "T";
		}
		else if (document.forms['parametroForm'].tipoPeriodo2.value == "B"){
			field = "_B";
			field2 = "B";
		}
		else if (document.forms['parametroForm'].tipoPeriodo2.value == "M"){
			field = "_M";
			field2 = "M";
		}
		else if (document.forms['parametroForm'].tipoPeriodo2.value == "D"){
			field = "_D";
			field2 = "D";
		}
		_setCheckBox(field);
		obSecuencia();	
		
		
		if (document.forms['parametroForm'].mostrarNit2.value == "N"){
			field = "_N";
		}else if (document.forms['parametroForm'].mostrarNit2.value == "C"){
			field = "_C";
		}
		_setCheckBox(field);
	}
	function _setCheckBox(field){
		if (document.getElementById){
			obj = document.getElementById(field);
		}
		else{
			eval("obj="+field);
		}
		if (obj)
			obj.checked = true;
	}
</script>

<%@ include file="../footer.jsp"  %>	
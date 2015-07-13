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
function __retornar(){
	document.location="<html:rewrite page='/mant/representante.do'/>";
}	
function __submit()
{
	document.forms[3].submit();
}
function __edit(index)
{
	document.forms[1].cuenta.value=document.forms[3].cuenta.value;
	document.forms[1].indice.value=index;
	document.forms[1].submit();
}
function __delete(index)
{
	document.forms[2].cuenta.value=document.forms[3].cuenta.value;
	document.forms[2].indice.value=index;
	document.forms[2].submit();
}	
function __create()
{
	if (document.forms[3].cuenta.value!= ""){
		document.forms[0].submit();
	}
	else{
		alert("<bean:message key="msg.seleccionar.cuenta"/>");
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

<html:form method="post" action="/create/parametro">
	<html:hidden property="cuenta"/>
</html:form>
<html:form method="post" action="/edit/parametro">
	<html:hidden property="indice"/>
	<html:hidden property="cuenta"/>
</html:form>
<html:form method="post" action="/delete/parametro">
	<html:hidden property="indice"/>
	<html:hidden property="cuenta"/>
</html:form>
<html:form method="post" action="/mant/parametro">
<div align="center"> 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td	height="40"	valign="bottom" colspan="2">
		<div align="center">
		<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			<tr>
				<td class="bienvenida">
				<div align="left" class="login"><bean:message key="lbl.compensacion.parametro.titulo" /></div>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr valign="middle">
					<td width="20%" class="bienvenida"><bean:message key="lbl.compensacion.parametro.cuenta" />(<font color="#FF0000">*</font>)</td>
					<td width="80%" class="bienvenida"><html:select property="cuenta" styleClass="botton-acceso" onchange="__submit();">
									<logic:notEmpty name="cuentasCompensacion">
											<html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
											<bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
				                            <html:options collection="cp" property="codigoCSIC" labelProperty="tag"/>
										   
									</logic:notEmpty>
									<logic:empty name="cuentasCompensacion">
										<html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
									</logic:empty>
									</html:select>
									</td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.cliente" /></td>
					<td class="bienvenida"><div id="nombreCliente" class="textbox" style="width:300px"><bean:write name="parametroForm" property="nombreCliente"/></div></td>
				</tr>
				<tr>
		<td class="texto-acceso">&nbsp;</td></tr>
	<tr>
		<td class="texto-acceso">&nbsp;<input class="botton" type="button" name="btnnew" value="<bean:message key='lbl.compensacion.parametro.nuevo' />" onclick="__create();"/></td>
	</tr>
	<tr>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="1" cellspacing="2">
			<tr class="tabla-acceso">
			    <td class="texto-acceso" width="10%" nowrap><bean:message key="lbl.compensacion.parametro.tipo.numeracion"/></td>
			    <td class="texto-acceso" width="35%"><bean:message key="lbl.compensacion.parametro.formulario"/></td>			    
			    <!--    <td class="texto-acceso" width="10%"><bean:message key="lbl.compensacion.parametro.cuenta.compensacion"/></td>  -->
			    <td class="texto-acceso" width="10%"><bean:message key="lbl.compensacion.parametro.tipo.periodo"/></td>
			    <td class="texto-acceso" width="10%"><bean:message key="lbl.compensacion.parametro.secuencia.actual"/></td>
			    <td class="texto-acceso" width="10%">Días Aviso Banco de la República</td>
			    <td class="texto-acceso" width="10%">Días Aviso Dian</td>
			    <td class="texto-acceso" width="15%"></td></tr>
			<logic:notEmpty name="parametros.cuenta">
				<logic:iterate name="parametros.cuenta" id="row"
					type="com.arango.internet.banking.ParametroCuentaCompensacion" indexId="resultNo" >
					<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
				    <logic:equal name="remainder" value="0">
				       <tr>
				    </logic:equal>
				    <logic:notEqual name="remainder" value="0">
				       <tr class="celda-clave1">
				    </logic:notEqual>
				    <td class="bienvenida">
				    <logic:equal name="row" property="tipoNumeracion" value="G" >
				    	<bean:message key="lbl.compensacion.parametro.tipo.numeracion.global" />
				    </logic:equal>
				    <logic:equal name="row" property="tipoNumeracion" value="F" >
				    	<bean:message key="lbl.compensacion.parametro.tipo.numeracion.por.formulario" />
				    </logic:equal></td>
				      <td class="bienvenida">
				    
				    <bean:write name="row" property="formulario"/> - 
				    <bean:write name="row" property="nombreFormulario"/></td>
				      <!--  <td class="bienvenida"><bean:write name="row" property="cuentaCompensacion"/></td>  -->
				    
				    <td class="bienvenida">
					    <logic:equal name="row" property="tipoPeriodo" value="A" >
					    	<bean:message key="lbl.compensacion.parametro.tipo.periodo.anual" />
					    </logic:equal>
					    <logic:equal name="row" property="tipoPeriodo" value="S" >
					    	<bean:message key="lbl.compensacion.parametro.tipo.periodo.semestral" />
					    </logic:equal>
					    <logic:equal name="row" property="tipoPeriodo" value="T" >
					    	<bean:message key="lbl.compensacion.parametro.tipo.periodo.trimestral" />
					    </logic:equal>
					    <logic:equal name="row" property="tipoPeriodo" value="B" >
					    	<bean:message key="lbl.compensacion.parametro.tipo.periodo.bimestral" />
					    </logic:equal>
					    <logic:equal name="row" property="tipoPeriodo" value="M" >
					    	<bean:message key="lbl.compensacion.parametro.tipo.periodo.mensual" />
					    </logic:equal>
					    <logic:equal name="row" property="tipoPeriodo" value="D" >
					    	<bean:message key="lbl.compensacion.parametro.tipo.periodo.diario" />
					    </logic:equal></td>
				    <td class="bienvenida"><bean:write name="row" property="secuenciaActual"/></td>
				    <td class="bienvenida"><bean:write name="row" property="diasAviso"/></td>
				    <td class="bienvenida"><bean:write name="row" property="diasAvisoDian"/></td>
				    <td class="bienvenida"><input type="button" class="botton" name="btnedit" onclick="__edit(<%=resultNo.intValue()%>)" value="<bean:message key='lbl.compensacion.parametro.editar' />"/>&nbsp;
				    	<input type="button" class="botton" name="btndel" onclick="__delete(<%=resultNo.intValue()%>)" value="<bean:message key='lbl.compensacion.parametro.eliminar' />"/></td>
				</logic:iterate>
			</logic:notEmpty>
			</table>
	</td></tr>
	
	<tr>
					<td align="center" colspan="2"><input type="button" class="botton" name="btnpc" onclick="__retornar()" value="<bean:message key='lbl.compensacion.parametro.titulo.2' />"/></td></tr>
	
</table></div></html:form>
<%@ include file="../footer.jsp"  %>	
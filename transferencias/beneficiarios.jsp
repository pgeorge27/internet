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
	history.back();
	}
function __submit()
{
	//document.forms['listaPlantillaForm'].submit();
	document.getElementById('beneForm').submit();
}

function __edit(index, secuencia)
{
	var form = document.getElementById('editBeneForm');
	form.indice.value=index;
	form.secuencia.value=secuencia;
	form.submit();
}

function __delete(index, secuencia){
	
	if(confirm("¿Desea eliminar el registro seleccionado?")){
	
		var form = document.getElementById('deleteBeneForm');
		
		form.indice.value=index;
		form.secuencia.value=secuencia;
		form.submit();
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
		<tr>
			<td>
			<table border="0" cellpadding="1" cellspacing="0" width="100%">
				<tr valign="top">
					<td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
					<td width="95%" class="msg">
						<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
						<span class="bienvenida">
							<table width="80%">
							<html:messages id="error">					
								<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
							</html:messages>
							</table>
						</span><br>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</logic:messagesPresent>

<html:form method="post" styleId="editBeneForm" action="/edit/beneficiario">
	<html:hidden property="indice"/>
	<html:hidden property="secuencia"/>
</html:form>
<html:form method="post" styleId="deleteBeneForm" action="/delete/beneficiario">
	<html:hidden property="indice"/>
	<html:hidden property="secuencia"/>
</html:form>

<html:form method="post" styleId="beneForm" action="/mant/beneficiarios">
<div align="center"> 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td	height="40"	valign="bottom" colspan="2">
		<div align="center">
		<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			<tr>
				<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
				<td class="bienvenida">
				<div align="left" class="login"><bean:message key="lbl.beneficiarios.general.mnu" /></div>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr valign="middle">
		<td colspan="2" align="center" width="30%">
			<%@ include file="../divHeader.jsp"%>
			<table width="200px">
				<tr>
					<td width="30%" align="right" class="bienvenida"><div align="right" class="texto-acceso"><bean:message key="lbl.transf.inter.cliente" /></div></td>
					<td width="80%" class="bienvenida" align="right">
						<html:select property="cliente" styleClass="botton-acceso" onchange="__submit();">
							<logic:notEmpty name="clientes.plantillas">
								<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
								<bean:define id="cp" scope="session" name="clientes.plantillas" type="java.util.ArrayList"/>
								<html:options collection="cp" property="codigo" labelProperty="nombre"/>
							</logic:notEmpty>
							<logic:empty name="clientes.plantillas">
								<html:option value=""><bean:message key="lbl.seleccione.no.hay.clientes"/></html:option>
							</logic:empty>
						</html:select>
					</td>
				</tr>
			</table>
			<%@ include file="../divFooter.jsp"%>
		</td>
	</tr>
	<tr><td class="texto-acceso">&nbsp;</td></tr>
	<tr>
		<td valign="top" colspan="2">
			<table width="100%" border="0" cellpadding="1" cellspacing="2">
				<tr class="tabla-acceso">
					<td class="texto-acceso" width="25%" nowrap><bean:message key="lbl.beneficiario.nombre"/></td>
					<td class="texto-acceso" width="25%" nowrap><bean:message key="lbl.beneficiario.cuenta"/></td>
					<td class="texto-acceso" width="25%" nowrap><bean:message key="lbl.beneficiario.banco"/></td>
					<td class="texto-acceso" width="25%"></td>
				</tr>
				<logic:notEmpty name="beneficiarios">
				<logic:iterate name="beneficiarios" id="row" type="com.arango.common.beans.BeneficiarioBean" indexId="resultNo" >
					<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
				    <logic:equal name="remainder" value="0">
				       <tr>
				    </logic:equal>
				    <logic:notEqual name="remainder" value="0">
				       <tr class="celda-clave1">
				    </logic:notEqual>
				    
				    <td class="bienvenida">
				    	<bean:write name="row" property="nombre" />
				    </td>
				    <td class="bienvenida">
				    	<bean:write name="row" property="cuenta" />
				    </td>
				    <td class="bienvenida">
				    	<bean:write name="row" property="banco" />
				    </td>
					<td class="bienvenida">
						<input type="button" class="botton" name="btnedit" onclick="__edit(<%=resultNo.intValue()%>, <bean:write name="row" property="secuencia" />)" value="<bean:message key='lbl.compensacion.parametro.editar' />"/>&nbsp;
						<input type="button" class="botton" name="btndel" onclick="__delete(<%=resultNo.intValue()%>, <bean:write name="row" property="secuencia" />)" value="<bean:message key='lbl.compensacion.parametro.eliminar' />"/>
					</td>
				</tr>
				</logic:iterate>
				</logic:notEmpty>
			</table>
		</td>
	</tr>
</table>
</div>
</html:form>
<%@ include file="../footer.jsp"  %>
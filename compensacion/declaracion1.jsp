<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<!DOCTYPE html>
<html:html>


<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="com.arango.common.util.Format" %>
<%@page import="com.arango.internet.banking.Movimiento" %>
<%@page import="com.arango.internet.banking.EstadoCuenta" %>
<%@page import="com.arango.internet.banking.Titular" %>

<%! Format f = Format.getFormat();%>


<%@ include file="../head.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
%>
<%
Object objEstCta = session.getAttribute("movimiento");
EstadoCuenta ec = null;
java.util.ArrayList mov = null;

if (objEstCta instanceof com.arango.internet.banking.EstadoCuenta){
	ec = (EstadoCuenta)objEstCta;
	mov = ec.Movimientos;
}
else{
}

if (ec == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/compensacion/seleccion.jsp");   
	return;
}
String cuenta = (String)session.getAttribute("cuenta.banco");
String cliente = "";
if (ec.Titulares != null && !ec.Titulares.isEmpty())
    	cliente = ((Titular)ec.Titulares.get(0)).getNombre();
%>

<script>
function _submit(_path){
	document.forms[0].ruta.value = ""+_path;
	openwin("<html:rewrite page='/compensacion/formulario5.jsp'/>?cuenta=<%=session.getAttribute("cuenta.csic")%>&ruta="+_path);
	document.location="<html:rewrite page='/compensacion/declaracion1.jsp'/>";
}
function openwin(url)
{
	nwin=window.open(url, "nwin",config="scrollbars=no,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no");
	nwin.focus();
}

</script>
<html:form action="/consultar/formulario1" method="post" target="_formulario">
	
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
	<html:hidden property="ruta" />
</html:form>
<body>
<%@ include file="../body.jsp" %>

<div class="container">


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



<div align="right"><INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/compensacion/seleccionsinMovimiento.jsp'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></div>


<br>

	<div class="row">
		<div>
			<div class="panel panel-default" >
				<div class="panel-heading">
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong><bean:message key="lbl.compensacion.movimiento.titulo"/></strong>
				</div>

</div>

</div>


<br>


<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.numero.cuenta"/>:</strong></div>
  <div class="col-md-1"></div>
  <div class="col-md-3" align="left"><%=f.formatCuenta(ec.getNumeroCuenta())%></div>
  <div class="col-md-1"></div>
</div>	

<br>


<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-3" align="left"><strong><bean:message key="lbl.titular"/>:</strong></div>
  <div class="col-md-1"></div>
  <div class="col-md-3" align="left"><%=cliente %></div>
  <div class="col-md-1"></div>
</div>	



<br>



<div align="center"><b>FORMULARIOS REGIMEN CAMBIARIO</b></div>

<br>
<br>


			 <div id="no-more-tables">
            <table class="col-md-12 table-bordered table-striped table-condensed cf">
        		<thead class="cf">
        			<tr>
        				<th>Formulario</th>
        				<th>Documento</th>
        			</tr>
        		</thead>
        		<tbody>
        			<tr>
        				<td data-title="Formulario"><font size="1">
								<a  href="javascript:_submit('Formulario3A.pdf');">
								Formulario No. 3A - Informe de Desembolsos y Pagos de Endeudamiento Externo</a>
							</font></td>
        				<td data-title="Documento"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/Instr3A20031201.pdf">
								Instrucciones</a>
							</font></td>
        		
        			</tr>
			</tbody>
			
        		<tbody>
        			<tr>
        				<td data-title="Formulario"><a  href="javascript:_submit('Formulario6.pdf');">
								Formulario No. 6 - Información de Endeudamiento Externo otorgado a Residentes</a></td>
        				<td data-title="Documento"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/InstrF620031201.pdf">
								Instrucciones</a>
							</font></td>
        		
        			</tr>
			</tbody>
			
			
			
			        		<tbody>
        			<tr>
        				<td data-title="Formulario"><font size="1">
								<a  href="javascript:_submit('Formulario7.pdf');">
								Formulario No. 7 - Información de Endeudamiento Externo otorgado a no Residentes</a></td>
        				<td data-title="Documento"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>"  height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/instr720031201.pdf">
								Instrucciones</a>
							</font></td>
        		
        			</tr>
			</tbody>
			
			
			
			
			
			
					        		<tbody>
        			<tr>
        				<td data-title="Formulario"><font size="1">
								<a  href="javascript:_submit('Formulario8.pdf');">
								Formulario No. 8 - Registro de Avales y Garantías en Moneda Extranjera</a></td>
        				<td data-title="Documento"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/instr820031201.pdf">
								Instrucciones</a>
							</font></td>
        		
        			</tr>
			</tbody>
			
			
			
								        		<tbody>
        			<tr>
        				<td data-title="Formulario"><font size="1">
								<a  href="javascript:_submit('Formulario9.pdf');">
								Formulario No. 9 - Registro de Cuenta Corriente de Compensación</a></td>
        				<td data-title="Documento"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/Instr920031201.pdf">
								Instrucciones</a>
							</font></td>
        		
        			</tr>
			</tbody>
			
			
			
											        		<tbody>
        			<tr>
        				<td data-title="Formulario"><font size="1">
								<a  href="javascript:_submit('Formulario11.pdf');">
								Formulario No. 11 Hoja 1 - Registro de Inversiones Internacionales</a></td>
        				<td data-title="Documento"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/Instr1120031201.pdf">
								Instrucciones</a>
							</font></td>
        		
        			</tr>
			</tbody>
			
			
			
			
			
														        		<tbody>
        			<tr>
        				<td data-title="Formulario"><font size="1">
								<a  href="javascript:_submit('Formulario13.pdf');">
								Formulario No. 13 - Registro de Inversión Suplementaria al Capital Asignado y 
								actualizaciond e cuentas patrimoniales - Sucursales del Régimen Especial</a></td>
        				<td data-title="Documento"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/Instr1320031201.pdf">
								Instrucciones</a>
							</font></td>
        		
        			</tr>
			</tbody>
			
			
			
																	        		<tbody>
        			<tr>
        				<td data-title="Formulario"><font size="1">
								<a  href="javascript:_submit('Formulario15.pdf');">
								Formulario No. 15 - Conciliación Patrimonial - Empresas y Sucursales Régimen General</a></td>
        				<td data-title="Documento"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/instr1520031201.pdf">
								Instrucciones</a>
							</font></td>
        		
        			</tr>
			</tbody>

																				        		<tbody>
        			<tr>
        				<td data-title="Formulario"><font size="1">
								<a  href="javascript:_submit('Formulario17.pdf');">
								Formulario No. 17 - Solicitud de Prórroga para el Registro de Inversiones Internacionales</a></td>
        				<td data-title="Documento"><font size="1">
								<img src="<html:rewrite page='/images/icono_acrobat.gif'/>" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/instr1720031201.pdf">
								Instrucciones</a>
							</font></td>
        		
        			</tr>
			</tbody>
			
		</table>	
			</div>	

		</div>
<br>
<br>
<div align="center"><INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/compensacion/movimiento.jsp'/>'" type=button value="<bean:message key="lbl.retroceder"/>"></div>

<br>
<%@ include file="../footer.jsp"  %>	
</div>

</body>
</html:html>
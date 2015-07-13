<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@page import="com.arango.common.util.Format"%>
<%@page import="com.arango.internet.banking.Titular"%>
<%@page import="com.arango.internet.banking.EstadoCuenta"%>
<%@page import="com.arango.internet.banking.Movimiento"%>
<%@page import="com.arango.common.util.StringUtilities" %>


<%
int[] dias = (int[])session.getAttribute("cant.dias.vencimientos");
%>


<%@page import="java.util.Locale"%><script languaje="javascript">
   var dias = <%=dias[0]%>;  
  function ValidarFecha(){
        var campoFecha = document.forms['vencimientoForm'].fecha.value;	
        if (campoFecha != ""){	
		var dia = campoFecha.substring(0,2);			
		var mes = campoFecha.substring(3,5);			  
		var anio = parseInt(campoFecha.substring(6,10));
		
		var fecha = new Date(anio,mes-1, dia);	
           fecha.setDate(fecha.getDate()+ dias);
		 
		    var strdia = fecha.getDate();
			
			var strmes = fecha.getMonth();
			var stranio = fecha.getFullYear();
			if(strdia >= 0 && strdia <= 9){
			       strdia = "0"+ strdia;
			}			
			 strmes += 1;
			if(strmes >= 0 && strmes <= 9)   {
			       strmes = "0" + strmes;
			}			
			
			var cadenadia =  strdia +"-" + strmes + "-" +stranio ;					 
		   
			document.forms['vencimientoForm'].vencimiento.value = cadenadia;
        }
  
  }
  function __digitOnly(obj){
	
	if ((event.keyCode < 48) || (event.keyCode > 57)) {		
			switch(event.keyCode){		
			 default : event.returnValue = false;
			 		   break;
			}
	}
}
function __digit(obj){
	
	if ((event.keyCode < 48) || (event.keyCode > 57)) {		
			switch(event.keyCode){			 
			 case 46 : // .
			 		   if (obj != null && obj.value != ""){
							index = obj.value.indexOf(".");
							if (index >= 0){
								event.returnValue = false;
							}
						}
					   break;
			 default : event.returnValue = false;
			 		   break;
			}
	}
}
function __retornar(){
	document.forms['backForm'].submit();
}
</script>
<%

 Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}

 String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar.js'/>"></script>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">
<%@ include file="../body.jsp" %>

<logic:messagesPresent>
  <table cellpadding="1" align="center" cellspacing="1" width="100%" class="tabla-acceso">
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

<form action="<html:rewrite page='/vencimiento/modificacion/consulta.do'/>" name="backForm" method="post">
	<input type="hidden" name="cuenta" value="<%=(String)session.getAttribute("consulta.vencimiento.cuenta")%>"/>
	<input type="hidden" name="desde" value="<%=(String)session.getAttribute("consulta.vencimiento.fecha.desde")%>"/>
	<input type="hidden" name="hasta" value="<%=(String)session.getAttribute("consulta.vencimiento.fecha.hasta")%>"/>
	<input type="hidden" name="tipoVencimiento" value="<%=(String)session.getAttribute("tipo.vencimiento")%>"/>
	
</form>

<html:form method="post" action="/vencimiento/importacion">
<input type="hidden" name="opcion" value="importacion"/>
<html:hidden property="indice"/>
<html:hidden property="secuenciaRegistro"/>
<html:hidden property="numeroDeclaracion"/>

<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" >
<tr>
	 <td><div align="left" class="login"><img src="<html:rewrite page='/images/gancho.gif'/>" border="0" style=" width : 24px;">Información de Importación</div></td>
	 <td width="8%">
	  <logic:notEmpty name="vencimientoForm" property="indice">
	 <div align="right">&nbsp;&nbsp;							
			<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>">
			</div></logic:notEmpty>
							</td>
</tr>
<tr><td>&nbsp;&nbsp;</td></tr> 
</table>
<table align="center"><tr><td>
<%@ include file="../divHeader.jsp"%> 
<table width="100%" border="0" cellpadding="1" cellspacing="1"  align="right">
<tr class="bienvenida">
    <td class="celda-clave1">Número de Cuenta</td>
    <td>
    	<logic:notEqual name="vencimientoForm" property="update" value="true">
	        <html:select property="cuenta" styleClass="lstbox">
					<logic:notEmpty name="cuentasCompensacion">
							<html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
							<bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
		                          <html:options collection="cp" property="codigoCSIC" labelProperty="tag"/>
						   
					</logic:notEmpty>
					<logic:empty name="cuentasCompensacion">
						<html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
					</logic:empty>	
		    </html:select>	 <span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
	   </logic:notEqual>
	    <logic:equal name="vencimientoForm" property="update" value="true">
	     	<html:hidden property="cuenta"/>
	    	<b><bean:write name="vencimientoForm" property="cuentaBanco"/></b>
	    </logic:equal>
	 </td>
</tr>
<tr class="bienvenida">
   <Td class="celda-clave1">Documento Transporte</Td>   
   <td><logic:notEqual name="vencimientoForm" property="update" value="true">

	    <html:text  styleClass="botton-acceso" property="docTransporte" size="30%" maxlength="30" />
	    </logic:notEqual>
   		<logic:equal name="vencimientoForm" property="update" value="true">
	     <html:text  styleClass="botton-acceso" property="docTransporte" size="30%" maxlength="30"  onkeypress="javascript: return false;" onkeydown="javascript: return false;" />
	    </logic:equal>
   </td>
   
</tr>
<tr class="bienvenida"> 
   <td class="celda-clave1">Fecha Transporte</td>
   <td class="bienvenida">
       <html:text property="fecha" styleClass="botton-acceso" size="30" maxlength="12" onblur="ValidarFecha()"/>
       <input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('fecha', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]
   </td> 
</tr>
<tr class="bienvenida">
   <td class="celda-clave1">Número Importación</td>
   <td><html:text  styleClass="botton-acceso" property="numImportacion" size="30%" maxlength="16" onblur="ValidarFecha();"  onclick="ValidarFecha()"></html:text></td>   
</tr>
<tr class="bienvenida">
    <td class="celda-clave1">Valor USD</td>
    <td><html:text  styleClass="botton-acceso" property="usd" size="30%" maxlength="20" onblur="ValidarFecha();" onkeypress="__digit(this);"/></td>
</tr>
<tr class="bienvenida">
   <td class="celda-clave1">Proveedor</td>
   <td><html:text  styleClass="botton-acceso" property="proveedor" size="30%" maxlength="150"/></td>
</tr>
<tr class="bienvenida">
   <td class="celda-clave1">Vencimiento(<%=dias[0] %> días)</td>
   <td><html:text styleClass="botton-acceso"  property="vencimiento" size="30%" maxlength="10"   readonly="true"/></td>   
</tr>
<tr><td><h1></h1></td></tr>
      <tr align="center">
	      <td colspan="2" ><input class="botton" type="button" value="Aceptar" onclick="submit()"/></td>
	  </tr>
</table>
<%@ include file="../divFooter.jsp"%>
</td></tr>
</table>
<table align="center" >
      <tr>
	      <td height="20" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
 
	  </tr>
   </table>
</html:form>


<%@ include file="../footer.jsp" %>
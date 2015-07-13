
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@page import="com.arango.common.util.Format"%>
<%@page import="com.arango.internet.banking.Titular"%>
<%@page import="com.arango.internet.banking.EstadoCuenta"%>
<%@page import="com.arango.internet.banking.Movimiento"%>
<%@page import="com.arango.common.util.StringUtilities" %>
<%@ page import="java.util.Locale" %>
<%
int[] dias = (int[])session.getAttribute("cant.dias.vencimientos");



 Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}

 String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>

<%@ include file="../head.jsp"%>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>

<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar.js'/>"></script>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script languaje="javascript">
   var dias = <%=dias[2]%>;   
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
function __submit(){
	if(document.forms['vencimientoForm'].fecha.value == ""){
		alert("  El campo Fecha Transporte está vacío  ");
		return;
	}
	document.forms['vencimientoForm'].submit();
}
function __retornar(){
	document.forms['backForm'].submit();
}
function _reset(){
	document.forms['vencimientoForm'].reset();	
	onchangeList(document.forms['vencimientoForm'].cuenta);
}

function clearList(){
	document.forms['vencimientoForm'].numeroDeclaracion.options.length = 0;
	document.forms['vencimientoForm'].numeroDeclaracion.options.options[0] = new Option("<bean:message key='lbl.transf.inter.seleccione'/>","");
}

function onchangeList2(){
	clearList();
	 if (document.forms['vencimientoForm'].cuenta.value == ""){
		document.forms['vencimientoForm'].numeroDeclaracion.options.length = 0;
		document.forms['vencimientoForm'].numeroDeclaracion.options.options[0] = new Option("<bean:message key='lbl.transf.inter.seleccione'/>","");
	}
}
function onchangeList(obj){
	   var str;
	   str = obj.value;
	   clearList();
	   if (str == ""){
	   		clearList();
	   }
	   else{
		   document.forms['vencimientoForm'].NumeroCuenta.focus();
		   document.forms['vencimientoForm'].NumeroCuenta.value=str;
		   obj.focus();
	   }
}
</script>

<%@ include file="../body.jsp" %>
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

<form action="<html:rewrite page='/vencimiento/modificacion/consulta.do'/>" name="backForm" method="post">
	<%String tem = (String)session.getAttribute("consulta.vencimiento.cuentaBanco");
	if (tem == null)
		tem =(String)session.getAttribute("consulta.vencimiento.cuenta");
	%>
	<input type="hidden" name="cuenta" value="<%=(String)session.getAttribute("consulta.vencimiento.cuenta")%>"/>	
	<input type="hidden" name="desde" value="<%=(String)session.getAttribute("consulta.vencimiento.fecha.desde")%>"/>
	<input type="hidden" name="hasta" value="<%=(String)session.getAttribute("consulta.vencimiento.fecha.hasta")%>"/>
	<input type="hidden" name="tipoVencimiento" value="<%=(String)session.getAttribute("tipo.vencimiento")%>"/>
</form>

<html:form method="post" action="/vencimiento/exportacion/anticipos">
<input type="hidden" name="opcion" value="anticipos"/>
<html:hidden property="indice"/>
<html:hidden property="secuenciaRegistro"/>
<div style="width:0;height:0;display:">
<input type="text" name="NumeroCuenta" id="NumeroCuenta" style="position:absolute; left:-99999em"/>
										
</div>
<table width="100%" border="0" cellpadding="1" cellspacing="1" >
<tr>
	 <td><div align="left" class="login"><img src="<html:rewrite page='/images/gancho.gif'/>" border="0" style=" width : 24px;">Información de Anticipos de Exportación</div></td>
	 <td width="8%">
	  <logic:notEmpty name="vencimientoForm" property="indice">
	 <div align="right">&nbsp;&nbsp;							
			<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>">
			</div></logic:notEmpty>
							</td>
</tr>
<tr height="10" ><td>
<h1></h1>
</td>
</tr>
</table>
<table align="center" width="57%"><tr><td align="center">
<%@ include file="../divHeader.jsp"%> 
<table  border="0" cellpadding="1" cellspacing="1" >
<tr><td>&nbsp;</td></tr>
<tr class="bienvenida">
    <td class="celda-clave1">Número de Cuenta</td>
    <td>   	
    	<logic:notEqual name="vencimientoForm" property="update" value="true">
	        <html:select property="cuenta" onchange="onchangeList(this)" styleClass="lstbox" style=" width : 104px; height : 20px;">
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
	     	<html:hidden property="cuenta" />
	    	<b><bean:write name="vencimientoForm" property="cuentaBanco"/></b>
	   </logic:equal>
	 </td>
</tr>
<tr class="bienvenida">
    <td class="celda-clave1">Consecutivo Declaración</td>
    <td>
    
    	<logic:notEqual name="vencimientoForm" property="update" value="true">
	        <html:select property="numeroDeclaracion" styleId="numeroDeclaracion" styleClass="lstbox">
							<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>					
		    </html:select> <span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
	    </logic:notEqual>
	    <logic:equal name="vencimientoForm" property="update" value="true">
	     	<html:hidden property="numeroDeclaracion"/>
	    	<b><bean:write name="vencimientoForm" property="numeroDeclaracion"/></b>
	    </logic:equal>
	 </td>
</tr>
<tr class="bienvenida"> 
   <td class="celda-clave1">Fecha Reintegro</td>
   <td class="bienvenida">
       <html:text property="fecha" styleClass="botton-acceso" size="30" maxlength="12" onblur="ValidarFecha();"/>
       <input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('fecha', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]
   </td> 
</tr>
<tr class="bienvenida">
    <td class="celda-clave1">Valor USD</td>
    <td><html:text  styleClass="botton-acceso" property="usd" onkeypress="__digit(this);" onblur="ValidarFecha();" size="30%" maxlength="20"/></td>
</tr>
<tr class="bienvenida">
   <td class="celda-clave1">Comprador</td>
   <td><html:text  styleClass="botton-acceso" property="comprador" size="30%" onblur="ValidarFecha();" maxlength="100"/></td>
</tr>
<tr class="bienvenida">
   <td class="celda-clave1">Vencimiento(<%=dias[2]%> días)</td>
   <td><html:text  styleClass="botton-acceso" property="vencimiento" size="30%" maxlength="20" readonly="true"/></td>
</tr>
<tr><td colspan="2"><h1></h1></td></tr>

      <tr>
	      <td width="10%" align="center" colspan="2"><input class="botton" type="button" value="Aceptar" onclick="ValidarFecha();submit()"/></td>
		 
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
<!-- script>
            if (document.forms['vencimientoForm'].cuenta.value != ""){
            	document.forms['vencimientoForm'].cuenta.value = "";
			}
            </script-->
<ajax:select
  baseUrl="/internet/lista/consecutivo/declaracion"
  source="NumeroCuenta"
  target="numeroDeclaracion"
  eventType="blur"
  parameters="cta={NumeroCuenta}"
  emptyFunction="onchangeList2"/>  
  
<%@ include file="../footer.jsp" %>
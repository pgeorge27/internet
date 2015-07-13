<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>

<%@ include file="../..//head.jsp"  %>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>

<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar.js'/>"></script>

<script language=javascript>


  // Original JavaScript code by Chirp Internet: www.chirp.com.au
  // Please acknowledge use of this code by including this header.

  function checkDate(field)
  {
    var allowBlank = true;
    var minYear = 2009;
    var maxYear = (new Date()).getFullYear();

    var errorMsg = "";

    // regular expression to match required date format
    re = /^(\d{1,2})\-(\d{1,2})\-(\d{4})$/;

    if(field.value != '') {
      if(regs = field.value.match(re)) {
        if(regs[1] < 1 || regs[1] > 31) {
          errorMsg = "Valor no valido para los dias : " + regs[1];
        } else if(regs[2] < 1 || regs[2] > 12) {
          errorMsg = "Valor no valido para los Meses: " + regs[2];
        } else if(regs[3] < minYear || regs[3] > maxYear) {
          errorMsg = "Valor no valido para los años: " + regs[3] + " \nDebe ser mayor a  " + minYear + " y menor que " + maxYear;
        }
      } else {
        errorMsg = "formato de fecha no valido: " + field.value;
      }
    } else if(!allowBlank) {
      errorMsg = "Favor ingrese una fecha en el formato valido";
    }

    if(errorMsg != "") {
      alert(errorMsg);
      field.focus();
      return false;
    }

    return true;
  }



function __retornar(){
	document.location="<html:rewrite page='/dian/cambioFecha/seleccion.do'/>";
}
function __cambiarfechaSubmit(){
  
  if (document.forms['movimientoForm'].desde.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['movimientoForm'].desde.focus();
			return;
		}
if(!checkDate(document.forms['movimientoForm'].desde)){
	return;
}	
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['movimientoForm'].elements;
	  for(var i = 0; i < elements.length; i++)
	  {
	  	 	if (elements[i].name == "indice")
	  	 	{
			   if (elements[i].checked)
			   {
			  	flag = true;
				index = elements[i].value;
			  	count++;
			   }
			}
	  }

	if (count >= 1){
		document.forms['movimientoForm'].submit();
	}		
	else{
		alert("Debe seleccionar un registro para aprobación");
	}

		
		
}
function __checkAll(element)
{
	var elements = document.forms['movimientoForm'].elements;
  	for(var i = 0; i < elements.length; i++)
 	{
  	 	if (elements[i].name == "indice")
  	 	   elements[i].checked = element.checked;
    }
}

var index = -1;
function __set(num){
	index = num;
}
function __editItem(){
	if (index == -1){
		alert("Debe seleccionar un registro");
	}
	else{
		__edit(index);
	}
}
</script>
<script language="javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script language="javascript" src="<html:rewrite page='/scripts/objetoFecha.js'/>"></script>

<%@ include file="/body.jsp"%>
				<html:form  action="/dian/cambiofecha/consultar"> 
                 	<html:hidden property="formulario" value="1067" />
					<html:hidden property="tipo" value="10" />
					<html:hidden property="formulariosSecundario" value="1" />
					
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="left"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login">Informe Datos Faltantes En Las Declaraciones De Cambio 1 - 1067 <br> Datos de la Importación</div></td>
							<td width="8%"><div align="right">&nbsp;
								<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
							</td>
                        </tr>
					  <tr>
						  <td> <br/>
							<div align="left">&nbsp; Fecha Legalización  
								<html:text property="desde" value=" " styleClass="botton-acceso" size="20" maxlength="10"/>
									<input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-yyyy');" > [<b>dd-mm-yyyy</b>]
									&nbsp;<INPUT class="botton" onclick="__cambiarfechaSubmit()" type="button" value="Cambiar Fecha"></div></td>
						   </tr> 
                    </table>
                  </div>
				  </td>
			  </tr> 
</table>  
<table width="100%" border="0" cellpadding="1" cellspacing="2">
         <tr><td>
         	<input type="checkbox" name="_all" onclick="__checkAll(this);">&nbsp;<bean:message key="lbl.compensacion.autorizar.seleccionar.todos"/>
         </td></tr>
</table>       
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">     
              <tr> 
                <td valign="top">
                <logic:present name="registro.dian.secundario.1">
                <table cellpadding="1" width="30%" border="0">
                <tr>
                </tr></table>
                
				<div id="record-view" style="overflow:auto;width:790;height:265">
				    <table cellpadding="1" width="100%" border="0">                    
                    <tr class="tabla-acceso">
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número de identificación del registro principal"># identificación del registro principal</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Formulario de la Declaración de cambio que se complementa">Formulario de la Declaración de cambio que se complementa</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha declaración cambio complementada">Fecha declaración cambio complementada</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número declaración cambio complementada">Número declaración cambio complementada</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Número declaración de importación">Número declaración de importación</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Valor USD pagado por declaración de importación">Valor USD pagado por declaración de importación</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Fecha de presentación comunicación u oficio">Fecha de presentación comunicación u oficio</div></td>
                       <td class="texto-acceso" align="center"><div class="texto-acceso" title="Identificación única del registro"><bean:message key="formulario.1059.identificacion.unica.registro"/></div></td>
                    </tr>
                    <logic:iterate name="registro.dian.secundario.1" id="row"
								   type="com.arango.internet.banking.dian.Formulario" 
								   indexId="resultNo" >
			     		<bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
					    <td class="bienvenida"><input type="checkbox" name="indice" onclick="__set(<%=resultNo%>)" value="<%=resultNo%>"/><bean:write name="row" property="identificacionUnicaRegistroPrincipal"/></td>
	                    <td class="bienvenida"><bean:write name="row" property="formularioDeclaracion"/>	
	                    <td class="bienvenida"><bean:write name="row" property="fechaDeclaracionComplementada" formatKey="formato-fecha"/>
	                    <td class="bienvenida"><bean:write name="row" property="numeroDeclaracionCambioComplementada"/>
	                    <td class="bienvenida"><bean:write name="row" property="numeroDeclaracionImportacion"/>	
	                    <logic:notEqual name="row" property="valorUSDDeclaracionImportacion" value="0">
							<td class="bienvenida"><bean:write name="row" property="valorUSDDeclaracionImportacion" format="######0.00"/></td>
						</logic:notEqual>	
						<logic:equal name="row" property="valorUSDDeclaracionImportacion" value="0">
							<td class="bienvenida">&nbsp;</td>
					    </logic:equal>	
	                    <td class="bienvenida"><bean:write name="row" property="fechaPresentacionOficio" formatKey="formato-fecha"/>	
	                    <td class="bienvenida"><bean:write name="row" property="identificacionUnicaRegistro"/>				    
						
                    </logic:iterate>
                    </table>
                    </div>
                    <script>
                    	if (window.screen.width > 800)
                    	{
                    		if (document.getElementById){
                    			var obj = document.getElementById("record-view");
                    			obj.style.width=window.screen.width-35;
                    		}
                    	}
                    </script>
			</logic:present>
			<logic:notPresent name="registro.dian.secundario.1">
			<table width="80%" border="0" cellpadding="0" cellspacing="2">
			  <tr class="tabla-acceso">
				<TD class="texto-acceso" width="15%">
				<bean:message key="msg.sin.movimentos"/></td></tr></table>
			</logic:notPresent>
			</td></tr></table>
			 </html:form>
<table width="80%" border="0" cellpadding="0" cellspacing="2">	
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
		
				<INPUT class="botton" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>			
<%@ include file="/footer.jsp"  %>
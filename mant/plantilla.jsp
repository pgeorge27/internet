<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.struts.util.LabelValueBean"%>
<%@ page import="com.arango.common.util.StringUtilities" %>
<%!
private String getNombre(String text){
    if (text == null)
		return "";
    String temp = StringUtilities.replace(text, "\"","&#034;");
    temp = StringUtilities.replace(temp, "\n", "\\n");
    temp = StringUtilities.replace(temp, "\r", "\\r");
    temp = StringUtilities.replace(temp, "\"", "\\\"");
    temp = StringUtilities.replace(temp, "'", "\\'");
    temp = temp.replace('\n', ' ');
    temp = temp.replace('\r', ' ');

    return temp;
}
%>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>

<script language="javascript">
var accounts = new Array();
function Account(codigo, nombre, moneda)
{
 this.codigo = codigo;
 this.nombre = nombre;
 this.moneda = moneda;
}
function getAccount(codigo)
{
   for (var i = 0; i < accounts.length; i++)
   {
   	   if (accounts[i].codigo == codigo)
	   {
	   	return accounts[i];
	   }
   }
   return null;
}

function changeList(obj){
   var str;
   var arr;
   if (obj.value.indexOf("~") > 0){
     arr = obj.value.split("~");
	 str = arr[0];
   }
   else{
      str = obj.value;
   }
   showAccountInfo(str);
}
function showAccountInfo(str){
    var c = getAccount(str);
	var obj = document.getElementById("nombreEmisor2");
    if (c != null)
    {
		obj.innerHTML = c.nombre;
		document.forms[0].nombreEmisor.value = c.nombre;
    }
    else{
    	obj.innerHTML = "";
    	document.forms[0].nombreEmisor.value = "";
    }		
}
function setCuenta(obj){
    document.forms[0].cuentaDb.value = obj.value;
    changeList(obj);
}
function entero()
{
 if ((event.keyCode < 48) || (event.keyCode > 57)) 
	if (event.keyCode != 44)
		event.returnValue = false;
}

function __formatDate(obj){
	if (obj){
	    var strObj = obj.value;
		var index = strObj.lastIndexOf("-");
		var strDate = "";
		if (index < 0 && strObj.length >= 8){	
			strDate = strObj.charAt(0) + strObj.charAt(1);
			strDate += "-";
			strDate += strObj.charAt(2) + strObj.charAt(3);
			strDate += "-";
			strDate += strObj.substring(4, strObj.length);
			obj.value = strDate;
		}
	}
}

function fecha()
{
 if ((event.keyCode < 48) || (event.keyCode > 57)) 
	if (event.keyCode != 45)
		event.returnValue = false;
}
function validateLength(obj, size){
    var str = _trim(obj.value);
	if (str.length >= size){
		event.returnValue = false;
	}
}
function _setDefaultCurrency(){
	var size = document.forms[0].moneda.options.length;
	var defaultCurrencyExists = false;
	var i =0;
	for (i = 0; i < size; i++){
		if (document.forms[0].moneda.options[i].value == "1"){
			defaultCurrencyExists = true;
			break;
		}
	}
	if (defaultCurrencyExists){
		document.forms[0].moneda.options.selectedIndex = i;
	}
}

function _trim(str){
	while(''+str.charAt(0)==' ')
		str=str.substring(1,str.length);
	return str;	
}
function alphanumeric(){
	if ((event.keyCode < 48) || (event.keyCode > 57)) {
		if ((event.keyCode >= 97) && (event.keyCode <= 122)){
			event.keyCode = event.keyCode - 32;
		}
		if ((event.keyCode < 65) || (event.keyCode > 90)){
			switch(event.keyCode){
			 case 32 : //  
			 case 44 : // ,
			 case 59 : // ;
			 case 48 : // 0
			 case 47 : // /
			 case 39 : // '
			 case 46 : // .
			 case 43 : // +
			 case 13 : a = 2;
					   break;
			 default : event.returnValue = false;
			 		   break;
			}
		}	
	}
}
function alphabetic(){
	if ((event.keyCode < 48) || (event.keyCode > 57)) {
		if ((event.keyCode >= 97) && (event.keyCode <= 122)){
			event.keyCode = event.keyCode - 32;
		}
		if ((event.keyCode < 65) || (event.keyCode > 90)){
			switch(event.keyCode){
			 case 32 :
			 case 13 : a = 2;
					   break;
			 default : event.returnValue = false;
			 		   break;
			}
		}	
	}
}

function _showAlert(field, label){
	if (isValidMessage(field.value)){
		var msg = "";
		switch(label){
			case 1 : msg = "<bean:message key="lbl.transf.inter.nombreBeneficiario"/>";
					 break;
			case 2 : msg = "<bean:message key="lbl.transf.inter.direccionBeneficiario"/>";
					 break;
			case 3 : msg = "<bean:message key="lbl.transf.inter.ciudadBeneficiario"/>";
					 break;
			case 4 : msg = "<bean:message key="lbl.transf.inter.detalle"/>";
					 break;					 
			case 5 : msg = "<bean:message key="lbl.transf.inter.bancoBeneficiario"/>";
					 break;
			case 6 : msg = "<bean:message key="lbl.transf.inter.direccionBancoIntermediario"/>";
					 break;
			case 7 : msg = "<bean:message key="lbl.transf.inter.ciudadBancoIntermediario"/>";
					 break;
			case 8 : msg = "<bean:message key="lbl.transf.inter.cuentaBancoIntermediario"/> <bean:message key="lbl.transf.inter.bancoBeneficiario"/>";
					 break;
			case 9 : msg = "<bean:message key="lbl.transf.inter.cuentaBeneficiario"/> <bean:message key="lbl.transf.inter.titulo.beneficiario"/>";
					 break;		 
			case 10: msg = "<bean:message key="lbl.transf.inter.swiftBeneficiario"/>/<bean:message key="lbl.transf.inter.abaBeneficiario"/> <bean:message key="lbl.transf.inter.titulo.nombreBancoIntermediario"/>";
					 break;						 
			case 11: msg = "<bean:message key="lbl.transf.inter.paisBancoIntermediario"/> <bean:message key="lbl.transf.inter.bancoBeneficiario"/>";
					 break;
			case 12: msg = "<bean:message key="lbl.transf.inter.paisBeneficiario"/> <bean:message key="lbl.transf.inter.titulo.beneficiario"/>";
		}
		field.className = "botton-acceso-wn";
		alert("<bean:message key="lbl.nota.transferencias.cuba"/>" + " " + msg);
	}
	else{
		field.className = "botton-acceso";
	}
}
function __validateField1(){
	var _value = __getValue("lblPaisBancoIntermediario");
	if (_value){
		if (isValidMessage(_value)){
			document.forms[0].swiftBancoIntermediario.className = "botton-acceso-wn";
			alert("<bean:message key="lbl.nota.transferencias.cuba2"/>");
		}
		else{
			document.forms[0].swiftBancoIntermediario.className = "botton-acceso";		
		}
	}
}
function __getValue(field){
	if (document.getElementById){
		obj = document.getElementById(field);
	}
	else{
		eval("obj = "+field);
	}
	return obj ? obj.innerHTML : "";
}
function __validateField2(){
	var _value = __getValue("lblPaisBancoBeneficiario");
	if (_value){
		if (isValidMessage(_value)){	
			document.forms[0].swiftBeneficiario.className = "botton-acceso-wn";
			alert("<bean:message key="lbl.nota.transferencias.cuba2"/>");
		}
		else{
			document.forms[0].swiftBeneficiario.className = "botton-acceso";
		}
	}
}

function isValidMessage(message){
	var str = message.toUpperCase();
	return str.match(/CUBA/);
}
function __decimalFormat(string){
	if (string == ''){
        string = '00';
    }
    else{
        if (string.length == 1){
            string=string+'0';
        }
    }
	return string;
}

function send(){
  var moneda = "";
  var monto = "";
  
  
  
     document.forms[0].submit();
}
function resetFields(){
	resetField("lblBancoBeneficiario");
	resetField("lblDireccionBancoBeneficiario");
	resetField("lblCiudadBancoBeneficiario");
	resetField("lblPaisBancoBeneficiario");
}
function resetField(fieldName){
	var obj;
	if (document.getElementById){
	 	obj = document.getElementById(fieldName);
	}
	else{
		eval("obj ="+ filedName);
	}
	obj.innerHTML = "";
}
function resetFields2(){
	resetField("lblNombreBancoIntermediario");
	resetField("lblDireccionBancoIntermediario");
	resetField("lblCiudadBancoIntermediario");
	resetField("lblPaisBancoIntermediario");	
}
function swiftMessage(){
	if (document.forms[0].swiftBeneficiario.value != ""){
		alert("<bean:message key="lbl.transf.inter.codigo.swift.incorrecto"/> ");
		resetFields();
		document.forms[0].swiftBeneficiario.focus();
	}
	else{
		resetFields();
	}
}
function swiftMessage2(){
	if (document.forms[0].swiftBancoIntermediario.value != ""){
		alert("<bean:message key="lbl.transf.inter.codigo.swift.incorrecto"/> ");
		resetFields2();
		document.forms[0].swiftBancoIntermediario.focus();
	}
	else{
		resetFields2();
	}	
}

function mascara(obj){
	obj.value = __format(obj.value);
}
function __format(str){
    var i=0;
    var string1='';
    string=maskoff(str);
    string1='';
    
    if (string.length>3){
        finale=string.length;
        inicio=string.length;
        for(i=inicio-3;i>0;i-=3){
            string1= ',' + string.substring(i,finale)+string1;
            finale=i;
        }
        string1=string.substring(0,i+3)+string1;
    }
    else
    {
      string1=string;
    }
    return string1;
}

function maskoff(valor){
 temp=valor
 do{
    temp=temp.replace(',','');
 }while(temp.indexOf(',')!=-1)
 return temp;
}

function _refresh(){
	var obj;
	if (document.forms[0].swiftBeneficiario.value != ""){
		if (isValidABANumber(document.forms[0].swiftBeneficiario.value)){	
			obj = document.getElementById("_ABA");
			obj.checked = true;
		}
		else{
			obj = document.getElementById("_SWIFT");
			obj.checked = true;
		}
		document.forms[0].swiftBeneficiario.focus();
	}
	if (document.forms[0].swiftBancoIntermediario.value != ""){
		if (isValidABANumber(document.forms[0].swiftBancoIntermediario.value)){	
			obj = document.getElementById("_ABA2");
			obj.checked = true;
		}
		else{
			obj = document.getElementById("_SWIFT2");
			obj.checked = true;
		}
		document.forms[0].swiftBancoIntermediario.focus();
		document.forms[0].cuentaBancoIntermediario.focus();
	}
	if(document.forms[0].swiftBancoIntermediario.value == ""){
		if (document.forms[0].cuentaBancoIntermediario.value != ""){
			_choseValue('ANOTHER');
		}
	}
}
function isInteger(strNumber)
{
	var objNotIntPattern = /[^0-9-]/;
	var objIntPattern = /^-[0-9]+$|^[0-9]+$/;
	if (strNumber != ""){
  	   return  !objNotIntPattern.test(strNumber) &&
		   	    objIntPattern.test(strNumber);
	}
	return true;
}
function isValidABANumber(number) {
	var n = 0;
	if (number != null && isInteger(number)) {        
		if (number.length == 9) {
			  for (i = 0; i < number.length; i += 3) {
				n += parseInt(number.charAt(i)) * 3
				  +  parseInt(number.charAt(i + 1)) * 7
				  +  parseInt(number.charAt(i + 2));
			  }
			  if (n != 0 && n % 10 == 0) {
				return true;
			  }
			  else {
				return false;
			  }
		}
		else {
			return false;
		}
	}
	else {
		return false;
	}
}
function __hideAccountList(){
	var selx=0; 
	var sely=0; 
	var sel;
	var selp;
	if (document.getElementById){
		sel = document.getElementById("cuentaDb");
	}
	else{
		sel = cuentaDb;
	}
	if(sel.offsetParent){
		selp=sel; while(selp.offsetParent){selp=selp.offsetParent; selx+=selp.offsetLeft; sely+=selp.offsetTop;}}
	selx+=sel.offsetLeft; sely+=sel.offsetTop
	selw=sel.offsetWidth; selh=sel.offsetHeight
	
	sel.style.display="none";	
}
function __showAccountList(){
	var selx=0; 
	var sely=0; 
	var sel;
	if (document.getElementById){
		sel = document.getElementById("cuentaDb");
	}
	else{
		sel = cuentaDb;
	}
	selx=0; sely=0; var selp;
	if(sel.offsetParent){selp=sel; while(selp.offsetParent){selp=selp.offsetParent; selx+=selp.offsetLeft; sely+=selp.offsetTop;}}
	selx+=sel.offsetLeft; sely+=sel.offsetTop
	selw=sel.offsetWidth; selh=sel.offsetHeight
	sel.style.display="";
	
}

function __showElement(element){
	__showHideElement(element, "");
}
function __hideElement(element){
	__showHideElement(element, "none");
}
function __showHideElement(element, prop){
	var obj;
	if (document.getElementById){
		obj = document.getElementById(element);
	}
	else{
		eval("obj = " + element);
	}
	obj.style.display = prop;
}
function  _choseValue(opt){
	__hideElement("lblNombreBancoIntermediario");
	__hideElement("lblDireccionBancoIntermediario");
	__hideElement("lblCiudadBancoIntermediario");
	__hideElement("lblPaisBancoIntermediario");
	
	__hideElement("txtNombreBancoBeneficiario");
	__hideElement("txtDireccionBancoIntermediario");
	__hideElement("txtCiudadBancoIntermediario");
	__hideElement("txtPaisBancoIntermediario");
	
	if (opt == "ANOTHER"){
		__showElement("txtNombreBancoBeneficiario");
		__showElement("txtDireccionBancoIntermediario");
		__showElement("txtCiudadBancoIntermediario");
		__showElement("txtPaisBancoIntermediario");
	}
	else{
		document.forms[0].bancoBeneficiario.value = "";
		document.forms[0].direccionBancoIntermediario.value = "";
		document.forms[0].ciudadBancoIntermediario.value = "";
		document.forms[0].paisBancoIntermediario.value = "";
		
		__showElement("lblNombreBancoIntermediario");
		__showElement("lblDireccionBancoIntermediario");
		__showElement("lblCiudadBancoIntermediario");
		__showElement("lblPaisBancoIntermediario");
	}
}
function __init(){
}
</script>
<script language="javascript">
<%int i = 0;%>
      <csic:forEachCuentaPerfil producto="CC" formatAccount="C" mancomunada="true">
      	<%if ("true".equals(mancomunada)) {%>
	      accounts[<%=i++%>]=new Account('<%=numCtaCSIC%>', '<%=getNombre(nombreTitular)%>', '<%=moneda%>');
	    <%}%>  
      </csic:forEachCuentaPerfil>
</script>
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
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td><div align="left" class="login"><bean:message key="lbl.transf.inter.titulo"/></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top">

<html:form method="post" action="/grabar/plantilla" onsubmit="document.forms[0].action.value='validate'">
<html:hidden property="descMoneda" />
<html:hidden property="action" />
<html:hidden property="mode" value="create"/>
<html:hidden property="numeroDocumento" />
<html:hidden property="secuencia" />
<html:hidden property="codigoCliente" />

<table width="100%" border="0" cellpadding="5" cellspacing="1">
  <tr>
	<td height="20" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>

<!-- EMISOR -->


<!-- BANCO BENEFICIARIO -->
<tr valign="middle" class="celda-clave1">
<td colspan="2" class="bienvenida">
&nbsp;&nbsp;&nbsp;<b><bean:message key="lbl.transf.inter.titulo.nombreBancoIntermediario"/><br>
&nbsp;&nbsp;&nbsp;<small>(<bean:message key="lbl.transf.inter.nota.banco.intermediario"/>)</small></b></td></tr>	
<tr valign="middle">
	<td class="bienvenida"><b>1:</b> <html:radio property="tipoSWIFTBeneficiario" value="SWIFT" styleId="_SWIFT"/>
					   <bean:message key="lbl.transf.inter.swiftBeneficiario"/>
					   <html:radio property="tipoSWIFTBeneficiario" value="ABA" styleId="_ABA"/>
					   <bean:message key="lbl.transf.inter.abaBeneficiario"/></td><tr>
<tr valign="middle">					   
	<td class="bienvenida"><html:text property="swiftBeneficiario" styleId="swiftBeneficiario" maxlength="18" styleClass="botton-acceso"/></td></tr>
						
<tr valign="middle">
	<td class="bienvenida"><b>2:</b> <bean:message key="lbl.transf.inter.nombreBancoIntermediario"/></td>
	<td class="bienvenida"><b>3:</b> <bean:message key="lbl.transf.inter.direccionBancoBeneficiario"/></td></tr>
<tr valign="top">
	<td class="bienvenida"><html:hidden property="bancoBeneficiario"/>
					   <div id="lblBancoBeneficiario" class="textbox"></div></td>
	<td class="bienvenida"><html:hidden property="direccionBancoBeneficiario"/>
					   <div id="lblDireccionBancoBeneficiario" class="textbox2"></div></td></tr>
<tr valign="middle">
	<td class="bienvenida"><b>4:</b> <bean:message key="lbl.transf.inter.ciudadBancoBeneficiario"/></td>
	<td class="bienvenida"><b>5:</b> <bean:message key="lbl.transf.inter.paisBancoBeneficiario"/></td></tr>
<tr valign="middle">
	<td class="bienvenida"><html:hidden property="ciudadBancoBeneficiario"/>
					   <div id="lblCiudadBancoBeneficiario" class="textbox"></td>
	<td class="bienvenida"><html:hidden property="paisBancoBeneficiario"/>
					   <div id="lblPaisBancoBeneficiario" class="textbox"></td></tr>
<!-- BANCO BENEFICIARIO -->

<!-- BANCO INTERMEDIARIO -->
<tr valign="middle" class="celda-clave1">
<td colspan="2" class="bienvenida">
&nbsp;&nbsp;&nbsp;<b><bean:message key="lbl.transf.inter.bancoBeneficiario"/></b></td></tr>	
<tr valign="middle">
	<td class="bienvenida"><b>6:</b> <bean:message key="lbl.transf.inter.cuentaBancoIntermediario"/></td>
	<td class="bienvenida"><b>7:</b> <html:radio property="tipoSWIFTIntermediario" value="SWIFT" styleId="_SWIFT2" onclick="_choseValue('SWIFT');"/>
					   <bean:message key="lbl.transf.inter.swiftBancoIntermediario"/>
					   <html:radio property="tipoSWIFTIntermediario" value="ABA" styleId="_ABA2" onclick="_choseValue('ABA');"/>
					   <bean:message key="lbl.transf.inter.abaBancoIntermediario"/>
					   <html:radio property="tipoSWIFTIntermediario" value="OTRO" styleId="_OTRO2" onclick="_choseValue('ANOTHER');"/>
					   <bean:message key="lbl.transf.inter.otroBancoIntermediario"/></td></tr>
<tr valign="middle">
	<td class="bienvenida"><html:text property="cuentaBancoIntermediario" styleId="cuentaBancoIntermediario"  onkeypress="alphabetic();" onblur="_showAlert(this,8);" maxlength="34" size="45" styleClass="botton-acceso"/></td>
	<td class="bienvenida"><html:text property="swiftBancoIntermediario" styleId="swiftBancoIntermediario" maxlength="18" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td></tr>

<tr valign="middle">
	<td class="bienvenida"><b>8:</b> <bean:message key="lbl.transf.inter.bancoBeneficiario"/></td>
	<td class="bienvenida"><b>9:</b> <bean:message key="lbl.transf.inter.direccionBancoIntermediario"/></td></tr>
<tr valign="top">
	<td class="bienvenida">
					   <div id="lblNombreBancoIntermediario" class="textbox" style="display:"></div>
					   <div id="txtNombreBancoBeneficiario" style="display:none"><html:text property="nombreBancoIntermediario" styleClass="botton-acceso" size="45" maxlength="50" onkeypress="alphanumeric()" onblur="_showAlert(this, 5);"/></div></td>
	<td class="bienvenida">
					   <div id="lblDireccionBancoIntermediario" class="textbox2" style="display:"></div>
					   <div id="txtDireccionBancoIntermediario" style="display:none"><html:textarea property="direccionBancoIntermediario" styleClass="botton-acceso" cols="35" rows="5" onkeypress="alphabetic();validateLength(this, 50)" onblur="_showAlert(this, 6);" /></div></td></tr>
<tr valign="middle">
	<td class="bienvenida"><b>10:</b> <bean:message key="lbl.transf.inter.ciudadBancoIntermediario"/></td>
	<td class="bienvenida"><b>11:</b> <bean:message key="lbl.transf.inter.paisBancoIntermediario"/></td></tr>
<tr valign="middle">
	<td class="bienvenida">
					   <div id="lblCiudadBancoIntermediario" class="textbox" style="display:"></div>
					   <div id="txtCiudadBancoIntermediario" style="display:none"><html:text property="ciudadBancoIntermediario" styleClass="botton-acceso" size="45" maxlength="20" onkeypress="alphabetic()" onblur="_showAlert(this, 7);"/></div></td>
	<td class="bienvenida">
					   <div id="lblPaisBancoIntermediario" class="textbox" style="display:"></div>
					   <div id="txtPaisBancoIntermediario" style="display:none"><html:select property="paisBancoIntermediario" styleId="paisBancoIntermediario" styleClass="botton-acceso" onchange="_showAlert(this, 11);">
							<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
							<csic:value-list fileName="paises">
								<%if (codigo != null && codigo.length() > 20){
									codigo = codigo.substring(0, 19);
								}%>
								<html:option value="<%=codigo%>" ><%=valor %></html:option>	
							</csic:value-list>
					   </html:select></div></td></tr>	
<!-- BANCO INTERMEDIARIO -->

<!-- BENEFICIARIO -->
<tr valign="middle" class="celda-clave1">
<td colspan="2" class="bienvenida"><b>
&nbsp;&nbsp;&nbsp;<bean:message key="lbl.transf.inter.titulo.beneficiario"/></b></td></tr>	
<tr valign="middle">
	<td class="bienvenida"><b>12:</b> <bean:message key="lbl.transf.inter.nombreBeneficiario"/></td>
	<td class="bienvenida"><b>13:</b> <bean:message key="lbl.transf.inter.cuentaBeneficiario"/></td></tr>
<tr valign="middle">
	<td class="bienvenida" nowrap><html:text property="nombreBeneficiario" styleId="nombreBeneficiario" maxlength="50" size="65" onkeypress="alphanumeric();" onblur="_showAlert(this, 1);" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
	<td class="bienvenida"><html:text property="cuentaBeneficiario" styleId="cuentaBeneficiario" maxlength="34" size="45" onkeypress="alphabetic();" onblur="_showAlert(this,9);" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td></tr>
<tr valign="middle">
	<td class="bienvenida"><b>14:</b> <bean:message key="lbl.transf.inter.direccionBeneficiario"/></td>
	<td class="bienvenida"></td></tr>
<tr valign="middle">
	<td class="bienvenida"><html:textarea property="direccionBeneficiario" styleId="direccionBeneficiario" cols="35" rows="5" onkeypress="alphabetic();validateLength(this, 90)" onblur="_showAlert(this, 2);" styleClass="botton-acceso"/></td>
	<td class="bienvenida"></td></tr>
<tr valign="middle">
	<td class="bienvenida"><b>15:</b> <bean:message key="lbl.transf.inter.ciudadBeneficiario"/></td>
	<td class="bienvenida"><b>16:</b> <bean:message key="lbl.transf.inter.paisBeneficiario"/></td></tr>
<tr valign="middle">
	<td class="bienvenida"><html:text property="ciudadBeneficiario" styleId="ciudadBeneficiario" size="45" onkeypress="alphabetic()" maxlength="40" onblur="_showAlert(this, 3);" styleClass="botton-acceso"/></td>
	<td class="bienvenida"><html:select property="paisBeneficiario" styleId="paisBeneficiario" styleClass="botton-acceso" onchange="_showAlert(this, 12);">
							<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
							<csic:value-list fileName="paises">
								<html:option value="<%=codigo%>" ><%=valor %></html:option>	
							</csic:value-list>
					   </html:select></td></tr>
<!-- BENEFICIARIO -->

<!-- DETALLE DE PAGO-->
<tr valign="middle" class="celda-clave1">
<td colspan="2" class="bienvenida"><b>
&nbsp;&nbsp;&nbsp;<bean:message key="lbl.transf.inter.detalle"/></b></td></tr>	
<tr valign="middle">
	<td class="bienvenida"><b>17:</b> <bean:message key="lbl.transf.inter.detalle"/></td>
	<td class="bienvenida"></td></tr>
<tr valign="top">
	<td class="bienvenida"><html:textarea property="instrucciones" styleId="detallePago" cols="35" rows="5" onkeypress="alphanumeric();validateLength(this, 130)" onblur="_showAlert(this,4);" styleClass="botton-acceso"/></td>
	<td class="bienvenida"></td>
</tr>
<!-- DETALLE DE PAGO-->

<tr>
       <td colspan="2" align="center"><br><br>
	   <input type="button" class="botton" onclick="send();" value="Aceptar"/>
	   &nbsp;&nbsp;&nbsp;&nbsp;
	   <input type="button" class="botton" onclick="document.location='<html:rewrite page='/mant/plantilla.do'/>'" value="Cancelar"/>	

</table>
</html:form>
<script>
function __initialize(){
	
	_refresh();
}
__initialize();
</script>


  
<ajax:updateField
  baseUrl="/internet/swift.view"
  source="swiftBeneficiario"
  target="lblBancoBeneficiario,lblDireccionBancoBeneficiario,lblCiudadBancoBeneficiario,lblPaisBancoBeneficiario"
  action="swiftBeneficiario"
  eventType="blur"
  parameters="number={swiftBeneficiario}, t=1" 
  emptyFunction="swiftMessage"
  postFunction="__validateField2"/>  

<ajax:updateField
  baseUrl="/internet/swift2.view"
  source="swiftBancoIntermediario"
  target="lblNombreBancoIntermediario,lblDireccionBancoIntermediario,lblCiudadBancoIntermediario,lblPaisBancoIntermediario"
  action="swiftBancoIntermediario"
  eventType="blur"
  parameters="number={swiftBancoIntermediario}, t=2" 
  emptyFunction="swiftMessage2"
  postFunction="__validateField1"/>   
<!-- Fin. Solicitud -->
</td>
  </tr>
  
</table></div>

<%@ include file="../footer.jsp"  %>
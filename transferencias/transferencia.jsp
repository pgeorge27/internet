<% session.setAttribute("selected", "transfer"); %>
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
String Moneda = (session.getAttribute("monedaSelect")!=null) ? session.getAttribute("monedaSelect").toString() : "";
ArrayList paises = new ArrayList();
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
		}else if (index == 7){	
			strDate = 	strObj.substring(8, strObj.length);
			strDate += "-";
			strDate += 	strObj.charAt(5) + strObj.charAt(6);
			strDate += "-";
			strDate += strObj.charAt(0) + strObj.charAt(1)+ strObj.charAt(2) + strObj.charAt(3);
			
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
	var na = navigator.appVersion
	
	if ((event.keyCode < 48) || (event.keyCode > 57)) {
		if (na.indexOf( 'Safari' )< 0){
			if ((event.keyCode >= 97) && (event.keyCode <= 122)){
				event.keyCode = event.keyCode - 32;
			}
		}
		if (!((event.keyCode >= 97) && (event.keyCode <= 122))){
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
}
function alphabetic(){
	var na = navigator.appVersion
	
	if ((event.keyCode < 48) || (event.keyCode > 57)) {
		if (na.indexOf( 'Safari' )< 0){
			if ((event.keyCode >= 97) && (event.keyCode <= 122)){
				event.keyCode = event.keyCode - 32;
			}
		}
		if ((event.keyCode < 65) || (event.keyCode > 122)){
			switch(event.keyCode){
			 case 32 :
			 case 13 : a = 2;
					   break;
			 default : event.returnValue = false;
			 		   break;
			}
		}	
		else{
			switch(event.keyCode){
				case 91 : event.returnValue = false;
				case 92 : event.returnValue = false;
				case 93 : event.returnValue = false;
				case 94 : event.returnValue = false;
				case 95 : event.returnValue = false;
				case 96 : event.returnValue = false;
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

function __maskmonto(){
alert(document.forms[0].cantidad.value);
}
function __isfechaFestiva(){
	
	if(document.forms[0].isFestivo.value != "false"){
		alert("La fecha elegida es festiva en "+document.forms[0].isFestivo.value);  	
	}else{}
}


function blockButton(){
	document.forms[0].tranferir.disabled = true;
}

function __ConmfirDuplicada(){
	document.forms[0].tranferir.disabled = true;
	
	if(document.forms[0].Duplicada.value == "true"){
		 if (confirm("¡Ya existe una tranferencia con la informacion suministrada!\n Desea seguir con la tranferencia actual?")){
				send(document.forms[0]);
		  	  } 
		 else{document.forms[0].tranferir.disabled = false;}
	}else {	send(document.forms[0]); }
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
	//return str.match(/CUBA/); //PABCR-2011-00191 - se comento para añadir una lista de paises restringidos
	return false;
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



function send(e){
	//Se valida el tamaño del campo detalle de pago 
	var detalle = document.forms[0].detallePago.value;
	if (detalle.length > 130){
		alert("El detalle del pago no debe ser mayor a 130 caracteres (Campo 22)");
		document.forms[0].tranferir.disabled = false;
		return false;
	}
	
	//Se valida la dirección del beneficiario 2014-11-14 orujano
	var dirbeneficiario = document.forms[0].direccionBeneficiario.value;
	dirbeneficiario = _trim(dirbeneficiario);
	if (dirbeneficiario.length <= 0){
		alert("La dirección del beneficirio es requerida (Campo 19)");
		document.forms[0].tranferir.disabled = false;
		return false;
	}else{
		if (dirbeneficiario.length < 10){
			alert("La dirección del beneficirio, debe ser una dirección real (Campo 19)");
			document.forms[0].tranferir.disabled = false;
			return false;
		}
	}
	
	var cuentaInter = document.forms[0].cuentaBancoIntermediario.value;
	document.forms[0].cuentaBancoIntermediario.value = cuentaInter.replace(" ","");
	
	//verificando si los campos 11 y 18 son diferentes Edgar Sucre => 06/03/2012
	if(!areEqual("cuentaBancoIntermediario","cuentaBeneficiario")){
		var moneda = "";
		var monto = "";
		var index = document.forms[0].moneda.selectedIndex;
		if (index >= 0)
			moneda = document.forms[0].moneda.options[index].text;
		document.forms[0].cantidad.value = maskoff(document.forms[0].cantidad.value);
		if (isInteger(document.forms[0].cantidad.value) && isInteger(document.forms[0].centavos.value)){
			monto = __format(document.forms[0].cantidad.value)+"."+__decimalFormat(document.forms[0].centavos.value);
		}
		document.forms[0].descMoneda.value=moneda;
		if(parseFloat(monto) >= 1){
			if (confirm("<bean:message key="lbl.transf.inter.confirmacion" arg0="monto" arg1="moneda"/>")){
			  	
				document.forms[0].moneda.disabled = false;
				document.forms[0].cuentaDb.disabled = false; 
			 	document.forms[0].submit();
				
		  	}
			document.forms[0].tranferir.disabled = false;
		}
		else{
			alert("<bean:message key="lbl.transferencia.zero"/> ");
			document.forms[0].tranferir.disabled = false;
		}
	}
	else{
		alert("Los campos 11 y 18 deben ser diferentes");
		document.forms[0].tranferir.disabled = false;
	}
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
		document.forms[0].swiftBeneficiario.value = "";
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
		document.forms[0].swiftBancoIntermediario.value = "";
		document.forms[0].swiftBancoIntermediario.focus();
	}
	else{
		resetFields2();
	}	
}

function mascara(obj){
document.forms[0].cantidad2.value = obj.value ;

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
	var Cuentainter  = document.forms[0].cuentaBancoIntermediario.value;
	__hideElement("txtNombreBancoBeneficiario");
	__hideElement("txtDireccionBancoIntermediario");
	__hideElement("txtCiudadBancoIntermediario");
	__hideElement("txtPaisBancoIntermediario");
	
	__showElement("lblNombreBancoIntermediario");
	__showElement("lblDireccionBancoIntermediario");
	__showElement("lblCiudadBancoIntermediario");
	__showElement("lblPaisBancoIntermediario");
		
	document.forms[0].bancoBeneficiario.value = "";
	document.forms[0].direccionBancoIntermediario.value = "";
	document.forms[0].ciudadBancoIntermediario.value = "";
	document.forms[0].paisBancoIntermediario.value = "";
	document.forms[0].cuentaBancoIntermediario.value = Cuentainter.replace(" ","");
	
	resetFields2();
	document.forms[0].swiftBeneficiario.value = _trim(document.forms[0].swiftBeneficiario.value);
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
	
	document.forms[0].swiftBancoIntermediario.value = _trim(document.forms[0].swiftBancoIntermediario.value);
	if (document.forms[0].swiftBancoIntermediario.value != ""){
		if (isValidABANumber(document.forms[0].swiftBancoIntermediario.value)){	
			obj = document.getElementById("_ABA2");
			obj.checked = true;
			_choseValue('ABA');
		}
		else{
			obj = document.getElementById("_SWIFT2");
			obj.checked = true;
			_choseValue('SWIFT')
		}
		document.forms[0].swiftBancoIntermediario.focus();
	}
	else{
		obj = document.getElementById("_SWIFT2");
		obj.checked = true;
		_choseValue('SWIFT');
	}
	if(document.forms[0].swiftBancoIntermediario.value == ""){
		if (document.forms[0].cuentaBancoIntermediario.value != ""){
			_choseValue('ANOTHER');
		}
	}
	document.forms[0].cantidad.focus();
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

function __resetField(element){
	var obj;
	if (document.getElementById){
		obj = document.getElementById(element);
	}
	else{
		eval("obj = " + element);
	}
	obj.innerHTML = "";
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
		resetFields2();
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

function areEqual(a,b){
	var field1 = document.getElementById(a);
	var field2 = document.getElementById(b);
	
	return field1.value == field2.value;
}
</script>
<script language="javascript">

<%int i = 0;%>
      <csic:forEachCuentaPerfil producto="CC" formatAccount="C" mancomunada="true">
      	<%if ("true".equals(mancomunada)) {%>
	      accounts[<%=i++%>]=new Account('<%=numCtaCSIC%>', '<%=getNombre(nombreTitular)%>', '<%=moneda%>');
	    <%}%>  
      </csic:forEachCuentaPerfil>
      
    function validaPaisBloq(campo, numCampo)
    {	
      	if (campo.options[campo.selectedIndex].id == 1)
      	{
			alert("<bean:message key="lbl.nota.transferencias.bloqPais"/>"  + " [" + campo.options[campo.selectedIndex].text+"]");
      	}
    }
</script>
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
<div align="center"> 
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr> 
		<td height="40" valign="bottom">
		<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			<tr>
				<td>
					<div align="left" class="texto-acceso">
					<a href="http://www.swift.com/bsl/index.faces" target="new">B&uacute;squeda-C&oacute;digos SWIFT</a>
					</div>
				</td>
			</tr>		 
			<tr>		     
				<td><div align="left" class="texto-acceso"><a href="https://www.frbservices.org/EPaymentsDirectory/reviseFedwireSearch.html" target="new">B&uacute;squeda-C&oacute;digos ABA</a></div></td>		
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr> 		    
				<td>
					<div align="left" class="login">
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
						<tr> 
							<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
							<td><div align="left" class="login"><bean:message key="lbl.transf.inter.titulo"/></div></td>
							<td width="8%"><div align="right">&nbsp;</div></td>
						</tr>
					</table>
					</div>
				</td>
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
		<html:form method="post" action="/transfer.do" >
			<html:hidden property="descMoneda" />
			<html:hidden property="action" />
			<html:hidden property="mode" />
			<html:hidden property="numeroDocumento" />

		<table width="100%" border="0" cellpadding="5" cellspacing="1">
			<tr>
				<td colspan="2" height="20" valign="middle" class="texto-acceso"><bean:message key="lbl.transf.campo.requerido"/></td>
			</tr>
			<tr valign="middle">
				<html:text property="Duplicada" styleId="Duplicada"  size="45" maxlength="20" value="false" style="display:none"/>
				<html:text property="cantidad2" styleId="cantidad2"   value="" style="display:none"/>
				<html:text property="isFestivo" styleId="isFestivo"   value="" style="display:none"/>
				<td width="50%" class="bienvenida"><bean:message key="lbl.transf.inter.plantilla"/></td>
				<td class="bienvenida">
					<html:select property="plantilla" styleId="plantilla" styleClass="botton-acceso">
						<html:option value="-1"><bean:message key="lbl.transf.inter.seleccione"/></html:option>
						<csic:plantillas>
							<html:option value="<%=codigo%>" ><%=valor %></html:option>	
						</csic:plantillas>
					</html:select>
				</td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"></td>
				<td class="bienvenida">
					<html:checkbox property="guardaOperacionFrecuente"/>
					<bean:message key="lbl.transf.inter.guardar.frecuente"/>
				</td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><b>1:</b> <bean:message key="lbl.transf.inter.fecha"/></td>
				<td class="bienvenida"></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><html:text property="fechaSolicitud" styleId="fechaSolicitud" size="20" maxlength="10" styleClass="botton-acceso" onkeypress="fecha();" onblur="__formatDate(this);"/>
					<input id="calendarbutton" type="button" class="calendar2" value=" " onclick="return showCalendar('fechaSolicitud', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]</td>
				<td class="bienvenida"></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida">
					<table width="100%">
						<tr valign="middle">
							<td class="bienvenida" align="left" width="130"><b>2:</b> <bean:message key="lbl.transf.inter.cantidad"/></td>
							<td class="bienvenida" align="left"><b></b> <bean:message key="lbl.transf.inter.centavos"/></td>
						</tr>
					</table>
				</td>
				<td class="bienvenida"><b>3:</b> <bean:message key="lbl.transf.inter.moneda"/></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida">
					<table width="100%">
						<tr valign="middle">
							<td class="bienvenida" align="left" width="80"><html:text property="cantidad"  styleId="cantidad" onkeypress="entero()" maxlength="10" onblur="mascara(this)" styleClass="botton-acceso"/></td>
							<td align="left" class="bienvenida">
								<html:text property="centavos"  styleId="centavos" onkeypress="entero()" maxlength="2" size="1" styleClass="botton-acceso"/>
								<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
							</td>
						</tr>
					</table>
				</td>
				<td class="bienvenida">
					<html:select property="moneda" styleId="moneda" styleClass="botton-acceso">
						<csic:monedas>
						<% 
							String selected = "";
							if(valor.equals(Moneda))
								selected = " selected";
							else
								selected = "";
						out.println("<option  value=\"" + codigo + "\"" + selected +">" + valor + "</option>");
						%>	
						</csic:monedas>
					</html:select>
					<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
				</td>
			</tr>

			<!-- EMISOR -->
			<tr valign="middle" class="celda-clave1">
				<td colspan="2" class="bienvenida">&nbsp;&nbsp;&nbsp;<b><bean:message key="lbl.transf.inter.titulo.emisor"/></b></td>
			</tr>
			<tr valign="middle">
				<td width="50%" class="bienvenida"><b>4:</b> <bean:message key="lbl.transf.inter.cuenta"/></td>
				<td width="50%" class="bienvenida"><b>5:</b> <bean:message key="lbl.transf.inter.nombreEmisor"/></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida">
					<html:select property="cuentaDb" styleId="cuentaDb" onchange="setCuenta(this)" styleClass="botton-acceso">
						<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
						<csic:forEachCuentaPerfil producto="CC" formatAccount="C" mancomunada="true">
							<%if ("true".equals(mancomunada)) {%>
							<html:option value="<%=numCtaCSIC%>" ><%=numCta %></html:option>	
							<%} %>
						</csic:forEachCuentaPerfil>
					</html:select>
					<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
				</td>
				<td class="bienvenida"><html:hidden property="nombreEmisor"/><div id="nombreEmisor2" class="textbox"></div></td>
			</tr>
			<!-- EMISOR -->

			<!-- BANCO INTERMEDIARIO -->
			<tr valign="middle" class="celda-clave1">
				<td colspan="2" class="bienvenida">
					&nbsp;&nbsp;&nbsp;<b><bean:message key="lbl.transf.inter.titulo.nombreBancoIntermediario"/><br>
					&nbsp;&nbsp;&nbsp;<small>(<bean:message key="lbl.transf.inter.nota.banco.intermediario"/>)</small></b></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><b>6:</b> <html:radio property="tipoSWIFTBeneficiario" value="SWIFT" styleId="_SWIFT"/>
					<bean:message key="lbl.transf.inter.swiftBeneficiario"/>
					<html:radio property="tipoSWIFTBeneficiario" value="ABA" styleId="_ABA"/>
					<bean:message key="lbl.transf.inter.abaBeneficiario"/></td>
			</tr>
			<tr valign="middle">					   
				<td class="bienvenida"><html:text property="swiftBeneficiario" styleId="swiftBeneficiario" maxlength="18" styleClass="botton-acceso"/></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><b>7:</b> <bean:message key="lbl.transf.inter.nombreBancoIntermediario"/></td>
				<td class="bienvenida"><b>8:</b> <bean:message key="lbl.transf.inter.direccionBancoBeneficiario"/></td>
			</tr>
			<tr valign="top">
				<td class="bienvenida"><html:hidden property="bancoBeneficiario"/><div id="lblBancoBeneficiario" class="textbox"></div></td>
				<td class="bienvenida"><html:hidden property="direccionBancoBeneficiario"/><div id="lblDireccionBancoBeneficiario" class="textbox2"></div></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><b>9:</b> <bean:message key="lbl.transf.inter.ciudadBancoBeneficiario"/></td>
				<td class="bienvenida"><b>10:</b> <bean:message key="lbl.transf.inter.paisBancoBeneficiario"/></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><html:hidden property="ciudadBancoBeneficiario"/><div id="lblCiudadBancoBeneficiario" class="textbox"></td>
				<td class="bienvenida"><html:hidden property="paisBancoBeneficiario"/><div id="lblPaisBancoBeneficiario" class="textbox"></td>
			</tr>
			<!-- BANCO INTERMEDIARIO -->
			
			<!-- BANCO BENEFICIARIO -->
			<tr valign="middle" class="celda-clave1">
				<td colspan="2" class="bienvenida">&nbsp;&nbsp;&nbsp;<b><bean:message key="lbl.transf.inter.titulo.nombreBancoBeneficiario"/></b></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><b>11:</b> <bean:message key="lbl.transf.inter.cuentaBancoIntermediario"/></td>
				<td class="bienvenida"><b>12:</b>
					<html:radio property="tipoSWIFTIntermediario" value="SWIFT" styleId="_SWIFT2" onclick="_choseValue('SWIFT');"/>
					<bean:message key="lbl.transf.inter.swiftBancoIntermediario"/>
					<html:radio property="tipoSWIFTIntermediario" value="ABA" styleId="_ABA2" onclick="_choseValue('ABA');"/>
					<bean:message key="lbl.transf.inter.abaBancoIntermediario"/>
					<html:radio property="tipoSWIFTIntermediario" value="OTRO" styleId="_OTRO2" onclick="_choseValue('ANOTHER');"/>
					<bean:message key="lbl.transf.inter.otroBancoIntermediario"/>
				</td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><html:text property="cuentaBancoIntermediario" styleId="cuentaBancoIntermediario"  onkeypress="alphabetic();" onblur="_showAlert(this,8);" maxlength="34" size="45" styleClass="botton-acceso"/></td>
				<td class="bienvenida"><html:text property="swiftBancoIntermediario" styleId="swiftBancoIntermediario" maxlength="18" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><b>13:</b> <bean:message key="lbl.transf.inter.bancoBeneficiario"/></td>
				<td class="bienvenida"><b>14:</b> <bean:message key="lbl.transf.inter.direccionBancoIntermediario"/></td>
			</tr>
			<tr valign="top">
				<td class="bienvenida">
					<div id="lblNombreBancoIntermediario" class="textbox" style="display:"></div>
					<div id="txtNombreBancoBeneficiario" style="display:none">
						<html:text property="nombreBancoIntermediario" styleClass="botton-acceso" size="45" maxlength="50" onkeypress="alphanumeric()" onblur="_showAlert(this, 5);"/></div>
				</td>
				<td class="bienvenida">
					<div id="lblDireccionBancoIntermediario" class="textbox2" style="display:"></div>
					<div id="txtDireccionBancoIntermediario" style="display:none">
						<html:textarea property="direccionBancoIntermediario" styleClass="botton-acceso" cols="35" rows="5" onkeypress="alphabetic();validateLength(this, 50)" onblur="_showAlert(this, 6);" /></div>
				</td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><b>15:</b> <bean:message key="lbl.transf.inter.ciudadBancoIntermediario"/></td>
				<td class="bienvenida"><b>16:</b> <bean:message key="lbl.transf.inter.paisBancoIntermediario"/></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida">
					<div id="lblCiudadBancoIntermediario" class="textbox" style="display:"></div>
					<div id="txtCiudadBancoIntermediario" style="display:none">
						<html:text property="ciudadBancoIntermediario" styleClass="botton-acceso" size="45" maxlength="20" onkeypress="alphabetic()" onblur="_showAlert(this, 7);"/></div>
				</td>
				<td class="bienvenida">
					<div id="lblPaisBancoIntermediario" class="textbox" style="display:"></div>
					<div id="txtPaisBancoIntermediario" style="display:none">
						<html:select property="paisBancoIntermediario" styleId="paisBancoIntermediario" styleClass="botton-acceso" onchange="validaPaisBloq(this,16);">
							<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
							<csic:paises>
								<%
									if (codigo != null && codigo.length() > 20)
									{
										codigo = codigo.substring(0, 19);
									}
									paises.add("<option  value=\"" + valor + "\"  id=\"" + bloqPais + "\" name=\"listaPaises\">" + valor + "</option>");
									out.println("<option  value=\"" + valor + "\"  id=\"" + bloqPais + "\" name=\"listaPaises\">" + valor + "</option>");	
								%>	
							</csic:paises>
						</html:select>
					</div>
				</td>
			</tr>	
			<!-- BANCO BENEFICIARIO -->

			<!-- BENEFICIARIO -->
			<tr valign="middle" class="celda-clave1">
				<td colspan="2" class="bienvenida"><b>&nbsp;&nbsp;&nbsp;<bean:message key="lbl.transf.inter.titulo.beneficiario"/></b></td>
			</tr>	
			<tr valign="middle">
				<td class="bienvenida"><b>17:</b> <bean:message key="lbl.transf.inter.nombreBeneficiario"/></td>
				<td class="bienvenida"><b>18:</b> <bean:message key="lbl.transf.inter.cuentaBeneficiario"/></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida" nowrap><html:text property="nombreBeneficiario" styleId="nombreBeneficiario" maxlength="50" size="65" onkeypress="alphanumeric();" onblur="_showAlert(this, 1);" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
				<td class="bienvenida"><html:text property="cuentaBeneficiario" styleId="cuentaBeneficiario" maxlength="34" size="45" onkeypress="alphabetic();" onblur="_showAlert(this,9);" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><b>19:</b> <bean:message key="lbl.transf.inter.direccionBeneficiario"/></td>
				<td class="bienvenida"></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><html:textarea property="direccionBeneficiario" styleId="direccionBeneficiario" cols="35" rows="5" onkeypress="alphabetic();validateLength(this, 90)" onblur="_showAlert(this, 2);" styleClass="botton-acceso"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
				<td class="bienvenida"></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><b>20:</b> <bean:message key="lbl.transf.inter.ciudadBeneficiario"/></td>
				<td class="bienvenida"><b>21:</b> <bean:message key="lbl.transf.inter.paisBeneficiario"/></td>
			</tr>
			<tr valign="middle">
				<td class="bienvenida"><html:text property="ciudadBeneficiario" styleId="ciudadBeneficiario" size="45" onkeypress="alphabetic()" maxlength="40" onblur="_showAlert(this, 3);" styleClass="botton-acceso"/></td>
				<td class="bienvenida">
					<html:select property="paisBeneficiario" styleId="paisBeneficiario" styleClass="botton-acceso" onchange="validaPaisBloq(this,21);">  
						<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
						
								<%
									for (int f = 0; f < paises.size(); f++){
									out.println(paises.get(f));	}
								%>	

					</html:select>
				</td>
			</tr>
			<!-- BENEFICIARIO -->

			<!-- DETALLE DE PAGO-->
			<tr valign="middle" class="celda-clave1">
				<td colspan="2" class="bienvenida"><b>&nbsp;&nbsp;&nbsp;<bean:message key="lbl.transf.inter.detalle"/></b></td>
			</tr>	
			<tr valign="middle">
				<td class="bienvenida"><b>22:</b> <bean:message key="lbl.transf.inter.detalle"/></td>
				<td class="bienvenida"></td>
			</tr>
			<tr valign="top">
				<td class="bienvenida"><html:textarea property="instrucciones" styleId="detallePago" cols="35" rows="5" onkeypress="alphanumeric();validateLength(this, 130)" onblur="_showAlert(this,4);" styleClass="botton-acceso"/></td>
				<td class="bienvenida"></td>
			</tr>
			<!-- DETALLE DE PAGO-->

			<tr>
				<td colspan="2" align="center"><br><br>
					<input id="tranferir" type="button" class="botton"  onclick="blockButton();"  value="<bean:message key="btn.enviar.aprobacion"/>"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="botton" onclick="document.location='<html:rewrite page='/transferencias/transferencia.jsp'/>'" value="<bean:message key="btn.limpiar"/>"/>
				</td>
			</tr>
		</table>
		</html:form>

		<script>
		function __initialize(){
			if(document.forms[0].cuentaDb.value == "")
			{}
			else{
				document.getElementById("moneda").setAttribute('disabled', 'enable');
				document.getElementById("cuentaDb").setAttribute('disabled', 'enable');
			}
			__formatDate(document.forms[0].fechaSolicitud);
			setCuenta(document.forms[0].cuentaDb);
			_refresh();
		}
		__initialize();

		//var nodo = document.getElementById('detallePago');
		//nodo.onpaste = function(e)
		//{return false;}
		</script>
		
		<ajax:updateField
		  baseUrl="${pageContext.request.contextPath}/plantilla.view"
		  source="plantilla"
		  target="nombreBeneficiario,cuentaBeneficiario,direccionBeneficiario,ciudadBeneficiario,paisBeneficiario,bancoBeneficiario,swiftBeneficiario,direccionBancoBeneficiario,ciudadBancoBeneficiario,paisBancoBeneficiario,nombreBancoIntermediario,swiftBancoIntermediario,direccionBancoIntermediario,cuentaBancoIntermediario,ciudadBancoIntermediario,paisBancoIntermediario"
		  action="plantilla"
		  eventType="change"
		  parameters="codigo={plantilla}"
		  postFunction="_refresh"/>
	  
		<ajax:updateField
		  baseUrl="${pageContext.request.contextPath}/swift.view"
		  source="swiftBeneficiario"
		  target="lblBancoBeneficiario,lblDireccionBancoBeneficiario,lblCiudadBancoBeneficiario,lblPaisBancoBeneficiario"
		  action="swiftBeneficiario"
		  eventType="blur"
		  parameters="number={swiftBeneficiario}, t=1"
		  emptyFunction="swiftMessage"
		  postFunction="__validateField2"/>

		<ajax:updateField
		  baseUrl="${pageContext.request.contextPath}/swift2.view"
		  source="swiftBancoIntermediario"
		  target="lblNombreBancoIntermediario,lblDireccionBancoIntermediario,lblCiudadBancoIntermediario,lblPaisBancoIntermediario"
		  action="swiftBancoIntermediario"
		  eventType="blur"
		  parameters="number={swiftBancoIntermediario}, t=2"
		  emptyFunction="swiftMessage2"
		  postFunction="__validateField1"/>
		  
		 <!-- verificacion q la tranferencia no este Duplicada  -->    
		  <ajax:updateField
		  baseUrl="${pageContext.request.contextPath}/duplicidadTranferencia.view"
		  source="tranferir"
		  target="Duplicada"
		  action="tranferir"
		  eventType="mouseup"
		  parameters="fechaValor={fechaSolicitud},CtaOrdenante={cuentaDb},beneficiario={nombreBeneficiario},cantidad={cantidad2},centavos={centavos},CtaBeneficiario={cuentaBeneficiario}" 
		  postFunction="__ConmfirDuplicada"
		  />
		  <!-- verificacion q la tranferencia no sea dia festivo  -->    
		<ajax:updateField
		  baseUrl="${pageContext.request.contextPath}/Fechasfestivas.view"
		  source="calendarbutton"
		  target="isFestivo"
		  action="calendarbutton"
		  eventType="blur"
		  parameters="fechaValor={fechaSolicitud}" 
		  postFunction="__isfechaFestiva"
		  />
		  <ajax:updateField
		  baseUrl="${pageContext.request.contextPath}/Fechasfestivas.view"
		  source="fechaSolicitud"
		  target="isFestivo"
		  action="fechaSolicitud"
		  eventType="blur"
		  parameters="fechaValor={fechaSolicitud}" 
		  postFunction="__isfechaFestiva"
		  />
		<!-- Fin. Solicitud -->
		</td>
	</tr>
</table></div>
<%@ include file="../footer.jsp"  %>
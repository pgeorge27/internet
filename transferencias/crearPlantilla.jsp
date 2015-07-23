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

<!DOCTYPE html>
<html:html>

<head>
<%@ include file="../head.jsp"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<%
String Moneda = (session.getAttribute("monedaSelect")!=null) ? session.getAttribute("monedaSelect").toString() : "";

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
		}else 
			if (index == 7){
			
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
	//Se valida que se escoga una cuenta
	var cuenta = document.forms[0].cuentaDb.value;
	if (cuenta.length <= 0){
		alert("El número de cuenta es requerido (Campo 2)");
		return false;
	}
	
	//Se valida que la dirección del beneficiario no sea nula
	var dirbeneficiario = document.forms[0].direccionBeneficiario.value;
	dirbeneficiario = _trim(dirbeneficiario);
	if (dirbeneficiario.length <= 0){
		alert("La dirección del beneficirio es requerida (Campo 17)");
		document.forms[0].tranferir.disabled = false;
		return false;
	}else{
		if (dirbeneficiario.length < 10){
			alert("La dirección del beneficirio, debe ser una dirección real (Campo 17)");
			document.forms[0].tranferir.disabled = false;
			return false;
		}
	}
	
	var cuentaInter = document.forms[0].cuentaBancoIntermediario.value;
	document.forms[0].cuentaBancoIntermediario.value = cuentaInter.replace(" ","");
	
	if(!areEqual("cuentaBancoIntermediario","cuentaBeneficiario")){
		var moneda = "";
		var monto = "";
		var index = document.forms[0].moneda.selectedIndex;
		if (index >= 0)
			moneda = document.forms[0].moneda.options[index].text;
		
			document.forms[0].descMoneda.value=moneda;
		 	if (confirm("Desea crear Plantilla "+ document.forms[0].nombreEmisor.value+" \ "+ document.forms[0].nombreBeneficiario.value)){
			  	e.disabled = true;
			  	document.forms[0].moneda.disabled = false;
				document.forms[0].cuentaDb.disabled = false;
			 	document.forms[0].submit();
		  	}
	}
	else{
		alert("Los campos 4 y 10 deben ser diferentes");
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

<body>

<div align="center" class="container"> 



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

		
						<div align="left" class="texto-acceso">
						<a href="http://www.chips.org/uid/uid_form.php" target="new">B&uacute;squeda-C&oacute;digos SWIFT</a>
						</div>
			 
				
						<div align="left" class="texto-acceso">
						<a href="http://www.fedwiredirectory.frb.org/search.cfm" target="new">B&uacute;squeda-C&oacute;digos ABA</a>
						</div>
			
			<br>

		<div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.transf.inter.titulo.plantilla"/></strong></div>
  <div class="panel-body">
  
  	<html:form method="post" action="/transfer" onsubmit="document.forms[0].action.value='validate'">
			<html:hidden property="descMoneda" />
			<html:hidden property="action" />
			<html:hidden property="mode" value="plantilla"/>
			<html:hidden property="numeroDocumento" />
  
  
  
  
  <div class="texto-acceso" align="left">
						<h6 style="color:#95A5A6 "><bean:message key="lbl.transf.campo.requerido"/></h6>
						
					</div>

<br>



   				           <div class="row">
  <div class="col-md-4" align="left"><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>&nbsp;<b>1:</b><bean:message key="lbl.transf.inter.moneda"/>:</div>

  <div class="col-md-3"><html:select property="moneda" styleId="moneda" styleClass="form-control">
						<csic:monedas>
						<%
						   String selected = "";
							if(valor.equals(Moneda))
								selected = " selected";
							else
								selected = "";
							out.println("<option value=\"" + codigo + "\"" + selected +">" + valor + "</option>");
						%>
						</csic:monedas>
						</html:select></div>

  <div class="col-md-2" align="left"></div>
  
  
    <div class="col-md-3"></div>
  

  
 
  </div>

		 <br>	

   				           <div class="row">
  <div class="col-md-4" align="left"><strong><bean:message key="lbl.transf.inter.titulo.emisor"/></strong><br><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>&nbsp;<b>2:</b> <bean:message key="lbl.transf.inter.cuenta"/>:</div>

  <div class="col-md-3"><html:select property="cuentaDb" styleId="cuentaDb" onchange="setCuenta(this)" styleClass="form-control" >
							<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
							<csic:forEachCuentaPerfil producto="CC" formatAccount="C" mancomunada="true">
								<%if ("true".equals(mancomunada)) {%>
								<html:option value="<%=numCtaCSIC%>" ><%=numCta %></html:option>	
								<%} %>
							</csic:forEachCuentaPerfil>
						</html:select></div>
  
  <div class="col-md-2" align="left"><b>3:</b> <bean:message key="lbl.transf.inter.nombreEmisor"/>:</div>
  
  
    <div class="col-md-3"><html:hidden property="nombreEmisor"/><div id="nombreEmisor2" class="form-control"></div></div>
  

  </div>
		 
		 
		 
		  <br>
		 
		 
		 
		  <div class="texto-acceso" align="left">
						<h6>	<div>
					<div><br>
					<b><bean:message key="lbl.transf.inter.titulo.nombreBancoIntermediario"/><br>
					<strong><small>(<bean:message key="lbl.transf.inter.nota.banco.intermediario"/>)</small></strong></b></div>
				</div>	</h6>
						
					</div> 
		 
		 
		 
		 
		 
		 <br>



   				           <div class="row">
  <div class="col-md-4" align="left"><b>4:</b>&nbsp;<html:radio property="tipoSWIFTBeneficiario" value="SWIFT" styleId="_SWIFT"/>&nbsp;&nbsp;<bean:message key="lbl.transf.inter.swiftBeneficiario"/>&nbsp; <html:radio property="tipoSWIFTBeneficiario" value="ABA" styleId="_ABA"/>&nbsp;&nbsp;<bean:message key="lbl.transf.inter.abaBeneficiario"/></div>

  <div class="col-md-3"><html:text property="swiftBeneficiario" styleId="swiftBeneficiario" maxlength="18" styleClass="form-control"/></div>

  <div class="col-md-2" align="left"></div>
  
  
    <div class="col-md-3"></div>
  

  
 
  </div>
		 
		 
		 
				 <br>	

   				           <div class="row">
  <div class="col-md-4" align="left">&nbsp;<b>5:</b>&nbsp;<bean:message key="lbl.transf.inter.nombreBancoIntermediario"/>:</div>

  <div class="col-md-3"><html:hidden property="bancoBeneficiario"/><div id="lblBancoBeneficiario" class="form-control"></div></div>
  
  <div class="col-md-2" align="left"><b>6:</b> <bean:message key="lbl.transf.inter.direccionBancoBeneficiario"/>:</div>
  
  
    <div class="col-md-3"><html:hidden property="direccionBancoBeneficiario"/><textarea id="lblDireccionBancoBeneficiario" class="form-control" rows="3"></textarea></div>
  

  </div>
		 
		 
		 
		 <br>	
		 
		 
		 

		  
		  
		  
		     				           <div class="row">
  <div class="col-md-4" align="left"><b>7:</b>&nbsp;<bean:message key="lbl.transf.inter.ciudadBancoBeneficiario"/>:</div>

  <div class="col-md-3"><html:hidden property="ciudadBancoBeneficiario"/><div id="lblCiudadBancoBeneficiario" class="form-control"></div></div>
  
  <div class="col-md-2" align="left"><b>8:</b>&nbsp;<bean:message key="lbl.transf.inter.paisBancoBeneficiario"/>:</div>
  
  
    <div class="col-md-3"><html:hidden property="paisBancoBeneficiario"/><div id="lblPaisBancoBeneficiario" class="form-control"></div></div>
  

  </div>
		  

		  
		  <br>
		  


		     				           <div class="row">
  <div class="col-md-4" align="left"><strong><b><bean:message key="lbl.transf.inter.bancoBeneficiario"/></b></strong><br><b>9:</b><bean:message key="lbl.transf.inter.cuentaBancoIntermediario"/>:</div>

  <div class="col-md-3"><html:text property="cuentaBancoIntermediario" styleId="cuentaBancoIntermediario" onkeypress="alphabetic();" onblur="_showAlert(this,8);" maxlength="34" size="45" styleClass="form-control"/></div>
  
  <div class="col-md-2" align="left"><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>&nbsp;<b>10:</b>&nbsp;<html:radio property="tipoSWIFTIntermediario" value="SWIFT" styleId="_SWIFT2" onclick="_choseValue('SWIFT');"/>&nbsp;<bean:message key="lbl.transf.inter.swiftBancoIntermediario"/>&nbsp;<html:radio property="tipoSWIFTIntermediario" value="ABA" styleId="_ABA2" onclick="_choseValue('ABA');"/>&nbsp;<bean:message key="lbl.transf.inter.abaBancoIntermediario"/></div>
  
  
    <div class="col-md-3"><html:text property="swiftBancoIntermediario" styleId="swiftBancoIntermediario" maxlength="18" styleClass="form-control"/></div>
  

  </div>
		  
		  
		  
		  <br>
		  
		 
		 
		 
		    				           <div class="row">
  <div class="col-md-4" align="left"><b>11:</b>&nbsp;<bean:message key="lbl.transf.inter.bancoBeneficiario"/>:</div>

  <div class="col-md-3"><div id="lblNombreBancoIntermediario" class="form-control" style="display:"></div><div id="txtNombreBancoBeneficiario" style="display:none"><html:text property="nombreBancoIntermediario" styleClass="form-control" size="45" maxlength="50" onkeypress="alphanumeric()" onblur="_showAlert(this, 5);"/></div></div>
  
  <div class="col-md-2" align="left"><b>12:</b>&nbsp;<bean:message key="lbl.transf.inter.direccionBancoIntermediario"/>:</div>
  
  
    <div class="col-md-3"> <html:hidden property="direccionBancoIntermediario"/><textarea id="lblDireccionBancoIntermediario" class="form-control" rows="3" onkeypress="alphabetic();validateLength(this, 50)" onblur="_showAlert(this, 6);"></textarea></div>
  

  </div>
		 


		 <br>	
		 
		 
		 

		  
		  
		  
		     				           <div class="row">
  <div class="col-md-4" align="left"><b>13:</b>&nbsp;<bean:message key="lbl.transf.inter.ciudadBancoIntermediario"/>:</div>

  <div class="col-md-3"><div id="lblCiudadBancoIntermediario" class="form-control" style="display:"></div>
						<div id="txtCiudadBancoIntermediario" style="display:none"><html:text property="ciudadBancoIntermediario" styleClass="form-control" size="45" maxlength="20" onkeypress="alphabetic()" onblur="_showAlert(this, 7);"/></div></div>
  
  <div class="col-md-2" align="left"><b>14:</b>&nbsp;<bean:message key="lbl.transf.inter.paisBancoIntermediario"/>:</div>
  
  
    <div class="col-md-3">	<div id="lblPaisBancoIntermediario" class="form-control" style="display:"></div>
						<div id="txtPaisBancoIntermediario" style="display:none">
						<html:select property="paisBancoIntermediario" styleId="paisBancoIntermediario" styleClass="form-control" onchange="validaPaisBloq(this,16);">
							<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
							<csic:paises>
								<%
									if (codigo != null && codigo.length() > 20)
									{
										codigo = codigo.substring(0, 19);
									}
									out.println("<option value=\"" + valor + "\"  id=\"" + bloqPais + "\" name=\"listaPaises\">" + valor + "</option>");
								%>	
							</csic:paises>
						</html:select>
						</div></div>
  

  </div>
		 
		 
		 
		  <br>
		 
		 
		 
		 
		 
		 
		 		     				           <div class="row">
  <div class="col-md-4" align="left"><b><bean:message key="lbl.transf.inter.titulo.beneficiario"/></b><br><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>&nbsp;<b>15:</b><bean:message key="lbl.transf.inter.nombreBeneficiario"/>:</div>

  <div class="col-md-3"><html:text property="nombreBeneficiario" styleId="nombreBeneficiario" maxlength="50" size="65" onkeypress="alphanumeric();" onblur="_showAlert(this, 1);" styleClass="form-control"/></div>
  
  <div class="col-md-2" align="left"><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>&nbsp;<b>16:</b>&nbsp;<bean:message key="lbl.transf.inter.cuentaBeneficiario"/></div>
  
  
    <div class="col-md-3"><html:text property="cuentaBeneficiario" styleId="cuentaBeneficiario" maxlength="34" size="45" onkeypress="alphabetic();" onblur="_showAlert(this,9);" styleClass="form-control"/></div>
  

  </div>
		  
		  
		  
		  <br>
		 
		 
		 
		 
		 
   				           <div class="row">
  <div class="col-md-4" align="left"><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>&nbsp;<b>17:</b><bean:message key="lbl.transf.inter.direccionBeneficiario"/>:</div>

  <div class="col-md-3"><html:hidden property="direccionBeneficiario"/><textarea id="direccionBeneficiario" cols="35" rows="5" onkeypress="alphabetic();validateLength(this, 90)" onblur="_showAlert(this, 2);" class="form-control"></textarea></div>
  
  
  
  
  

  
  
  
  

  <div class="col-md-2" align="left"></div>
  
  
    <div class="col-md-3"></div>
  

  
 
  </div>

		 <br>	
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 		     				           <div class="row">
  <div class="col-md-4" align="left"><b>18:</b><bean:message key="lbl.transf.inter.ciudadBeneficiario"/>:</div>

  <div class="col-md-3"><html:text property="ciudadBeneficiario" styleId="ciudadBeneficiario" size="45" onkeypress="alphabetic()" maxlength="40" onblur="_showAlert(this, 3);" styleClass="form-control"/></div>
  
  <div class="col-md-2" align="left"><b>19:</b><bean:message key="lbl.transf.inter.paisBeneficiario"/>:</div>
  
  
    <div class="col-md-3"><html:select property="paisBeneficiario" styleId="paisBeneficiario" styleClass="form-control" onchange="validaPaisBloq(this,21);">  
							<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
							<csic:paises>
								<%
									if (codigo != null && codigo.length() > 20)
									{
										codigo = codigo.substring(0, 19);
									}
									out.println("<option value=\"" + valor + "\"  id=\"" + bloqPais + "\" name=\"listaPaises\">" + valor + "</option>");	
								%>	

							</csic:paises>
						</html:select></div>
						
						<html:hidden property="instrucciones" styleId="detallePago" />
  

  </div>
		  

		  
		  <br>
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 <br>
		 
		 
		 
		 					  	<div align="center">
						<input type="button" class="btn btn-default" style="width: 150px" onclick="send(this);" value="Guardar Plantilla"/>
								<input type="button" class="btn btn-default" style="width: 150px" onclick="document.location='<html:rewrite page='/transferencias/crearPlantilla.jsp'/>'" value="<bean:message key="btn.limpiar"/>"/>	
		
				</div>
				
				<br>
		 
		 
		  </html:form> 
		  
		  </div>
		 


  
</div>












<br>


			<script>
			function __initialize(){
				if(document.forms[0].cuentaDb.value == "")
				{}
				else 
				{
					document.getElementById("moneda").setAttribute('disabled', 'enable');
					document.getElementById("cuentaDb").setAttribute('disabled', 'enable');
				}
				__formatDate(document.forms[0].fechaSolicitud)
				setCuenta(document.forms[0].cuentaDb);
				_refresh();
			}
			__initialize();
			
			//var nodo = document.getElementById('detallePago');
			//nodo.onpaste = function(e)
			//{return false;}
			</script>

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
			<!-- Fin. Solicitud -->



</div>
</body>
</html:html>

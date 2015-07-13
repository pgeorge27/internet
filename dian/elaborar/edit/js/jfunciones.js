// JavaScript Document
<!--
function fixTwoDecimals(original){
	var result="";
    if (orifginal != "" && !isNaN(original))
    	result = Math.round(original*100)/100;
	return result;
}
function frmValida(formulario,validar){
	var cadena = document.getElementById(validar).value;
	var count = 0;
	for(i=0; i < document.getElementById(formulario).length; i++){
			objForm = document.getElementById(formulario).elements[i].name;
			if (cadena.indexOf(objForm) != -1){			   
			   if (document.getElementById(formulario).elements[i].value == ''){
				   document.getElementById(formulario).elements[i].className = 'txtTextoV';
				   count++;
			   }else if(document.getElementById(formulario).elements[i].value == 0){
				   document.getElementById(formulario).elements[i].className = 'txtTextoV';
				   count++;
			   }
			}
	}
	if(count > 0){
		alert("Complete los datos marcados");
	}else{
		document.getElementById(formulario).submit();
	}
}

function _trim(str){
	while(''+str.charAt(0)==' ')
		str=str.substring(1,str.length);
	return str;	
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


function __hideAccountList(){
	var sel;
	if (document.all){
	   sel = document.all.tags("SELECT");
	}
	else{
	   sel = document.getElementsByTagName("SELECT");
	}
	
	for(i=0;i<sel.length;i++){
		selx=0; sely=0; var selp;
		if(sel[i].offsetParent){selp=sel[i]; while(selp.offsetParent){selp=selp.offsetParent; selx+=selp.offsetLeft; sely+=selp.offsetTop;}}
		selx+=sel[i].offsetLeft; sely+=sel[i].offsetTop
		selw=sel[i].offsetWidth; selh=sel[i].offsetHeight
		
		if(sel[i].style.visibility!="hidden"){
			sel[i].style.visibility="hidden";
		}
	}
}
function __showAccountList(){
	var svn;
	var sel;
	if (document.all){
	   sel = document.all.tags("SELECT");
	}
	else{
	   sel = document.getElementsByTagName("SELECT");
	}
	
	for(i=0;i<sel.length;i++){
		selx=0; sely=0; var selp;
		if(sel[i].offsetParent){selp=sel[i]; while(selp.offsetParent){selp=selp.offsetParent; selx+=selp.offsetLeft; sely+=selp.offsetTop;}}
		selx+=sel[i].offsetLeft; sely+=sel[i].offsetTop
		selw=sel[i].offsetWidth; selh=sel[i].offsetHeight
		sel[i].style.visibility="visible"
	}	
	
}
function validateLength(obj, size){
    var str = _trim(obj.value);
	if (str.length >= size){
		event.returnValue = false;
	}
}
function __isValidNumber(element, decimals){
	var regexp_user;
	eval("regexp_user=/^([1-9]{1}[0-9]{0,}(\.[0-9]{0,"+decimals+"})?|0(\.[0-9]{0,"+decimals+"})?|\.[0-9]{1,"+decimals+"})$/");
	if (element.value != ""){
		if(element.value.match(regexp_user) == null){
			alert("Debe ingresar hasta "+decimals+ " decimales");
		}
	}
}
-->
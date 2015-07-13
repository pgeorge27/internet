// esta funcion se encargara de validar si el pin de token introducido cumple con el largo estipulado
function tokenLenValidation(cantidad,field){
	//el parametro cantidad es la cantidad de caracteres que debe tener el pin
	//el parametro field es el id del campo de texto a ser validado
		
	if(field.length == cantidad){
		return true;
	}
	else{
		return false;
	}
}

function tokenSeqValidation(cadena)
{
	var seq ;	
	for(var i=0; i < cadena.length; i++)
	{		
		if( 
			(parseInt(cadena.charAt(i)) == parseInt(cadena.charAt(i+1))  && parseInt(cadena.charAt(i+1)) == parseInt(cadena.charAt(i+2))) || 
			(parseInt(cadena.charAt(i)) == parseInt(cadena.charAt(i+1))-1 && parseInt(cadena.charAt(i+1)) == parseInt(cadena.charAt(i+2))-1) ||
			(parseInt(cadena.charAt(i)) == parseInt(cadena.charAt(i+1))+1  &&  parseInt(cadena.charAt(i+1)) == parseInt(cadena.charAt(i+2))+1)
		  )
		{
			return false;
		}
		seq = cadena.charAt(i);
	}
	return true
}

function escribir(A){
	if(A.charCodeAt(0)!=160){
      if(document.getElementById("Foco")){
    	  if(document.getElementById(document.getElementById("Foco").value).value.length<6){
    			 document.getElementById(document.getElementById("Foco").value).value=document.getElementById(document.getElementById("Foco").value).value+A;
    			 window.status="";
    			 focusContinueControl();
    			return true
    			}
    	  
      }else if(document.getElementById("clave")){
    	  if(document.getElementById("clave").value.length<6){
		 document.getElementById("clave").value=document.getElementById("clave").value+A;
		 window.status="";
		 focusContinueControl();
		return true
		}}
      else if(document.getElementById("segundaClave")){
    	  if(document.getElementById("segundaClave").value.length<4){
		 document.getElementById("segundaClave").value=document.getElementById("segundaClave").value+A;
		 window.status="";
		 focusContinueControl();
		return true
		}}
      else
    	  {
 			 document.getElementById(Foco).value=document.getElementById(Foco).value+A;
 			 window.status="";
 			 focusContinueControl();
 			return true
 			}
    	  
	}
}

function clearChar(){
	 if(document.getElementById("Foco") ){
		 var B=document.getElementById(document.getElementById("Foco").value).value;
		 var A=document.getElementById(document.getElementById("Foco").value).value.length;
		 document.getElementById(document.getElementById("Foco").value).value=B.substring(0,A-1);
	 }else if (document.getElementById("clave")){
	     var B=document.getElementById("clave").value;
	     var A=document.getElementById("clave").value.length;
	      document.getElementById("clave").value=B.substring(0,A-1);
	 }else{
		 var B=document.getElementById(Foco).value;
		 var A=document.getElementById(Foco).value.length;
		 document.getElementById(Foco).value=B.substring(0,A-1);
	  }
	 
	 
	 
	 focusContinueControl()
}
function clearField(){
	if(document.getElementById("Foco") ){
		document.getElementById(document.getElementById("Foco").value).value=""
	}else if (document.getElementById("clave")){
	document.getElementById("clave").value="" 
		}
	else{
		document.getElementById(Foco).value=""
	}
}

function focusContinueControl(){
	if(document.getElementById("Entrar")!=null&&!document.getElementById("Entrar").disabled)
	{document.getElementById("Entrar").focus()}
	};

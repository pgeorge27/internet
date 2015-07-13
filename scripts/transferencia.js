function escribir(A){
	if(A.charCodeAt(0)!=160){
      if(document.getElementById("Foco")){
    	  if(document.getElementById(document.getElementById("Foco").value).value.length<4){
    			 document.getElementById(document.getElementById("Foco").value).value=document.getElementById(document.getElementById("Foco").value).value+A;
    			 window.status="";
    			 focusContinueControl();
    			return true
    			}
    	  
      }else if(document.getElementById("clave")){
    	  if(document.getElementById("clave").value.length<4){
		 document.getElementById("clave").value=document.getElementById("clave").value+A;
		 window.status="";
		 focusContinueControl();
		return true
		}}
      else if(document.getElementById("clavetoken")){
    	  if(document.getElementById("clavetoken").value.length<8){
		 document.getElementById("clavetoken").value=document.getElementById("clavetoken").value+A;
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
	if(document.getElementById("Foco") )
	{
		document.getElementById(document.getElementById("Foco").value).value=""
	}
	else if (document.getElementById("clave"))
	{
		document.getElementById("clave").value="" 
	}
	else if (document.getElementById("claveToken"))
	{
		document.getElementById("claveToken").value=""
	}
	else 
	{
		document.getElementById(Foco).value=""
	}
}

function focusContinueControl(){
	if(document.getElementById("Entrar")!=null&&!document.getElementById("Entrar").disabled)
	{document.getElementById("Entrar").focus()}
	};

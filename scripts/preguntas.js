function send(){
    if(validateQuestion() && validatePreg(document.forma.respuesta1)
    		&& validatePreg(document.forma.respuesta2) && validatePreg(document.forma.respuesta3) && validatePreg(document.forma.pregunta3))
    {
  		document.forma.submit();
    }  
}

function validateQuestion(){
	if (document.forma.pregunta1.value == "-1")
	{
		alert("Debe seleccionar la pregunta 1");
		return false;
	}
  	if (document.forma.respuesta1.value == "")
  	{
     	 alert("El campo de respuesta 1 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirma1.value == "")
  	{
     	 alert("El campo de Confirmacion a la pregunta 1 no puede estar vacio");
     	 return false;
  	}  	
  	if (document.forma.respuesta1.value != document.forma.confirma1.value)
  	{
		 alert("La respuesta a la pregunta 1 no coincide con la confirmacion");
		 return false;
	}
	if (document.forma.pregunta2.value == "-1")
	{
		alert("Debe seleccionar la pregunta 1");
		return false;
	}
  	if (document.forma.respuesta2.value == "")
  	{
     	 alert("El campo de respuesta 2 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirma2.value == "")
  	{
     	 alert("El campo de Confirmacion a la pregunta 2 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.respuesta2.value != document.forma.confirma2.value)
  	{
		 alert("La respuesta a la pregunta 2 no coincide con la confirmacion");
		 return false;
  	}
  	if (document.forma.pregunta3.value == "")
  	{
     	 alert("El campo de pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirmapreg3.value == "")
  	{
     	 alert("El campo de Confirmacion a la pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirmapreg3.value != document.forma.pregunta3.value)
  	{
     	 alert("La pregunta 3 y su confirmacion no contienen los mismos valores, verifique.");
     	 return false;
  	}
  	if (document.forma.respuesta3.value == "")
  	{
     	 alert("El campo de respuesta 3 no puede estar vacio");
     	 return false;
  	}
  	
  	if (document.forma.confirma3.value == "")
  	{
     	 alert("El campo de Confirmacion a la pregunta 3 no puede estar vacio");
     	 return false;
  	}

  	if (document.forma.respuesta3.value != document.forma.confirma3.value)
  	{
		 alert("La respuesta a la pregunta 3 no coincide con la confirmacion");
		 return false;
  	}
  	return true;    				 
}

function validatePreg(campo) {
    var RegExPattern = /([a-zA-Z0-9]{4,10})$/;
    var resp = false;
    var errorMessage = 'Los campos solo pueden contener caracteres alfanumericos y deben poseer mas de 4 caracteres.';
    if ((campo.value.match(RegExPattern)) && (campo.value!='')) {
        resp = true;
    } else {
        alert(errorMessage);
        resp = false;
    }
    return resp;
}
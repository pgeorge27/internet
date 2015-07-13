function ocultar(elemento,id) {
    if(id)
    {
    var n= id.length;
      for (i=0;i<n;i++)
      {
        id[i].disabled=true;
      }
    }  
    elemento.style.display ="none"; 
 }



/* Funcion para mostrar elementos DIV */
function mostrar(elemento,id) {
   if(id)
    {
      var n= id.length;
          for (i=0;i<n;i++)
      {
        id[i].disabled=false;
      }
    }
    elemento.style.display = "";    
}  
function mostrarNotaDebito(pIndice, pTitulo, pTipoConcepto, pFecha, pConcepto,pImporte, pCuenta,pNombre,pDireccion, pPais, pUsuario, pMoneda){
  ocultar(estcta);
  mostrar(notas);
  tituloNota.innerText=pTitulo;
  nombreCuenta.innerText=pNombre;
  numeroCuenta.innerText=pCuenta ;
  fecha.innerHTML=pFecha ;
  moneda.innerHTML=pMoneda;
  importe.innerText=pImporte;
  concepto.innerText=pConcepto;
  if (pUsuario == ""){
	  ocultar(nombreUsuario);
      ocultar(lblAtt);
  }else{
    mostrar(nombreUsuario);
    mostrar(lblAtt);
  	nombreUsuario.innerText=pUsuario ;  
  }
  if (document.forms["pdoc"]){
  	document.forms["pdoc"].lblsubtitulo.value=pTitulo;
  	document.forms["pdoc"].nombreCuenta.value=pNombre;
  	document.forms["pdoc"].numeroCuenta.value=pCuenta;
  	document.forms["pdoc"].fecha.value=pFecha;
  	document.forms["pdoc"].moneda.value=pMoneda;
  	document.forms["pdoc"].importe.value=pImporte;
  	document.forms["pdoc"].concepto.value=pConcepto;
  	document.forms["pdoc"].nombreUsuario.value=pUsuario;
  }
  
}

function mostrarNotaCredito(pIndice,pTitulo, pTipoConcepto, pFecha, pConcepto,pImporte, pCuenta,pNombre,pDireccion, pPais, pUsuario, pMoneda){
  ocultar(estcta);
  mostrar(notas);
  tituloNota.innerText=pTitulo;
  nombreCuenta.innerText=pNombre;
  numeroCuenta.innerText=pCuenta ;
  fecha.innerHTML=pFecha ;
  moneda.innerHTML=pMoneda;
  importe.innerText=pImporte;
  concepto.innerText=pConcepto;
  if (pUsuario == ""){
	  ocultar(nombreUsuario);
      ocultar(lblAtt);
  }else{
    mostrar(nombreUsuario);
    mostrar(lblAtt);
  	nombreUsuario.innerText=pUsuario ;  
  }
  if (document.forms["pdoc"]){
  	document.forms["pdoc"].lblsubtitulo.value=pTitulo;
  	document.forms["pdoc"].nombreCuenta.value=pNombre;
  	document.forms["pdoc"].numeroCuenta.value=pCuenta;
  	document.forms["pdoc"].fecha.value=pFecha;
  	document.forms["pdoc"].moneda.value=pMoneda;
  	document.forms["pdoc"].importe.value=pImporte;
  	document.forms["pdoc"].concepto.value=pConcepto;
  	document.forms["pdoc"].nombreUsuario.value=pUsuario;
  }
}

function ocultarNotas() {
  ocultar(notas);
  mostrar(estcta);
}

function desplegarConcepto(concepto){
  mensajebox.innerText=concepto;
  mensajebox.style.posTop=document.body.scrollTop+150;
  mensaje.showElement();
}

function clearMensaje(){
   var visibilidad='';
     if (NS4){
       visibilidad = 'hide';
       eval('document.' + 'mensaje'+ 'box.visibility = "' + visibilidad + '"');
     }
     else{ 
       visibilidad = 'hidden';
       eval('mensaje' + 'box.style.visibility = "' + visibilidad + '"');
     }  
   MenuActivado=null;
 }


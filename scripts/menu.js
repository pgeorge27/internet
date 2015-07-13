
var baseTime = 15000;
var time;
var timeWait = 10000;
var control = false;
var urlBase = "/";

function getControlTime(){
 if (time == null){
   time = 60 * 1000; // 60 segundos
 }
 return time;
}

var timeoutID; 
var waitID;  

function iniciarConteo()
  { 
   clearTimeout(timeoutID);      
   timeoutID = setTimeout('tiempoCumplido()',getControlTime());
  }

function setTimer(){
    var docu = top.document;
    var ventanas = docu.frames;
    if(ventanas.length >0){
        for (var i=0; i < ventanas.length;i++){
           ventanaActual = ventanas[i];
           ventanaActual.onscroll= iniciarConteo;
           ventanaActual.document.onkeypress=iniciarConteo;
           ventanaActual.document.onmousemove=iniciarConteo;
           ventanaActual.document.onclick=iniciarConteo;
      }
     }else{
           docu.onscroll= iniciarConteo;
           docu.document.onkeypress=iniciarConteo;
           docu.document.onmousemove=iniciarConteo;
           docu.document.onclick=iniciarConteo;
     }    
}

function tiempoCumplido(){
  if(document.URL.search("index")==-1)
    top.location.replace(urlBase);
}

// Inicia el conteo
setTimer();


var imagenA = new Array();
function registro()
  {
    var imgID;
    var flag;
  }
function initMenu(TD_IDS)
{
   for (var i=0;i<TD_IDS.length;i++)
    { 
      imagenA[i]= new registro;
      imagenA[i].imgID=TD_IDS[i];
      imagenA[i].flag='0'
    }
	
}


function menuOnclick(indice)
  {
   for(var i=0;i<imagenA.length;i++)
    { 
      if (imagenA[i].flag=='1')
        {
          document.all[imagenA[i].imgID].className=imagenA[i].imgID;
          imagenA[indice].flag='0';
        }
    }
   document.all[imagenA[indice].imgID].className=imagenA[indice].imgID+'on';
   imagenA[indice].flag='1';
  }

function menuOnover(indice)
  {
     document.all[imagenA[indice].imgID].className=imagenA[indice].imgID+'on';
  }

function menuOnout(indice)
  {
      document.all[imagenA[indice].imgID].className=imagenA[indice].imgID;
  }


/*Esta función crea el objeto popout como tal.*/
function popout(id, posY, width, posX) 
 {
  this.id = id;                     // Nombre del elemento y la variable
  this.posY = posY;                 // posición en Y
  this.posX = posX;                 // posición en x
  this.width = width;               // ancho del elemento
  this.show = false;                // mostrar o no el elemento
  this.makeElement = makeElement;   // constructor de la caja de contenido
  this.showElement = showElement;   // visibilidad del elemento
  this.hideElement = hideElement;   // oculta el elemento
 }

/*Esta función crea la caja de opciones y la coloca en la posición adecuada*/

function makeElement(boxBg, boxColor, boxCode) 
{
  var padding = (NS4) ? '' : 'padding: 3 0 3 3;';
    document.write(
    '<STYLE TYPE="text/css">',
    '#', this.id, 'box {',
      'position: absolute;',
      'font-size:x-small;',
      'left: ', this.posX,'; top: ', this.posY, ';',
      'width: ', this.width, ';',
      'layer-background-color: ', boxBg, ';',
      'background-color: ', '#FFFFFF' , ';',
      'visibility: hidden;',
      'border-width: 2;',
      'border-style: solid;',
      'border-color: ', boxColor, ';',
       padding,
      'z-index: 6',
     '}',
      '#', this.id, 'box ', 'A:hover {text-decoration: underline;color : black;font-style : oblique  !important;}',
      '#', this.id, 'box ', 'A:visited {text-decoration: none;color : black  !important;}',
      '#', this.id, 'box ', 'A:active {text-decoration: none;color : black  !important;}',
      '#', this.id, 'box ', 'A {text-decoration: none;color : black  !important;}',
      '#', this.id, 'box ', 'A:link   {text-decoration: none;color : black !important;}',
    '</STYLE>',
    '<DIV ID="', this.id, 'box">',
    boxCode,
    '</DIV>'
  );
}

/*Esta función se encarga de manejar el despliegue del elemento*/
function showElement() 
 {
//  clearMenu();  
  if ((MenuActivado != null) && (MenuActivado!= this) ){
    if (NS4){
       visibilidad = 'hide';
       eval('document.' + MenuActivado.id + 'box.visibility = "' + visibilidad + '"');
     }
     else{ 
       visibilidad = 'hidden';
       eval(MenuActivado.id + 'box.style.visibility = "' + visibilidad + '"');
     }
     //MenuActivado.hideElement();
     MenuActivado.show=false;
     MenuActivado=null; 
   }


  this.show = !this.show;
  var pos = (this.show) ? this.width : 0;
  if (NS4) 
   {
    var str = (this.show) ? 'show' : 'hide';
    eval('document.' + this.id + 'box.zIndex = ' + maxZ);
    eval('document.' + this.id + 'box.visibility = "' + str + '"');
   } 
  else 
   {
    var str = (this.show) ? 'visible' : 'hidden';
    if (str=='visible') hideListBoxes();
    eval(this.id + 'box.style.zIndex = ' + maxZ);
    eval(this.id + 'box.style.visibility = "' + str + '"');
   }
   MenuActivado = this;
   event.cancelBubble = true;
}

/*  Esta funcion se encarga de ocultar el elemento*/

function hideElement() 
 {
  var pos =  0;
  if (NS4) 
   {
    eval('document.' + this.id + 'box.zIndex = ' + maxZ);
    eval('document.' + this.id + 'box.visibility = "' + 'hide' + '"');
   } 
  else 
   {
    eval(this.id + 'box.style.zIndex = ' + maxZ);
    eval(this.id + 'box.style.visibility = "' + 'visible' + '"');
   }
   this.show = false;
//   MenuActivado = null;
   event.cancelBubble = true;
}


/*Verifica que se pueda aplicar estilos en la página*/
function styleEnabled() 
{
  return ((NS4 && document.test) || IE4);
}

function hideListBoxes(){
  for (i=0; i<document.all.length;i++)
    if (document.all.item(i).type=="select-one")
      ocultar(document.all(i));    
    // Esto es porque el browser sobrepone los campos tipo lista sobre el menu
}

function showListBoxes(){
  for (i=0; i<document.all.length;i++)
    if (document.all(i).type=="select-one")
      mostrar(document.all(i));    
}

/* Funcion para ocultar elementos DIV */
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
function setAmbiente(){
   NS4 = (document.layers) ? true : false;
   IE4 = (document.all) ? true : false;
   maxZ = 2;
}

/*Variables de ambiente sobre el tipo de navegador y maxZ sobre la posición del objeto 
    en el eje virtual z*/

/*Variables para el menu en el area de Internet Banking*/

var NS4 = '';
var IE4 = '';
var maxZ = 1;
var MenuActivado = null ;
 
var  despliegue = '' ;
//var  pagos   = new popout('pagos', 100, 240, 190);
var  consultas   = new popout('consultas', 150, 220, 270);
//var  solicitudes = new popout('solicitudes', 79, 200, 50);
//var  clientes    = new popout('clientes',79,200 ,300);


  
function makePopupSolicitud(){  

}

function makePopupPago(){
}

function makePopupCliente(){
}


   function cantidadElementos(Pv_Trama)
    {
     var Ln_Indice;
     var Ln_Cantidad=0;
     for(Ln_Indice=0; Ln_Indice<=Pv_Trama.length;Ln_Indice++)
        if(Pv_Trama.substr(Ln_Indice,1)=='~')
          Ln_Cantidad++;
        return Ln_Cantidad;
    }

 function desarmarTrama(Pv_Trama)
  {  
   var Ln_Posicion;
   var Ln_Longitud;
   var Ln_Indice;
   var Ln_Cantidad;
   var Lv_TempTrama;
   var Lt_ResultadoTrama= new Array(Pv_Trama.length); 
   Lv_TempTrama = Pv_Trama;
   Ln_Longitud = Pv_Trama.length;
   Ln_Cantidad = cantidadElementos(Pv_Trama);
   for(Ln_Indice=0;Ln_Indice<Ln_Cantidad;Ln_Indice++)
    {
     Ln_Posicion = Pv_Trama.indexOf('~');
     Lt_ResultadoTrama[Ln_Indice] = Pv_Trama.substr(0,Ln_Posicion);
     Pv_Trama = Pv_Trama.substr(Ln_Posicion+1,Ln_Longitud-Ln_Posicion);
    }
   return Lt_ResultadoTrama;
 }

 function clearMenu(){
   var visibilidad='';
   if (MenuActivado != null){
    if (NS4){
       visibilidad = 'hide';
       eval('document.' + MenuActivado.id + 'box.visibility = "' + visibilidad + '"');
     }
     else{ 
       visibilidad = 'hidden';
       eval(MenuActivado.id + 'box.style.visibility = "' + visibilidad + '"');
     }
     //MenuActivado.hideElement();
     MenuActivado.show=false;
   }
   MenuActivado=null;
   showListBoxes();     
 }


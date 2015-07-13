var baseTime = 15000;
var time;
var timeWait = 10000;
var control = false;

function getControlTime(){
 if (time!=null){
   return time;
 }
 else{
 if(top.contenido.doc.document.URL.search("BE_P_Gen_Doc")==-1){
    if(top.titular.control.getTimeOut() != null){
      time = top.titular.control.getTimeOut() * 1000;
      return time;
      }
    else 
      return baseTime;
    }else{
      return baseTime;
     }
 }
}

var timeoutID; 
var waitID;  

function iniciarConteo()
  { 
   clearTimeout(timeoutID);      
   timeoutID = setTimeout('tiempoCumplido()',getControlTime());
  }

function setTimer(){
	var docu = top.contenido;
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
  if(top.contenido.doc.document.URL.search("BE_P_Gen_Doc")==-1)
    top.location.replace("/");
}


/*Dentro de este archivo se encuentran todos las funciones de JavaScript necesarias
  para poder dibujar el menu de la manera adecuada.
  Creada por : Alexis Bonilla 
  Fecha      : 12/11/1998
  Modificado : 11:32 AM 12/17/1998
               08/MAR/1999 Rubén Cogley
*/


/* modificacion hecha por francisco castañeda 06-04-1999*/


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
   /*if(imagenA[indice].flag=='1')
    {
     return;
    }
   else
    {*/
   document.all[imagenA[indice].imgID].className=imagenA[indice].imgID+'h';
    //}
  }

function menuOnout(indice)
  {
   /*if(imagenA[indice].flag=='1')
    {
     return;
    }
   else
    {*/
      document.all[imagenA[indice].imgID].className=imagenA[indice].imgID;
   // }
  }


/*Final de la modificacion hecha por francisco castañeda 06-04-1999*/

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
    top.contenido.doc.document.write(
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
  return ((NS4 && top.contenido.doc.document.test) || IE4);
}

function hideListBoxes(){
  for (i=0; i<document.all.length;i++)
    if (document.all.item(i).type=="select-one")
      top.biblioteca.ocultar(document.all(i));
    
    // Esto es porque el browser sobrepone los campos tipo lista sobre el menu
}

function showListBoxes(){
  for (i=0; i<document.all.length;i++)
    if (document.all(i).type=="select-one")
      top.biblioteca.mostrar(document.all(i));
    
}

function setAmbiente(){
   NS4 = (top.contenido.doc.document.layers) ? true : false;
   IE4 = (top.contenido.doc.document.all) ? true : false;
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
var  pagos   = new popout('pagos', 100, 240, 190);
var  consultas   = new popout('consultas', 150, 220, 270);
var  solicitudes = new popout('solicitudes', 79, 200, 50);
var  clientes    = new popout('clientes',79,200 ,300);

function makePopupConsulta(){
 /* despliegue='<A HREF=""></A>';*/
  despliegue='<U><B><FONT  color = "black" face = "Arial">Cuentas:</FONT></B></U><BR> ';
  despliegue+='&nbsp; &nbsp;  <A HREF="/Formas/Consultas/Resumen.html" TARGET="_self">Consulta      Saldos</a><BR>';
  despliegue+='&nbsp; &nbsp;  <A HREF="/Formas/Consultas/Movimientos.html" TARGET="_self">Consulta Movimiento</a><BR>';
  despliegue+='&nbsp; &nbsp; <A HREF="/Formas/Consultas/EstadoDeCuenta.html" TARGET="_self">Estado de Cuenta mes anterior</a><BR>';
  despliegue+='<BR><B><U><FONT  color = "black" face = "Arial">Inversiones:</FONT></B></U><BR> ';
  despliegue+='&nbsp; &nbsp;<A HREF="/Formas/Consultas/CondicionesDP.html" TARGET="_self"> Depósitos a Plazo</a><BR>';
  despliegue+='<BR><B><A class="menu2" HREF="/Formas/Consultas/ConsultaPrestamo.html" TARGET="_self"> Pr&eacute;stamos</a></B><BR>';
  despliegue+='<A HREF=""></A>';
 
  consultas.makeElement('#FFFFFF', '#800000',despliegue);
 }
  
function makePopupSolicitud(){  
  despliegue='<A HREF=""></A>';
  despliegue+='<A HREF="/Formas/Solicitudes/Sol_AperCta_E.html" TARGET="_self">Apertura de Cuentas</a><BR>';
  despliegue+='<A HREF="/ib-undercon.html" TARGET="_self">Chequeras</a><BR>';
  despliegue+='<A HREF="/ib-undercon.html" TARGET="_self">Prestamos</a><BR>';
  despliegue+='<A HREF="/ib-undercon.html" TARGET="_self"></A>';
  solicitudes.makeElement('#FFFFFF', '#800000',despliegue);
}

function makePopupPago(){
  despliegue='<U><B><FONT  color = "black" face = "Arial">Pagos:</FONT></B></U><BR> ';
  despliegue+='&nbsp; &nbsp;  <A HREF="/Formas/Pagos/PagoPrestamo.html" TARGET="doc">Pago de Préstamo</a><BR>';
  despliegue+='&nbsp; &nbsp;  <A HREF="/Formas/Pagos/PagoTC.html" TARGET="doc">Pago de Tarjeta de Crédito</a><BR>';
  despliegue+='<A HREF=""></A>';
  pagos.makeElement('#FFFFFF', '#800000',despliegue);
 }



function makePopupCliente(){
 
  var Ln_Indice;
  var Pv_Trama=top.titular.control.getListTitular();
  var donde="";
  var Lp_Cantidad = cantidadElementos(Pv_Trama);
  var tem=desarmarTrama(Pv_Trama);
  despliegue='<A HREF=""></A>';
  if (Lp_Cantidad>0)
   {
    for (var i=0; i<Lp_Cantidad; i++)
      despliegue+='<A HREF="javascript:top.listas.setCodigoClienteBanco('+ tem[i] + ');top.contenido.doc.location.replace(\'/ib-cont.html\');"><small><small>'+top.titular.control.getNombreCorto(tem[i])+'</a></small></small><BR>';       
   }
  despliegue+='<A HREF=""></A>';
  clientes.makeElement('#0000FF', '#800000',despliegue);
  if(top.listas.getCodigoClienteBanco()=='')
    {
      top.listas.setCodigoClienteBanco(tem[0]);
    }
  //clientes.showElement();
}

/*Dibuja Menu de cualquiera de las areas*/

function dibujaMenu()
  {
   initMenu(['solicitudes','pagos','transferencias','consultas','clientes']);
 
   setAmbiente();
   makePopupPago();
   makePopupConsulta();
   makePopupSolicitud();
   makePopupCliente();
   top.contenido.doc.document.writeln('<table border="0" width="100%"><TR><TD width="10%">&nbsp;</td><TD width="90%" align="left">');
   top.contenido.doc.document.writeln('<img src="/Images/logo.jpg" >');
   top.contenido.doc.document.writeln('</TD></TR></Table>');
   top.contenido.doc.document.writeln('<TABLE CLASS="menuPrincipal" >');
   top.contenido.doc.document.writeln(' <TR><TD>');
   top.contenido.doc.document.writeln('  <TABLE>');
   top.contenido.doc.document.writeln('   <TR>');
 
 
/*   top.contenido.doc.document.writeln('    <TD ID="clientes" CLASS="clientes" ONMOUSEOVER="menuOnover(4)" ONMOUSEOUT="menuOnout(4);" onclick="ejecutarOpcion(10);" ALIGN="CENTER"> </TD>');
*/
  //top.contenido.doc.document.writeln('    <TD ID="solicitudes" CLASS="solicitudes" ONMOUSEOVER="menuOnover(0)" ONMOUSEOUT="menuOnout(0)" onclick="menuOnclick(0);ejecutarOpcion(6);" ALIGN="CENTER"> &nbsp</TD>');
  //top.contenido.doc.document.writeln('    <TD ID="pagos" CLASS="pagos" ONMOUSEOVER="menuOnover(1)" ONMOUSEOUT="menuOnout(1);" onclick="menuOnclick(1);ejecutarOpcion(7);" ALIGN="CENTER">&nbsp</TD>');
    top.contenido.doc.document.writeln('    <TD ID="pagos" CLASS="pagos" ALIGN="CENTER">&nbsp</TD>');

     
   top.contenido.doc.document.writeln('    <TD ID="consultas" CLASS="consultas" TITLE="Consultas de saldos, estados de cuenta y movimientos" ONMOUSEOVER="menuOnover(3)" ONMOUSEOUT="menuOnout(3);" onclick="menuOnclick(3);ejecutarOpcion(9);" ALIGN="CENTER"></TD>');
   top.contenido.doc.document.writeln('    <TD>&nbsp;&nbsp;&nbsp;&nbsp;</TD>');
   top.contenido.doc.document.writeln('    <TD CLASS="util-info" ONMOUSEOVER="this.className=\'util-info-on\'"  TITLE="Cambio de clave" ONMOUSEOUT="this.className=\'util-info\'" onclick="ejecutarOpcion(5);" ALIGN="CENTER"> </TD>');
   top.contenido.doc.document.writeln('    <TD>&nbsp;&nbsp;&nbsp;&nbsp;</TD>');
   top.contenido.doc.document.writeln('    <TD CLASS="util-calculo" TITLE="Proyecciones" ONMOUSEOVER="this.className=\'util-calculoon\'" ONMOUSEOUT="this.className=\'util-calculo\'" onclick="ejecutarOpcion(3);"> </TD>');
   top.contenido.doc.document.writeln('    <TD ID="transferencias" CLASS="transferencias" ONMOUSEOVER="menuOnover(2)" ONMOUSEOUT="menuOnout(2);" onclick="menuOnclick(2);ejecutarOpcion(8);" ALIGN="CENTER">&nbsp;</TD>');
   top.contenido.doc.document.writeln('    <TD>&nbsp;&nbsp;&nbsp;&nbsp;</TD>')
   top.contenido.doc.document.writeln('    <TD CLASS="util-salir" TITLE="Salir" ONMOUSEOVER="this.className=\'util-salir-on\'" ONMOUSEOUT="this.className=\'util-salir\'" onclick="ejecutarOpcion(11);"><img src="/Images/salir.jpg" ></TD>');


   top.contenido.doc.document.writeln('   </TR>');
   top.contenido.doc.document.writeln('   <TR>');
   top.contenido.doc.document.writeln('    <TD Colspan="8" > <img src="/Images/barra.jpg" ></TD>');
   top.contenido.doc.document.writeln('   </TR>');
   top.contenido.doc.document.writeln('  </TABLE>');
   top.contenido.doc.document.writeln(' </TD></TR>');
   top.contenido.doc.document.writeln('</TABLE>');
   //window.onclick= clearMenu;
  }

/*Esta funcion ejecuta la opion escogida dentro del area de IB*/
function ejecutarOpcion(opcion)
 {
  switch (opcion)
   {
    case 1  : top.contenido.doc.location="/Utilidades/buscar2.html";break;
    case 2  : top.contenido.doc.location="/ib-undercon.html";break;
    case 3  : top.contenido.doc.location="/Utilidades/calculo.html";break;
    case 4  : top.contenido.doc.location="/ib-undercon.html";break;
    case 5  : top.contenido.doc.location="/Utilidades/cambioClave.html";break;
    case 6  : solicitudes.showElement();break;
    case 7  : pagos.showElement();
	      break;
             //top.contenido.doc.location="/ib-undercon.html";break;
    case 8  : top.contenido.doc.location="/Formas/Transferencias/transferencias.html";break;
    case 9  : consultas.showElement();break;
    case 10 : clientes.showElement();break;
    case 11 : top.biblioteca.location.replace('/ib-biblio.html');
	      //top.location.replace('/index.html');
	     top.location.replace('/');

              //top.location.replace('http://panama.bancodecredito.com.co');
              //top.titular.location='/gen-titul.html';
              //top.contenido.location ='/gen-cont.html';
              break;
    default : break;
   }
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

setTimer();
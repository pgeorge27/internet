<!-- 

/*Funcion de validacion de datos introducidos en un campo de forma de html
  el llamado debe acerce cuando se ejecute cualquier proceso onblur sobre 
  dicho campo*/


var b=0;
var c=0;
var y=0;
var valinicial=0.9;
var x=valinicial;
var difAnt=1;
var difAct=0;
var flag=0;
var pago1=0;
var pago2=0;
var pago3=0;
var pago4=0;
var pago5=0;
var err=0.0000000000000001;
var n=100000;
var mensualidadPasar=0;

function inicializar()
  {
    valinicial=0.9;
    Xd=valinicial;
    Xi=0;
    Xm=(Xi+(Xd-Xi)/2);
    difAct=0;
    flag=0;
    err=0.0000000000000001;
    n=100000;
  }
  

function rewriteFrame(label) {

var inte=round2(document.forma.tasa.value/1200,10);
var intA=0;
var montoA=0;
var montoAC=document.forma.monto.value;
var amort=0;
var mensu=document.forma.mensualidad.value;
var Npagos=document.forma.pagos.value;
var totalpago=0;
var totalint=0;
var totalamort=0;

var HTML='';
if (!label || label == "")
  label = "Totales";

 HTML+='<table width="80%" border="0" cellpadding="0" cellspacing="2" id="proyeccion" >';

 var styleClass = "";
for(i=0;i<=Npagos;i++)
  {
    styleClass = (i%2) == 0 ? "class=\"celda-clave1\"": "";
    if (i==0)
      {
	if (Npagos>0)
          {
		  
            HTML+='<TR ALIGN=RIGHT ' + styleClass + '><TD ALIGN=CENTER CLASS="bienvenida" width="20%">'+i+'</TD><TD CLASS="bienvenida" width="20%"></TD><TD CLASS="bienvenida"></TD><TD CLASS="bienvenida" width="20%"></TD><TD CLASS="bienvenida" width="20%">'+mascara(montoAC)+'</TD></TR>';
          }
      }
    else{
          intAC=montoAC*inte;
          intA=mascara(round2(intAC,2));

          if ((i==Math.floor(Npagos))&&(Math.abs(document.forma.pagos.value-Math.floor(document.forma.pagos.value))>0.0))
            {
              mensu=montoAC +intAC;
            }

          mensuD=mascara(round2(mensu,2))
          amortC=mensu-intAC;
          amort=mascara(round2(amortC,2));
          montoAC=montoAC-amortC;
          montoA=mascara(round2(montoAC,2));

          HTML+='<TR ALIGN=RIGHT ' + styleClass + '><TD ALIGN=CENTER CLASS="bienvenida">'+i+'</TD><TD CLASS="bienvenida">'+mensuD+'</TD><TD CLASS="bienvenida">'+amort+'</TD><TD CLASS="bienvenida">'+intA+'</TD><TD CLASS="bienvenida">'+montoA+'</TD></TR>';

          totalpago+=mensu*1;
          totalint+=intAC *1;
          totalamort+=amortC *1;
        }

  }
  HTML+='<TR  class="tabla-acceso" ALIGN=RIGHT><TD ALIGN=CENTER class="texto-acceso">'+label+'</TD><TD class="texto-acceso">'+mascara(round2(totalpago,2))+'</TD><TD class="texto-acceso">'+mascara(round2(totalamort,2))+'</TD><TD class="texto-acceso">'+mascara(round2(totalint,2))+'</TD><TD class="texto-acceso"></TD></TR>';       
  HTML+='</TABLE></BODY>';

  return HTML; 
}

function limpiar()
  {
    document.all.proyeccion.outerHTML='<TABLE border="1" ID="proyeccion"><TR><TD></TD></TR></TABLE>';
  }



function mascara(s)
  { 
    var i=0;
    var string1='';
    string=s.toString();
    string1='';
    if (string.indexOf('.')=='-1')
      {
        string=string+'.00';
      }
    else
      {
        if ((string.length-string.indexOf('.'))==2)
          {
            string=string+'0';
          }
      }


    if (string.length>6)
      { 
        finale=string.length;
        inicio=string.indexOf('.');
        for(i=inicio-3;i>0;i-=3)
          {
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


function round2(numero,dec)
  {
    divisor=Math.pow(10,dec);
    numero*= divisor;
    numero=Math.round(numero);
    numero/=divisor;
    return numero;
  }

  function alerta4valores(mensaje)
    {
      if (!mensaje || mensaje == "")
        mensaje = "Para calcular valores debe existir un campo en blanco";
      window.alert(mensaje);
    }

  function finteres()
    {
      return document.forma.tasa.value/1200;
    }

        
  

  function verificarCampo(mensaje, label)
    {
      b =0;
      c =0;
      y =0;
     
      for(i=0;i<=3;i++)
        {
          if (document.forma.elements[i].value=="") 
            {
              b=i; 
              c++; 
            }
        }
    
      if (c==1)
        {
          calcular(b);
		  document.all["proyeccion"].outerHTML=rewriteFrame(label);
        }
	  else
        {
          alerta4valores(mensaje);
        }
    
      
    }
  

  function calcular(n)
    {
      switch(n)
        {
          case  0: calcularMonto();
                   break;
          case  1: calcularTasa();
                   break;
          case  2: calcularPagos();
                   break;
          case  3: document.forma.mensualidad.value=calcularMensualidad(4);
                   document.forma1.menD.value=calcularMensualidad(4);
                   break;
        }
    }


 
   

  function calcularMonto()
    {
        monto1=0;
        monto1=(finteres())*1;
        monto1+=1;       
        document.forma.monto.value= round2(document.forma.mensualidad.value * ((Math.pow(monto1, document.forma.pagos.value)-1)/(finteres() * Math.pow(monto1, document.forma.pagos.value))),4);
     

    }

  function calcularPagos()
    {
     with(Math)
        {
          pago1 =(log(document.forma.mensualidad.value )/LN10);
          pago2 =pago1 -(log(document.forma.mensualidad.value - document.forma.monto.value * finteres())/LN10);
	  pago3=(finteres())*1;
          pago4=pago3+1.0;
          pago5 =(log(pago4)/LN10);
          document.forma.pagos.value= round2(pago2/pago5,2);          
          

        }

    }
 

  function calcularMensualidad(decimales)
    {
          mensualidad1 = 0;
          mensualidad1 = finteres() * 1;
          mensualidad1+=1;
          mensualidad2=Math.pow(mensualidad1,document.forma.pagos.value);
          mensualidad3=mensualidad2-1;
          mensualidad= round2((document.forma.monto.value*(finteres() *mensualidad2 ))/mensualidad3,decimales);
          return mensualidad
    }





function calcularY(valor)
  {
       
        y=Math.pow(10,((Math.log(document.forma.mensualidad.value)/Math.LN10)-(Math.log(document.forma.mensualidad.value - document.forma.monto.value * valor)/Math.LN10))/document.forma.pagos.value)-1;
       
  }

function calcularTasa() 
  {
       inicializar();

        for(ni=0;flag!=1;ni++)
          {
            calcularY(Xm);
            difAct=y-Xm;
            
            if(Math.abs(difAct)<=err)
              {
                flag=1;
                interes=Xm;
              }

            if(ni>=n)
              {
                flag=1;
                interes=Xm;
              }

            if(flag!=1)
              {
                if (difAct<0)
                  {
                    Xi=Xm;
                    Xm=(Xi+(Xd-Xi)/2);
                  }
                else
                  {
                    Xd=Xm;
                    Xm=(Xi+(Xd-Xi)/2);
                  }
              }
              
          }

       document.forma.tasa.value=round2(interes*1200,10);

   
 }




/****      SECCIÓN DE VALIDACIÓN     ****/

function validarEntrada(elemento, mascara, nombre)
 {
  var textoValido=true;
  var enteroValido=true;
  var flotanteValido=true;
  var interesValido=true;

 
      if (mascara=='d')
        enteroValido=validarNum(elemento.value);
      else
        if (mascara=='f')
          flotanteValido=validarFlot(elemento.value);
        else
        if (mascara=='i')
          interesValido=validarInt(elemento.value);

   
   if (!flotanteValido||!enteroValido||!interesValido)
    {
     alert(nombre);
     
    }
 }


function validarNum(s)
 {
  if(s=='')
    return true;
  for(var i=0;i<s.length; i++)
  {
   var digito=s.substring(i,i+1);
   if (digito<"0"||digito>"9")
     return false;
  }
  return true;
 }

function validarFlot(s)
 {
  var punto=true;
  if(s=='')
   return true;
  for(var i=0;i<s.length; i++)
  {
   var digito=s.substring(i,i+1);
   if (digito<"0"||digito>"9")
    {
     if (digito==".")
      {
       if (punto)
        punto=false;
       else
        return false;
      }
     else
      return false;
    }
  }
  return true;

 }







//  -->

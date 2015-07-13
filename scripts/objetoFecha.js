var CONST_YEAR = "";
var CONST_MONTH = "";
var CONST_DAY  = "";
function fechaObject(objectName,fecha, pYear, pMonth, pDay)
  {
    if (pYear)
       CONST_YEAR = pYear;
    if (pMonth)
       CONST_MONTH = pMonth;
    if (pDay)
       CONST_DAY = pDay;
          
// Atributos 
    this.objectName=objectName;
    this.dia=" ";
    this.mes=" ";
    this.anio=" ";
    this.fechaString=(fecha)?fecha:"";
    this.constanteLabel="L08";
    this.funcionesUsuario="";
    this.fechaInicial=(fecha)?fecha:"";
    this.HTML="";
    
    

  /*Atributos que contienen las funciones que se van a ejecutar en los diferentes eventos
    el usuario escribe los nombres de funciones separados por punto y coma ";"            */

    this.DDonBlur='onblur=""';
    this.DDonChange='onchange="'+this.objectName+'.setDia(this.value);'+this.objectName+'.fechaValida(this);"';
    this.DDonKeypress='onkeypress=""';
    this.DDonFocus='onfocus=""';

    this.MMonBlur='onblur=""';
    this.MMonChange='onchange=" '+this.objectName+'.setMes(this.value);'+this.objectName+'.fechaValida(this);"';
    this.MMonKeypress='onkeypress=""';
    this.MMonFocus='onfocus=""';

    this.AAonBlur='onblur=""';
    this.AAonChange='onchange="'+this.objectName+'.setAnio(this.value);'+this.objectName+'.fechaValida(this);"';
    this.AAonKeypress='onkeypress=""';
    this.AAonFocus='onfocus=""';

	
	

// Metodos

//     Validaciones:
    this.validaMayor=validaMa;
    this.validaMenor=validaMe;
    this.validaRango=validaR;
    this.fechaValida=validarFecha;
   
/* Eventos */
  /*Eventos del campo Fecha */
    this.DDOnBlur=DDFonB;
    this.DDOnKeypress=DDFonK;
    this.DDOnChange=DDFonCh;
    this.DDOnFocus=DDFonF;

/* Eventos */
  /*Eventos del campo Fecha */
    this.MMOnBlur=MMFonB;
    this.MMOnKeypress=MMFonK;
    this.MMOnChange=MMFonCh;
    this.MMOnFocus=MMFonF;

/* Eventos */
  /*Eventos del campo Fecha */
    this.AAOnBlur=AAFonB;
    this.AAOnKeypress=AAFonK;
    this.AAOnChange=AAFonCh;
    this.AAOnFocus=AAFonF;

 
//     Asignaciones:
    this.setFecha=setF;
    this.setDia=setD;
    this.setMes=setM;
    this.setAnio=setA;
    this.JoinFecha=JoinF;
//     Obtenciones:
    this.getFecha=getF;
    this.getDia=getD;
    this.getMes=getM;
    this.getAnio=getA;
    this.getOraDate=getOraD;
   

//    Utilitarios:

    this.paint=p;
    this.reset=resetear;
    this.toMesNum=toMesN;
    this.Update=UpdF2;
 }
function JoinF()
  { 
    if(document.all[this.objectName])
      {
        document.all[this.objectName+"F"].value=String((this.dia<9)?"0"+String(this.dia):this.dia)+"-"+this.mes+"-"+this.anio;
      }
   
  }

function DDFonF(funciones)
  {
     if(!funciones)funciones='';

     this.DDonFocus=this.DDonFocus.substr(0,this.DDonFocus.length-1)+';'+funciones+'"'; 
  }


function DDFonB(funciones)
  {if(!funciones)funciones='';

    this.DDonBlur=this.DDonBlur.substr(0,this.DDonBlur.length-1)+';'+funciones+'"'; 
  }


function DDFonK(funciones)
  {if(funciones){}else{funciones='';}

    this.DDonKeypress=this.DDonKeypress.substr(0,this.DDonKeypress.length-1)+';'+funciones+'"';
  }


function DDFonCh(funciones)
  {if(funciones){}else{funciones='';}
   this.DDonChange=this.DDonChange.substr(0,this.DDonChange.length-1)+';'+funciones+'"';
  }

function MMFonF(funciones)
  {if(!funciones)funciones='';

    this.MMonFocus=this.MMonFocus.substr(0,this.MMonFocus.length-1)+';'+funciones+'"'; 
  }


function MMFonB(funciones)
  {if(!funciones)funciones='';

    this.MMonBlur=this.MMonBlur.substr(0,this.MMonBlur.length-1)+';'+funciones+'"'; 
  }


function MMFonK(funciones)
  {if(funciones){}else{funciones='';}

    this.MMonKeypress=this.MMonKeypress.substr(0,this.MMonKeypress.length-1)+';'+funciones+'"';
  }


function MMFonCh(funciones)
  {if(funciones){}else{funciones='';}
   this.MMonChange=this.MMonChange.substr(0,this.MMonChange.length-1)+';'+funciones+'"';
  }

function AAFonF(funciones)
  {if(!funciones)funciones='';

    this.AAonFocus=this.AAonFocus.substr(0,this.AAonFocus.length-1)+';'+funciones+'"'; 
  }


function AAFonB(funciones)
  {if(!funciones)funciones='';

    this.AAonBlur=this.AAonBlur.substr(0,this.AAonBlur.length-1)+';'+funciones+'"'; 
  }


function AAFonK(funciones)
  {if(funciones){}else{funciones='';}

    this.AAonKeypress=this.AAonKeypress.substr(0,this.AAonKeypress.length-1)+';'+funciones+'"';
  }


function AAFonCh(funciones)
  {if(funciones){}else{funciones='';}
   this.AAonChange=this.AAonChange.substr(0,this.AAonChange.length-1)+';'+funciones+'"';
  }







/* Funcion que reinicializa la fecha a la fecha que el usuario envión al momento de crear el objeto*/
function resetear()
  {
   this.fechaString=this.fechaInicial;
   this.setFecha();
   document.all[this.objectName].innerHTML=this.HTML;
  }



 /* Funcion para escribir el codigo HTML y manipuladores de eventos, correspondientes a un objeto Fecha*/

function p()
  {  
  	var HTMLfecha="";
  	var HTMLTABLEopen='<TABLE><TR><TD ID="'+this.objectName+'">';
  	var HTMLTABLEclose='</TD></TR></TABLE>';
        var dia="";
        var mes="";
    	var fechaEnteraHTML='<INPUT TYPE="HIDDEN"  ID="'+this.objectName+'F" NAME="'+this.objectName+'F" SIZE="10" ID="'+this.objectName+'" VALUE="0" >';

	HTMLfecha+='<SELECT ID="'+this.objectName+'Dia"'+this.DDonBlur+' '+this.DDonChange+' '+this.DDonKeypress+' '+this.DDonFocus+'>';
	for(i=1;i<32;i++)
    	  {          
            if (i<10)
              dia='0';
            else
              dia='';
            if(i==this.dia)          
              HTMLfecha+='<OPTION VALUE="'+i+'"SELECTED>'+dia+i+'</OPTION>';
            else
              HTMLfecha+='<OPTION VALUE="'+i+'">'+dia+i+'</OPTION>'; 
           }
       HTMLfecha+='</SELECT><small> de'+'\&nbsp';
       
	HTMLfecha+='<SELECT   ID="'+this.objectName+'Mes" '+this.MMonBlur+' '+this.MMonChange+' '+this.MMonKeypress+' '+this.MMonFocus+' >';
       for(i=1;i<13;i++)
         {          
            if (i<10)
              mes='0';
            else
              mes='';
           if(i==Number(this.mes))          
             HTMLfecha+='<OPTION VALUE="'+mes+i+'"SELECTED>'+findLabel(i)+'</OPTION>';
           else
             HTMLfecha+='<OPTION VALUE="'+mes+i+'">'+findLabel(i)+'</OPTION>'; 
         }
       HTMLfecha+='</SELECT> de</small>'+'\&nbsp';
       HTMLfecha+='<SELECT ID="'+this.objectName+'Anio"  '+this.AAonBlur+' '+this.AAonChange+' '+this.AAonKeypress+' '+this.AAonFocus+' >';
       fin=this.anio+1;
       inicio=this.anio-1;
       for(i=inicio;i<fin;i++)
         {      
           if(i==this.anio)
             HTMLfecha+='<OPTION VALUE="'+i+'" SELECTED>'+i+'</OPTION>';     
           else
             HTMLfecha+='<OPTION VALUE="'+i+'">'+i+'</OPTION>'; 
         
          }
       HTMLfecha+='</SELECT>'; 
       this.HTML=HTMLfecha; 
       document.write(HTMLTABLEopen);
       document.write(HTMLfecha);
       document.write(HTMLTABLEclose);
       document.write(fechaEnteraHTML);
      }




function getF()
  {
      return this.fechaString;
  }

function getD()
  {
      return this.dia;
  }
function getM()
  {
      return this.mes;
  }

function getA()
  {
      return this.anio;
  }

function getOraD()
  {
     return this.dia+'-'+this.toMesNum()+'-'+this.anio;
  }

/* Funcion para validar que se haya introducido una fecha válida */


function validarFecha(elemento )
 {
  var diasxmes=[31,28,31,30,31,30,31,31,30,31,30,31,30,31];
 var i;
  for (i=1; i<13; i++)
   {
    if (Number(this.mes)==i)
     {
      
      if (Number(this.dia)>diasxmes[i-1])
        { 
          if (!((this.mes=='02')&& (Number(this.anio)%4==0)&&(Number(this.dia)==29)))
          {
            alert("Fecha Incorrecta");
            if(elemento)
              {
                 this.reset();
              }
          }
        }
     }
   }
  this.Update();
  return true;
 }

/*
  Funcion para asignar la fecha al objeto fecha. Si la fecha no se inicializó con ningun valor, 
  se le asigna la fecha de hoy, de lo contrario se le asignan a los campos dia, mes y anio los valores
  correspondientes
*/

function UpdF2()
  {
    this.fechaString=String(this.anio)+String(this.mes)+String((this.dia<9)?"0"+String(this.dia):String(this.dia));
   
  }
function setF()
  {
   var anos=0;
   var fechaSistema;  

    if (this.fechaString!="")
      {
        this.dia=Number(this.fechaString.substr(0,2));
        this.mes=this.fechaString.substr(2,2); 
        this.anio=Number(this.fechaString.substr(4,4));
      }
      else
      {
        this.fechaString=CONST_YEAR+CONST_MONTH+CONST_DAY;
        this.fechaInicial=this.fechaString;
        this.dia=Number(this.fechaString.substr(6,2));
        this.mes=this.fechaString.substr(4,2); 
        this.anio=Number(this.fechaString.substr(0,4));
      }

  }


/* Funcion para asignar el valor del día individualmente */
function setD(dia)
  {
    this.dia=dia  
  }

/* Funcion para asignar el valor del mes individualmente */

function setM(mes)
  { 
    this.mes=mes  
  }


/* Funcion para asignar el valor del anio individualmente */
function setA(anio)
  {
    this.anio=anio;
  }




/* Funcion que valida si la fecha del objeto fecha se encuentra en el rango entre la fecha1 y la fecha2 */
function validaR(fecha1,fecha2)
 { 
   if(this.validaMayor(fecha1)&&this.validaMenor(fecha2))
   {
      return true;
   }
   return false;
 }


/*  Funcion que valida si la fecha que contiene el objeto fecha es mayor que la fechaMayor */
function validaMa(fechaMayor)
  {
     return this.fechaString>fechaMayor.fechaString;
  }
       
/*  Funcion que valida si la fecha que contiene el objeto fecha es menor que la fechaMenor */
function validaMe(fechaMenor)
  {
     return this.fechaString<fechaMenor.fechaString;  
  }

function errorPage()
  {
   var HTML="";
   HTML='<HEAD><TITLE>Disculpe</TITLE></HEAD><BODY BACKGROUND="/HTML/images/fondo.gif"><P><P ALIGN="CENTER"><IMG SRC="../images/logoerr.gif" WIDTH="197" HEIGHT="195" ALIGN="BOTTOM" BORDER="0"><I></I></P><P ALIGN="CENTER"><FONT SIZE="4" COLOR="#770000"><I><B>Disculpe, en estos momentos estamos</B></I></FONT></P><P ALIGN="CENTER"><FONT SIZE="4" COLOR="#770000"><I><B>fuera de servicio!!!</B></I></FONT></P><P ALIGN="CENTER"><FONT SIZE="4" COLOR="#770000"><I><B>Intentelo m&aacute;s tarde... GRACIAS</B></I></FONT></P></BODY>';
   document.open("text/html", "replace");
   document.writeln=HTML;
   document.close();
  }
function toMesN(){
   switch (Number(this.mes)){
     case 1 : return 'JAN' ;
     case 2 : return 'FEB';
     case 3 : return 'MAR';
     case 4 : return 'APR';
     case 5 : return 'MAY';
     case 6 : return 'JUN';
     case 7 : return 'JUL';
     case 8 : return 'AUG';
     case 9 : return 'SEP';
     case 10 : return 'OCT';
     case 11 : return 'NOV';
     case 12 : return 'DEC';
    }
}

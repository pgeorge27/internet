
var cuentas = new Array();

function showDisponible(){
    var c = getCuenta(document.forma.NumeroCuenta.value);
    if (c !=null)
    {
		if (lblSaldoTotal){
			lblSaldoTotal.innerHTML=c.total;
			lblSaldoDisponible.innerHTML=c.disponible;
		}
		else{
			document.forma.SaldoDisponible.value=c.disponible;
			document.forma.SaldoTotal.value=c.total;
		}	
    }
    else{
		if (lblSaldoTotal){
			lblSaldoTotal.innerHTML="_______________";
			lblSaldoDisponible.innerHTML="_______________";
		}
		else{
			document.forma.SaldoDisponible.value="";
			document.forma.SaldoTotal.value="";
		}	
	}		
}
function Cuenta(codigo, disponible, total, moneda)
{
 this.codigo = codigo;
 this.disponible = disponible;
 this.total = total;
 this.moneda = moneda;
}
function getCuenta(codigo)
{
   for (var i = 0; i < cuentas.length; i++)
   {
   	   if (cuentas[i].codigo == codigo)
	   {
	   	return cuentas[i];
	   }
   }
   return null;
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

function isDigit(num) {
	if (num.length > 1){
		return false;
	}
	var string="1234567890";
	if (string.indexOf(num)!= -1){
		return true;
	}
	return false;
}

function isBlank(val){
	if(val==null){
		return true;
	}
	for(var i=0;i<val.length;i++) {
		if ((val.charAt(i)!=' ')&&
			(val.charAt(i)!="\t")&&
			(val.charAt(i)!="\n")&&
			(val.charAt(i)!="\r")){
				return false;
		}
	}
	return true;
}

function isInteger(val){
	if (isBlank(val)){
		return false;
	}
	for(var i=0;i<val.length;i++){
		if(!isDigit(val.charAt(i))){
			return false;
		}
	}
	return true;
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

function confirmar(strValue)
{
	var	mensaje = '¿Desea realizar la operación por un monto de ' + mascara(strValue) + '?';
	return confirm(mensaje);
}


function maskoff(valor)
{ temp=valor
  do
  {
    temp=temp.replace(',','');
  }while(temp.indexOf(',')!=-1)
return temp;
}

function isPositiveNumber(strNumber)
{
	var objNotPositivePattern = /[^0-9.]/;
	var objPositivePattern = /^[.][0-9]+$|[0-9]*[.]*[0-9]+$/;
	var objTwoDotPattern = /[0-9]*[.][0-9]*[.][0-9]*/;
	if (strNumber != ""){
        return !objNotPositivePattern.test(strNumber) &&
		   	    objPositivePattern.test(strNumber)  &&
    	       !objTwoDotPattern.test(strNumber);
	}
}
function ocultartext() {
 document.forma.monto.disabled=true;
 }
 function mostrartext() {
    document.forma.monto.disabled=false;   
}  
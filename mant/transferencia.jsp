
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ page import="com.arango.common.util.*"%>
<%@ page import="com.arango.common.banking.Productos"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Locale"%>
<%@ page import="com.arango.common.beans.*"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Calendar"%>


<%
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
Calendar cale = Calendar.getInstance();
cale.setTime(new java.util.Date());
java.util.Date hasta = cale.getTime();
cale.set(Calendar.DATE, 1);
java.util.Date desde = cale.getTime();
String fechaDesde = df.format(desde);
String fechaHasta = df.format(hasta);

%>
<%@ include file="../head.jsp"%>
<%
session.setAttribute("send.email.notification","false");
session.setAttribute("get.balance","false");
%>
<script language="JavaScript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>

<script LANGUAGE=javascript>
function _reset(){
	document.forma.reset();	
	onchangeList(document.forma.ctaOrigenCA);
}
function clearList(){
	document.forma.ctaDestinoCA.options.length = 0;
	document.forma.ctaDestinoCA.options.options[0] = new Option("<bean:message key="lbl.seleccione.una.cuenta"/>","");
}
function onchangeList2(){
	if (document.forma.ctaOrigenCA.value == "-1"){
		document.forma.ctaDestinoCA.options.length = 0;
		document.forma.ctaDestinoCA.options.options[0] = new Option("<bean:message key="lbl.seleccione.una.cuenta"/>","");
	}
//	onchangeList(document.forma.ctaOrigenCA);

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


function validarEntrada(elemento)
{
   if (parseInt(elemento.value) < 1){
       elemento.value='';
       alert('<bean:message key="msg.transferencia.monto.mayor.cero"/>');
       elemento.focus();
       return false;
   }
   
   if (!isPositiveNumber(elemento.value)){
     alert("<bean:message key="msg.transferencia.valor.valido.monto"/>");
     elemento.value="";
     elemento.focus();
     return false;
   }
   
   return true;
}

function hideElement(elementName){
   var obj = document.getElementById(elementName);
   obj.style.display="none";
}
function showElement(elementName){
   var obj = document.getElementById(elementName);
   obj.style.display="";
}

function changeCta(){
      hideElement("corriente1");
      hideElement("comision1");
      hideElement("corriente2");
      hideElement("comision2");

      switch(document.forma.tipoTransferencia.value)
      {
        case '01': // CC - CA
                   showElement("corriente1");
                   showElement("comision2");
                   break;
        case '02': // CA - CC
                   showElement("comision1");
                   showElement("corriente2");
                   break;
        case '03': // CC - CC
                   showElement("corriente1");
                   showElement("corriente2");
                   break;
        case '04': // CA - CA
                   showElement("comision1");
                   showElement("comision2");
                   break;
      }
}
function ClickEnviar(){
    var moneda = "";
 	if(document.forma.monto.value == "")
    {
      alert('<bean:message key="msg.transferencia.falta.monto"/>');
      document.forma.monto.focus();
      return false;
    }       
    var ctas = document.forma.ctaOrigenCA.value.split("~");
    var cta = getCuenta(ctas[0]);
    if (cta)
	    moneda = " " + cta.moneda;
	
    if(confirm("<bean:message key="lbl.confirmacion" arg0="mascara(document.forma.monto.value)" arg1="moneda"/>")){
	    //document.forma.submit();
	    return true;
	}    
	else{
		return false;
	}
}
function _submit(){
	return validateAccount();
}
function _submitForm(){
	if (validateAccount())
		document.forma.submit();
}
function validateAccount(){
    if(validarEntrada(document.forma.monto)){
      switch(document.forma.tipoTransferencia.value)
      {
        case '01': document.forma.cuentaDb.value = document.forma.ctaOrigenCC.value;
        		   document.forma.cuentaCr.value = document.forma.ctaDestinoCA.value;	
        		   if((document.forma.ctaOrigenCC.value=="-1")||(document.forma.ctaDestinoCA.value=="-1")){
			       	  alert('<bean:message key="msg.transferencia.falta.cuenta"/>');
			          return false;
 			       }   
 		           else{
		             if(document.forma.ctaOrigenCC.value == document.forma.ctaDestinoCA.value){
		               alert('<bean:message key="msg.transferencia.cuenta.iguales"/>')
		               return false;
		             }   
		             else{
			           return ClickEnviar();
			         }
			       }
                   break;
        case '02': document.forma.cuentaDb.value = document.forma.ctaOrigenCA.value;
        		   document.forma.cuentaCr.value = document.forma.ctaDestinoCC.value;        
         	       if((document.forma.ctaDestinoCC.value=="-1")||(document.forma.ctaOrigenCA.value=="-1")){
		              alert('<bean:message key="msg.transferencia.falta.cuenta"/>')	;
		              return false;
		           }   
		           else{
		              if(document.forma.ctaDestinoCC.value == document.forma.ctaOrigenCA.value){
		                alert('<bean:message key="msg.transferencia.cuenta.iguales"/>');
		                return false;
		              }  
		              else
		                return ClickEnviar();
		           }
                   break;
        case '03': document.forma.cuentaDb.value = document.forma.ctaOrigenCC.value;
        		   document.forma.cuentaCr.value = document.forma.ctaDestinoCC.value;
		           if((document.forma.ctaDestinoCC.value=="-1")||(document.forma.ctaOrigenCC.value=="-1")){
		              alert('<bean:message key="msg.transferencia.falta.cuenta"/>')	;
		              return false;
		           }    
		           else{
		             if(document.forma.ctaDestinoCC.value == document.forma.ctaOrigenCC.value){
		               alert('<bean:message key="msg.transferencia.cuenta.iguales"/>');
		               return false;
		             }    
		             else{
		               return ClickEnviar();
		             }
		           }  
                   break;
        case '04': document.forma.cuentaDb.value = document.forma.ctaOrigenCA.value;
        		   document.forma.cuentaCr.value = document.forma.ctaDestinoCA.value;
        	       if((document.forma.ctaDestinoCA.value=="-1")||(document.forma.ctaOrigenCA.value=="-1")){
		              alert('<bean:message key="msg.transferencia.falta.cuenta"/>')	;
		              return false;
		           }    
		           else{
		             if(document.forma.ctaDestinoCA.value == document.forma.ctaOrigenCA.value){
		               alert('<bean:message key="msg.transferencia.cuenta.iguales"/>');
		               return false;
		             }    
		             else{
		            	return ClickEnviar();
		             }
		           }
                   break;
        }
	}
	else{
		return false;
	}
}
function onchangeList(obj){
   var str;
   var arr;
   if (obj.value.indexOf("~") > 0){
     arr = obj.value.split("~");
	 str = arr[0];
   }
   else{
      str = obj.value;
   }
   if (str == "-1"){
   		clearList();
   }
   else{
	   document.forma.NumeroCuenta.focus()
	   document.forma.NumeroCuenta.value=str;
	   obj.focus();
   }
   showDisponible();
}
</script>
<script language="javascript">
var cuentas = new Array();
<%int i = 0;%>
<csic:forEachCliente>
      <csic:forEachCuenta producto="01">
      cuentas[<%=i++%>]=new Cuenta('<%=numCtaCSIC%>', '<%=saldo%>', '<%=saldoTotal%>', '<%=moneda_abreviatura%>');
      </csic:forEachCuenta>
</csic:forEachCliente>

</script>

<%@ include file="../body.jsp"%>

<div align="center"> 
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td><div align="left" class="login"><bean:message key="mnu.transferencia.internas"/></div></td>
		  <td width="8%"><div align="right">&nbsp;</div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top">
										<form action="<html:rewrite page='/do.transferencia'/>" method="post" name="forma" onsubmit="return _submit();">
										<input type="hidden" name="cuentaDb">
										<input type="hidden" name="cuentaCr">
										<input type="hidden" name="tipoTransferencia" value="04">
										<input type="text" name="NumeroCuenta" id="NumeroCuenta" style="width:0;height:0">
										<common:Token  tokenTag="<%=CommandToken.TRANSFERENCIA%>"/>
										<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">
		  <tr> 
			<td width="40%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.transferencia.ca.debitar"/></div>
													<td width="60%" nowrap><csic:ListaCuentas mostrarDefault="true" classname="form" name="ctaOrigenCA" producto="CA-CC" onchange="onchangeList(this)"  formatCuenta="A-S-C"/>
												  		<span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td></tr>
												<tr vAlign="center">
													<td class="texto-acceso" align="middle" colspan="2">
													  <div align="center">
														<bean:message key="lbl.saldo.disponible"/>
														<b><span id="lblSaldoDisponible">____________</span></b>
														&nbsp;<bean:message key="lbl.saldo.total"/>
														<b><span id="lblSaldoTotal">____________</span></b>
													  </div>
													  </td></tr>
                                			   <TR>
                                					<TD height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.transferencia.ca.acreditar"/></div>
													<TD class=style1 noWrap width="81%"><select class="form" id="ctaDestinoCA" name="ctaDestinoCA">
														    <option value=""><bean:message key="lbl.seleccione.una.cuenta"/></option>
														</select><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></TD></TR>
											   <TR class=txt vAlign=center>
                                					<TD noWrap align=right width="19%" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.transferencia.monto"/></div>
													<TD class=ConsultaValue noWrap width="81%"><input class="form" type="text" name="monto" size="17" maxlength="16" ><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
											 <tr> 
			<td>&nbsp;<br><br></td>
											   <TR>
                               
                                <td colspan="2" align="right"><input name="botonEnviar" onclick="_submitForm();" type="button" class="botton" value="<bean:message key="btn.transferir"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
			  <input TYPE="BUTTON" class="botton" VALUE="<bean:message key="btn.limpiar"/>" onclick="_reset()">
			</td></TR></TBODY></TABLE></FORM>
            <script>
            if (document.forma.ctaOrigenCA.value != "-1"){
            	onchangeList(document.forma.ctaOrigenCA);
			}
            </script>
<ajax:select
  baseUrl="/internet/cuenta.view"
  source="NumeroCuenta"
  target="ctaDestinoCA"
  eventType="blur"
  parameters="cta={NumeroCuenta}"
  emptyFunction="onchangeList2"/>     
         
           </td>
  </tr>
  
  <tr>
	<td height="20" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table></div>
<%@ include file="../footer.jsp"  %>
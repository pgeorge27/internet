<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<% 
String field = request.getParameter("field");
%>
<!DOCTYPE html>
<html:html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Dirección Especifica</title>
	<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/style.css'/>" />

<style>

.textfield, .textfield-fecha, .text, .textfield2, .text2, .textfield3, .textfield-m,.textfield-y {
	height: 22px;
	font-weight: bold;	
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	background-color: #EFEFEE;
	color:black;
	border: 1px solid #000000;
}
.textfield, .text, .text2, .textfield2{
	width: 230px;
}
.textfield-fecha{
width: 200px;
}
.textfield-y{
width: 70px;
}
.textfield-m{
width: 50px;
}
.text,.text2{
	height: 22px;
	color:#808080;
	padding:1;
}
.text2, .textfield2{
	height: 40px;
}
.text2{
	height: 40px;
	overflow: auto;
}

.celdas, .celdas-border{
	height: 22px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #3E3E3E;
}
.celdas-border{
	border-bottom:1px solid #A4A4A4;
}
.textfield-error{
	background-color: #FF;
	border:1px red solid;
}
.marco, .marco-titulo{
	width:90%;
	text-aling:center;
 }
.marco-titulo{
	width:60%;
} 
</style>
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/estilo.css'/>">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/newlf.css' />">

<script type="text/javascript">
var fieldsArray = ["calle","residencia","municipio", "urbanizacion", "mailingCode", "casa"];

function setParametros(frm, id, value) {
if(!frm || !id)

return;

var elem = frm.elements[id];

if(!elem)

return;

elem.value = value;
}

function getParametros(frm, id) {
if(!frm || !id)

return;

var elem = frm.elements[id];

if(!elem)

return;

return elem.value;
}

function splitDireccion() {
	alert('direccion...........');
	alert('direccion...........'+window.parent.document);
var direccion = window.parent.document.getElementById('direccionFisica').value;
alert(direccion);
var frm = document.forms['frm'];
var arrVariables = direccion.split(",");

for (i=0; i<arrVariables.length; i++) {
     if(i<fieldsArray.length)
    	setParametros(frm, fieldsArray[i], arrVariables[i]);
}

}

function setDireccion() {

var direccion = '';
var frm = document.forms['frm'];
var arrVariables = direccion.split(",");
for (i=0; i<fieldsArray.length; i++) {
direccion = direccion + getParametros(frm, fieldsArray[i]);
if(i<(fieldsArray.length-1))
    direccion = direccion + ',';
}
window.parent.document.getElementById('direccionFisica').value = direccion;
window.top.hidePopWin();
}

</script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
</head>
<body onload="splitDireccion()">

<div class="container">

		<div class="row" style="padding-top: 5%; padding-left: 3%; padding-right: 3%;">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong>Dirección Específica</strong></div>

					  <div class="panel-body">

<form id="frm" name="frm" action="">
	
			 <br> 
					       <div  style="width: 90%; padding-left: 10%;"> 
            	
              <div class=""><strong>Calle y Nro:</strong></div>
                <div><input name="calle" maxlength="25" size="45" class="form-control" type="text">
                </div>
            </div>
            
            				 <br> 
					       <div  style="width: 90%; padding-left: 10%;"> 
            	
              <div class=""><strong>Edificio / Residencia:</strong></div>
                <div><input name="residencia" maxlength="25" size="45" class="form-control" type="text">
                </div>
            </div>
            
            
                        				 <br> 
					       <div  style="width: 90%; padding-left: 10%;"> 
            	
              <div class=""><strong>Municipio:</strong></div>
                <div><input name="municipio" maxlength="25" size="45" class="form-control" type="text">
                </div>
            </div>
            
            
                                    				 <br> 
					       <div  style="width: 90%; padding-left: 10%;"> 
            	
              <div class=""><strong>Urbanización:</strong></div>
                <div><input name="urbanizacion" maxlength="25" size="45" class="form-control" type="text">
                </div>
            </div>
            


                                  				 <br> 
					       <div  style="width: 90%; padding-left: 10%;"> 
            	
              <div class=""><strong>Mailing Code:</strong></div>
                <div><input name="mailingCode" maxlength="25" size="45" class="form-control" type="text">
                </div>
            </div>
            
            
                                             				 <br> 
					       <div  style="width: 90%; padding-left: 10%;"> 
            	
              <div class=""><strong>Casa:</strong></div>
                <div><input name="casa" maxlength="25" size="45" class="form-control" type="text">
                </div>
            </div>

</form>

</div>

<div align="center">
  
       <input class="btn btn-default" onclick="setDireccion();" value="Aceptar" type="button">
      <input  class="btn btn-default" onclick="window.top.hidePopWin()" value="Cancelar" type="button">
	</div>
	<br>

</div>
</div>
</div>
</div>
</div>
</body>
</html>
</html:html>
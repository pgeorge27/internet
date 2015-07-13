<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<% 
String field = request.getParameter("field");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
</head>
<body onload="splitDireccion()">
<form id="frm" name="frm" action="">
	<div align="center"><br>
	    	 <table border="0" cellpadding="1" cellspacing="0" width="300">
					
						<tbody><tr>
			    	 			<td class="celdas-border" width="30%"><b>Calle y Nro:</b></td>
							<td class="celdas" width="60%">
							<input name="calle" maxlength="25" size="45" class="textfield" type="text"></td>
							</tr>
			    	 	<tr valign="middle">	    	 		
							<td class="celdas-border">Edificio/Residencia:</td>
							<td class="celdas"><input name="residencia" maxlength="25" size="45" class="textfield" type="text"></td>
							</tr>
			    	 	<tr valign="middle">
			    	 		
							<td class="celdas-border">Municipio:</td>
							<td class="celdas"><input name="municipio" maxlength="25" size="45" class="textfield" type="text"></td>
							</tr>
<tr valign="middle">
			    	 		
							<td class="celdas-border" width="30%">Urbanización:</td>
							<td class="celdas" width="60%"><input name="urbanizacion" maxlength="25" size="45" class="textfield" type="text"></td>
							</tr>
			    	 	<tr valign="middle">
			    	 		
							<td class="celdas-border">Mailing Code:</td>
							<td class="celdas"><input name="mailingCode" maxlength="25" size="45" class="textfield" type="text"></td>
							</tr>
			    	 	<tr valign="middle">
			    	 		
							<td class="celdas-border">Casa:</td>
							<td class="celdas"><input name="casa" maxlength="25" size="45" class="textfield" type="text"></td>
							</tr>

			    	 	
<tr valign="middle">			       <td align="center" COLSPAN="2" heigth="100px"><br>
				   <input class="botton" onclick="setDireccion();" value="Aceptar" type="button">
				   <input class="botton" onclick="window.top.hidePopWin()" value="Cancelar" type="button">
	    	 	</td></tr>
						</tbody></table>
			
	    </div>
</form>
</body>
</html>
</html>
<% session.setAttribute("selected", "ayuda"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%!
private String getTitulo(String tipo){
	String product = "tit.politicas.seguridad.po";
	if ("PO".equals(tipo))
		product = "tit.politicas.seguridad.po";
	else if ("AF".equals(tipo))
	product = "tit.acuerdos.formulario.af";
	else if ("MU".equals(tipo))
	product = "tit.manual.usuario.mu";
	else if ("VD".equals(tipo))
	product = "tit.video.demo.vd";
	
	return product;	
}
%>
<%
String prod = "ALL";
if (request.getParameterValues("titul") != null)
{
  prod = request.getParameterValues("titul")[0];
} 
%>

<%@ include file="../head.jsp"%> 

<script language="JavaScript">

function retornar(){
	history.back();
}	  
</script>
<%@ include file="../body.jsp"%>

<div align="center"> 
<table width="90%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
	<div> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr>
		    <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>		
			<td><div align="left" class="login">Consejos de Seguridad</div></td>
		  <td width="8%">&nbsp;	</td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr> 
	<td valign="top" class="bienvenida">
		<p class="bienvenida">
<br>
Conozca los servicios, beneficios y recomendaciones de seguridad que le ofrecen los canales Helm Bank [Panamá].
<br>
Les presentamos Helm Virtual, un sistema que le ofrece mayor seguridad, agilidad y comodidad para la realización de sus transacciones financieras y la consulta de productos y servicios.
<br><br>
Nuestros canales son:

<UL>
    <li>Oficina de Representación Bogotá (571) 236-6012.</li>
    <li>Oficina Principal Panamá (507) 265-2820.</li>
    <li>Internet - www.helmpanama.com</li>
</UL>
<B>Los beneficios que le ofrece la Banca Virtual son:</B>

<UL>
    <li> Facilidad para hacer sus consultas y transferencias electrónicas en línea desde cualquier lugar del mundo las 24 horas del día los 7 días de la semana, ya sea desde su casa u oficina.</li>
    <li> Seguridad para manejar sus productos y realizar transacciones por medio del uso de claves de acceso personalizadas.</li>
    <li>Facilidad y agilidad en la administración de sus cuentas y transacciones.</li>
    <li>Soporte y atención personalizada.</li>
    <li>Información actualizada de los horarios y direcciones de nuestra red de oficinas.</li>
</UL>
<b>Recomendaciones generales</b>
<br>
Tenga en cuenta las siguientes recomendaciones para la generación y uso de claves de canales electrónicos:

<UL>
    <li>Genere claves que sean difíciles de descifrar.</li>
    <li>Cambie sus claves mínimo una vez al mes, para minimizar el riesgo de que alguien pueda descifrarlas por múltiples intentos.</li>
    <li>No informe a terceros por ningún medio sus claves o información financiera.</li>
    <li>Guarde sus claves en un lugar seguro.</li>
</UL>		
		</p>
	  </td>
  </tr>
  
  <tr>
	<td height="20" align="center" valign="middle" class="texto-ayuda"></td>
  </tr>
</table></div>

<%@ include file="../footer.jsp"  %>
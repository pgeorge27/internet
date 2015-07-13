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
function openCom(url)
{
	Helcom=window.open(url, "Helcom",config="scrollbars=no,resizable=no,toolbar=no,location=yes,status=yes,menubar=no,width="+window.screen.width+",height="+(window.screen.height-10));
	Helcom.focus();
}
</script>
<%@ include file="../body.jsp"%>

<div align="center"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr align="left"> 
		    <td width="50px"  valign="bottom"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
			<td  valign="bottom"><div align="left" class="login" ><bean:message key="<%=getTitulo(prod)%>"/></div></td>
		  </tr>
		</table>
<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">

  <tr> 
	<td valign="top" align="center">
	<form name="forma" method="POST">
		<%@ include file="../divHeader.jsp" %>
		<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">
		<tr>
		<td align="center">
			<table>
				<tr>
				<td>
				<div align="center" class="texto-ayuda">
				Descargue el Video Demo de Helm Virtual desde <a href="#" onclick="openCom('<html:rewrite page="/ayuda/videohelmbank.html"/>');" > 
				<span class="texto-acceso">aquí</span>.</a>
				</div>
				<br><br>
				</td>
				</tr>
				<tr>
				<td>
				<div align="center" class="texto-ayuda">
				Descargue el Video Demo del Menú de Administración desde <a href="#" onclick="openCom('<html:rewrite page="/ayuda/videoAdministracion.html"/>');" > 
				<span class="texto-acceso">aquí</span>.</a>
				</div>
				</td>
				</tr>
			</table>
		</td></tr>
		  <tr> 
			<td width="8%" colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;<div align="center"> 
			  <INPUT class="botton" onclick="retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
			 </td>
		  </tr>
		</table>
		<%@ include file="../divFooter.jsp" %>
	</form></td>
  </tr>
  
  <tr>
	<td height="20" align="center" valign="middle" class="texto-ayuda"></td>
  </tr>
</table></div>

<%@ include file="../footer.jsp"  %>
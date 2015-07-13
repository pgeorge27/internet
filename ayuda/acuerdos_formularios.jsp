<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.util.Locale" %>
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
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
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
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td><div align="left" class="login"><bean:message key="<%=getTitulo(prod)%>"/></div></td>
			<td width="8%">
				<div align="right">&nbsp;
				<!--<INPUT class="botton" onclick="retornar()" type="button" value="<bean:message key="lbl.retroceder"/>">-->
				</div>
			</td>
		  </tr>
		</table>
	</div>
	</td>
  </tr>
  <tr> 
	<td align="center" class="celda-clave1"><div align="center" class="texto-ayuda">&nbsp;<bean:message key="lbl.acuerdos.formularios.1"/><br>&nbsp;<bean:message key="lbl.acuerdos.formularios.2"/>
	</div></td>
  </tr>
  <tr>
  <td align="center" class="celda-clave1">
  <div align="center" class="texto-ayuda"><a target="_new" href="<html:rewrite page='/ayuda/ACUERDO HELM VIRTUAL PANAMA.pdf'/>">Acuerdos Virtuales</a></div>
  </td>
  </tr>
  <tr>
  <td align="center" class="celda-clave1">
	<div align="center" class="texto-ayuda">
  		<a target="_new" href="<html:rewrite page='/ayuda/PAN ACUERDO BANCA ELECTRONICA.pdf'/>">ACUERDO BANCA ELECTRONICA</a>
	</div>
  </td>
  </tr>
  <tr>
	<td valign="top">
	<form name=forma method=POST>
		<table width="85%" border="0" align="center" cellpadding="5" cellspacing="5">
		  <tr>
			<td align="center" class="celda-clave1">
				<div align="center" class="texto-ayuda">&nbsp;<bean:message key="lbl.acuerdos.formularios.3"/>
				</div>
			</td>
		  </tr>
		  <tr> 
			<td width="8%" colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;
				<div align="center"> 
				<INPUT class="botton" onclick="retornar()" type="button" value="<bean:message key="lbl.retroceder"/>">
				</div>
			</td>
		  </tr>
		</table>
	</form>
	</td>
  </tr>
  <tr>
	<td height="20" align="center" valign="middle" class="texto-ayuda"></td>
  </tr>
</table></div>

<%@ include file="../footer.jsp"  %>
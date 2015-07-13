<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales"%>
<%@ page import="com.arango.common.beans.PerfilXML"%>
<%@ page import="com.arango.common.beans.Cliente"%>
<%@ page import="com.arango.common.beans.ClaveEspecial"%>
<%
PerfilXML p2 = (PerfilXML)session.getAttribute("perfil.xml");
if (p2 == null)
	pageContext.forward("/index.jsp");
String nom = "";
nom = p2.getNombre();
%>

<%@ include file="head.jsp"%>
<style>

a.ln, a.ln:active,a.ln:link,a.ln:visited, a.ln:hover {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #004284;
	text-decoration: none;
}
a.ln:hover {
	text-decoration: underline;
}
</style>
</head>
<%@ include file="body.jsp"%>

<table width="750" border="0" align="left" cellpadding="0" cellspacing="0">
<tr> 
<td height="40" valign="bottom"><div align="left"> 
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
	  <tr> 
		<td width="32%" class="tabla-acceso"><div align="center" class="bienvenida"><bean:message key="tit.bienvenida"/>  
			<strong>&nbsp;<%=nom%></strong></div></td>
		<td width="68%">&nbsp;</td>
	  </tr>
	</table>
  </div></td>
</tr>
<tr><td colspan="2"><br><br></td></tr>
<csic:clave-especial/>
<% 
if ("true".equals(session.getAttribute("mostrar.mensaje.clave.especial")) 
		&& session.getAttribute("clave.secundaria") != null ){
ClaveEspecial clave = (ClaveEspecial)session.getAttribute("clave.secundaria");

if ( ConstantesGlobales.PRIMER_LOGIN == clave.getFlag()){ %>
<tr>
  <td class="bienvenida2" colspan="2">
  
  <table class="tabla-acceso1" width="100%" border="0" cellspacing="2" cellpadding="2" align="left">
                      <tr> 
                        <td width="5%"><div align="left"><img src="<html:rewrite page='/images/icon_info_lrg.gif'/>"></div></td>
                        <td width="95%" class="bienvenida" align="left"><bean:message key="lbl.clave.especial.cambiar"/>
	<a href="<html:rewrite page='/ib/cambioClaveEspecial.jsp'/>">
	<bean:message key="lbl.clave.especial.click.aqui"/></a></td></table></tr>
<% }
 else if(ConstantesGlobales.CLAVE_BLOQUEADA.equals(clave.getEstado())){
	 %>
 <tr>
  <td class="bienvenida" colspan="2">
	 
	 <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso1">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="bienvenida"><bean:message key="lbl.clave.especial.bloqueada"/><br>
	 <bean:message key="lbl.clave.especial.mensaje"/>
								   </td></tr>
			 </table></td></tr>
		  </table></td></tr>
	 
	 <%
 }
 else if(ConstantesGlobales.CLAVE_EXPIRADA.equals(clave.getEstado())){
	 %>
  <tr>
  <td class="bienvenida" colspan="2">
  <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso1">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="bienvenida"><bean:message key="lbl.clave.especial.expirada"/><br>
	 <bean:message key="lbl.clave.especial.mensaje"/>
								   </td></tr>
			 </table></td></tr>
		  </table>
	 </td></tr>
	 <%
 }
}%>
 <tr>
  <td class="bienvenida" colspan="2">
  
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="100%" class="bienvenida">
				  <table class="tabla-acceso1" width="100%" border="0" cellspacing="2" cellpadding="2" align="left">
                      <tr> 
                        <td width="5%"><div align="left"><img src="<html:rewrite page='/images/icon_info_lrg.gif'/>"></div></td>
                        <td width="95%" class="bienvenida" align="left">
	 Ya puede descargar sus transferencias en Formato Swift.&nbsp;
								   <a href="<html:rewrite page='/guia-swift.pdf'/>" class="ln" target="_NEW">Instructivo On Line</a></td></tr>
			 </table></td></tr>
		  </table>
 </td></tr>
<tr> 
<td height="30" class="texto-acceso"><br><br></td>
</tr>
<tr height="60%"><td>&nbsp;</td></tr>
</table>

<%@ include file="footer.jsp" %>
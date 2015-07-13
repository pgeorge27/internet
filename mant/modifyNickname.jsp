<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import = "com.arango.common.beans.PerfilXML"%>
<%@ page import = "com.arango.common.beans.Cuenta"%>
<%@ page import = "com.arango.common.util.Format"%>

<%@ include file="../head.jsp"  %>
<script language="javascript">
function enviar(){
	document.forma.submit();
}
function cancelar(){
	document.location = "nickname.jsp"
}
</script>
<%@ include file="../body.jsp"  %>

<%
String cta = request.getParameter("cta");
PerfilXML perfil = (PerfilXML)session.getAttribute("perfil.xml");
Cuenta cuenta = perfil.getCuentaCSIC(cta);
Format f = Format.getFormat();
%>
<table width="750" border="0" align="left" cellpadding="0" cellspacing="0">
	  <tr> 
		<td height="40" colspan="2" valign="bottom"><div align="left"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			  <tr> 
				<td width="92%"><div align="left" class="login"><bean:message key="tit.nickname.account"/></div></td>
				<td width="8%"><div align="right"></div></td>
			  </tr>
			</table>
		  </div></td>
	  </tr>
	  <tr> 
		<td height="30" class="texto-acceso">&nbsp;</td>
		<td class="texto-acceso"><div align="right">&nbsp;</div></td>
	  </tr>
	  <tr> 
		<td valign="top" align="center">
			<table width="100%" border="0" cellspacing="1" cellpadding="0">                   
				<tr> 
				  <td width="68%" height="20" class="catra-texto" align="left">
				  
<form name="forma" action="<html:rewrite page='/do.nickname'/>" method="post">
	<input type="hidden" name="cta" value="<%=cuenta.getCodigoCSIC()%>">
<table width="80%" border="0" cellpadding="0" cellspacing="2">
	  <tr class="tabla-acceso"> 
		<td height="15" class="texto-acceso"><bean:message key="lbl.numero.cuenta"/></td>
   		<td width="60%" class="texto-acceso"><bean:message key="lbl.nickname"/></td>
   </tr>   
   <tr>
		<td class="bienvenida"><%=f.formatCuenta(cuenta.getCodigoBanco(), "C")%> <%=cuenta.getNombreProducto()%></td>
		<td class="bienvenida"><input class="botton-acceso" type="form" name="nickname" maxlength="60" size="30" value="<%=cuenta.getNickname()%>"></td>
	</tr>	

<tr valign="middle">
		<TD colspan="2"><small style="color:red"><b><bean:message key="lbl.nickname.observacion"/></b></small></td></tr>
	<tr><TD colspan="2"><small style="color:#8e181c">
        <bean:message key="lbl.nickname.observacion1"/></small>
        	
	<tr>
	<td colspan="2" align="right"><br><br>
	<INPUT class="botton" onclick="enviar();" type="button" value="<bean:message key="btn.enviar"/>">
	&nbsp;
	<INPUT class="botton" onclick="cancelar();" type="button" value="<bean:message key="btn.cancelar"/>">
	</td>
	</tr>
</table></td></tr></table></td></tr></table>
</form>
<%@ include file="../footer.jsp"  %>
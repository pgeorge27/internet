<% session.setAttribute("selected", "ayuda"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%@ include file="../head.jsp"%> 

<script language="JavaScript">
function retornar(){
	history.back();
}	  
</script>

<%@ include file="../body.jsp"%>

<div align="center">
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
		<div align="center"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
				<tr> 
					<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
					<td><div align="left" class="login">Instalador de Carga Masiva</div></td>
				</tr>
			</table>
		</div>
	</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
	<form name=forma method=POST>
	    <%@ include file="../divHeader.jsp" %>
		<table width="75%" border="0" align="center" cellpadding="5" cellspacing="5">
			<tr>
				<td align="center">
				<div align="center" class="texto-ayuda">Descargue el Instalador de Carga Masiva desde <a target="_new" href="<html:rewrite page='/ayuda/CargaMasiva.zip'/>"><span class="texto-acceso">aquí</span>.</a></div>
				</td>
			</tr>
			<tr>
				<td width="8%" colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;<div align="center"> 
				  <INPUT class="botton" onclick="retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
				</td>
			</tr>
		</table>
		<%@ include file="../divFooter.jsp" %>
	</form>
	</td>
  </tr>
  <tr>
	<td height="20" align="center" valign="middle" class="texto-ayuda"></td>
  </tr>
</table>
</div>

<%@ include file="../footer.jsp"  %>
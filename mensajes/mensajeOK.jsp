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
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td valign="top">
	<form name="forma" method="POST">
		<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">
		<tr>
		<td align="center" class="tabla-border">
		<table><tr>
		<td><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
		<td>
		<div align="center" class="texto-ayuda">
		<bean:message key="lbl.mensaje.confirmacion" />
		</div>
	   </td>
		</tr>
		</table></td></tr>
		  <tr> 
			<td width="8%" colspan="2" align="center">&nbsp;&nbsp;&nbsp;&nbsp;<div align="center"> 
			  <INPUT class="botton" onclick="retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
			 </td>
		  </tr>
		</table>
	  </form></td>
  </tr>
  
  <tr>
	<td height="20" align="center" valign="middle" class="texto-ayuda"></td>
  </tr>
</table></div>

<%@ include file="../footer.jsp"  %>
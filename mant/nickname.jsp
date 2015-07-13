<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>

<%@ include file="../head.jsp"  %>
<script language="javascript">
function changeNickname(cta){
	document.forma.cta.value=cta;
	document.forma.submit();
}
</script>
<%@ include file="../body.jsp"  %>
<form name="forma" action="<html:rewrite page='/mant/modifyNickname.jsp'/>" method="post">
	<input type="hidden" name="cta">
</form>
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
		<td valign="top" align="left">
			<table width="100%" border="0" cellspacing="1" cellpadding="0">                   
				<tr> 
				  <td width="68%" height="20" class="catra-texto" align="left">
					<table width="80%" border="0" cellpadding="0" cellspacing="2">
					  <tr class="tabla-acceso"> 
						<td height="15" class="texto-acceso"><bean:message key="lbl.numero.cuenta"/></td>
						<td width="60%" colspan="2" class="texto-acceso"><bean:message key="lbl.nickname"/></td>
					</tr>
      <csic:forEachCuentaPerfil formatAccount="C" >
         <tr <%=classIndexCta.intValue()%2==0?"class=\"celda-clave1\"" : ""%>>
			<td width="40%" class="bienvenida"><%=numCta%> <%=producto%></td>
			<td width="45%" class="bienvenida"><%=nickname%></td>
			<td width="15%" class="bienvenida"><input type="button" class="botton-acceso" name="btnChange" value="<bean:message key="lbl.btn.cambiar"/>" onclick="changeNickname(<%=numCtaCSIC%>)"></td>
		</tr>	
      </csic:forEachCuentaPerfil>
<tr valign="middle">
		<TD colspan="2"><small style="color:red"><b><bean:message key="lbl.nickname.observacion"/></b></small></td></tr>
	<tr><TD colspan="2"><small style="color:#8e181c">
        <bean:message key="lbl.nickname.observacion1"/></small>
</table></td></tr></table></td></tr></table>

<%@ include file="../footer.jsp"  %>
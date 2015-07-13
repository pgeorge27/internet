<% session.setAttribute("selected", "administracion"); %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="com.arango.internet.beans.IBAfiliacion" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ page import="com.arango.common.beans.Usuario" %>
<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>
<%@ page import="java.util.ArrayList" %>
<%! 
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
private String getStatus(String status){
	String descestado = "";
	if (ConstantesGlobales.USUARIO_ACTIVO.equals(status))
	  descestado = "lbl.administration.user.active";
	else if (ConstantesGlobales.USUARIO_INACTIVO.equals(status))
	  descestado = "lbl.administration.user.inactive";
	else if (ConstantesGlobales.USUARIO_BLOQUEADO.equals(status))
	  descestado = "lbl.administration.user.lock";
	else
	    descestado = "lbl.administration.user.active";
	return descestado;  
}
%>

<%@ include file="../head.jsp"  %>

<script language="javascript">
function __submit(usr, opt){
	document.forms[0].username.value=usr;
	document.forms[0].action.value=opt;
	if ("I" == opt){
		if (confirm('<bean:message key="lbl.administration.msg.inactivar" arg0=" '+usr+' "/>')){
			document.forms[0].submit();
		}
	}
	else if("D" == opt) {
		if (confirm('<bean:message key="lbl.administration.msg.desbloquear" arg0=" '+usr+' "/>')){
			document.forms[0].submit();
		}
	 }	

}

</script>
<script type="text/javascript" src="imageGallery.js"></script>

<jsp:useBean id="marcas" class="com.arango.internet.beans.MarcasIdentidad" scope="page"/>

<%@ include file="../body.jsp"  %>

<html:form action="/user" method="post">
	<html:hidden property="username"/>
	<html:hidden property="action"/>
</html:form>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton" >
			  <tr> <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
				<td width="100%"><div align="left" class="login"><bean:message key="lbl.administration.users"/></div></td>
				<td width="8%"><div align="right"></div></td>
			  </tr>
			</table>
<table width="100%" border="0"  cellpadding="0" cellspacing="0">
  <tr> 
		<td valign="top" align="left">
			<table width="100%" border="0" cellspacing="1" cellpadding="0">                   
				<tr> 
				  <td width="100%" height="20" class="catra-texto" align="left">
					 <%@ include file="../divHeader.jsp"%>
					<table width="600" border="0" cellpadding="0" cellspacing="3">
					  <tr class="tabla-acceso"> 
						<td width="50%" height="15" class="texto-acceso"><bean:message key="lbl.administration.user.name"/></td>
						<td width="10%" height="15" class="texto-acceso"><bean:message key="lbl.administration.status"/></td>
						<td width="15%" class="texto-acceso"><bean:message key="lbl.administration.user.username"/></td>
						<td width="25%" class="texto-acceso"><bean:message key="lbl.administration.user.acciones"/></td>
					</tr>
	<%
	IBAfiliacion ib = new IBAfiliacion(); 
	UserInfo user = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
	ArrayList users = ib.getUsuarios(user);
	Usuario u = null;
	
	for(int i=0; i < users.size(); i++){
	    String btnInactivar = " class=\"botton-acceso\" ";
	    String btnActivar = " class=\"botton-acceso\" ";
		u = (Usuario)users.get(i);
	    if (!"99".equals(u.getUsuarioGrupo().getEstado())){
	    	if(u.getUsuarioGrupo().getEstado().equals(ConstantesGlobales.USUARIO_ACTIVO))
	    		btnActivar = " class=\"botton-acceso-disable\" disabled=\"disabled\" ";
	    	else
	    		btnInactivar = " class=\"botton-acceso-disable\" disabled=\"disabled\" ";
	%>
      
         <tr <%=i%2==0?"class=\"celda-clave1\"" : ""%>>
			<td class="bienvenida" width="55%"><%=u.getNombreCompleto()%></td>
			<td class="bienvenida" width="10%"><%=TagUtil.getString(pageContext, getStatus(u.getUsuarioGrupo().getEstado()))%></td>
			<td class="bienvenida" width="15%"><%=u.getUsuarioGrupo().getUserId()%></td>
			
			<td class="bienvenida" width="20%" align="center" nowrap><span></span><input  type="button" <%=btnInactivar %> name="btnChange" value="<bean:message key="lbl.administration.disable"/>" onclick="__submit('<%=u.getUsuarioGrupo().getUserId()%>', 'I')"></span><!--/td>
			<td class="bienvenida" width="20%" align="center" nowrap--><span>&nbsp;&nbsp;<input type="button" <%=btnActivar %> name="btnChange" value="<bean:message key="lbl.administration.unlock"/>" onclick="__submit('<%=u.getUsuarioGrupo().getUserId()%>', 'D')"></span></td>
		</tr>	
      <% }
	    }%>
 
</table>
 <%@ include file="../divFooter.jsp"%>
 </td></tr></table></td></tr>
 
	  <tr> 
		<td height="30" class="texto-acceso">&nbsp;</td>
		<td class="texto-acceso"><div align="right">&nbsp;</div></td>
	  </tr>
 </table>

<%@ include file="../footer.jsp"  %>

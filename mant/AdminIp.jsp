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
<%@ page import="com.arango.internet.beans.IBdireccionesIp"%>
<%@ page import="com.arango.common.beans.IPbeansAdress"%>
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
	 if("Y" == opt){
		if (confirm('<bean:message key="lbl.administration.msg.IP.inactivar" arg0=" '+usr+' "/>')){
			document.forms[0].submit();
		}
	}
	else if("N" == opt){
		if (confirm('<bean:message key="lbl.administration.msg.IP.activar" arg0=" '+usr+' "/>')){
			document.forms[0].submit();
		}
    }		
	else if("E" == opt){
			if (confirm('<bean:message key="lbl.administracion.IP.confirma.eliminar" arg0=" '+usr+' " />')){
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

<table width="750" border="0"  cellpadding="0" cellspacing="0">
	  <tr> 
		<td height="40" colspan="2" valign="bottom"><div align="left"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			  <tr> 
				<td width="92%"><div align="left" class="login"><bean:message key="lbl.administration.users"/></div></td>
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
						<td width="40%" height="15" class="texto-acceso"><bean:message key="lbl.administration.IP.id"/></td>
						<td width="30%" height="15" class="texto-acceso"><bean:message key="lbl.administration.IP.estado"/></td>
						<td width="10%" class="texto-acceso"><bean:message key="lbl.administration.IP.direccion"/></td>
						<td width="20%"></td>
					</tr>
	<%
	IBdireccionesIp ib = new IBdireccionesIp(); 
	UserInfo user = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
	ArrayList direcciones = ib.getIPdirecciones(user.getUserId());
	IPbeansAdress u = null;
	for(int i=0; i < direcciones.size(); i++){
	    u = (IPbeansAdress)direcciones.get(i);
	    if (!"99".equals(u.getDireccion())){
	%>
      
         <tr <%=i%2==0?"class=\"celda-clave1\"" : ""%>>
			<td class="bienvenida"><%=u.getId_direccion()%></td>
			<td class="bienvenida"><%=TagUtil.getString(pageContext, getStatus(u.getEstado()))%></td>
			<td class="bienvenida"><%=u.getDireccion()%></td>
			<td class="bienvenida" align="center" nowrap><span><input type="button" class="botton-acceso" name="btnChange" value="<bean:message key="lbl.administration.disable"/>" onclick="__submit('<%=u.getId_direccion()%>', 'Y')"></span>
								  			   <span><input type="button" class="botton-acceso" name="btnChange" value="<bean:message key="lbl.administration.unlock"/>" onclick="__submit('<%=u.getId_direccion()%>', 'N')"></span>
								  			     <span><input type="button" class="botton-acceso" name="btnChange" value="<bean:message key="lbl.eliminar"/>" onclick="__submit('<%=u.getId_direccion()%>', 'E')"></span></td>
		</tr>	
      <% }
	    }%>
 
</table></td></tr></table></td></tr></table>

<%@ include file="../footer.jsp"  %>

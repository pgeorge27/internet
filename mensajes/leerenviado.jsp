<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ page import="com.arango.common.beans.Lista" %>
<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>
<%@ page import="java.util.ArrayList, java.util.Date" %>
<%@ page import = "com.arango.common.services.ManagerBean"%>
<%@ page import="com.arango.common.beans.MensajeBanco" %>

<%! 
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
private String getDate()
{
	Date fecha = new Date(System.currentTimeMillis());
	return f.formatFecha(fecha, "dd-MM-yyyy");  
}
%>

<script language="JavaScript">

function retornar(){
	history.back();
}	  
</script>

<%@ include file="../head.jsp"  %>

<%@ include file="../body.jsp"  %>

<%
	String empresa = session.getAttribute("codigo.empresa").toString();
	String id = request.getParameter("id");
	ManagerBean mb = new ManagerBean();
	MensajeBanco msb = mb.devolverMensaje(Integer.parseInt(empresa), Long.parseLong(id));
%>

<%@ include file="../divHeader.jsp"  %>
<table width="750" border="0" cellpadding="0" cellspacing="0" align="left">
 <tr> 
	<td height="20" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="100%"><div  class="login"><%=msb.getTitulo()%></div></td>
			<td>
			<div align="right">&nbsp;
			 <INPUT class="botton" onclick="retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
			</td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr> 
	<td>
	 <table cellspacing="3" cellpading="3" class="tabla-border" width="100%">
       <tr valign="top">
      	  <td colspan="2" width="100%">
      	  	<%=msb.getMensaje()%>
	      </td>
	    </tr>
	  </table>
	</td>
  </tr>
  <tr>
  	<td align="right">
  	  <a href="do.mensajesbanco?tipo=D&id=<%=id%>&empresa=<%=empresa%>">
  	  <img src="<html:rewrite page='/images/mensajes/delete2.png' />" border="0" title="Eliminar Mensaje"/></a>
  	</td>
  </tr>
  <tr>
	<td height="20" valign="middle" class="texto-acceso"></td>
  </tr>
</table>
<%@ include file="../divFooter.jsp"  %>

<%@ include file="../footer.jsp"  %>
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

<%! 
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
private String getDate()
{
	Date fecha = new Date(System.currentTimeMillis());
	return f.formatFecha(fecha, "dd-MM-yyyy");  
}
%>

<%@ include file="../head.jsp"  %>

<script language="JavaScript">

function retornar(){
	history.back();
}

function send() {
	if (document.editform.mensaje.value == "")
		alert("El campo mensaje no puede estar vacío");
	else
		document.editform.submit();
}
</script>

<%@ include file="../body.jsp"  %>


<table width="750" border="0" cellpadding="0" cellspacing="0" align="left">
 <tr> 
	<td height="20" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="100%"><div  class="login"><bean:message key="lbl.mensaje.titulo1"/></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr><td>
  <table width="100%" border="0" cellpadding="0" cellspacing="2">
     <tr>
	 <td width="50%" class="bienvenida"><font size="3" ><bean:message key="lbl.mensaje.titulo2"/></font></td> 
	 <td width="25%"></td> 
	 <td width="50%"></td> 
	 </tr>
      </table>
   </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr> 
	<td>
	 <table cellspacing="3" cellpading="3" class="tabla-border">
       <tr valign="top">
      	  <td colspan="2">
      	  <table><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><B><p class="bienvenida"><bean:message key="lbl.preg.secreta.observacion"/></p></B></td>
	      </tr></table>
	      </td>
	    </tr>
      <tr>
	    <td class="bienvenida">
	    <UL>
	       <li><bean:message key="lbl.mensaje.obs1" /></li>
	       <li><bean:message key="lbl.mensaje.obs2" /></li>
	    </UL>
	    </td>
	  </tr>
	  </table>
	</td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr> 
	<td valign="top">
	  <form name="editform" action="do.mensajesbanco" method="post">
	  <input type="hidden" name="tipo" value="N" />
	  <table>
	  	<tr>
	  		<td class="bienvenidaBold"><bean:message key="lbl.mensaje.fecha" /></td>
	  		<td><input type="text" name="fecha" class="caja-acceso" readonly value="<%=getDate()%>"></td>
	  	</tr>
	  	<tr>
	  		<td class="bienvenidaBold"><bean:message key="lbl.mensaje.asunto" /></td>
	  		<td>
	  			<select name="asunto">
			    <%
			   		ManagerBean mb = new ManagerBean();
			   		ArrayList lista = mb.obtieneAsuntosMensajes();
			   		Lista l = null;	
			   		for (int i=0; i<lista.size(); i++)
			   		{
			   			l = (Lista)lista.get(i);
			   	%>
			   		<option value="<%=l.getCodigo()%>"><%=l.getDescripcion()%></option>
			   	<%  } 
			   	%>
	  			</select>
	  		</td>
	  	</tr>
	  	<tr>
	  		<td class="bienvenidaBold"><bean:message key="lbl.mensaje.mensaje" /></td>
	  		<td>
	  			<textarea name="mensaje" class="caja-acceso" cols="40" rows="10"></textarea>
	  		</td>
	  	</tr>
	  	<tr> 
			<td align="center" colspan="2">
			<input name="button" type="button" class="botton" onclick="send()" value="<bean:message key="btn.enviar"/>"> 
			  &nbsp;&nbsp;<input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>"> 
			</td>
		  </tr>
	  </table>
	  </form>
	</td>
  </tr>
  <tr>
	<td height="20" valign="middle" class="texto-acceso"></td>
  </tr>
</table>


<%@ include file="../footer.jsp"  %>
<%session.setAttribute("selected", "mensajes"); %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ page import="com.arango.common.beans.Pagina" %>
<%@ page import="com.arango.common.beans.MensajeBanco" %>
<%@ page import="com.arango.common.beans.Paginador" %>
<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>
<%@ page import="java.util.ArrayList, java.util.Date" %>
<%@ page import = "com.arango.common.services.ManagerBean"%>


<%@ include file="../head.jsp"  %>

<%@ include file="../body.jsp"  %>

<script language="Javascript">
	function nuevo()
	{
		parent.document.location = "enviarMensaje.jsp";
	}

	function selectAll()
	{
	   for (i=0;i<document.editform.elements.length;i++)
	   {
	      if(document.editform.elements[i].type == "checkbox")
	      {
		      if (document.editform.elements[i].checked == 1)
	         	 document.editform.elements[i].checked=0;
	          else
	             document.editform.elements[i].checked=1;
       	  } 
	   }
	}
</script>

<table width="750" border="0" cellpadding="0" cellspacing="0" align="left">
 <tr> 
	<td height="20" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="100%"><div  class="login"><bean:message key="lbl.enviados.titulo"/></div></td>
		  </tr>
		</table>
	  </div>
	  </td>
  </tr>
  <tr>
	<td width="50%" class="bienvenida"><font size="3" ><bean:message key="lbl.enviados.titulo2"/></font></td> 
  </tr>
  <tr>
	<td height="20" valign="middle" class="texto-acceso"></td>
  </tr>
  <tr>
  <td align="center">
  
<table width="80%">
<tr ><td colspan="2"  align="left" >
  
 <%@ include file="../divHeader.jsp" %>
 
	  <form name="editform" action="do.mensajesbanco" method="post">
	  <input type="hidden" name="tipo" value="BS" />
	  <input type="hidden" name="cantidad" value="10"/>
	  <table cellpadding="0" cellspacing="0" width="500px">
	  	<tr class="linea-botton">
	  		<td>&nbsp;</td>
	  		<td class="bandeja-style" width="300px">T&iacute;tulo</td><td class="bandeja-style" width="200px">Fecha</td>
	  	</tr>
	  	<%
	  		com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
	  		String estado = null;
	  		
	  		MensajeBanco msg = null;
			String url = "";
	  		Paginador paginas = (Paginador)session.getAttribute("bandeja.salida");
	  		System.out.println("Cantidad de Paginas = " + paginas.getTotalPaginas());
	  		int pagina = 1;
	  		if (request.getParameter("page") != null)
	  			pagina = Integer.parseInt(request.getParameter("page"));
	  		
	  		ArrayList pregs = new ArrayList();
	  		
	  		if (paginas.getTotalPaginas() > 0)
	  		{
	  			Pagina pag = (Pagina)paginas.getPage(pagina);
				pregs = pag.getRegistros();
	  		}
	  		
	  		System.out.println("Antes del For ");
	  		for (int i=0; i<pregs.size(); i++)
	  		{
		  		System.out.println("Entro al For ");
	  			msg = (MensajeBanco)pregs.get(i);
	  			System.out.println("Codigo de Mensaje = " + msg.getCodigoMensaje());
	  			System.out.println("Estado Banco = " + msg.getEstadoBanco());

	  	%>
	  		<tr class="bienvenida">
	  			<td><input type="checkbox" name="ids" value="<%=msg.getCodigoMensaje()%>" /></td>
	  			<td>
	  			&nbsp;&nbsp;<a href="leerenviado.jsp?id=<%=msg.getCodigoMensaje()%>"><%=msg.getTitulo()%></a>
	  			</td>
	  			<td><%=f.formatFecha(msg.getFecha(), "dd-MM-yyyy")%></td>
	  		</tr>
	  	<% 
	  		}
	  	%>
	  	<tr><td colspan="3">&nbsp;</td></tr>
		<%
  		if (paginas.getTotalPaginas() > 0)
  		{
		%>
		<tr>
			<td colspan="3">
				<table width="100%">
					<tr>
					   <td><a href="javascript:selectAll();">Seleccionar Todo</a></td>
	  		           <td align="right">
	  			            <INPUT class="botton" name="submit" type="submit" value="Eliminar" title="Eliminar mensajes seleccionados">
	  		            </td>
					</tr>
				</table>
			</td>
	  	</tr>
	  	<%
  		}
	  	%>
	  	<tr>
	  		<td colspan="3">
	  			<%=paginas.getPages() %>
	  		</td>
	  	</tr>
	  </table>
	  </form>
	  <%@ include file="../divFooter.jsp" %>
 	 </td></tr>
	 </table>
  </td>
  </tr>
  

</table>
 
<%@ include file="../footer.jsp"  %>
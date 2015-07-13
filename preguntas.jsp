<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import = "com.arango.common.beans.UserInfo"%>
<%@ page import = "com.arango.common.services.ManagerBean"%>
<%@ page import = "com.arango.common.beans.PreguntaUsuario"%>
<%@ page import = "java.util.ArrayList, java.util.Random"%>
<%@ page import = "com.arango.common.delegate.Manager"%>


<%@ include file="head.jsp"%>

<script language="javascript" src="../scripts/campos.js"></script>

<%@ include file="body.jsp"%>
 <br>
 
<%
    String admpregsec=(request.getParameter("admpregsec")!=null)? request.getParameter("admpregsec") :"false";
    PreguntaUsuario pregunta = null;
    ArrayList preguntas = null;
	Random r= new Random();
	r.setSeed(System.currentTimeMillis());
	int numero = -1;
    if("TRUE".equals(admpregsec.toUpperCase())){
    	session.setAttribute("teclado.virtual","1");
    }

    if (session.getAttribute("teclado.virtual") != null)
    {
    	String redireccionar = session.getAttribute("teclado.virtual").toString();
    	if (redireccionar.equals("0"))
    	{
			%>
			<script languaje="JavaScript">
			location.href='<html:rewrite page="/start.jsp"/>';
			</script>
			<% 
    	}
    }
    else
    {
		%>
		<script languaje="JavaScript">
		location.href='<html:rewrite page="/start.jsp"/>';
		</script>
		<% 
    }

    
	if (session.getAttribute("preg.secretas") != null)
    {
	   Manager manager = new Manager();
	   preguntas = (ArrayList)session.getAttribute("preg.secretas");
	   if (manager.getPreguntaStatus(session.getAttribute("user.id").toString())==2)
	   {
		   numero = r.nextInt(preguntas.size());
		   pregunta = (PreguntaUsuario)preguntas.get(numero);	   

%>

<html:form action="/preguntas" method="post">
<input type="hidden" name="secuencia" id="secuencia" value="<%=pregunta.getSecuencia()%>" />
<input type="hidden" name="admpregsec" id="admpregsec" value="<%=admpregsec%>" />
<input type="hidden" name="indice" id="indice" value="<%=numero%>" />

<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
<tr> 
	<td height="20" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> <!--td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
			<td><div align="left" class="login"><bean:message key="lbl.preg.secreta.titulo1"/></div></td-->
			<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
				<td width="100%"><div align="left" class="login"><bean:message key="lbl.preg.secreta.titulo1"/></div></td>
				<td width="8%"><div align="right"></div></td>
			
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr> 
	<td valign="top" align="center">
			    <%@ include file="divHeader.jsp"%>
		<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
		  <tr> 
			<td height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.preg.secreta.pregunta.responder"/></div></td>
			<td colspan="2" class="bienvenida">
			   <%
			   if (pregunta.getTipo() == 1)
			   {
				   if (pregunta.getNombreEtiqueta() != null)
				   {
					   %>
					   <bean:message key="<%=pregunta.getNombreEtiqueta()%>"/>
					   <% 
				   }
				   else
				   {
					   %>
					   <%=pregunta.getDescripcionPregunta()%>
					   <% 
				   }
			   }
			   else
			   {
				   %>
				   <%=pregunta.getDescripcionPregunta()%>
				   <% 
			   }
			   %>
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
		    </td>
		  </tr>
		 <tr> 
			<td height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.preg.secreta.respuesta.pregunta"/></div></td>
			<td colspan="2"><html:password property="respuesta" styleClass="botton-acceso" redisplay="false" styleId="clave"/> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
		  </tr>
		  <tr> 
			<td>&nbsp;</td>
			<td colspan="2">
			<html:submit styleClass="botton"><bean:message key="btn.enviar"/></html:submit> 
			</td>
		  </tr>
		</table>
		<%@ include file="divFooter.jsp"%>	
	 </td>
  </tr>
</table> 


 </html:form>
<%
	   }
	   else
	   {
			%>
			<script languaje="JavaScript">
			location.href='<html:rewrite page="/preguntasError.jsp"/>';
			</script>
			<% 
	   }
	}
	else
	{
		%>
		<script languaje="JavaScript">
		location.href='<html:rewrite page="/start.jsp"/>';
		</script>
		<% 
	}
%>
  <tr>
	<td height="20" valign="middle" class="texto-acceso" align="center"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
<tr><td height="20">&nbsp;</td></tr>
<%@ include file="footer.jsp" %> 
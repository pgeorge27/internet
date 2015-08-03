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

<div class="container">
	<div class="row">

		<div class="col-md-4 col-md-offset-1">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.preg.secreta.titulo1"/>
					</strong>
				</div>

				<div class="panel-body">
					<html:form action="/preguntas" method="post">
						<input type="hidden" name="secuencia" id="secuencia" value="<%=pregunta.getSecuencia()%>" />
						<input type="hidden" name="admpregsec" id="admpregsec" value="<%=admpregsec%>" />
						<input type="hidden" name="indice" id="indice" value="<%=numero%>" />

						<p>
							<bean:message key="lbl.preg.secreta.pregunta.responder"/><span>(<font color="#FF0000">*</font>)</span>
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
						</p>
						<p>
							<bean:message key="lbl.preg.secreta.respuesta.pregunta"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
						</p>
						<p>
							<html:password property="respuesta" styleClass="form-control" redisplay="false" styleId="clave"/>
						</p>
						<div align="center">
							<html:submit styleClass="btn btn-default"><bean:message key="btn.enviar"/></html:submit> 
						</div>
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
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="tit.title.ingreso.clave.token"/>
					</strong>
				</div>
				<div class="panel-body">
					<html:form method="post" action="/claveToken.do">
						<p><bean:message key="lbl.clave.token"/></p>
						<p><html:text property="claveToken" styleClass="form-control"  maxlength="8" styleId="claveToken"/></p>
						<div align="center">
						<p><input name="button" onclick="send();" type="button" class="btn btn-default" value='<bean:message key="btn.enviar"/>'></p>
						<p>
							<div id="teclado" style=" display:none; visibility: hidden;">
								<div id="lower" style="display: none;" ></div>
								<div id="upper"></div>
								<div id="cls" align="bo"></div>
							</div>
						</p>
						</div>
						<p></p>
                    </html:form>
				</div>
			</div>
		</div>
	</div>
</div>



<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
<tr> 
	<td height="20" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> <!--td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
			<td><div align="left" class="login"></div></td-->
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
			  <span class="texto-acceso">(<font color="#FF0000">*2</font>)</span>
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
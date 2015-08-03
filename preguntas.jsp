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

		<div class="col-md-6 col-md-offset-3">
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
							<bean:message key="lbl.preg.secreta.pregunta.responder"/><span> (<font color="#FF0000">*</font>)</span>
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
							<bean:message key="lbl.preg.secreta.respuesta.pregunta"/><span class="texto-acceso"> (<font color="#FF0000">*</font>)</span>
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
	</div>
</div>

<%@ include file="footer.jsp" %> 
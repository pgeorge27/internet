<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<html>
<head></head>
<body>
<%
  session.removeAttribute("validacion.movimientos.inicial");
%>
<html:form action="/declaracion/formulario" method="post">
	<html:hidden property="indice" value="<%=request.getParameter("indice") %>"/>
	<html:hidden property="cuenta" value="<%=request.getParameter("cuenta")%>"/>	
	<html:hidden property="ruta" value="<%=request.getParameter("ruta")%>"/>
	<html:hidden property="est" value="R"/>
	<html:hidden property="cfAnt" value="<%=request.getParameter("cfAnt")%>"/>
	<html:hidden property="seqAnt" value="<%=request.getParameter("seqAnt")%>"/>
	<html:hidden property="seqfAnt" value="<%=request.getParameter("seqfAnt")%>"/>
	<html:hidden property="seqdAnt" value="<%=request.getParameter("seqdAnt")%>"/>
	<html:hidden property="mf" value="<%=request.getParameter("mf") %>"/>
</html:form>
<script>
document.forms['formularioForm'].submit();
</script>
</body>
</html>
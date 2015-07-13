<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<html>
<head></head>
<body>
<%
  session.removeAttribute("validacion.movimientos.inicial");

%>
<html:form action="/formulario10/consultar/formulario" method="post">
	<html:hidden property="indice" value="<%=request.getParameter("indice") %>"/>
	<html:hidden property="cuenta" value="<%=request.getParameter("cuenta")%>"/>	
	<html:hidden property="ruta" value="<%=request.getParameter("ruta")%>"/>
</html:form>
<script>
document.forms['formularioForm'].submit();
</script>
</body>
</html>
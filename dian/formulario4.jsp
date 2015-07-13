<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<html>
<head></head>
<body>
<%
  session.removeAttribute("validacion.movimientos.inicial");
%>
<html:form action="/dian/consultar/formulario" method="post">
	<html:hidden property="indice" value="<%=request.getParameter("indice") %>"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>	
	<html:hidden property="unico" value="s"/>
</html:form>
<script>
document.forms['formularioForm'].submit();
</script>
</body>
</html>
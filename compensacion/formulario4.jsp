<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<html>
<head></head>
<body>
<%
  session.removeAttribute("validacion.movimientos.inicial");
  session.setAttribute("validacion.movimientos.inicial", "I");
  String var = (String) request.getParameter("indice");
%>
<html:form action="/declaracion/formulario" method="post">
	<html:hidden property="indice" value="<%=var %>"/>
	<html:hidden property="cuenta" value='<%=request.getParameter("cuenta")%>'/>	
	<html:hidden property="ruta" value='<%=request.getParameter("ruta")%>'/>
</html:form>
<script>
document.forms['formularioForm'].submit();
</script>
</body>
</html>
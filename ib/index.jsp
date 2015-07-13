<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<html:html>

<head>
<html:base />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta NAME="KEYWORDS" CONTENT="Banco; Costa Rica ; Bank; Finnance; Finanzas; ">
<meta NAME="DESCRIPTION" CONTENT="Banca por Internet, avanzado y moderno....">
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
</head>
<frameset framespacing="0" border="false" frameborder="0" rows="100%">
  <frame name="contenido" scrolling="auto" src="<html:rewrite page='/index2.jsp'/>">
</frameset>
</html:html>
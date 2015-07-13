<%@ page import="java.util.Enumeration" %>
<http>
<head></head>
<body>
<%
	session.setAttribute("nombre1", "Francisco");
	session.setAttribute("nombre2", "Ovidio");
	session.setAttribute("nombre3", "Jair");

	out.print("Parametro = " + request.getParameter("p"));
%>
</body>
</http>
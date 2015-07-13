<%@ page import="java.util.Enumeration, java.util.Hashtable" %>
<http>
<head></head>
<body>
<%
	session.setAttribute("nombre1", "Francisco");
	session.setAttribute("nombre2", "Ovidio");
	session.setAttribute("nombre3", "Jair");
	
	Hashtable h = new Hashtable();
	h.put("nombre3", "Francisco");
	h.put("nombre4", "Ovidio");
	h.put("nombre5", "Jair");
	
	Enumeration en = h.keys();
	while (en.hasMoreElements())
	{
		String objeto = en.nextElement().toString();
		out.print(objeto + " = " + h.get(objeto) + "<br>");
	}
	out.print("request path = " + request.getContextPath());
%>
</body>
</http>
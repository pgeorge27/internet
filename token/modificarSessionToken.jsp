<%
String id = request.getParameter("id");
String valor = request.getParameter("valor");
if (valor.equals("null"))
{
	session.setAttribute(id,null);
}
else
{
	session.setAttribute(id,valor);
}
out.println("aeiou");
%>
<%@ page language="java" 
contentType="text/html;charset=utf-8" 
import="java.util.*, java.io.*,
 com.arango.internet.banking.compensacion.reportes.*"%>
<%
String name = (String)session.getAttribute("frm3_4_10.nombre.documento");
response.addHeader("Content-disposition", name);
try
{
	InformesCuentasCompensacion report = (InformesCuentasCompensacion)session.getAttribute("frm3_4_10.formulario");
	out.print(report.toXML());
}
catch(Exception ex)
{
    ex.printStackTrace();
  out.println("There were errors on the form " + ex.toString() );
}
%>





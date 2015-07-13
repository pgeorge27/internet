<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@page import="com.arango.common.util.Format" %>
<%@page import="com.arango.internet.banking.EstadoCuenta" %>
<%@page import="com.arango.internet.banking.Movimiento" %>
<%@page import="com.arango.internet.banking.Titular" %>
<%@page import="com.arango.common.util.StringUtilities" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
String strFechaDesde = "";
String strFechaHasta = "";
Date desde = (Date)session.getAttribute("fecha.desde");
Date hasta = (Date)session.getAttribute("fecha.hasta");
if (desde != null){
    strFechaDesde = df.format(desde);
}
if (hasta != null){
    strFechaHasta = df.format(hasta);
}
String cuentaCSIC = (String)session.getAttribute("cuenta.csic");
%>
<html>
<head>
<script>
function __refresh(){
	document.forms['consultaEstadoForm'].submit();
}
</script>
</head>
<body onload="__refresh();">
<html:form method="post" action="/consulta/estado/autorizar">
<html:hidden property="estado" value="T"/>
<html:hidden property="tipo" value="3"/>
<html:hidden property="cuenta" value="<%=cuentaCSIC%>"/>
<html:hidden property="desde" value="<%=strFechaDesde%>"/>
<html:hidden property="hasta" value="<%=strFechaHasta%>"/>

</html:form>
</body>
</html>
<% session.setAttribute("selected", "custodia"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@page import="com.arango.common.util.Format" %>

<%@page import="com.arango.internet.banking.Custodia" %>


<%@page import="com.arango.common.util.StringUtilities" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%! Format f = Format.getFormat();




private String getDescEstado(String estado){
    if ("P".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente";
    }
    else if ("M".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente.elaborar";
    }
    else if ("A".equals(estado)){
        return "lbl.compensacion.consulta.estado.aprobado";
    }
    else if ("T".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente.aprobar";
    }
    else if ("X".equals(estado)){
        return "lbl.compensacion.consulta.estado.rechazado";
    }
    return "lbl.compensacion.consulta.estado.pendiente.elaborar";
}
%>
<%



java.util.ArrayList mov = (java.util.ArrayList)session.getAttribute("custodia");


Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);


String index= request.getParameter("index");


String mensaje="";

try{
	int i = Integer.parseInt(index);
	Custodia cus = null;
	cus = (Custodia)mov.get(i);
	mensaje = cus.getDetalle();
}catch (Exception ex)
{
	
	}
%>

<%@ include file="../head.jsp"%>
<script type="text/javascript">

function cerrar(){
	window.close();
}
</script>
</head>
<body>

<div id="estcta" align="left">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr>
	    <td class="texto-acceso"><%=mensaje %></td>
	  </tr>
      <tr>
										<td align="right"  ><input class="lgbutton" name="btnCerrar" type="button" value="Cerrar" OnClick="cerrar()"></td>
	</tr>
</table>
</div>
 
<%@ include file="../footer.jsp"  %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
String url = request.getContextPath()+"/dian/xml/"+ session.getAttribute("formulario")+ ".jsp";%>
<%@ include file="/head.jsp"%> 
<%@ include file="/body.jsp"%> 
    <div align="center" style="width:400px; height:200px;" class="tabla-acceso"> 
        <div align="center" style="margin:10%">
            <div>
            	<img alt="Exito" src="<html:rewrite page='/images/success.gif'/>">
            </div>
            <p class="bienvenida">Proceso realizado exitosamente</p>
        	<p class="bienvenida">El archivo XML ha sido generado. Haga click <a href="<html:rewrite page='/exporter/xml_frm3_4_10'/>">aquí</a> para descargar</p>
        </div>
    </div>

<%@ include file="/footer.jsp" %>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
String url = request.getContextPath()+"/dian/xml/"+ session.getAttribute("formulario")+ ".jsp";%>
<%@ include file="/head.jsp"%> 
<%@ include file="/body.jsp"%> 

<div class="container">
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

    <div class="col-md-6 col-md-offset-3">

        <div class="well">
          <div align="center">
            <p>
              <img alt="Exito" src="<html:rewrite page='/images/success.gif'/>">
            </p>
            <p class="bienvenida">Proceso realizado exitosamente</p>
			<p class="bienvenida">El archivo XML ha sido generado. Haga click <a href="<html:rewrite page='/exporter/xml_frm3_4_10'/>">aquí</a> para descargar</p>
          </div>
        </div>
    </div>
  </div>
</div>

<%@ include file="/footer.jsp" %>

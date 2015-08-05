<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ include file="/head.jsp"%> 
<script language=javascript>
function __retornar(){
	document.location="<html:rewrite page='/multipagos/CargaArchivo.jsp'/>"
}
</script>
<%@ include file="/body.jsp"%> 

<div class="container"> 
  <div class="row" style="padding-right: 3%; padding-left: 3%;"> 
    <div class="col-md-4 col-md-offset-4">
      <div class="panel panel-default" >
        <div class="panel-heading">
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>Operación Suspendida</strong>
        </div>
        <div class="panel-body">
          <div align="center">
            <img src="<html:rewrite page='/images/warning.gif'/>">
          </div>
          <p class="bienvenida">Los pagos procesados estan presentando errores favor contactar al Soporte Tecnico</p>
          <div align="center">
            <input class="botton btn btn-default" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<%@ include file="/footer.jsp" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ include file="/head.jsp"%> 

<%
 String tranferCounter =  (String)session.getAttribute("multipagos.transferencias.counters.total");
 String tranferInValid =  (String)session.getAttribute("multipagos.transferencias.counters.invalid");
 String tranferValid =    (String)session.getAttribute("multipagos.transferencias.counters.valid");
 
if (tranferCounter == null) {tranferCounter = "";}
if (tranferInValid == null) {tranferInValid = "";}
if (tranferValid == null) {tranferValid = "";}

session.removeAttribute("multipagos.transferencias.counters.total");
session.removeAttribute("multipagos.transferencias.counters.invalid");
session.removeAttribute("multipagos.transferencias.counters.valid");
%>
<script language=javascript>
function __retornar(){
	document.location="<html:rewrite page='/multipagos/CargaArchivo.jsp'/>"
}
</script>
<%@ include file="/body.jsp"%> 


<div class="container"> 
  <div class="row"> 
    <div class="col-md-4 col-md-offset-4">
      <div class="panel panel-default" >
        <div class="panel-body">
          <div align="center">
            <img src="<html:rewrite page='/images/success.gif'/>">
            <p class="bienvenida">Operación realizada</p>
          </div>
          <p class="bienvenida">Pagos Por archivo : <%=tranferCounter%></p>
          <p class="bienvenida">Pagos Procesados Correctamente  : <%=tranferValid%></p>
          <p class="bienvenida">Pagos no procesados   : <%=tranferInValid%></p>
          <div align="center">
          <input class="botton btn btn-default" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="/footer.jsp" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ include file="../../head.jsp"%>

<%@ include file="../../body.jsp" %>
	<br><br>
	<%
String fechaInicioStart=null;
String fechaFinalStart=null;
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
Calendar cal = Calendar.getInstance();
fechaFinalStart=df.format(cal.getTime());
cal.set(Calendar.DATE, 1); 
fechaInicioStart=df.format(cal.getTime());
%>
<html:form method="post" action="/consulta/estado">
	<html:hidden property="cuenta"/>
	<html:hidden property="estado" value="P"/>
	<html:hidden property="desde" value="<%=fechaInicioStart%>"/>
	<html:hidden property="hasta" value="<%=fechaFinalStart%>"/>
</html:form>
<script>
function _consulta(cta){
	document.forms["consultaEstadoForm"].cuenta.value=cta;
	document.forms["consultaEstadoForm"].submit();
}
</script>

<div class="container">
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

    <div class="col-md-4 col-md-offset-4">
      <div class="panel panel-default" >
        <div class="panel-heading" >
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>

          </strong>
        </div>

        <div class="panel-body">
          <div align="center">
            <img src="<html:rewrite page='/images/warning.gif'/>">

            <p>
              <bean:message key="lbl.compensacion.formulario.10.no.disponible"/>
            </p>

			<p>Si desea consultar los movimientos pendientes haga CLICK <a href="javascript:_consulta(<%=session.getAttribute("cuenta.formulario10") %>);">Aquí</a></p>

            <INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/formulario10/mant/cuenta.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<%@ include file="../../footer.jsp" %>

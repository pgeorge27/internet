<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="com.arango.internet.services.interfaces.ITransferencia"  %>

<%@ page import="org.apache.struts.action.ActionError"%>
<%@ page import="org.apache.struts.action.ActionErrors"%>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>

<%
int index = -1;
Object obj = session.getAttribute("indice.transferencia.modificacion");
String s = null;
if (obj != null)
    s = obj.toString();
if (s != null){
    try{
        index = Integer.parseInt(s);
    }
    catch(NumberFormatException e){
        index = -1;
    }
}
if (index < 0)
    response.sendRedirect("modificacion.jsp");
ArrayList data = (ArrayList)session.getAttribute("transferencias");
if (data == null)
    response.sendRedirect("modificacion.jsp");
if (data.size() < index)
    response.sendRedirect("modificacion.jsp");
TransferenciaInternacional transf = (TransferenciaInternacional)data.get(index);
String fecha=""; 
String secuencia= "";
Locale locale2 = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
Date today = new Date();
%>
<%@ include file="../head.jsp"%>
<script language="javascript">
function validateLength(obj, size){
    var str = _trim(obj.value);
	if (str.length >= size){
		event.returnValue = false;
	}
}
function __back(){
	document.location = "<html:rewrite page='/transferencias/modificacion.jsp'/>";
}
function __continue(){
	document.forms[0].tipo.value="<%=ITransferencia.MODIFICADA %>";
	document.forms[0].submit();
}
</script>
<%@ include file="../body.jsp"%>

<div class="container"> 
    <div class="row" style="padding-right: 3%; padding-left: 3%;">

      <div class="col-md-6 col-md-offset-3">
        <div class="panel panel-default" >
          <div class="panel-heading">
            <img src="<html:rewrite page='/images/logo_icon.png' />" />
            <strong>
              <bean:message key="lbl.transf.inter.recibo.modificacion"/>
            </strong>
          </div>
          <div class="panel-body">
            <div align="right">
              <input class="btn btn-default" onclick="document.forms[0].submit();" type="button" value="<bean:message key="lbl.retroceder"/>">
            </div>

            <html:form method="post" action="/autoriza">   
              <html:hidden property="tipo" value="<%=ITransferencia.MODIFICADA%>" />
              <html:hidden property="indice" value="<%=String.valueOf(index)%>"/>

              <p><bean:message key="lbl.transf.inter.fecha"/></p>

              <p class="bienvenida"><%=f.formatFechaLong(today, locale2)%></p>

              <p class="bienvenida"><bean:message key="lbl.transf.inter.secuencia"/></p>

              <p class="bienvenida"><%=StringUtilities.replace(f.formatCuenta(transf.getNumeroDocumento(), "A-S-C"), "-", "")%></p>
              <p class="bienvenida"><bean:message key="lbl.transf.inter.cuenta"/></p>
              <p class="bienvenida"><%=transf.getCuenta() != null ? f.formatCuenta(transf.getCuenta().getCodigoBanco()) : ""%></p>

              <p class="bienvenida"><bean:message key="lbl.transf.inter.cantidad"/></p>
              <p class="bienvenida"><%=f.formatMonto(transf.getMonto())%></p>

              <p class="bienvenida"><bean:message key="lbl.transf.inter.moneda"/></p>
              <p class="bienvenida"><%=StringUtilities.getValue(transf.getMoneda())%></p>

              <p class="bienvenida"><bean:message key="lbl.transf.inter.cuentaBeneficiario"/></p>
              <p class="bienvenida"><%=StringUtilities.getValue(transf.getCuentaBeneficiario())%> <%=StringUtilities.getValue(transf.getNombreBeneficiario())%></p>

              <p class="bienvenida"><bean:message key="lbl.transf.inter.motivo"/></p>
              <p class="bienvenida"><html:textarea property="motivo" styleId="motivo" cols="35" rows="5" onkeypress="validateLength(this, 100)" styleClass="form-control"/></p>

            </html:form>

            <div align="center">
              <input type="button" class="btn btn-default" value="<bean:message key="lbl.transf.inter.modificar"/>" onclick="__continue();">
              <input class="btn btn-default" onclick="__back()" type="button" value="<bean:message key="lbl.retroceder"/>">
            </div>

          </div>
        </div>
      </div>
    </div>
  </div>

<%@ include file="../footer.jsp" %>
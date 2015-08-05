<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="com.arango.internet.beans.TranferenciaProcesada"%>
<%@ page import="java.util.Locale" %>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>
<% 
String fecha=""; 
String secuencia= "";
%>

<%@ include file="../head.jsp"%>

<%

TranferenciaProcesada transf = (TranferenciaProcesada)session.getAttribute("transfer");
session.setAttribute("tmasivo", null);
session.setAttribute("transfer", null);
secuencia = (String)session.getAttribute("secuencia");
   
Locale locale2 = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
Date today = new Date();

String titulo = "lbl.transf.inter.recibo.aprobacion";
if (session.getAttribute("titulo.recibo") != null){
    titulo = (String)session.getAttribute("titulo.recibo");
}
%>
<%@ include file="../body.jsp"%>


<div class="container"> 
    <div class="row" style="padding-right: 3%; padding-left: 3%;">

    <html:form method="post" action="/multipagos/Consulta/autorizaciones">
      <html:hidden property="estado" value="P" /> 
      <html:hidden property="tipo" value="1" /> 
      <%
        String strConsultaTrans = session.getAttribute("consulta.transfer.cliente").toString();
      %>
      <html:hidden property="cliente" value="<%=strConsultaTrans%>"/>
    </html:form>

      <div align="right">
        <img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
      </div>
      <br>
      <br>
      <div height="26" width="100%" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
        <div  class="fuente-principal">
          <bean:message key="tit.title.atenticacion.paso3"/>
        </div>
      </div>
      <br>
      <br>
      <logic:present name="msg">
      <div align="center" class="well col-md-4">
        <p><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>"></p>
        <p><b><bean:message key="errors.header"/></b></p>
        <p class="fuente-principal">
          <%String error = session.getAttribute("msg").toString();%>
          <bean:message key="<%=error%>"/></p>
        </div>
      </logic:present>
      <%
      session.removeAttribute("msg");
      %>

      <div class="col-md-4 col-md-offset-4">
        <div class="panel panel-default" >
          <div class="panel-heading">
            <img src="<html:rewrite page='/images/logo_icon.png' />" />
            <strong>
             <bean:message key="<%=titulo%>"/>
            </strong>
          </div>
          <div class="panel-body">

            <div align="right">
              <input class="btn btn-default" onclick="document.forms[0].submit();" type="button" value="<bean:message key="lbl.retroceder"/>">
            </div>

            <p class="bienvenida"><bean:message key="lbl.transf.inter.fecha"/></p>
            <p class="bienvenida"><%=f.formatFechaLong(today, locale2)%></p></tr>
            <p class="bienvenida"><bean:message key="lbl.transf.inter.secuencia"/></p>
            <p class="bienvenida"><%=StringUtilities.replace(f.formatCuenta(transf.getNumeroDocumento(), "A-S-C"), "-", "")%></p>
            <p class="bienvenida"><bean:message key="lbl.transf.inter.cuenta"/></p>
            <p class="bienvenida"><%=StringUtilities.getValue(transf.getCuentaAbanks())%></p>
            <tr valign="middle" class="celda-clave1">
            <p class="bienvenida"><bean:message key="lbl.transf.inter.cantidad"/></p>
            <p class="bienvenida"><%=f.formatMonto(transf.getMonto())%></p>


            <p class="bienvenida"><bean:message key="lbl.transf.inter.moneda"/></p>
            <p class="bienvenida"><%=StringUtilities.getValue(transf.getMonedaAbanks())%></p>
            <p class="bienvenida"><bean:message key="lbl.transf.inter.cuentaBeneficiario"/></p>
            <p class="bienvenida"><%=StringUtilities.getValue(transf.getCuentabancoBeneficiario())%> <%=StringUtilities.getValue(transf.getNombreBeneficiario())%></p>

            <div align="center">
              <a href="javascript:printPage2()">
                <img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0">
              </a>
            </div>

            <input class="btn btn-default" onclick="document.forms[0].submit();" type="button" value="<bean:message key="lbl.retroceder"/>">

          </div>
        </div>
      </div>

      <logic:present name="mensaje.final">
        <script type="text/javascript">
          alert("<bean:message key='lbl.transf.inter.mensaje.final'/>");
        </script>
      </logic:present>

      <logic:present name="transferencia.pendiente.aprobacion">
        <script type="text/javascript">
          alert("<bean:message key='lbl.transf.inter.mensaje.transferencia.pendiente.aprobar'/>");
        </script>
      </logic:present>

    </div>
  </div>

<%@ include file="../footer.jsp" %>
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

TranferenciaProcesada transf = (TranferenciaProcesada)session.getAttribute("tmasivo");
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

					<p class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.fecha"/></p>
					<p class="bienvenida" width="70%"><%=f.formatFechaLong(today, locale2)%></p>

					<p class="bienvenida" width="30%"><bean:message key="lbl.monto.firma.cantidad.token.masivo"/></p>
					<p class="bienvenida"><%=transf.getNumRegistro()%></p>

					<p class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.cuenta"/></p>
					<p class="bienvenida"><%=StringUtilities.getValue(transf.getCuentaAbanks())%></p>

					<p class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.cantidad"/></p>
					<p class="bienvenida"><%=f.formatMonto(transf.getMonto())%></p>

					<p class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.moneda"/></p>
					<p class="bienvenida"><%=StringUtilities.getValue(transf.getMonedaAbanks())%></p>

					<div align="center">
						<a href="javascript:printPage2()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a>
					</div>

					<td colspan="2" align="center">
						<input class="btn btn-default" onclick="document.forms[0].submit();" type="button" value="<bean:message key="lbl.retroceder"/>">
					</td>

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
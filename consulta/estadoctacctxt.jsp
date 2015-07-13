<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.arango.common.util.Format"%>
<%@page import="com.arango.internet.banking.Titular"%>
<%@page import="com.arango.internet.banking.EstadoCuenta"%>
<%@page import="com.arango.internet.banking.Movimiento"%>
<%@page import="com.arango.common.util.StringUtilities" %>

<%! Format f = Format.getFormat();
private String getDescripcion(String text){
    if (text == null)
		return "";
    String temp = StringUtilities.replace(text, "\"","&#034;");
    temp = StringUtilities.replace(temp, "\n", "\\n");
    temp = StringUtilities.replace(temp, "\r", "\\r");
    temp = StringUtilities.replace(temp, "\"", "\\\"");
    temp = StringUtilities.replace(temp, "'", "\\'");
    temp = temp.replace('\n', ' ');
    temp = temp.replace('\r', ' ');

    return temp;
}
 private String formatDocument(String doc){
      String year = doc.substring(doc.length() - 2, doc.length());
      String num = doc.substring(2, doc.length()- 2);
      return num+"-"+year;  
    }
%>
<%
response.setContentType("text/plain");
response.addHeader("Content-disposition", "inline; filename=statement.txt" );

EstadoCuenta ec = (EstadoCuenta)session.getAttribute("estado.cta");
if (ec == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/ib/systemError2.jsp");   
}

ArrayList clientes = ec.Titulares;
ArrayList Movimientos = ec.Movimientos;
String titulares="";
String codigoCliente = "";
if (clientes.size() > 0){
  titulares=((Titular)clientes.get(0)).getNombre();
  codigoCliente=((Titular)clientes.get(0)).getCodigoCliente();
}  

%>


<bean:message key="tit.title.consulta.estado.cuenta.cc"/>

<bean:message key="lbl.desde"/>,<%=f.formatFecha((java.util.Date)ec.getFechaInicio())%>
<bean:message key="lbl.hasta"/>,<%=f.formatFecha((java.util.Date)ec.getFechaFin())%>
<bean:message key="lbl.cuenta.corriente"/>,<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>
<bean:message key="lbl.titular"/>,<%=((Titular)ec.Titulares.get(0)).getNombre()%>
<bean:message key="lbl.moneda"/>,<%=ec.getMoneda()%>
<bean:message key="lbl.saldo.inicio.mes"/>,<%=f.formatMonto(ec.getSaldoAnterior())%>
<bean:message key="lbl.total.cheques.otros.debitos" arg0="<%=String.valueOf(ec.getCantidadDebitos())%>"/>,<%=f.formatMonto(ec.getTotalDebitos())%>
<bean:message key="lbl.total.depositos.otros.creditos" arg0="<%=String.valueOf(ec.getCantidadDepositos())%>"/>,<%=f.formatMonto(ec.getTotalDepositos())%>
<bean:message key="lbl.cc.saldo.fecha"/>,<%=f.formatMonto(ec.getSaldoTotal())%>
<bean:message key="lbl.cc.saldo.reserva"/>,<%=f.formatMonto(ec.getSaldoTransito())%>
<bean:message key="lbl.cc.saldo.disponible"/>,<%=f.formatMonto(ec.getSaldoDisponible())%>

<bean:message key="lbl.est.cta.fecha.valida"/>,<bean:message key="lbl.fecha"/>,<bean:message key="lbl.descripcion"/>,<bean:message key="lbl.referencia"/>,<bean:message key="lbl.est.cta.monto"/>,<bean:message key="lbl.est.cta.detalle.saldo"/>	  
<%
String styleClass = "";
ArrayList mov = Movimientos;
Movimiento m = null;
double monto =  0;
for (int i = 0; i < mov.size(); i++){
	m = (Movimiento)mov.get(i);
	if ("D".equals(m.getTipoTransaccion()))
		monto = m.getMonto() * -1;
	else{
		monto = m.getMonto();
	}		
%>
<%=f.formatFecha(m.getFechaValida())%>,<%=f.formatFecha(m.getFecha())%>,<%=m.getDescripcion()%>,<%=m.getNumeroDocumento()==null?"":m.getNumeroDocumento()%>,<%=f.formatMonto(monto)%>,<%=f.formatMonto(m.getSaldo())%>
<%} /* End for - loop */ %>  
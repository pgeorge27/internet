<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.util.Locale" %>
<%@ page import="java.text.*" %>
<%@page import="com.arango.internet.banking.CuentaPrestamo"%>
<%@page import="com.arango.common.util.Format"%>

<%! Format f = Format.getFormat();
    public String formatPorcentaje(double monto) {
        Locale locale = new Locale("en", "US");
        String pattern = "##0.0000 %";
        StringBuffer buffer = null;
        try {
            NumberFormat nf = NumberFormat.getNumberInstance(locale);
            DecimalFormat df = (DecimalFormat) nf;
            df.applyPattern(pattern);
            return df.format(monto / 100);
        } catch (Exception e) {
            return String.valueOf(monto);
        }

    }%>
<%
CuentaPrestamo cta = (CuentaPrestamo)session.getAttribute("consulta");
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (cta == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/ib/systemError2.jsp");   
}
String backPage="";
if (request.getParameter("backPage") != null)
  backPage=(String)request.getParameter("backPage");  

%>

<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>

<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr> 
		<td height="30" class="texto-acceso"><div id=bankdiv align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>"></div></td>
		<td class="texto-acceso"><div align="right">&nbsp;</div></td>
	  </tr>
	  <tr> 
		<td height="40" colspan="2" valign="bottom"><div align="left"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" >
			  <tr> 
            <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
				<td width="92%"><div align="left" class="login"><bean:message key="tit.consulta.saldo.pr"/></div></td>
			  </tr>
			</table>
		  </div></td>
	  </tr>
	  <tr> 
		<td valign="top" align="center" colspan="2"><div align="center">
		<%@ include file="../divHeader.jsp"%>
			<table width="100%" border="0" cellspacing="1" cellpadding="0">                   
				<tr> 
				  <td height="20" class="catra-texto" align="center">
					<table width="100%" border="0" cellpadding="2" cellspacing="2" >
					  <tr> 
						<td width="20%" height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.numero.prestamo"/></div></td>
			    <td width="35%" height="15" class="bienvenida" align="right"><%=f.formatCuenta(cta.getNumeroCuenta())%></td>
				<td width="25%" align="right"></td>
				<td width="15%" align="right"></td>
		  </tr>
		  <tr>
			<td  height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.moneda"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=cta.getMoneda()%></td>
		  </tr>
		  <tr>
			<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.nombre"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=cta.getNombre()%></td>
		   </tr>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.fecha.desembolso"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatFecha(cta.getFechaDesembolso(), locale)%></td>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso" nowrap><bean:message key="lbl.pr.fecha.proximo.vencimiento"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatFecha(cta.getFechaProximoVencimiento(), locale)%></td>
   </tr>
   <tr>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.valor.inicial"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getMontoInicial())%></td>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.capital.vencido"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getCapitalVencido())%></td>
   </tr>
   <tr>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.saldo.actual"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getSaldoActual())%></td>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.capital.vencer"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getCapitalAVencer())%></td>
   </tr>
   <tr>
	<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.pr.fecha.vencimiento.final"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatFecha(cta.getFechaVencimiento(), locale)%></td>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.interes.vencido"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getInteresVencido())%></td>
   </tr>
   <tr>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.tasa.interes"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=formatPorcentaje(cta.getTasaInteres())%></td>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.interes.vencer"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getInteresPorVencer())%></td>
   </tr>
   <tr>
	<td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.pr.periodicidad.intereses"/></div></td>
			    <td height="15" class="bienvenida" align="right" nowrap><%=cta.getPeriodicidadInteres()%></td>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.saldo.total"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=f.formatMonto(cta.getDeudaTotal())%></td>
   </tr>
   <tr>
	<td height="15" class="celda-clave1"><div align="right"  nowrap class="texto-acceso"><bean:message key="lbl.pr.periodicidad.capital"/></div></td>
			    <td height="15" class="bienvenida" align="right"><%=cta.getPeriodicidadCapital()%></td>
   </tr>
</table>
   
<table width="100%" border="0" cellpadding="2" cellspacing="2" class="linea-botton">   
 	<TD><div align="left" class="subtitulos"><br><bean:message key="lbl.pr.detalle.interes"/></div>
	</TD></TR>
</table>
   
<table width="100%" border="0" cellpadding="2" cellspacing="2">  
  <tr>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.interes.por.vencer"/></div></td>
			    <td height="15" class="bienvenida" align="center"><bean:message key="lbl.pr.rango" arg0="<%=f.formatFecha(cta.getInteresPorVencerDesde(), locale)%>" arg1="<%=f.formatFecha(cta.getInteresPorVencerHasta(), locale)%>"/></td>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.numero.dias"/></div></td>
			    <td height="15" class="bienvenida" align="center"><%=cta.getDiasPorVencer()%></td>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.tasa"/></div></td>
			    <td height="15" align="right" class="bienvenida" nowrap><%=formatPorcentaje(cta.getTasaPorVencer())%></td>
  </tr>
 <tr>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.interes.vencido"/></div></td>
			    <td height="15" class="bienvenida" align="center" nowrap>
<% if (cta.getInteresVencidoDesde() != null){%>
    <bean:message key="lbl.pr.rango" arg0="<%=f.formatFecha(cta.getInteresVencidoDesde(), locale)%>" arg1="<%=f.formatFecha(cta.getInteresVencidoHasta(), locale)%>"/></td>
<%}else{%>
    &nbsp;&nbsp;</td>
<%}%>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.numero.dias"/></div></td>
			    <td height="15" class="bienvenida" align="center">
<% if (cta.getInteresVencidoDesde() != null){%>
  	<%=cta.getCantDiasVencido()%></td>
<%}else{%>
	&nbsp;</td>
<%}%>
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.pr.tasa"/></div></td>
			    <td height="15" class="bienvenida" align="right">
<% if (cta.getInteresVencidoDesde() != null){%>
	<%=formatPorcentaje(cta.getTasaInteresVencido())%></td>
<%}else{%>
     &nbsp;</td>
<%}%>
  </tr>  
  </table>
   
<table width="100%" border="0" cellpadding="2" cellspacing="2">  
  <tr><td valign="top" class="texto-acceso" colspan="4"><br><div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div></td>
	</tr>
	<tr> 
		<td valign="top" class="texto-acceso" colspan="4"><div align="center"><br>
				<INPUT class="botton" onclick="retornar()" type=button value="<bean:message key="lbl.retroceder"/>"> </td></tr>
      </TABLE>  
</TD></tr></table>
<%@ include file="../divFooter.jsp"%>



<SCRIPT language="Javascript">
  function retornar(){
   window.location.href="<html:rewrite page='/servicios/seleccionso.jsp?prod=PR'/>";
  }
</script>


<%@ include file="../footer.jsp"  %>
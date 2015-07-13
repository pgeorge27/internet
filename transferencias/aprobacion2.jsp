<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
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

TransferenciaInternacional transf = (TransferenciaInternacional)session.getAttribute("transfer");

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
<html:form method="post" action="/query2">
<html:hidden property="estado" /> 
<%
   String strConsultaTrans = session.getAttribute("consulta.transfer.cliente").toString();
 %>
<html:hidden property="cliente" value="<%=strConsultaTrans%>"/>
</html:form>

<div align="center"> 
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="92%">
				<div align="left" class="login"><bean:message key="<%=titulo%>"/></div></td>
			<td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="document.forms[0].submit();" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
		  </tr>
		</table></td>
  </tr>
<tr> 
	<td class="texto-acceso"></td>
  </tr>
  <tr> 
	<td valign="top">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="2">
        
        
		  <tr valign="middle">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.fecha"/></td>
					<td class="bienvenida" width="70%"><%=f.formatFechaLong(today, locale2)%></td></tr>
            <tr valign="middle" class="celda-clave1">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.secuencia"/></td>
                   <td class="bienvenida"><%=StringUtilities.replace(f.formatCuenta(transf.getNumeroDocumento(), "A-S-C"), "-", "")%></td></tr>                      
            <tr valign="middle">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.cuenta"/></td>
                   <td class="bienvenida"><%=transf.getCuenta() != null ? f.formatCuenta(transf.getCuenta().getCodigoBanco()) : ""%></td></tr>
             <tr valign="middle" class="celda-clave1">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.cantidad"/></td>
                   <td class="bienvenida"><%=f.formatMonto(transf.getMonto())%></td></tr>     
             <tr valign="middle">
        			<td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.moneda"/></td>
                   <td class="bienvenida"><%=StringUtilities.getValue(transf.getMoneda())%></td></tr>                   
            <tr valign="middle" class="celda-clave1">
		           <td class="bienvenida" width="30%"><bean:message key="lbl.transf.inter.cuentaBeneficiario"/></td>
                   <td class="bienvenida"><%=StringUtilities.getValue(transf.getCuentaBeneficiario())%> <%=StringUtilities.getValue(transf.getNombreBeneficiario())%></td></tr>

<tr>
<td colspan="2" align="center"><br><br>

<div align="center"><a href="javascript:printPage2()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
<tr>
<td colspan="2" align="center">
<INPUT class="botton" onclick="document.forms[0].submit();" type="button" value="<bean:message key="lbl.retroceder"/>">


</td></tr></table></td></tr></table></div>


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
<%@ include file="../footer.jsp" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.internet.beans.TranferenciaProcesada"%>
<%@ page import="com.arango.common.beans.DetalleTransferencia"%>
<%@ page import="com.arango.internet.services.interfaces.ITransferencia"  %>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="java.util.Locale" %>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
private String getNivelAutorizacion(String estado){
    if (estado == null){
        return "lbl.transf.inter.estado.no.definido";
    }
    if ("A".equals(estado)){
        return "lbl.transf.inter.autorizada";
    }
    else if ("P".equals(estado)){
        return "lbl.transf.inter.pendiente";
    }
    else if ("D".equals(estado)){
        return "lbl.transf.inter.no.autorizada";
    }
    else
    if (estado.equals("R")) {
        return "lbl.transf.inter.rechazada";
    }
    
    return "lbl.transf.inter.estado.no.definido";
}
private String getDescEstado(String estado){
    if (estado == null){
        return "lbl.transf.inter.estado.no.definido";
    }
    
    if (ITransferencia.APROBADA.equals(estado)){
        return "lbl.transf.inter.aprobada";
    }
    else if (ITransferencia.MODIFICADA.equals(estado)){
        return "lbl.transf.inter.pendiente";
    }
    else if (ITransferencia.PENDIENTE.equals(estado)){
        return "lbl.transf.inter.pendiente";
    }
    else if (ITransferencia.RECHAZADA.equals(estado)){
        return "lbl.transf.inter.rechazada";
    }
    else if (ITransferencia.EN_PROCESO.equals(estado)){
        return "lbl.transf.inter.en.proceso";
    }
    else if (ITransferencia.PROCESADA.equals(estado)){
        return "lbl.transf.inter.completada";
    }
    else if (ITransferencia.RECHAZADA_BANCO.equals(estado)){
        return "lbl.transf.inter.rechazada.banco";
    }
    return "lbl.transf.inter.estado.no.definido";
}
%>
<%@ include file="../head.jsp"  %>

<%@ include file="../body.jsp"%>
<%Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr> 
	 <td height="40" valign="bottom"><div align="center"> 
		 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		   <tr> 
			 <td width="92%">
				<div align="left" class="login">Consulta Tranferencias Multipagos</div></td>
			<td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="document.location='<html:rewrite page='/multipagos/pconsultaMultipagos.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
<logic:present name="consulta.clte">
<tr><td class="bienvenida"><strong><%=session.getAttribute("consulta.clte") %></strong></td></tr>

</logic:present>
<tr><td>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <TR class="tabla-acceso">
    <TD class="texto-acceso" width="5%"><bean:message key="lbl.transf.inter.secuencia"/></TD>
    <TD class="texto-acceso" width="7%">Fecha Efectiva</TD>
    <TD class="texto-acceso" width="7%"><bean:message key="lbl.transf.inter.cantidad"/></TD>
    <TD class="texto-acceso" width="12%"><bean:message key="lbl.moneda"/></TD> 
    <TD class="texto-acceso" width="10%">Beneficiario</TD>
    <TD class="texto-acceso" width="10%"><bean:message key="lbl.beneficiario.cuenta"/></TD>
	<TD class="texto-acceso" width="10%"><bean:message key="lbl.transf.inter.elaborador.por"/></TD>
    <TD class="texto-acceso" width="5%"><bean:message key="lbl.transf.inter.estado"/></TD>
    <TD class="texto-acceso" width="25%"><bean:message key="lbl.transf.inter.nivel.aprobacion"/></TD>  
  <TR>
    <TD colspan="8"></TD>
    <TD class="texto-acceso"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    						  <tr class="tabla-acceso">
    						  	  <td class="texto-acceso" width="30%"><bean:message key="lbl.transf.inter.aprobado.por"/></td>
    						      <td class="texto-acceso" width="30%"><bean:message key="lbl.transf.inter.fecha.aprobacion"/></td>
    						      <td class="texto-acceso" width="10%"><bean:message key="lbl.transf.inter.tipo.relacion"/></td>
    						      <td class="texto-acceso" width="30%"><bean:message key="lbl.transf.inter.estado"/></td></tr>
    						  </table></td></tr>  
<%
ArrayList data = (ArrayList)session.getAttribute("transferencias");
String styleClass = "";
if (data != null){
    TranferenciaProcesada t = null;
    String fecha = null;
    String aprobadorStr = null;
    DetalleTransferencia detalle = null;
    for (int i = 0; i < data.size(); i++){
	if (i % 2 == 0)
		styleClass = "";
	else
		styleClass = "class=\"celda-clave1\"";
        
		t = (TranferenciaProcesada)data.get(i);
        if (t.getDetalle() != null && t.getDetalle().size() > 0){
            StringBuffer buffer = new StringBuffer();
            buffer.append("<table width=\"100%\">");
            for (int j = 0; j < t.getDetalle().size(); j++){
	            detalle = (DetalleTransferencia) t.getDetalle().get(j);	 	            
	            buffer.append("<tr><td class=\"bienvenida\" width=\"30%\">");
	            buffer.append(detalle.getUsername());
	            buffer.append("</td><td class=\"bienvenida\" width=\"30%\">");
	            buffer.append(f.formatFecha(detalle.getFechaAprobacion(), locale));
	            buffer.append("</td><td class=\"bienvenida\" width=\"10%\">");
	            buffer.append(detalle.getTipoRelacion());
	            buffer.append("</td><td class=\"bienvenida\" width=\"30%\" nowrap>");
	            buffer.append(com.arango.internet.tag.TagUtil.getString(pageContext, getNivelAutorizacion(detalle.getEstado())));	            
	            buffer.append("</td></tr>");
            }
            buffer.append("</table>");
            aprobadorStr = buffer.toString();
        }
        else{
            fecha = "";
            aprobadorStr = "";
        }
%>
<tr valign="middle" <%=styleClass%>>
        <td class="bienvenida"><a href="<html:rewrite page='/multipagos/detalleCon.jsp'/>?w=<%=i%>&t=1"><%=StringUtilities.replace(f.formatCuenta(t.getNumeroDocumento(), "A-S-C"), "-", "")%></a></td>
        <td class="bienvenida"><%=f.formatFecha(t.getFechaValor(), locale)%></td>
        <td class="bienvenida" align="right"><%=f.formatMonto(t.getMonto())%></td>
        <td class="bienvenida"><%=t.getMonedaAbanks() %></td>  
        <td class="bienvenida"><%=t.getNombreBeneficiario()==null?"":t.getNombreBeneficiario()%></td> 
		<td class="bienvenida"><%=t.getCuentabancoBeneficiario	()==null?"":t.getCuentabancoBeneficiario()%></td> 
		<td class="bienvenida"><%=t.getAdicionadoPor() == null ? "" : t.getAdicionadoPor()%></td>	
		<td class="bienvenida" nowrap><bean:message key="<%=getDescEstado(t.getEstado())%>"/></td>
        <td class="bienvenida"><%=aprobadorStr%></td> 	
		<td class="bienvenida"><%=t.getDescripcionRechazo() == null ? StringUtilities
										.getValue(t.getMotivo())
										: t.getDescripcionRechazo()%></td>		
</tr>
<%
   } /* End  for*/
} /* End if */ %>  
</TABLE>
<br>
<div align="center">
<INPUT class="botton" onclick="document.location='<html:rewrite page='/multipagos/pconsultaMultipagos.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
</tr></table>

<%@ include file="../footer.jsp"  %>
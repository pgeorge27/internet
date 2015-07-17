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

<div class="container"> 
    <div class="row">
        <div class="table-responsive">
            <div class="col-md-6">
                <p class="bienvenida_1">
                    <img src="<html:rewrite page='/images/gancho.gif'/>" border="0">
                    <strong>Consulta Tranferencias Multipagos</strong>
                </p>
            </div>
            <div class="col-md-6">
                <div align="right">
                    <input class="botton btn btn-default" onclick="document.location='<html:rewrite page='/multipagos/pconsultaMultipagos.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>">
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <logic:present name="consulta.clte">
            <p class="bienvenida"><strong><%=session.getAttribute("consulta.clte") %></strong></p>
        </logic:present>

        <div id="no-more-tables">
            <table class="col-md-12 table-bordered table-striped table-condensed cf">
                <thead class="cf">
                    <tr class="tabla-acceso">
                        <td class="texto-acceso" width="5%">
                            <bean:message key="lbl.transf.inter.secuencia"/>
                        </td>
                        <td class="texto-acceso" width="7%">Fecha Efectiva
                        </td>
                        <td class="texto-acceso" width="7%">
                            <bean:message key="lbl.transf.inter.cantidad"/>
                        </td>
                        <td class="texto-acceso" width="12%">
                            <bean:message key="lbl.moneda"/>
                        </td> 
                        <td class="texto-acceso" width="10%">Beneficiario
                        </td>
                        <td class="texto-acceso" width="10%">
                            <bean:message key="lbl.beneficiario.cuenta"/>
                        </td>
                        <td class="texto-acceso" width="10%">
                            <bean:message key="lbl.transf.inter.elaborador.por"/>
                        </td>
                        <td class="texto-acceso" width="5%">
                            <bean:message key="lbl.transf.inter.estado"/>
                        </td>
                        <td class="texto-acceso" width="25%">
                            <bean:message key="lbl.transf.inter.nivel.aprobacion"/>
                        </  td>  
                        <tr>
                            <td colspan="8">
                            </td>
                            <td class="texto-acceso">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr class="tabla-acceso">
                                        <td class="texto-acceso" width="30%">
                                            <bean:message key="lbl.transf.inter.aprobado.por"/>
                                        </td>
                                        <td class="texto-acceso" width="30%">
                                            <bean:message key="lbl.transf.inter.fecha.aprobacion"/>
                                        </td>
                                        <td class="texto-acceso" width="10%">
                                            <bean:message key="lbl.transf.inter.tipo.relacion"/>
                                        </td>
                                        <td class="texto-acceso" width="30%">
                                            <bean:message key="lbl.transf.inter.estado"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </thead>
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
                                <td class="bienvenida"><%=t.getCuentabancoBeneficiario  ()==null?"":t.getCuentabancoBeneficiario()%></td> 
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
            </table>
            <br>
        </div>
    </div>
    <div align="center">
        <input class="botton btn btn-default" onclick="document.location='<html:rewrite page='/multipagos/pconsultaMultipagos.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>">
    </div>
</div>

<%@ include file="../footer.jsp"  %>
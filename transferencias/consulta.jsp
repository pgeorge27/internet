<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
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
	else if (estado.equals("C")) {
        return "lbl.transf.inter.completada";
    }
    return "lbl.transf.inter.estado.no.definido";
}
%>
<!DOCTYPE html>
<html:html>

<head>
<%@ include file="../head.jsp"  %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>
<%@ include file="../body.jsp"%>

<body>


<div class="container">

	<div class="row">
		<div>
			<div class="panel panel-default" >
				<div class="panel-heading">
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong><bean:message key="lbl.transf.inter.consulta"/></strong>
				</div>

</div>

</div>

</div>


<%Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr> 
	 <td height="40" valign="bottom"><div align="center"> 
		 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		   <tr> 
			 <td width="92%">
				<div align="left" class="login"></div></td>
			<td width="8%"><div align="right">&nbsp;
							<INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/servicios/transferencias.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
		  </tr>
		</table>
		<br>
	  </div></td>
  </tr>
<logic:present name="consulta.clte">
<tr><td class="bienvenida"><strong><%=session.getAttribute("consulta.clte") %></strong></td></tr>

</logic:present>
<tr><td>
<div id="no-more-tables">
<table class="col-md-12 table-bordered table-striped table-condensed cf">
<thead class="cf">
  <TR class="tabla-acceso">
    <TD class="texto-acceso" ><bean:message key="lbl.transf.inter.secuencia"/></TD>
    <TD class="texto-acceso" ><bean:message key="lbl.transf.inter.fecha.elaboracion"/></TD>
    <TD class="texto-acceso" >Fecha Efectiva</TD>
    <TD class="texto-acceso" ><bean:message key="lbl.transf.inter.cantidad"/></TD>
    <TD class="texto-acceso" ><bean:message key="lbl.moneda"/></TD> 
    <TD class="texto-acceso" ><bean:message key="lbl.transf.inter.cuenta"/></TD>
    <TD class="texto-acceso" ><bean:message key="lbl.transf.inter.elaborador.por"/></TD>
    <TD class="texto-acceso" ><bean:message key="lbl.transf.inter.estado"/></TD>
    <TD class="texto-acceso" ><bean:message key="lbl.transf.inter.nivel.aprobacion"/></TD>
    <TD class="texto-acceso" ><bean:message key="lbl.transf.inter.comentario"/></TD></TR>
  <TR>
    <TD colspan="8"></TD>
    <TD class="texto-acceso"><table width="100%" border="0" cellspacing="0" cellpadding="0">
    						  <tr class="tabla-acceso">
    						  	  <td class="texto-acceso" ><bean:message key="lbl.transf.inter.aprobado.por"/></td>
    						      <td class="texto-acceso" ><bean:message key="lbl.transf.inter.fecha.aprobacion"/></td>
    						      <td class="texto-acceso" ><bean:message key="lbl.transf.inter.tipo.relacion"/></td>
    						      <td class="texto-acceso" ><bean:message key="lbl.transf.inter.estado"/></td></tr>
    						  </table></td></tr>  </thead>
<%
ArrayList data = (ArrayList)session.getAttribute("transferencias");
String styleClass = "";
if (data != null){
    TransferenciaInternacional t = null;
    String fecha = null;
    String aprobadorStr = null;
    DetalleTransferencia detalle = null;
    for (int i = 0; i < data.size(); i++){
	if (i % 2 == 0)
		styleClass = "";
	else
		styleClass = "class=\"celda-clave1\"";
        t = (TransferenciaInternacional)data.get(i);
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
        <td data-title="Referencia"  class="bienvenida"><a href="<html:rewrite page='/transferencias/detalle.jsp'/>?w=<%=i%>&t=1"><%=StringUtilities.replace(f.formatCuenta(t.getNumeroDocumento(), "A-S-C"), "-", "")%></a></td>
        <td data-title="Fecha Elaboración"  class="bienvenida"><%=f.formatFecha(t.getFechaElaboracion(), locale)%></td>
         <td data-title="Fecha Efectiva" class="bienvenida"><%=f.formatFecha(t.getFecha(), locale)%></td>
        <td data-title="Cantidad - Amount" class="bienvenida" align="right"><%=f.formatMonto(t.getMonto())%></td>
        <td data-title="Moneda" class="bienvenida"><%=t.getMoneda() %></td>  
        <td data-title="Número de Cuenta - Account Number" class="bienvenida"><%=f.formatCuenta(t.getCuenta().getCodigoBanco(), "C") %></td>  
        <td data-title="Elaborador por" class="bienvenida"><%=t.getUsuarioPrepara()==null?"":t.getUsuarioPrepara()%></td>   
        <td data-title="Estado" class="bienvenida" nowrap><bean:message key="<%=getDescEstado(t.getEstado())%>"/></td>
        <td data-title="Nivel de Autorización" class="bienvenida"><%=aprobadorStr%></td>                        
        <td data-title="Comentario" class="bienvenida"><%=t.getDescripcionRechazo()==null?StringUtilities.getValue(t.getMotivo()):t.getDescripcionRechazo()%></td>        
</tr>
<%
   } /* End  for*/
} /* End if */ %>  
</table>
<br>
</div>
<br>
<div align="center">
<br>
<INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/servicios/transferencias.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
</tr></div></table>

<%@ include file="../footer.jsp"  %>

</div>
</body>
</html:html>
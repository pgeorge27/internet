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
<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
ArrayList data = (ArrayList)session.getAttribute("transferencias");
int counter = 0;
if (data != null){
    counter = data.size();
}
%>
<%@ include file="../head.jsp"  %>
<script type="text/javascript">

function __update(){
	document.forms[0].submit();
}
</script>
<%@ include file="../body.jsp"%>

<br>
<logic:messagesPresent>
  <table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
	<span class="bienvenida">
		<table width="80%">
		<html:messages id="error">					
			<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
		</html:messages>
		</table>
	</span><br>
								   </td></tr>
			 </table></td></tr>
		  </table>
</logic:messagesPresent>
<div align="center"> 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="92%">
				<div align="left" class="login"><bean:message key="lbl.transf.inter.modificacion"/></div></td>
			<td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="document.location='<html:rewrite page='/servicios/modificacion.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
		  </tr>
		</table></td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  	
<logic:present name="consulta.clte">
<tr><td class="bienvenida"><strong><%=session.getAttribute("consulta.clte") %></strong></td></tr>
</logic:present>            
<tr><td>
<br>
<div align="left">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<html:form method="post" action="/update">        
  <tr> 
  <td colspan="4">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td width="31%" height="20"></td>
	<td width="34%" nowrap></td>
	<td width="35%"><div align="right"></div></td></tr></table>
	</td></tr>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
  <TR class="tabla-acceso">
<TD class="texto-acceso" width="5%"><bean:message key="lbl.transf.inter.secuencia"/></TD>
    <TD class="texto-acceso" width="5%"><bean:message key="lbl.transf.inter.fecha.elaboracion"/></TD>
    <TD class="texto-acceso" width="5%">Fecha Efectiva</TD>
    <TD class="texto-acceso" width="10%"><bean:message key="lbl.transf.inter.cantidad"/></TD>  
    <TD class="texto-acceso" width="5%"><bean:message key="lbl.moneda"/></TD> 
    <TD class="texto-acceso" width="10%"><bean:message key="lbl.transf.inter.cuenta"/></TD>
    <TD class="texto-acceso" width="10%"><bean:message key="lbl.transf.inter.elaborador.por"/></TD>
    <TD class="texto-acceso" width="5%"><bean:message key="lbl.transf.inter.estado"/></TD>
    <TD class="texto-acceso" width="30%"><bean:message key="lbl.transf.inter.nivel.aprobacion"/></TD>
    <TD class="texto-acceso" width="20%"><bean:message key="lbl.transf.inter.comentario"/></TD></TR>
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

String styleClass = "";

if (data != null){
    counter = data.size();
    TransferenciaInternacional t = null;
    String aprobadorStr = null;
    DetalleTransferencia detalle = null;
    boolean aprobacion = true;
    String url = null;
    for (int i = 0; i < data.size(); i++){
        t = (TransferenciaInternacional)data.get(i);
		if (i % 2 == 0)
			styleClass = "";
		else
			styleClass = "class=\"celda-clave1\"";
        if (t.getDetalle() != null && t.getDetalle().size() > 0){
            StringBuffer buffer = new StringBuffer();
            buffer.append("<table width=\"100%\">");
            for (int j = 0; j < t.getDetalle().size(); j++){
	            detalle = (DetalleTransferencia) t.getDetalle().get(j);	 	            
	            buffer.append("<tr valign=\"top\"><td class=\"bienvenida\" width=\"40%\">");
	            if (ITransferencia.APROBADA.equals(detalle.getEstado())){
	                if (userInfo.getClienteCSIC().equals(detalle.getGrupo()) &&
	                    userInfo.getUsuario().equals(detalle.getUsuario())){
	                    aprobacion = false;
	                }
	            }
	            buffer.append("<tr><td class=\"bienvenida\" width=\"30%\">");
	            buffer.append(detalle.getUsername());
	            buffer.append("</td><td class=\"bienvenida\" width=\"30%\">");
	            buffer.append(f.formatFecha(detalle.getFechaAprobacion(), locale));
	            buffer.append("</td><td class=\"bienvenida\" width=\"30%\">");
	            buffer.append(f.formatFecha(detalle.getFecha(), locale));
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
            aprobadorStr = "";
        }
%>
<tr valign="top" <%=styleClass%>>
        <td class="bienvenida" nowrap><html:radio property="indice" value="<%=String.valueOf(i)%>"/><a href="<html:rewrite page='/transferencias/detalle.jsp'/>?w=<%=i%>&t=3"><%=StringUtilities.replace(f.formatCuenta(t.getNumeroDocumento(), "A-S-C"), "-", "")%></a></td>
        <td class="bienvenida"><%=f.formatFecha(t.getFechaElaboracion(), locale)%></td>
        <td class="bienvenida"><%=f.formatFecha(t.getFecha(), locale)%></td>
        <td class="bienvenida" align="right"><%=f.formatMonto(t.getMonto())%></td>
        <td class="bienvenida"><%=t.getMoneda() %></td>  
        <td class="bienvenida"><%=f.formatCuenta(t.getCuenta().getCodigoBanco(), "C") %></td>     
        <td class="bienvenida"><%=t.getUsuarioPrepara()==null?"":t.getUsuarioPrepara()%></td>   
        <td class="bienvenida"><bean:message key="<%=getDescEstado(t.getEstado())%>"/></td>
        <td class="bienvenida"><%=aprobadorStr%></td>                        
        <td class="bienvenida"><%=t.getDescripcionRechazo()==null?StringUtilities.getValue(t.getMotivo()):t.getDescripcionRechazo()%></td>                       
</tr>
<%
   } /* End  for*/
} /* End if */ 
%>  
</table>
<table width="100%" border="0" cellspacing="5" cellpadding="5">
	<tr><td align="center">
					  <input type="button" class="botton" value="<bean:message key="lbl.transf.inter.modificar"/>" onclick="__update();"></TR>
	<tr><td align="center"><br>
	<INPUT class="botton" onclick="document.location='<html:rewrite page='/servicios/modificacion.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>"></td></tr></table>
</html:form></TABLE>
</table></div>

<%@ include file="../footer.jsp"  %>
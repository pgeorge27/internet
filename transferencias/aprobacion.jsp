<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"
	prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic"
	prefix="logic"%>
<%@ taglib uri="/tags/asi-internet" prefix="csic"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
<%@ page import="com.arango.common.beans.DetalleTransferencia"%>
<%@ page import="com.arango.internet.services.interfaces.ITransferencia"%>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="java.util.Locale"%>

<%!com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();

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

	private String getDescEstado(String estado) {
		if (estado == null) {
			return "lbl.transf.inter.estado.no.definido";
		}

		if (ITransferencia.APROBADA.equals(estado)) {
			return "lbl.transf.inter.aprobada";
		} else if (ITransferencia.MODIFICADA.equals(estado)) {
			return "lbl.transf.inter.pendiente";
		} else if (ITransferencia.PENDIENTE.equals(estado)) {
			return "lbl.transf.inter.pendiente";
		} else if (ITransferencia.RECHAZADA.equals(estado)) {
			return "lbl.transf.inter.rechazada";
		} else if (ITransferencia.EN_PROCESO.equals(estado)) {
			return "lbl.transf.inter.en.proceso";
		} else if (ITransferencia.PROCESADA.equals(estado)) {
			return "lbl.transf.inter.completada";
		} else if (ITransferencia.RECHAZADA_BANCO.equals(estado)) {
			return "lbl.transf.inter.rechazada.banco";
		}
		return "lbl.transf.inter.estado.no.definido";
	}%>
<%
	session.setAttribute("transfer", null);
	session.setAttribute("multiAprobacion", null);
	session.setAttribute("multiT", null);
	session.setAttribute("indices", null);
	session.setAttribute("transfer", null);
	session.setAttribute("tmasivo", null);
	session.setAttribute("indice", null);
	
	Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
	ArrayList data = (ArrayList) session.getAttribute("transferencias");
	int counter = 0;
	if (data != null) {
		counter = data.size();
	}
%>

<!DOCTYPE html>
<html:html>

<head>
<%@ include file="../head.jsp"%>
<script type="text/javascript">
function __aprobar(){
	var flag = false;
	var index = 0;
	var count = 0;
	var elements = document.forms['autorizarForm'].elements;
	for(var i = 0; i < elements.length; i++)
	{
		if (elements[i].name == "indice")
		{
		   if (elements[i].checked)
		   {
			flag = true;
			index = elements[i].value;
			count++;
		   }
		}
	}

	if (count > 0){
		return true;  
	}		
	else{
		alert("Debe seleccionar un registro para enviar a aprobación");
		return false;
	}
}

function set(target){

	//document.forms[0].autoriza.disabled = true;
	//document.forms[0].rechaza.disabled = true;
	//document.forms[0].retrocede.disabled = true;

	var count = <%=counter%>;
    var aprobacion = "<bean:message key="lbl.transf.inter.confirma.autorizar"/>";
    var rechazo = "<bean:message key="lbl.transf.inter.confirma.rechazar"/>";
    var msg = "";
    if (count > 0 && __aprobar()){
	    if (target == "<%=ITransferencia.APROBADA %>" || target == "<%=ITransferencia.AUTORIZAR_BENEFICIARIO %>"){
	        msg = aprobacion;
	    }
	    else{
	    	msg = rechazo;
	    }
	    if (confirm(msg)){
			document.forms[0].autoriza.disabled = true;
			document.forms[0].rechaza.disabled = true;
			document.forms[0].retrocede.disabled = true;
			
			//document.forms[0].tipo.value=target;
			<%session.setAttribute("autorizada",null);%>
			document.forms[0].submit();
		}else{
			document.forms[0].autoriza.disabled = false;
			document.forms[0].rechaza.disabled = false;
			document.forms[0].retrocede.disabled = false;
		}
	}
}

function __reject(){
	document.forms[0].tipo.value="<%=ITransferencia.RECHAZADA_BANCO %>";
	document.forms[0].submit();
}

function __update(){
	document.forms[0].tipo.value="Z";
	document.forms[0].submit();
}
</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
</head>
<%@ include file="../body.jsp"%>

<body>

<div  class="container"> 

	<%if(session.getAttribute("tieneToken").equals("S")){ %>
	<div class="row">
 
  <div class="col-md-10"><img src="<html:rewrite page='/images/logo_icon.png' />" /><bean:message key="lbl.transferencias.autorizaciones.nuevas"/></div>
</div>
		
			<%} %>


	<div align="right">&nbsp; <INPUT class="btn btn-default"
					onclick="document.location='<html:rewrite page='/servicios/aprobacion.jsp'/>';"
					type="button" value="<bean:message key="lbl.retroceder"/>"></div>
<br>

	<logic:present name="consulta.clte">
	<tr>
		<td class="bienvenida" align="left"><strong><%=session.getAttribute("consulta.clte")%></strong></td>
	</tr>
	</logic:present>

<logic:messagesPresent>
	<table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso">
		<tr>
			<td>
			<table border="0" cellpadding="1" cellspacing="0" width="100%">
				<tr valign="top">
					<td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
					<td width="95%" class="msg">
						<span class="bienvenida"><b><bean:message key="errors.header" /></b></span><br>
						<span class="bienvenida">
							<table width="80%">
								<html:messages id="error">
									<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
								</html:messages>
							</table>
						</span><br>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</logic:messagesPresent>

<br>
	<div class="row">
		<div>
			<div class="panel panel-default" >
				<div class="panel-heading" align="left">
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong><bean:message key="lbl.transf.inter.aprobacion"/></strong>
				</div>

</div>

</div>

</div>

<html:form method="post" action="/autoriza">
<html:hidden property="tipo" />

				<div id="no-more-tables">
<table class="col-md-12 table-bordered table-striped table-condensed cf">
<thead class="cf">   
					<TR class="tabla-acceso">
						<TD class="texto-acceso" ><bean:message key="lbl.transf.inter.secuencia" /></TD>
						<TD class="texto-acceso" ><bean:message key="lbl.transf.inter.fecha.elaboracion" /></TD>
						<TD class="texto-acceso" >Fecha Efectiva</TD>
						<TD class="texto-acceso" ><bean:message key="lbl.transf.inter.cantidad" /></TD>
						<TD class="texto-acceso" ><bean:message key="lbl.moneda" /></TD>
						<TD class="texto-acceso" ><bean:message key="lbl.transf.inter.cuenta" /></TD>
						<TD class="texto-acceso" ><bean:message key="lbl.transf.inter.elaborador.por" /></TD>
						<TD class="texto-acceso" ><bean:message key="lbl.transf.inter.estado" /></TD>
						<TD class="texto-acceso" ><bean:message key="lbl.transf.inter.nivel.aprobacion" /></TD>
						<TD class="texto-acceso" ><bean:message key="lbl.transf.inter.comentario" /></TD>
					</TR></thead>  
					<TR>
						<TD colspan="8"></TD>
						<TD class="texto-acceso">
						<table class="col-md-12 table-bordered table-striped table-condensed cf">
						<thead class="cf"> 
							<tr class="tabla-acceso">
								<td class="texto-acceso"><bean:message key="lbl.transf.inter.aprobado.por" /></td>
								<td class="texto-acceso" ><bean:message key="lbl.transf.inter.fecha.aprobacion" /></td>
								<td class="texto-acceso" ><bean:message key="lbl.transf.inter.tipo.relacion" /></td>
								<td class="texto-acceso" ><bean:message key="lbl.transf.inter.estado" /></td>
							</tr></thead>  
						</table>
						
					
					<%
						String styleClass = "";
						boolean isNva	  = false;
						String cssClase	  = "";	
						String tipo		  = "";

						if (data != null) {
							counter = data.size();
							TransferenciaInternacional t = null;
							String aprobadorStr = null;
							DetalleTransferencia detalle = null;
							boolean aprobacion = true;
							for (int i = 0; i < data.size(); i++) {
								t = (TransferenciaInternacional) data.get(i);
								if (i % 2 == 0)
									styleClass = "";
								else
									styleClass = "class=\"celda-clave1\"";
								if (t.getDetalle() != null && t.getDetalle().size() > 0) {
									StringBuffer buffer = new StringBuffer();
									buffer.append("<table width=\"100%\">");
									
									for (int j = 0; j < t.getDetalle().size(); j++) {
										detalle = (DetalleTransferencia) t.getDetalle()
												.get(j);
										buffer.append("<tr class=\"bienvenida\" valign=\"top\" ><td class=\"bienvenida\" width=\"40%\">");
										if (ITransferencia.APROBADA.equals(detalle.getEstado())) {
											if (userInfo.getClienteCSIC().equals(detalle.getGrupo())
												&& userInfo.getUsuario().equals(detalle.getUsuario())) {
												aprobacion = false;
											}
										}
										buffer.append("<tr><td data-title=\"Autorizado por\" class=\"bienvenida\" width=\"30%\">");
										buffer.append(detalle.getUsername());
										buffer.append("</td><td data-title=\"Fecha Aprobación\" class=\"bienvenida\">");
										buffer.append(f.formatFecha(detalle.getFechaAprobacion(), locale));
										buffer.append("</td><td  data-title=\"Tipo Relación\" class=\"bienvenida\" >");
										buffer.append(detalle.getTipoRelacion());
										buffer.append("</td><td data-title=\"Estado\" class=\"bienvenida\">");
										buffer.append(com.arango.internet.tag.TagUtil.getString(pageContext,getNivelAutorizacion(detalle.getEstado())));
										buffer.append("</td></tr>");
									}
									buffer.append("</table>");
									aprobadorStr = buffer.toString();
								} else {
									aprobadorStr = "";
								}
								
								isNva = t.isNuevaTransBeneficiario();
								if (isNva == true)
								{
									cssClase = "class=\"isNva\"";
									tipo = ITransferencia.AUTORIZAR_BENEFICIARIO;
								}
								else
								{
									cssClase = "class=\"bienvenida\"";
									tipo = ITransferencia.APROBADA;
								}
					%>
					<tr valign="top" <%=/*styleClass*/ cssClase%>>
						<td data-title="Referencia" class="bienvenida" nowrap>
							<html:radio property="indice" value='<%=""+i %>' styleId="<%=tipo%>" onclick="document.forms[0].tipo.value=this.id;"/>
							<a href="<html:rewrite page='/transferencias/detalle.jsp'/>?n=<%=tipo%>&w=<%=i%>&t=2"><%=StringUtilities.replace(f.formatCuenta(t
							.getNumeroDocumento(), "A-S-C"), "-", "")%></a></td>
						<td data-title="Fecha Elaboración" class="bienvenida"><%=f.formatFecha(t.getFechaElaboracion(), locale)%></td>
						<td data-title="Fecha Efectiva" class="bienvenida"><%=f.formatFecha(t.getFecha(), locale)%></td>
						<td data-title="Cantidad - Amount" class="bienvenida" align="right"><%=f.formatMonto(t.getMonto())%></td>
						<td data-title="Moneda" class="bienvenida"><%=t.getMoneda()%></td>
						<td data-title="Número de Cuenta - Account Number" class="bienvenida"><%=f.formatCuenta(t.getCuenta().getCodigoBanco(), "C")%></td>
						<td data-title="Elaborador por" class="bienvenida"><%=t.getUsuarioPrepara() == null ? "" : t.getUsuarioPrepara()%></td>
						<td data-title="Estado" class="bienvenida"><bean:message key="<%=getDescEstado(t.getEstado())%>" /></td>
						<td data-title="Nivel de Autorización" class="bienvenida"><%=aprobadorStr%></td>
						<td data-title="Comentario" class="bienvenida"><%=t.getDescripcionRechazo() == null ? StringUtilities.getValue(t.getMotivo()) : t.getDescripcionRechazo()%></td>
					</tr>
					<%
							} /* End  for*/
						} /* End if */
					%>
				</table>
				
				
				
				
				
				
				
				<br>
					
						<br>
				<table width="100%" border="0" cellspacing="5" cellpadding="5">

					
					
					
					
					<div align="center">
<input type="button" class="btn btn-default"
							value="<bean:message key='lbl.transf.inter.autorizar'/>"
							onclick="set('<%=ITransferencia.APROBADA %>');"
							name="autoriza" >
							
<input type="button" class="btn btn-default"
							value="<bean:message key='lbl.transf.inter.rechazar'/>"
							onclick="__reject();"
							name="rechaza"></div>
					
					
					
					
					
				
						<div align="center"><br>
						<INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/servicios/aprobacion.jsp'/>';"
							type="button" value="<bean:message key="lbl.retroceder"/>" name="retrocede">
						<input type="hidden" id>
						</div>
				
				</table>
				</div>
			</html:form>

		</div>

</body>
</html:html>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"
	prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic"
	prefix="logic"%>
<%@ taglib uri="/tags/asi-internet" prefix="csic"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.internet.beans.TranferenciaProcesada"%>
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
	session.setAttribute("multiAprobacion", null);
	session.setAttribute("multiT", null);
	session.setAttribute("indices", null);
	Locale locale = (Locale) session
			.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
	session.setAttribute("transfer", null);
	session.setAttribute("tmasivo", null);
	ArrayList data = (ArrayList) session.getAttribute("transferencias");
	int counter = 0;
	if (data != null) {
		counter = data.size();
	}
%>
<%@ include file="../head.jsp"%>
<style type="text/css">
	.nueva {
		background-color: #F6C683;
		color: white;
	}
</style>

<script type="text/javascript">
seleccionados = new Array();
var moneda = "";
var monedaIso ="";
$(document).ready(function(){

	moneda = "";
	$(":checkbox").click(function(data){
		obj = {indice:this.value,tipo:$(this).attr("id")};
		Xopa = $(':checkbox:checked').size();

		if(this.checked){
			seleccionados.push(obj);
			moneda = $(this).attr("moneda");
			monedaIso = $(this).attr("monedaIso");
			comodin = ":checkbox[moneda !='" + moneda + "']";
			//Selecall = ":checkbox[moneda ='" + moneda + "']";
		//	$(Selecall).attr("checked", "checked");
			$(comodin).attr('disabled', 'disabled');
			if(seleccionados.length >= 2){
				$("#btmRechaza").attr('disabled', 'disabled');
			}
		}
		else{
			seleccionados = deleteFromArray(seleccionados,obj)
			if(seleccionados.length == 0){
				moneda = "";
				monedaIso= "";
				$(":checkbox").removeAttr('disabled');
			}
			else if(seleccionados.length <= 1){
				$("#btmRechaza").removeAttr('disabled');
			}
		}
		//console.info(seleccionados);
		//console.info($(this).attr("moneda"));
	});	
});

function deleteFromArray(arreglo,obj){
	arr = new Array()
	for(i=0;i<arreglo.length;i++){
		if(arreglo[i].indice!=obj.indice){
			arr.push(arreglo[i]);
		}
	}
	return arr;
}

function validame(){
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
		alert("Debe seleccionar un registro para rechazar");
		return false;
	}	
}

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
	var count = <%=counter%>;
	var porAprobar = "<%=ITransferencia.AUTORIZAR_BENEFICIARIO%>";
    var aprobacion = "<bean:message key="lbl.transf.inter.confirma.autorizar"/>";
    var rechazo = "<bean:message key="lbl.transf.inter.confirma.autorizar.Masivo"/>";
    var msg = "";
    if (count > 0 && __aprobar()){
	    if (target == "<%=ITransferencia.APROBADA %>" || target == "<%=ITransferencia.AUTORIZAR_BENEFICIARIO %>"){
	        msg = aprobacion;
	    }
	    else{
	    	msg = rechazo;
	    }
	    //if (confirm(msg)){
		var tipos = new Array();
		for(i=0;i<seleccionados.length;i++){
			$(document.forms[0]).prepend('<input type="hidden" name="tipo" value="' + seleccionados[i].tipo + '">');
			if(seleccionados[i].tipo == porAprobar){
				$(document.forms[0]).prepend('<input type="hidden" name="paraAprobar" value="' + seleccionados[i].indice + '">');	
			}
			
		}
		$(document.forms[0]).prepend('<input type="hidden" name="moneda" value="' + moneda + '">');
		$(document.forms[0]).prepend('<input type="hidden" name="monedaIso" value="' + monedaIso + '">');
		//document.forms[0].tipo.value=tipos;
		<%session.setAttribute("autorizada",null);%>
		document.forms[0].submit();
		//}
	}
}

function __reject(){
	if(validame()){
		var tipo = "<%=ITransferencia.RECHAZADA_BANCO %>";
		$(document.forms[0]).prepend('<input type="hidden" name="moneda" value="' + moneda + '">');
	    $(document.forms[0]).prepend('<input type="hidden" name="monedaIso" value="' + monedaIso + '">');
		$(document.forms[0]).prepend('<input type="hidden" name="tipo" value="' + tipo + '">');
		document.forms[0].submit();	
	}	
}

function __update(){
	var tipo = "Z";
	$(document.forms[0]).prepend('<input type="hidden" name="tipo" value="' + tipo + '">');
	document.forms[0].submit();
}
</script>
<%@ include file="../body.jsp"%>

<div class="container"> 

	<div class="row">

		<div class="table-responsive">
			<logic:messagesPresent>
			<table class="table">
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
		</div>

		<div class="col-md-12">
			<p class="bienvenida_1">
				<img src="<html:rewrite page='/images/gancho.gif'/>" border="0">
				<strong><bean:message key="lbl.transf.inter.aprobacion" /></strong>
			</p>
		</div>

		<div class="col-md-12">
			<div class="col-md-6">
				<bean:message key="lbl.transferencias.autorizaciones.nuevas"/>
			</div>
			<div class="col-md-6">
				<div align="right">&nbsp; <input class="botton btn btn-default" onclick="document.location='/internet/servicios/aprobacion.jsp';" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
			</div>
		</div>
	</div>
	<br>
	<div class="row">

		<logic:present name="consulta.clte">
			<p class="bienvenida"><strong><%=session.getAttribute("consulta.clte")%></strong></p>
		</logic:present>

		<div id="no-more-tables">
			<table class="col-md-12 table-bordered table-striped table-condensed cf">
				<html:form method="post" action="/multipago/autoriza">
				<html:hidden styleId="proporcion" property="proporcion" value="masivo" />
					<thead class="cf">
						<tr class="tabla-acceso">
							<td class="texto-acceso" width="5%"><bean:message
								key="lbl.transf.inter.secuencia" /></td>
							<td class="texto-acceso" width="5%"><bean:message
								key="lbl.transf.inter.fecha.elaboracion" /></td>
							<td class="texto-acceso" width="5%">Fecha Efectiva</td>
							<td class="texto-acceso" width="10%"><bean:message
								key="lbl.transf.inter.cantidad" /></td>
							<td class="texto-acceso" width="5%"><bean:message
								key="lbl.moneda" /></td>
							<td class="texto-acceso" width="7%"><bean:message
								key="lbl.transf.inter.cuenta" /></td>
							<td class="texto-acceso" with="15%"><bean:message 
								key="lbl.transf.inter.cuentaBeneficiario" /></td>
							<td class="texto-acceso" width="10%"><bean:message
								key="lbl.transf.inter.elaborador.por" /></td>
							<td class="texto-acceso" width="9%"><bean:message
								key="lbl.transf.inter.estado" /></td>
							<td class="texto-acceso" width="25%"><bean:message
								key="lbl.transf.inter.nivel.aprobacion" /></td>
						</tr>
						<tr>
							<td colspan="9"></td>
							<td class="texto-acceso">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr class="tabla-acceso">
										<td class="texto-acceso" width="30%">
											<bean:message key="lbl.transf.inter.aprobado.por" />
										</td>
										<td class="texto-acceso" width="30%">
											<bean:message key="lbl.transf.inter.fecha.aprobacion" />
										</td>
										<td class="texto-acceso" width="10%">
											<bean:message key="lbl.transf.inter.tipo.relacion" />
										</td>
										<td class="texto-acceso" width="30%">
											<bean:message key="lbl.transf.inter.estado" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</thead>
							<%
								String styleClass = "";
								boolean isNva	  = false;
								String cssClase	  = "";	
								String tipo		  = "";

									if (data != null) {
										counter = data.size();
										TranferenciaProcesada t = null;
										String aprobadorStr = null;
										DetalleTransferencia detalle = null;
										boolean aprobacion = true;
										for (int i = 0; i < data.size(); i++) {

											t = (TranferenciaProcesada) data.get(i);
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
													buffer
															.append("<tr class=\"bienvenida\" valign=\"top\" ><td class=\"bienvenida\" width=\"40%\">");
													if (ITransferencia.APROBADA.equals(detalle
															.getEstado())) {
														if (userInfo.getClienteCSIC().equals(
																detalle.getGrupo())
																&& userInfo.getUsuario().equals(
																		detalle.getUsuario())) {
															aprobacion = false;
														}
													}
													buffer
															.append("<tr><td class=\"bienvenida\" width=\"30%\">");
													buffer.append(detalle.getUsername());
													buffer
															.append("</td><td class=\"bienvenida\" width=\"30%\">");
													buffer.append(f.formatFecha(detalle
															.getFechaAprobacion(), locale));
													buffer
															.append("</td><td class=\"bienvenida\" width=\"10%\">");
													buffer.append(detalle.getTipoRelacion());
													buffer
															.append("</td><td class=\"bienvenida\" width=\"30%\" nowrap>");
													buffer.append(com.arango.internet.tag.TagUtil
															.getString(pageContext,
																	getNivelAutorizacion(detalle
																			.getEstado())));
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
										cssClase	= "nueva";
										tipo		= ITransferencia.AUTORIZAR_BENEFICIARIO;
									}
									else
									{
										cssClase = "bienvenida";
										tipo		= ITransferencia.APROBADA;
									}
							%>
						<tbody>
							<tr valign="top" class="<%=cssClase %>" >
								<td class="bienvenida" data-title="<bean:message key="lbl.transf.inter.secuencia" />" nowrap><input type="checkbox" moneda="<%=t.getMonedaAbanks()%>" monedaIso="<%=t.getCodigoMonedaIso()%>" name="indice" value='<%=""+i %>' id="<%=tipo%>" /><a
									href="<html:rewrite page='/multipagos/detalleApr.jsp'/>?n=<%=tipo%>&w=<%=i%>&t=2"><%=StringUtilities.replace(f.formatCuenta(t
												.getNumeroDocumento(), "A-S-C"), "-",
												"")%></a></td>
								<td class="bienvenida" data-title="<bean:message key="lbl.transf.inter.fecha.elaboracion" />"<%=f.formatFecha(t.getFechaElaboracion(), locale)%></td>
								<td class="bienvenida" data-title="Fecha Efectiva"><%=f.formatFecha(t.getFechaValor(), locale)%></td>
								<td class="bienvenida" data-title="<bean:message key="lbl.transf.inter.cantidad" />" align="right"><%=f.formatMonto(t.getMonto())%></td>
								<td class="bienvenida" data-title="<bean:message key="lbl.moneda" />"<%=t.getMonedaAbanks()%></td>
								<td class="bienvenida" data-title="<bean:message key="lbl.transf.inter.cuenta" />"<%=f.formatCuenta(t.getCuentaAbanks())%></td>
								<td class="bienvenida" data-title="<bean:message key="lbl.transf.inter.cuentaBeneficiario" />"<%=t.getCuentabancoBeneficiario()%></td>
								<td class="bienvenida" data-title="<bean:message key="lbl.transf.inter.elaborador.por" />"<%=t.getAdicionadoPor() == null ? "" : t
										.getAdicionadoPor()%></td>
								<td class="bienvenida" data-title="<bean:message key="lbl.transf.inter.estado" />"<bean:message
									key="<%=getDescEstado(t.getEstado())%>" /></td>
								<td class="bienvenida" data-title="<bean:message key="lbl.transf.inter.nivel.aprobacion" />"<%=aprobadorStr%></td>
							</tr>
							<%
								} /* End  for*/
									} /* End if */
							%>
						</tbody>

					<!-- <tbody>
						<tr>
							<td data-title="<bean:message key="lbl.transf.inter.secuencia" />" >AAC</td>
							<td data-title="Fecha Elaboración">AUSTRALIAN AGRICULTURAL COMPANY LIMITED.</td>
							<td data-title="Fecha Efectiva">$1.38</td>
							<td data-title="Cantidad - Amount" class="numeric">-0.01</td>
							<td data-title="Moneda" class="numeric">-0.36%</td>
							<td data-title="Numero de cuenta - Account Number" class="numeric">$1.39</td>
							<td data-title="Numero de cuenta Beneficiario - Beneficiary Account Number" class="numeric">$1.39</td>
							<td data-title="Elaborado Por">$1.38</td>
							<td data-title="Estado">9,395</td>
							<td data-title="Nivel de Autorización">1</td>
						</tr>
						<tr>
							<td data-title="Referencia">AAC</td>
							<td data-title="Fecha Elaboración">AUSTRALIAN AGRICULTURAL COMPANY LIMITED.</td>
							<td data-title="Fecha Efectiva">$1.38</td>
							<td data-title="Cantidad - Amount" class="numeric">-0.01</td>
							<td data-title="Moneda" class="numeric">-0.36%</td>
							<td data-title="Numero de cuenta - Account Number" class="numeric">$1.39</td>
							<td data-title="Numero de cuenta Beneficiario - Beneficiary Account Number" class="numeric">$1.39</td>
							<td data-title="Elaborado Por">$1.38</td>
							<td data-title="Estado">9,395</td>
							<td data-title="Nivel de Autorización">1</td>
						</tr>
						<tr>
							<td data-title="Referencia">AAC</td>
							<td data-title="Fecha Elaboración">AUSTRALIAN AGRICULTURAL COMPANY LIMITED.</td>
							<td data-title="Fecha Efectiva">$1.38</td>
							<td data-title="Cantidad - Amount" class="numeric">-0.01</td>
							<td data-title="Moneda" class="numeric">-0.36%</td>
							<td data-title="Numero de cuenta - Account Number" class="numeric">$1.39</td>
							<td data-title="Numero de cuenta Beneficiario - Beneficiary Account Number" class="numeric">$1.39</td>
							<td data-title="Elaborado Por">$1.38</td>
							<td data-title="Estado">9,395</td>
							<td data-title="Nivel de Autorización">1</td>
						</tr>
					</tbody> -->
					
				</html:form>
			</table>
		</div>
	</div>
	<br>
	<div class="row">
		<div align="center">
			<input type="button" class="botton btn btn-default" value="<bean:message key="lbl.transf.inter.autorizar"/>" onclick="set('<%=ITransferencia.APROBADA %>');">
			<input type="button" class="botton btn btn-default" id="btmRechaza" value="<bean:message  key="lbl.transf.inter.rechazar"/>" onclick="__reject();">
			<input class="botton btn btn-default" onclick="document.location='<html:rewrite page='/multipagos/consultaAutCan.jsp'/>';" type="button" value="<bean:message key="lbl.retroceder"/>">
			<input type="hidden" />
		</div>
	</div>
</div>

<%@ include file="../footer.jsp"%>
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

<logic:messagesPresent>
	<table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso table-responsive">
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

<div align="center">
<table class="table-responsive" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="40" valign="bottom">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			<tr>
				<td colspan="2">
					<table>
						<tr valign="baseline">
							<td><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
							<td class="bienvenida_1"><bean:message key="lbl.transferencias.autorizaciones.nuevas"/></td>
						</tr>	
					</table>
				</td>
			</tr>
			<tr>
				<td width="92%">
					<div align="left" class="login"><bean:message key="lbl.transf.inter.aprobacion" /></div>
				</td>
				<td width="8%">
					<div align="right">&nbsp; <INPUT class="botton btn btn-default"
					onclick="document.location='<html:rewrite page='/servicios/aprobacion.jsp'/>';"
					type="button" value="<bean:message key="lbl.retroceder"/>"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="texto-acceso">&nbsp;</td>
	</tr>

	<logic:present name="consulta.clte">
		<tr>
			<td class="bienvenida"><strong><%=session.getAttribute("consulta.clte")%></strong></td>
		</tr>
	</logic:present>
	<tr>
		<td><br>
		<div align="left">
		<table class="table-responsive" width="100%" border="0" cellspacing="0" cellpadding="0">
			<html:form method="post" action="/multipago/autoriza">
			<html:hidden styleId="proporcion" property="proporcion" value="masivo" />
<%-- 		<html:hidden styleId="tipos" property="tipo" /> --%>
			<tr>
				<td colspan="4">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="31%" height="20"></td>
						<td width="34%" nowrap></td>
						<td width="35%">
						<div align="right"></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
				<table class="table-responsive" width="100%" border="0" cellspacing="1" cellpadding="1">
					<TR class="tabla-acceso">
						<TD class="texto-acceso" width="5%"><bean:message
							key="lbl.transf.inter.secuencia" /></TD>
						<TD class="texto-acceso" width="5%"><bean:message
							key="lbl.transf.inter.fecha.elaboracion" /></TD>
						<TD class="texto-acceso" width="5%">Fecha Efectiva</TD>
						<TD class="texto-acceso" width="10%"><bean:message
							key="lbl.transf.inter.cantidad" /></TD>
						<TD class="texto-acceso" width="5%"><bean:message
							key="lbl.moneda" /></TD>
						<TD class="texto-acceso" width="7%"><bean:message
							key="lbl.transf.inter.cuenta" /></TD>
						<TD class="texto-acceso" with="15%"><bean:message 
							key="lbl.transf.inter.cuentaBeneficiario" /></TD>
						<TD class="texto-acceso" width="10%"><bean:message
							key="lbl.transf.inter.elaborador.por" /></TD>
						<TD class="texto-acceso" width="9%"><bean:message
							key="lbl.transf.inter.estado" /></TD>
						<TD class="texto-acceso" width="25%"><bean:message
							key="lbl.transf.inter.nivel.aprobacion" /></TD>
					</TR>
					<TR>
						<TD colspan="9"></TD>
						<TD class="texto-acceso">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="tabla-acceso">
								<td class="texto-acceso" width="30%"><bean:message
									key="lbl.transf.inter.aprobado.por" /></td>
								<td class="texto-acceso" width="30%"><bean:message
									key="lbl.transf.inter.fecha.aprobacion" /></td>
								<td class="texto-acceso" width="10%"><bean:message
									key="lbl.transf.inter.tipo.relacion" /></td>
								<td class="texto-acceso" width="30%"><bean:message
									key="lbl.transf.inter.estado" /></td>
							</tr>
						</table>
						</td>
					</tr>
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
					<tr valign="top" class="<%=cssClase %>" >
						<td class="bienvenida" nowrap><input type="checkbox" moneda="<%=t.getMonedaAbanks()%>" monedaIso="<%=t.getCodigoMonedaIso()%>" name="indice" value='<%=""+i %>' id="<%=tipo%>" /><a
							href="<html:rewrite page='/multipagos/detalleApr.jsp'/>?n=<%=tipo%>&w=<%=i%>&t=2"><%=StringUtilities.replace(f.formatCuenta(t
										.getNumeroDocumento(), "A-S-C"), "-",
										"")%></a></td>
						<td class="bienvenida"><%=f.formatFecha(t.getFechaElaboracion(), locale)%></td>
						<td class="bienvenida"><%=f.formatFecha(t.getFechaValor(), locale)%></td>
						<td class="bienvenida" align="right"><%=f.formatMonto(t.getMonto())%></td>
						<td class="bienvenida"><%=t.getMonedaAbanks()%></td>
						<td class="bienvenida"><%=f.formatCuenta(t.getCuentaAbanks())%></td>
										
								<td class="bienvenida"><%=t.getCuentabancoBeneficiario()%></td>									
							
						<td class="bienvenida"><%=t.getAdicionadoPor() == null ? "" : t
								.getAdicionadoPor()%></td>
						<td class="bienvenida"><bean:message
							key="<%=getDescEstado(t.getEstado())%>" /></td>
						<td class="bienvenida"><%=aprobadorStr%></td>
						
					</tr>
					<%
						} /* End  for*/
							} /* End if */
					%>
				</table>
				<table class="table-responsive" width="100%" border="0" cellspacing="5" cellpadding="5">
					<tr>
						<td align="center"><input type="button" class="botton"
							value="<bean:message key="lbl.transf.inter.autorizar"/>"
							onclick="set('<%=ITransferencia.APROBADA %>');">
						&nbsp;&nbsp; <input type="button" class="botton" id="btmRechaza"
							value="<bean:message  key="lbl.transf.inter.rechazar"/>"
							onclick="__reject();"> &nbsp;&nbsp;</td>
					</TR>
					<tr>
						<td align="center"><br>
						<INPUT class="botton"
							onclick="document.location='<html:rewrite page='/multipagos/consultaAutCan.jsp'/>';"
							type="button" value="<bean:message key="lbl.retroceder"/>">
						<input type="hidden" id>
						</td>
					</tr>
				</table>

				
			</html:form>
		</TABLE>
</table>
</div>
</div>

<%@ include file="../footer.jsp"%>
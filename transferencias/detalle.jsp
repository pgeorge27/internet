<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
<%@ page import="com.arango.common.beans.DetalleTransferencia"%>
<%@ page import="com.arango.internet.services.interfaces.ITransferencia"  %>

<!DOCTYPE html>
<html>

<head>

<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
String format = "dd-MMM-yyyy HH:mm:ss";

SimpleDateFormat formatter = new SimpleDateFormat(format);

public boolean isValidABANumber(String number) {
    int n = 0;
    if (number != null && number.matches("^[0-9]{9}$")) {        
        if (number.length() == 9) {
              for (int i = 0; i < number.length(); i += 3) {
                n += Integer.parseInt(String.valueOf(number.charAt(i))) * 3
                  +  Integer.parseInt(String.valueOf(number.charAt(i + 1))) * 7
                  +  Integer.parseInt(String.valueOf(number.charAt(i + 2)));
              }
              if (n != 0 && n % 10 == 0) {
                return true;
              }
              else {
                return false;
              }
        }
        else {
            return false;
        }
    }
    else {
        return false;
    }
}
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
    else
        return "lbl.transf.inter.estado.no.definido";
}
%>
<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
int index = -1;
String s = request.getParameter("w");
String nueva = request.getParameter("n");
if (nueva == null){
	nueva = ITransferencia.APROBADA;
}
if (s != null){
    try{
        index = Integer.parseInt(s);
    }
    catch(NumberFormatException e){
        index = -1;
    }
}
if (index < 0)
    response.sendRedirect("consulta.jsp");
ArrayList data = (ArrayList)session.getAttribute("transferencias");
if (data == null)
    response.sendRedirect("consulta.jsp");
if (data.size() < index)
    response.sendRedirect("consulta.jsp");

TransferenciaInternacional t = (TransferenciaInternacional)data.get(index);
session.setAttribute("detalle.transferencia.impresion", t);
%>
<%@ include file="../head.jsp"%>
<script language="javascript">
function __showElement(element){
	__showHideElement(element, "");
}
function __hideElement(element){
	__showHideElement(element, "none");
}
function __showHideElement(element, prop){
	var obj;
	if (document.getElementById){
		obj = document.getElementById(element);
	}
	else{
		eval("obj = " + element);
	}
	obj.style.display = prop;
}
function __print(){
	__hideElement("_printer");
	printPage3();
	__showElement("_printer");
}
</script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>
<%@ include file="../body.jsp" %>

<body>

<div class="container">

<table align="center" border="0" cellpadding="1" cellspacing="1" width="100%">
   <tr valign="top">
        <td>
          <table border="0" cellpadding="1" cellspacing="1" width="100%">          
            <tr>
                <td>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                   <tr>
                     <td>
                        <table border="0" cellpadding="3" cellspacing="1" width="100%">
                          <tr><td>    
<table align="center" width="100%" border="0" cellpadding="3" cellspacing="1">
<tr valign="top">
	<td class="bienvenida" width="30%"></td>
	<td class="bienvenida" width="70%"></td></tr>
<tr valign="top">
	<td class="bienvenida" colspan="2">
	

	
<table align="center" border="0" width="100%" id="table1">
	<tr>
		
		<td  class="login" width="60%" ><bean:message key="lbl.transf.inter.titulo"/></td>
		<td  class="bienvenida" align="right" width="40%"><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"></td>
	</tr>
</table>
	<br>
<table align="center" border="0" width="100%" id="table2" cellpadding="0" cellspacing="0" class="tabla-border2">
	<tr class="celda-clave3">
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td width="50%" class="row-bottom-right-border">
		<table border="0" width="100%" id="table5">
			<tr>
				<td  class="bienvenida" width="40%"><bean:message key="lbl.transf.inter.moneda"/>/<bean:message key="lbl.transf.inter.cantidad"/></td>
				<td  class="texto-acceso" width="60%"><%=StringUtilities.getValue(t.getMoneda())%> <%=f.formatMonto(t.getMonto())%></td>
			</tr>
			<tr>
				<td  class="bienvenida"><bean:message key="lbl.transf.inter.secuencia"/></td>
				<td  class="texto-acceso"><%=StringUtilities.replace(f.formatCuenta(t.getNumeroDocumento(), "A-S-C"), "-", "")%></td>
			</tr>
			<tr>
				<td  class="bienvenida"><bean:message key="lbl.transf.inter.fecha.elaboracion"/></td>
				<td  class="texto-acceso"><%=f.formatFecha(t.getFechaElaboracion(), locale)%></td>
			</tr>
			<tr>
				<td  class="bienvenida"></td>
				<td  class="texto-acceso"></td>
			</tr>
		</table>
		</td>
		<td width="50%" class="row-bottom-border">
		<table border="0" width="100%" id="table6">
			<tr>
				<td  class="bienvenida" width="40%"><bean:message key="lbl.transf.inter.fecha.proceso"/></td>
				<td  class="texto-acceso" width="60%"><%=f.formatFecha(t.getFecha(), locale)%></td>
			</tr>
			<tr>
				<td  class="bienvenida"><bean:message key="lbl.transf.inter.banco.corresponsal"/></td>
				<td  class="texto-acceso">
				<%
				if (!ITransferencia.PENDIENTE.equals(t.getEstado())&&
				    !ITransferencia.APROBADA.equals(t.getEstado())){
					out.print(StringUtilities.getValue(t.getBancoCorresponsal()));
					}
				%></td>
			</tr>
			<tr>
				<td  class="bienvenida"></td>
				<td  class="texto-acceso"></td>
			</tr>
			<tr>
				<td  class="bienvenida"><bean:message key="lbl.transf.inter.referencia.recibida"/></td>
				<td  class="texto-acceso"><%=StringUtilities.getValue(t.getReferenciaRecibida())%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td width="50%">
		<table border="0" width="100%" id="table7" >
			<tr valign="top">
				<td  class="bienvenida" width="40%"><bean:message key="lbl.transf.inter.estado"/></td>
				<td  class="texto-acceso" width="60%"><%=com.arango.internet.tag.TagUtil.getString(pageContext, getDescEstado(t.getEstado()))%></td>				
			</tr>
		</table>
		</td>
		<td width="50%">
		<table border="0" width="100%" id="table7">
			<tr>
				<td  class="texto-acceso" colspan="2"><%=StringUtilities.getValue(t.getReferenciaRecibida())%></td>
			</tr>
		</table>
		</td>
	</tr>
</table><br>
<table border="0" width="100%" id="table3" cellpadding="0" cellspacing="0" class="tabla-border2">
	<tr class="celda-clave3">
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign="top">
		<td width="50%" class="row-bottom-right-border">
		<table border="0" width="100%" id="table8">
			<tr>
				<td  class="sub-title"><bean:message key="lbl.transf.inter.nombre.beneficiario"/></td>
			</tr>
			<tr>
				<td  class="bienvenida"><bean:message key="lbl.transf.inter.cuenta"/> <b><%=StringUtilities.getValue(t.getCuentaBeneficiario())%></b></td>
			</tr>
			<tr>
				<td  class="texto-acceso"><%=StringUtilities.getValue(t.getNombreBeneficiario())%><br>
										<%=StringUtilities.getValue(t.getDireccionBeneficiario())%><br>
										<%=StringUtilities.getValue(t.getCiudadBeneficiario())%><br>
										<%=StringUtilities.getValue(t.getPaisBeneficiario())%></td>
			</tr>
		</table>
		</td>
		<td width="50%" class="row-bottom-border">
		<table border="0" width="100%" id="table9">
			<tr>
				<td  class="sub-title"><bean:message key="lbl.transf.inter.bancoBeneficiario"/></td>
			</tr>
			<tr>
				<td  class="bienvenida"><%if (t.getCuentaBancoIntermediario() != null){%>
				<bean:message key="lbl.transf.inter.cuenta"/> <b><%=StringUtilities.getValue(t.getCuentaBancoIntermediario())%></b>
				<%} %>
				<%if (t.getSwiftBancoIntermediario() != null && t.getSwiftBancoIntermediario().length() > 0){ %>
				<%if (isValidABANumber(t.getSwiftBancoIntermediario())){ %>
				ABA
				<%}else{ %>
				<bean:message key="lbl.transf.inter.swiftBeneficiario"/>
				<%} %> <b><%=StringUtilities.getValue(t.getSwiftBancoIntermediario())%></b>
				<%} %></td>
			</tr>
			<tr>
				<td  class="texto-acceso"><%=StringUtilities.getValue(t.getNombreBancoIntermediario())%></td>
			</tr>
			<tr>
				<td  class="texto-acceso"><%=StringUtilities.getValue(t.getDireccionBancoIntermediario())%><br>
				<%=StringUtilities.getValue(t.getCiudadBancoIntermediario())%><br>
				<%=StringUtilities.getValue(t.getPaisBancoIntermediario())%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="row-bottom-right-border">
		
		<table border="0" width="100%" id="table10">
			<tr>
				<td  class="sub-title"><bean:message key="lbl.transf.inter.nombreBancoIntermediario"/></td>
			</tr>
			<tr>
				<td  class="bienvenida">
				<%if (t.getSwiftBeneficiario() != null && t.getSwiftBeneficiario().length() > 0){%>
				<%if (isValidABANumber(t.getSwiftBeneficiario())){ %>
				ABA
				<%}else{ %>
				<bean:message key="lbl.transf.inter.swiftBancoIntermediario"/>
				<%} %>
				 <b><%=StringUtilities.getValue(t.getSwiftBeneficiario())%></b> 
				<%} %>
				</td>
			</tr>
			<tr>
				<td  class="texto-acceso"><%=StringUtilities.getValue(t.getBancoBeneficiario())%><br>
										<%=StringUtilities.getValue(t.getDireccionBancoBeneficiario())%><br>
										<%=StringUtilities.getValue(t.getCiudadBancoBeneficiario())%><br>
										<%=StringUtilities.getValue(t.getPaisBancoBeneficiario())%></td>
			</tr>
		</table>
		
		</td>
		<td class="row-bottom-border">
		<table border="0" width="100%" id="table11">
			<tr>
				<td  class="sub-title"><bean:message key="lbl.transf.inter.emisor"/></td>
			</tr>
			<tr>
				<td  class="texto-acceso"><%=StringUtilities.getValue(t.getNombreEmisor())%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr valign="top">
		<td class="row-right-border">
		<table border="0" width="100%" id="table12">
			<tr>
				<td  class="sub-title"><bean:message key="lbl.transf.inter.detalle"/></td>
			</tr>
			<tr>
				<td  class="texto-acceso"><%=StringUtilities.getValue(t.getInstrucciones())%></td>
			</tr>
		</table>
		</td>
		<td>
		<table border="0" width="100%" id="table13">
			<tr>
				<td  class="sub-title"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table><br>
<table border="0" width="100%" id="table4" cellpadding="0" cellspacing="0" class="tabla-border2">
	<tr class="celda-clave3">
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr valign="top">
		<td width="50%" class="row-right-border">
		<table border="0" width="100%" id="table14">
			<tr>
				<td  class="sub-title"></td>
			</tr>
			<tr>
				<td  class="texto-acceso"></td>
			</tr>
			<tr>
				<td  class="bienvenida"></td>
			</tr>
		</table>
		</td>
		<td width="50%">
		<table border="0" width="100%" id="table15">
			<tr>
				<td  class="sub-title"><bean:message key="lbl.transf.inter.nivel.aprobacion"/></td>
			</tr>
			<tr>
				<td  class="bienvenida"><bean:message key="lbl.transf.inter.elaborador.por"/> <b><%=t.getUsuarioPrepara()==null?"":t.getUsuarioPrepara()%> <%=f.formatFechaLong(t.getFechaElaboracion(), locale) %></b></td>
			</tr>
			<%
		if (t.getDetalle() != null && t.getDetalle().size() > 0){
			DetalleTransferencia detalle = null;
			for (int j = 0; j < t.getDetalle().size(); j++){
				detalle = (DetalleTransferencia) t.getDetalle().get(j);	 	 
				%>
				<tr>
					<td  class="bienvenida"><bean:message key="lbl.transf.inter.aprobacion.realizada" arg0="<%=String.valueOf(j+1)%>" arg1="<%=detalle.getTipoRelacion()%>"/> <b><%=detalle.getUsername() %> <%=formatter.format(detalle.getFechaAprobacion()) %> <%=com.arango.internet.tag.TagUtil.getString(pageContext, getNivelAutorizacion(detalle.getEstado()))%> </b></tr>
				<%
			}
		}	
		%>	
		</table>
		</td>
	</tr>
</table>
<br>
<div id="_printer" style="display:">
<table width="100%" cellpadding="5" cellspacing="5">
	<tr>
      <td align="center">
      <br>
		<div class="visible-lg" align="center">
			<a href="javascript:__print()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
		<div align="center">
			<a href="<html:rewrite page='/reciboxml/download'/>" target="_new"><img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0">&nbsp;Descargar Transferencia de Fondos en formato PDF</a></div>
		<%if (ITransferencia.PROCESADA.equals(t.getEstado())) {%>	
		<br>
		<div align="center">
			<a href="<html:rewrite page='/swift/download'/>" target="_new"><img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0">&nbsp;Descargar SWIFT en formato PDF</a></div>
			<%} %>	
		</td></tr>
	<tr>
	
	
		<td align="center">
        <%
        String target = request.getParameter("t");
        if ("1".equals(target)){
        %>
        <br>
	        <input type="button" class="btn btn-default" onclick="document.location='<html:rewrite page='/transferencias/consulta.jsp'/>'" value="<bean:message key="lbl.retroceder"/>" >
	    <%}else if ("3".equals(target)){%>   
	 
	    	<input type="button" class="btn btn-default" onclick="document.location='<html:rewrite page='/transferencias/modificacion.jsp'/>'" value="<bean:message key="lbl.retroceder"/>" >
	    	&nbsp;&nbsp;&nbsp;
			<input type="button" class="btn btn-default" value="<bean:message key="lbl.transf.inter.modificar"/>" onclick="document.forms[0].submit();">
			<html:form method="post" action="/update"> 
				<html:hidden property="indice" value="<%=String.valueOf(index)%>"/>
			</html:form>
        <%}else{
        	String tieneToken = (String) session.getAttribute("tieneToken");
        	if(tieneToken != null && tieneToken.equals("S")){
        %>
            	<input type="button" class="btn btn-default" onclick="document.location='<html:rewrite page='/transferencias/aprobacionMasiva.jsp'/>'" value="<bean:message key="lbl.retroceder"/>" >
        <%
        	}
        	else{
        %>
        		<input type="button" class="btn btn-default" onclick="document.location='<html:rewrite page='/transferencias/aprobacion.jsp'/>'" value="<bean:message key="lbl.retroceder"/>" >
        <%
        	}
        	
        %>

        </td>    
    <tr>
		<td align="center">
	        <html:form method="post" action="/autoriza">   
				<html:hidden property="tipo" />
				<html:hidden property="pantalla" value="directa" />
				<html:hidden property="indice" value="<%=String.valueOf(index)%>"/>
			</html:form>	
			<script language="javascript">
				function set(){
				    var aprobacion = "<bean:message key="lbl.transf.inter.confirma.autorizar"/>";
				    var rechazo = "<bean:message key="lbl.transf.inter.confirma.rechazar"/>";
				    var msg = "";
				    
				        msg = aprobacion;
				    
				    if (confirm(msg)){
						document.forms[0].tipo.value="<%=nueva %>";
						document.forms[0].submit();
					}
				}
				function __reject(){
					document.forms[0].tipo.value="<%=ITransferencia.RECHAZADA_BANCO %>";
					document.forms[0].submit();
				}
			</script>
			<input type="button" class="btn btn-default" value="<bean:message key="lbl.transf.inter.autorizar"/>" onclick="set();">
			&nbsp;&nbsp;&nbsp;
			<input type="button" class="btn btn-default" value="<bean:message key="lbl.transf.inter.rechazar"/>" onclick="__reject();">
        <%}%>
        </td></tr>
</table>
</div>
<!-- Fin. Solicitud -->
</td></tr></table>
                        </td></tr></table></td></tr></table></td></tr></table></table>


<%@ include file="../footer.jsp"  %>
</div>
</body>
</html>
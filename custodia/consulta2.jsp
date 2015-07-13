<% session.setAttribute("selected", "custodia"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@page import="com.arango.common.util.Format" %>

<%@page import="com.arango.internet.banking.Custodia" %>


<%@page import="com.arango.common.util.StringUtilities" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%! Format f = Format.getFormat();
private String getDescEstado(String estado){
    if ("P".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente";
    }
    else if ("M".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente.elaborar";
    }
    else if ("A".equals(estado)){
        return "lbl.compensacion.consulta.estado.aprobado";
    }
    else if ("T".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente.aprobar";
    }
    else if ("X".equals(estado)){
        return "lbl.compensacion.consulta.estado.rechazado";
    }
    return "lbl.compensacion.consulta.estado.pendiente.elaborar";
}
private String getDescripcion(String text){
    if (text == null)
		return "";
    String temp = StringUtilities.replace(text, "\"","&#034;");
    temp = StringUtilities.replace(temp, "\n", "\\n");
    temp = StringUtilities.replace(temp, "\r", "\\r");
    temp = StringUtilities.replace(temp, "\"", "\\\"");
    temp = StringUtilities.replace(temp, "'", "\\'");
    temp = temp.replace('\n', ' ');
    temp = temp.replace('\r', ' ');

    return temp;
}
%>
<%



java.util.ArrayList mov = (java.util.ArrayList)session.getAttribute("custodia");


Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);

if (mov == null){   
	session.setAttribute("csic.exception", new Exception("Api de custodia retorna Cuenta = NULL"));
	pageContext.forward(request.getContextPath()+ "/custodia/seleccion.do");  
	return;
}
String cuenta = (String)session.getAttribute("cuenta.banco");
String cliente = "";

SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
String strFechaDesde = "";
String strFechaHasta = "";
Date desde = (Date)session.getAttribute("fecha.desde");
Date hasta = (Date)session.getAttribute("fecha.hasta");
if (desde != null){
    strFechaDesde = df.format(desde);
}
if (hasta != null){
    strFechaHasta = df.format(hasta);
}
String cuentaCSIC = (String)session.getAttribute("cuenta.csic");
Date fechaCustodia = (Date)session.getAttribute("fecha.consulta.custodia");

%>
<%@ include file="../head.jsp"%>

<SCRIPT language=javascript src="<html:rewrite page='/scripts/NotasDebitoCredito.js'/>"></SCRIPT>
<script language=javascript>
function __download(){
	document.forms["pdoc"].submit();
}
function __asociar(index){
	document.forms["modificarForm"].indice.value=index;
	document.forms["modificarForm"].submit();
}
function __showHideElement(element){
	var obj;
	if (document.getElementById){
		obj = document.getElementById(element);
	}
	else{
		eval("obj = " + element);
	}
	if (obj.style.display == "none")
		obj.style.display = "";
	else	
		obj.style.display = "none";
}

function Detalle( indice ){
    
    var win2;
    if (window.showModalDialog) {
    
 	 window.showModalDialog("<html:rewrite page='/custodia/DescripcionDetalle.jsp'/>?index="+indice+"", "","center=yes; resizable=no; dialogWidth=450px; dialogHeight=350px");
	}
	else{
     win2 = open("<html:rewrite page='/custodia/DescripcionDetalle.jsp'/>?index="+indice+"", "","center:yes; resizable:no; Width:450px; Height:350px");
     if (!win2.closed)
       {
         win2.focus();
       }
    }   
}
</script>
<SCRIPT language=javascript src="<html:rewrite page='/scripts/formatDes.js'/>"></SCRIPT>
<%@ include file="../body.jsp"%>

<div id="estcta" align="left">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr> 
		<td height="30" class="texto-acceso"><div id=bankdiv align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>"></div></td>
		<td class="texto-acceso"><div align="right">&nbsp;</div></td>
	  </tr>
	  <tr> 
		<td height="40" colspan="2" valign="bottom"><div align="center"> 
			<table width="100%" border="0" cellpadding="2" cellspacing="2" class="linea-botton">
			  <tr> 
				<td width="92%"><div align="left" class="login">
					<img src="<html:rewrite page='/images/gancho.gif' />"/>Consulta de Inversiones
					</div></td>
				<td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="document.location='<html:rewrite page='/custodia/seleccion.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
			  </tr>
			</table></div></td>
	  </tr>
	  <tr> 
		<td valign="top" align="center">
			<table width="100%" border="0" cellspacing="1" cellpadding="0">                   
				<tr> 
				  <td width="55%" height="20" class="catra-texto" align="center">
<%
  if (!mov.isEmpty())
  {
%>



<table width="40%" border="0" cellpadding="0" cellspacing="2" align="center">
		
		<tr> 
		  <td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso">Nro. Custodia</div></td>
          <td align="right" height="15" class="bienvenida"><%=session.getAttribute("ctaCustodia") %></td>
       </tr>
		<tr> 
		  <td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso">Cliente</div></td>
          <td align="right" height="15" class="bienvenida"><%=session.getAttribute("nombre.cliente.custodia") %></td>
       </tr>
		<tr> 
		  <td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso">Fecha</div></td>
          <td align="right" height="15" class="bienvenida"><%=f.formatFecha(fechaCustodia, locale) %></td>
       </tr>
</table>	   
<table width="40%" border="0" cellpadding="0" cellspacing="2" align="center">	   
<tr> 
					  <td height="15" colspan="2" nowrap>
								<div align="left" class="texto-acceso"><br>
								Coloque el apuntador en la columna Detalle, para ver el detalle completo
								<br></div></td></tr>
</table>
<br>
<table width="100%" border="0" cellpadding="1" cellspacing="2">  
<tr class="tabla-acceso">		               
					   <td class="texto-acceso" width="10%">Fecha Compra</td>					 					   
					   <td class="texto-acceso" width="10%">Fecha Vencimiento</td>
					   <td class="texto-acceso" width="5%">Emisor</td>
					   <td class="texto-acceso" width="5%">Producto</td>
					   <td class="texto-acceso" width="10%">Valor Nominal</td>
					   <td class="texto-acceso" width="5%">Cupon</td>
					   <td class="texto-acceso" width="10%">Precio Compra</td>
					   <td class="texto-acceso" width="5%">T.I.R.</td>
					   <td class="texto-acceso" width="5%">Valor Giro</td>
					   <td class="texto-acceso" width="10%">Prox. Pago Int.</td>
					   <td class="texto-acceso" width="10%">Detalle</td>					   
					   
</tr>
<%				
String styleClass = "";
Custodia cus = null;
double total = 0;
String moneda = "";
String deta = null;
boolean registro = true;
for (int i = 0; i < mov.size(); i++){
	cus = (Custodia)mov.get(i);
if(cus.getDetalle()!= null){
	if(cus.getDetalle().length() > 20){
		deta = cus.getDetalle().substring(0, 19)+"...";
	}
	else
	{
		deta = cus.getDetalle();
	}
}
else{
	deta = "";
}
	if (i % 2 == 0)
		styleClass = "";
	else
		styleClass = "class=\"celda-clave1\"";	


	
	
if( moneda.equals(cus.getMonedaNominal())){
	
 }	else {	
	
	moneda = cus.getMonedaNominal();
	
	if(!registro) {
%>


<tr>
     		      <td width="10%" class="celda-clave1"><div class="bienvenida"><b>Total Moneda</b></div></td>
     		      <td width="10%"></td>
     		      <td width="10%"></td>
     		      <td width="10%"></td>
     		      <td width="10%" class="celda-clave1" align="right"><b><div class="bienvenida"><%=f.formatMonto(total )%></div></b></td>
</tr>


<%
	}%>
	
<tr>
				  <td  class="celda-clave1" colspan="3"><div class="bienvenida"><b>Moneda: <%=cus.getMonedaNominal() %></b></div></td>
</tr>
<% 	
registro = false;
total= 0;
}		//cierra el else%>


<tr >				   
				        <td class="bienvenida" width="10%"><%= f.formatFecha(cus.getFechaCompra(), locale) %></td>					 					   
						<td class="bienvenida" width="10%"><%= f.formatFecha(cus.getFechaVencimiento(), locale) %></td>
						<td class="bienvenida" width="5%"><%=cus.getNombreEmisor() %></td>
						<td class="bienvenida" width="5%"><%=cus.getNombreProducto() %></td>
						<td class="bienvenida" width="10%" align="right"><%= f.formatMonto(cus.getValorNominal()) %></td>

						<td class="bienvenida" width="5%" align="right"><%= cus.getCupon()==0.0?"": f.formatMonto(cus.getCupon()) %></td>
						
						<td class="bienvenida" width="10%" align="right"><%=f.formatMonto(cus.getPrecioCompra()) %></td>
						<td class="bienvenida" width="5%" align="right"><%=cus.getTir()==0.0?"": f.formatMonto(cus.getTir()) %></td>
						<td class="bienvenida" width="5%"><%=f.formatMonto(cus.getValorGiro()) %></td>
						<td class="bienvenida" width="10%"><%=f.formatFecha(cus.getFechaprox(), locale) %></td>
						<td class="bienvenida" width="50%" title="<%=cus.getDetalle()==null?"":cus.getDetalle() %>">
						<a href="javascript:Detalle('<%= "" +i %>')"><%=deta%></a>
						</td>				   					   				  
</tr>

<%
total +=  cus.getValorNominal();
} /* End for - loop*/ 

if( mov.size()> 0){
%>
<tr>
     		      <td width="10%" class="celda-clave1"><div class="bienvenida"><b>Total Moneda</b></div></td>
     		      <td width="10%"></td>
     		      <td width="10%"></td>
     		      <td width="10%"></td>
     		      <td width="10%" class="celda-clave1" align="right"><b><div class="bienvenida"><%=f.formatMonto(total )%></div></b></td>
</tr>
<% }%>
</table>
<script>
function _submit(index, index2){
	document.forms['formularioForm'].indice.value = index;
	document.forms['formularioForm'].indice2.value = index2;
	document.forms['formularioForm'].submit();
}
function __refresh(){
	document.forms['consultaEstadoForm'].submit();
}
</script>

<table width="80%" border="0" cellpadding="0" cellspacing="2">
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><input type="image" onclick="printPage3()" src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32"></div></td>
	</tr>
	<tr>

	<td valign="top" class="texto-acceso" ><div align="center"><!-- a onmouseover="window.status='<bean:message key="tit.title.banco"/>';return true;" onmouseout="window.status='';return true;" href="<html:rewrite page='/custodia/consultaPDF.jsp'/>" target="_new">
	 <img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0">&nbsp;<bean:message key="lbl.descargar.pdf"/></a-->&nbsp;</div></td>

	</tr>
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>		
				<INPUT class="botton" onclick="document.location='<html:rewrite page='/custodia/seleccion.do'/>'" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>					
<%
}
else
{
%>
<table width="80%" border="0" cellpadding="0" cellspacing="2">
  <tr class="tabla-acceso">
<TD class="texto-acceso" width="15%">
<bean:message key="msg.sin.movimentos"/></td></tr>
<tr> 
	<td valign="top" class="texto-acceso"><div align="center"><br>
			<INPUT class="botton" onclick="document.location='<html:rewrite page='/custodia/seleccion.do'/>'" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>
<%
}
%>
</table></div></table></div>
    
<!--fin - estado de cuenta-->
<div></div>
<!--nota-->
<div id="notas" style="display:none" align="center">
<form name="pdoc" action="<html:rewrite page='/note2.download'/>" target="_new" method="post">
	<input type="hidden" name="lbltitulo" value="<bean:message key="lbl.aviso.debito.titulo"/>">
	<input type="hidden" name="lblsubtitulo" value="<bean:message key="lbl.aviso.debito.cuenta.corriente"/>" >
	<input type="hidden" name="lblnombreCuenta" value="<bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.1"/>">
	<input type="hidden" name="nombreCuenta">
	<input type="hidden" name="lblnumeroCuenta" value="<bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.2"/>">
	<input type="hidden" name="numeroCuenta">
	<input type="hidden" name="lblfecha" value="<bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.3"/>">
	<input type="hidden" name="fecha">
	<input type="hidden" name="lblmoneda" value="<bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.4"/>">
	<input type="hidden" name="moneda">
	<input type="hidden" name="lblimporte" value="<bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.5"/>">
	<input type="hidden" name="importe">
	<input type="hidden" name="lblconcepto" value="<bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.6"/>">
	<input type="hidden" name="concepto">
	<input type="hidden" name="lblnombreUsuario" value="<bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.7"/>">
	<input type="hidden" name="nombreUsuario">
</form>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
               <tr> 
                <td height="30" class="texto-acceso"><div id=bk2 align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>" width="260" height="68"></div></td>
                <td class="texto-acceso"><div align="right">
					</div></td>
              </tr>
              <tr> 
                <td height="40" colspan="2" valign="bottom"><div align="left"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td width="92%"><div align="left" class="login"><bean:message key="lbl.aviso.debito.titulo"/></div></td>
                      <td width="8%"><div align="right">&nbsp;
							<a href="javascript:ocultarNotas();"><INPUT class="botton" onclick="javascript:ocultarNotas();" type="button" value="<bean:message key="lbl.retroceder"/>"></a></div></td>
                      </tr>
                    </table>
                  </div></td>
              </tr>
              <tr> 
                <td colspan="2" valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                    <tr> 
                      <td colspan="4"><div align="center" class="subtitulos"><br>
						<SPAN id="tituloNota"> <bean:message key="lbl.aviso.debito.cuenta.corriente"/></SPAN>
					</div><br></td>
                    </tr>
                   <tr> 
                      <td width="15%" height="20" class="bienvenida" align="left"><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.1"/></b></td>
                      <td width="25%" class="bienvenida" align="left"><SPAN id="nombreCuenta"></SPAN></td>
                    </tr>  
                    <tr> 
                      <td height="20" class="bienvenida" align="left"><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.2"/></b></td>
                      <td class="bienvenida" align="left"><SPAN id="numeroCuenta"></SPAN></td>
                      <td></td>
                      <td></td>
                    </tr> 
                    <tr> 
                      <td height="20" class="bienvenida" align="left"><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.3"/></b></td>
                      <td class="bienvenida" align="left"><SPAN id="fecha"></SPAN></td>
                      <td></td>
                      <td></td>
                    </tr> 
                    <tr> 
                      <td height="20" class="bienvenida" align="left"><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.4"/></b></td>
                      <td class="bienvenida" align="left"><SPAN id="moneda"></SPAN></td>
                      <td width="15%" class="bienvenida" align="left"><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.5"/></b></td>
                      <td width="15%" class="bienvenida" align="right"><SPAN id="importe"></SPAN></td>
                    </tr>                                         
                    <tr> 
                      <td height="20" class="bienvenida" align="left"><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.6"/></b></td>
                      <td class="bienvenida" colspan="3"><SPAN id="concepto"></SPAN></td>
                    </tr> 
                    <tr> 
                      <td height="20" class="bienvenida" align="left"><b><span id="lblAtt" style="display:none"><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.7"/></b></span></td>
                      <td class="bienvenida" align="left"><SPAN id="nombreUsuario" style="display:none"></SPAN></td>
                    </tr>
                    
                  </table></td>
              </tr>
              <tr> 
                <td colspan="2" valign="top">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2" valign="top" class="texto-acceso"><div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
                <div align="center"><br>
					<a href="javascript:__download()"><img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0"><bean:message key="lbl.descargar.pdf"/></a>
					<br></div></td>
	</tr>
	<tr> 
	<td valign="top" class="texto-acceso"><div align="center"><br>
			<INPUT class="botton" onclick="javascript:ocultarNotas();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
      </table>
</div>
<!--fin nota-->
<%@ include file="../footer.jsp"  %>
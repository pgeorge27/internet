<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@page import="com.arango.common.util.Format" %>
<%@page import="com.arango.internet.banking.EstadoCuenta" %>
<%@page import="com.arango.internet.banking.Movimiento" %>
<%@page import="com.arango.internet.banking.DetalleMovimiento" %>
<%@page import="com.arango.internet.banking.Titular" %>
<%@page import="com.arango.common.util.StringUtilities" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html:html>

<%! Format f = Format.getFormat();%>
<%!
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
Object objEstCta = session.getAttribute("movimiento");
EstadoCuenta ec = null;
java.util.ArrayList mov = null;

if (objEstCta instanceof com.arango.internet.banking.EstadoCuenta){
	ec = (EstadoCuenta)objEstCta;
	mov = ec.Movimientos;
}
else{
}

Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);

if (ec == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward(request.getContextPath()+ "/compensacion/contrato.do");  
	return;
}
String cuenta = (String)session.getAttribute("cuenta.banco");
String cliente = "";
if (ec.Titulares!=null && !ec.Titulares.isEmpty()){
    cliente = ((Titular)ec.Titulares.get(0)).getNombre();
}
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
session.setAttribute("form.back","/consulta/estado/autorizar");
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
function __return(){
	document.forms['movimientoForm'].submit();
}
function __rechazar(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizacionMultipleForm'].elements;
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

	if (count >= 1){
		document.forms['autorizacionMultipleForm'].action="<html:rewrite page='/compensacion/definir/motivo.do'/>";
		document.forms['autorizacionMultipleForm'].submit();  
	}		
	else{
		alert("Debe seleccionar un registro para rechazar");
	}
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
function __refresh(){
	document.forms['autorizacionMultipleForm'].submit();
}
</script>
<SCRIPT language=javascript src="<html:rewrite page='/scripts/formatDes.js'/>"></SCRIPT>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<%@ include file="../body.jsp"%>
<body>

<div class="container">




<div align="right"><INPUT class="btn btn-default" onclick="__return()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>

<br>



		


	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.compensacion.autorizar.titulo"/> </strong></div>

</div>



<div id="estcta" >


				
<%
  if (!mov.isEmpty())
  {
%>


<br>


<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2"><strong><bean:message key="lbl.desde"/>:</strong></div>
  <div class="col-md-2"><%=f.formatFecha(desde, locale)%></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"><strong><bean:message key="lbl.hasta"/>:</strong></div>
  <div class="col-md-2"><%=f.formatFecha(hasta, locale)%></div>
   <div class="col-md-1"></div>
</div>





<br>


<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2"><strong><bean:message key="lbl.numero.cuenta"/>:</strong></div>
  <div class="col-md-2"><%=f.formatCuenta(ec.getNumeroCuenta())%></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
   <div class="col-md-1"></div>
</div>


<br>

<br>



<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2"><strong><bean:message key="lbl.titular"/>:</strong></div>
  <div class="col-md-2"><%=cliente%></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
   <div class="col-md-1"></div>
</div>



<br>



             
			

<br>

								<div align="center"><strong>
									<bean:message key="lbl.cc.descripcion.observacion"/></strong></div>

					

<br>
<html:form action="/compensacion/autorizar/multiple" method="post">
<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>


      <div align="left"><input type="button" class="btn btn-default" value="<bean:message key="lbl.compensacion.autorizar"/>" onclick="__submit();">
			  						
			  <input type="button" class="btn btn-default" name="btnedit" onclick="__rechazar()" value="Rechazar"/>
			  									
			  <input type="button" class="btn btn-default" value="<bean:message key="lbl.compensacion.refrescar"/>" onclick="__refresh();"></div>
			  
<br>


<div align="left"><input type="checkbox" name="_all" onclick="__checkAll(this);"><bean:message key="lbl.compensacion.autorizar.seleccionar.todos"/></div>

<br>

						<div id="no-more-tables">
<table class="col-md-12 table-bordered table-striped table-condensed cf">
  <thead class="cf"> 

<tr class="tabla-acceso">
	<td ><bean:message key="lbl.fecha"/></TD>
    <td ><bean:message key="lbl.descripcion"/></TD>
 	<td><bean:message key="lbl.debito"/></TD>
    <td><bean:message key="lbl.credito"/></TD>
</tr></thead>
  
<%
String styleClass = "";
Movimiento m = null;
for (int i = 0; i < mov.size(); i++){
	m = (Movimiento)mov.get(i);
	if (i % 2 == 0)
		styleClass = "";
	else
		styleClass = "class=\"celda-clave1\"";
%>

<TR valign="top" <%=styleClass%>>
    <TD  data-title="Fecha" align=left>
    <%if (m.getDetalle()!=null) {%>
    <a href="javascript:__showHideElement('iddeta<%=m.getSecuencia()%>')" title="Ver Detalle">+</a>&nbsp;
    <% } %>
    <html:checkbox property="indice" value="<%=""+i %>"/><%=f.formatFecha(m.getFechaValida(), locale)%></TD>
    <% if (0==m.getTipo()){ // Si tipo == movimiento se utilize el td existente (link actual)%>
    <TD  data-title="Descripción" style="color:blue;CURSOR: hand" 
    <%if ("D".equals(m.getTipoTransaccion())){%>
    onclick="mostrarNotaDebito(<%=i %>,'<bean:message key="lbl.aviso.debito.cuenta.corriente"/>','<bean:message key="lbl.debitamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFechaValida(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(cliente)%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda() %>');" 
    <%}else{%>
	onclick="mostrarNotaCredito(<%=i %>,'<bean:message key="lbl.aviso.credito.cuenta.corriente"/>','<bean:message key="lbl.acreditamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFechaValida(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(cliente)%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda() %>');" 
	<%}%>
    align=left><SPAN id=desc style="color:blue;hand;font-size:10px;font-family: Verdana, Arial, Helvetica, sans-serif;"><%=m.getDescripcion()%></SPAN></TD>
    <%}
else{  // si tipo == D se crea Nuevo link %>
<TD class="bienvenida" 
    align=left  style="color:blue;CURSOR: hand" onclick="location.href='<%=request.getContextPath() %>/detalles/movimiento.do?secuencia=<%=m.getSecuencia() %>'"><SPAN id=desc style="color:blue;hand;font-size:10px;font-family: Verdana, Arial, Helvetica, sans-serif;"><%=m.getDescripcion()%></SPAN></TD>
<%} %>
    
        <TD  data-title="Débito" align=right><%="D".equals(m.getTipoTransaccion())?f.formatMonto(m.getMonto()):"&nbsp;"%></TD>
    <TD  data-title="Crédito" align=right><%="C".equals(m.getTipoTransaccion())?f.formatMonto(m.getMonto()):"&nbsp;"%></TD>
</TR>
    <tr>
	    <td colspan="6">
	    
	    			<% ArrayList detallemov = m.getDetalle();
		if (detallemov != null) { 
			DetalleMovimiento d = null;
	  %>
	  
	  <div id="no-more-tables">
           <div id="iddeta<%=m.getSecuencia()%>" sytle="display:none;">
			 <table class="col-md-12 table-bordered table-striped table-condensed cf">
			  <thead class="cf">  
				   <tr class="tabla-acceso">		               
					   <td >Valor Total del Formulario</td>					 					   
					   <td >Número Declaración</td>
					   <td >Estado</td>
					   <td >Formulario</td>						   
					   
				 </tr></thead>
					<%for (int j=0; j< detallemov.size(); j++) {
						d= (DetalleMovimiento)detallemov.get(j);
						if (j % 2 == 0)
							styleClass = "class=\"celda-clave2\"";
						else
							styleClass = "class=\"celda-clave1\"";
						%>		
				<tr class="tabla-acceso">				   
				   <td data-title="Monto Total del Formulario"  align="right"><%=f.formatMonto(d.getValor())%></td>				 				   
				   <td data-title="Número Declaración"  align="center"><%=d.getSecuenciaDeclaracion()%></td>		
				   <td data-title="Estado"class="bienvenida"><bean:message key="<%=getDescEstado(d.getEstado())%>"/></td>
				   <td data-title="Formulario"><% if (d.getNombreFormulario() != null){%>
						<a  href="javascript:_submit(<%=i%>,<%=j%>);"><%=d.getCodigoFormulario()%>-<%=d.getNombreFormulario()%></a>
					<%}else{%>
						&nbsp;
					<%}%></td>						   				  
				</tr>
		<% }  %>
     		</table></div></div>
		<% }  %>
		
		
	    
	    </td>
	 </tr>
<%} /* End for - loop*/ %>

</table></div>
</html:form>
<script>
function __checkAll(element)
{

	var elements = document.forms['autorizacionMultipleForm'].elements;
  	for(var i = 0; i < elements.length; i++)
 	{
  	 	if (elements[i].name == "indice")
  	 	   elements[i].checked = element.checked;
    }

}
function __submit(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizacionMultipleForm'].elements;
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
		<% session.setAttribute("legalizar","APROBACION"); %>
		document.forms['autorizacionMultipleForm'].submit();  
	}else{
		alert("Debe seleccionar al menos un registro para aprobación");
	}		
}
function __refresh(){
	document.forms['consultaEstadoForm'].submit();
}
function openwin(url)
{
	nwin=window.open(url, "nwin",config="scrollbars=no,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no");
	nwin.focus();
}
function _submit(index, index2){
	document.forms['formularioForm'].indice.value = index;
	document.forms['formularioForm'].indice2.value = index2;
	document.forms['formularioForm'].submit();
}
</script>

<html:form action="/consultar/formulario" method="post" target="_formulario">
    <html:hidden property="unico" value="autorizar"/>
	<html:hidden property="indice"/>
	<html:hidden property="indice2"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
</html:form>
<html:form method="post" action="/consulta/estado/autorizar">
<html:hidden property="estado" value="T"/>
<html:hidden property="tipo" value="3"/>
<html:hidden property="cuenta" value="<%=cuentaCSIC%>"/>
<html:hidden property="desde" value="<%=strFechaDesde%>"/>
<html:hidden property="hasta" value="<%=strFechaHasta%>"/>

</html:form>

<br>

<div class="visible-lg" align="center"><input type="image" onclick="printPage3()" src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32"></div>
	<br>
<div align="center">
		
				
				<INPUT class="btn btn-default" onclick="__return()" type=button value="<bean:message key="lbl.retroceder"/>"></div>
				
				<br>
				
<%
}
else
{
%>
<br>
<div align="center">
<bean:message key="msg.sin.movimentos"/></div>

<br>

<div align="center">
			<INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/compensacion/contrato.do'/>'" type=button value="<bean:message key="lbl.retroceder"/>"></div>
			<br>

<%
}
%>
</div>
    
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

      <br>     
<div align="left"><strong><bean:message key="lbl.aviso.debito.titulo"/></strong></div>
<div align="right">
<a href="javascript:ocultarNotas();"><INPUT class="btn btn-default" onclick="javascript:ocultarNotas();" type="button" value="<bean:message key="lbl.retroceder"/>"></a></div>
              
              <br> 
              
              
              
              
             <div align="center">
						<strong><SPAN id="tituloNota"> <bean:message key="lbl.aviso.debito.cuenta.corriente"/></SPAN></strong>
					</div> 
              
              
              
              <br>
               <br>   
              
              
              
  <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.1"/></strong></div>
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><SPAN id="nombreCuenta"></SPAN></div>
  <div class="col-md-1"></div>

  </div>
              
      <br>         
              
              
              
              
              
              
              
              
  <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.2"/></strong></div>
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><SPAN id="numeroCuenta"></SPAN></div>
  <div class="col-md-1"></div>

  </div>
              
      <br>         
                    
  
              
              
                            
                <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.3"/></strong></div>
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><SPAN id="fecha"></SPAN></div>
  <div class="col-md-1"></div>

  </div>
              
      <br>   
              
          
                                        
                <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.4"/></strong></div>
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><SPAN id="moneda"></SPAN></div>
  <div class="col-md-1"></div>
   <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.5"/></strong></div>
    <div class="col-md-1"></div>
        <div class="col-md-1" align="left"><SPAN id="importe"></SPAN></div>
         <div class="col-md-1"></div>

  </div>
              
      <br>   
      
      
      
                      <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.6"/></strong></div>
  <div class="col-md-1"></div>
  <div class="col-md-3" align="left"><SPAN id="concepto"></SPAN></div>
  <div class="col-md-1"></div>

  </div>
              
      <br>   
              
              
                                   <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><span id="lblAtt" style="display:none"><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.7"/></span></strong></div>
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><SPAN id="nombreUsuario" style="display:none"></SPAN></div>
  <div class="col-md-1"></div>

  </div>
              
      <br>                                       
               
               
                    
   <div class="visible-lg" align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
                <div align="center">
					<a href="javascript:__download()"><img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0"><bean:message key="lbl.descargar.pdf"/></a>
					</div>
					<br> 
	 
	<div align="center">
			<INPUT class="btn btn-default" onclick="javascript:ocultarNotas();" type=button value="<bean:message key="lbl.retroceder"/>"></div>
    
    <br> 
</div>
<!--fin nota-->
<%@ include file="../footer.jsp"  %>
</div>
</body>
</html:html>
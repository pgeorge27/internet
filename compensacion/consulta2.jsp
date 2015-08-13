<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@page import="com.arango.common.util.Format" %>
<%@page import="com.arango.internet.banking.EstadoCuenta" %>
<%@page import="com.arango.internet.banking.DetalleMovimiento" %>
<%@page import="com.arango.internet.banking.Movimiento" %>
<%@page import="com.arango.internet.banking.Titular" %>
<%@page import="com.arango.common.util.StringUtilities" %>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html:html>

<head>

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
	pageContext.forward(request.getContextPath()+ "/seleccion/estado.do");  
	return;
}
String cuenta = (String)session.getAttribute("cuenta.banco");
String estado = (String)session.getAttribute("estado");
String cliente = "";
if (ec.Titulares!=null && !ec.Titulares.isEmpty()){
    cliente = ((Titular)ec.Titulares.get(0)).getNombre();
}
session.setAttribute("form.back","/consulta/estado");

%>
<%@ include file="../head.jsp"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>

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
	document.location="<%=request.getContextPath()%>/seleccion/estado.do";
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
</script>
<SCRIPT language=javascript src="<html:rewrite page='/scripts/formatDes.js'/>"></SCRIPT>
<%@ include file="../body.jsp"%>

<body>
<div class="container">






<div align="right"><INPUT class="btn btn-default" onclick="__return()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>


 <br>


        <div class="panel panel-default">
					 <div class="panel-heading" align="justify" id=bankdiv ><img  src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.compensacion.consulta.titulo"/> - 
					<%
					Object obj = session.getAttribute("con.tipo.mov");
					String tipo = obj == null ? "1" : obj.toString();
					if ("1".equals(tipo)){%>
					<bean:message key="tit.title.consulta.movimientos.dia"/>
					<%}else if ("2".equals(tipo)){%>
					<bean:message key="tit.title.consulta.movimientos.mes.actual"/>
					<%}else if ("3".equals(tipo)){%>
					<bean:message key="tit.title.consulta.movimientos.historico"/>
					<%}%></strong></div>


</div>


<html:form action="/asociar" method="post">
	<html:hidden property="indice"/>
</html:form>


<%
  if (!mov.isEmpty())
  {
%>
<%if (!"1".equals(tipo)){%>
<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2"><strong><bean:message key="lbl.desde"/>:</strong></div>
  <div class="col-md-2"><%=f.formatFecha((java.util.Date)session.getAttribute("fecha.desde"), locale)%></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"><strong><bean:message key="lbl.hasta"/>:</strong></div>
  <div class="col-md-2"><%=f.formatFecha((java.util.Date)session.getAttribute("fecha.hasta"), locale)%></div>
   <div class="col-md-1"></div>
</div>
<%}%>








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














<div id="estcta">
<div align="center"><strong><bean:message key="lbl.cc.descripcion.observacion"/></strong></div>

<br>
						<div id="no-more-tables">
<table class="col-md-12 table-bordered table-striped table-condensed cf">
  <thead class="cf"> 

<tr class="tabla-acceso">
	<td><bean:message key="lbl.fecha"/></TD>
    <td ><bean:message key="lbl.descripcion"/></TD>
 	<td><bean:message key="lbl.debito"/></TD>
    <td><bean:message key="lbl.credito"/></TD>
    <td>Estado Movimiento</TD></tr></thead>

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
    <TD data-title="Fecha" align=left>
    <%if(m.getDetalle()!=null){ %>
    <a href="javascript:__showHideElement('iddeta<%=m.getSecuencia()%>')" title="Ver Detalle">+</a>&nbsp;
    <%} else{%>
    &nbsp;&nbsp;&nbsp;
    <%} %>
    <%=f.formatFecha(m.getFechaValida(), locale)%></TD>
    <% if (0==m.getTipo()){ // Si tipo == movimiento se utilize el td existente (link actual)%>
    <TD data-title="Descripción" class="bienvenida" style="CURSOR: hand" 
    <%if ("D".equals(m.getTipoTransaccion())){%>
    onclick="mostrarNotaDebito(<%=i %>,'<bean:message key="lbl.aviso.debito.cuenta.corriente"/>','<bean:message key="lbl.debitamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFechaValida(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(cliente)%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda() %>');" 
    <%}else{%>
	onclick="mostrarNotaCredito(<%=i %>,'<bean:message key="lbl.aviso.credito.cuenta.corriente"/>','<bean:message key="lbl.acreditamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFechaValida(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(cliente)%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda() %>');" 
	<%}%>
    align=left><SPAN id=desc style="color:blue;hand;font-size:11px;font-family: Verdana, Arial, Helvetica, sans-serif;"><%=m.getDescripcion()%></SPAN></TD>
    <%}
else{  // si tipo == D se crea Nuevo link %>
<TD data-title="Descripción"  class="bienvenida" 
    align=left style="color:blue;CURSOR: hand" onclick="location.href='<%=request.getContextPath() %>/detalles/movimiento.do?secuencia=<%=m.getSecuencia() %>'"><SPAN id=desc style="color:blue;hand;font-size:11px;font-family: Verdana, Arial, Helvetica, sans-serif;"><%=m.getDescripcion()%></SPAN></TD>
<%} %>
        <TD data-title="Débito" class="bienvenida prueba" align=right width="16%"><%="D".equals(m.getTipoTransaccion())?f.formatMonto(m.getMonto()):"&nbsp;"%></TD>
    <TD data-title="Crédito"  class="bienvenida prueba" align=right width="16%"><%="C".equals(m.getTipoTransaccion())?f.formatMonto(m.getMonto()):"&nbsp;"%></TD>
    <td data-title="Estado"  class="bienvenida"><%=m.getEstado()==null?"":m.getEstado() %></td>
   </TR>
    <tr>
	    <td colspan="6" class="paddingCero">
	    
	    			<% ArrayList detallemov = m.getDetalle();
		if (detallemov != null) { 
			DetalleMovimiento d = null;
	  %>
           <div id="iddeta<%=m.getSecuencia()%>" sytle="display:none;">






									<div id="no-more-tables">
<table class="col-md-12 table-bordered table-striped table-condensed cf">
  <thead class="cf"> 
				   <tr>		               
					   <td>Valor Total del Formulario</td>					 					   
					   <td>Número Declaración</td>
					   <td >Estado</td>
					   <td>Formulario</td>						   
					   
					   		<td>Reprocesado</td>
					  
				 </tr></thead>
					<%for (int j=0; j< detallemov.size(); j++) {
						d= (DetalleMovimiento)detallemov.get(j);
						if (j % 2 == 0)
							styleClass = "class=\"celda-clave2\"";
						else
							styleClass = "class=\"celda-clave1\"";
						%>		
				<tr>				   
				   <td data-title="Valor Total del Formulario"><%=f.formatMonto(d.getValor())%></td>				 				   
				   <td data-title="Numero de Declaración"><%=d.getSecuenciaDeclaracion()%></td>		
				   <td data-title="Estado"><bean:message key="<%=getDescEstado(d.getEstado())%>"/></td>
				   <td data-title="Formulario"><% if (d.getNombreFormulario() != null){%>
						<a  href="javascript:_submit(<%=i%>,<%=j%>);"><%=d.getCodigoFormulario()%>-<%=d.getNombreFormulario()%></a>
					<%}else{%>
						&nbsp;
					<%}%></td>	
					
	                      <%if(d.getReproceso().equals("0")){ %>
			                    <td data-title="Reprocesado"></td>
			                    <% } else { %>
			                    <td data-title="Reprocesado"><a href="javascript:_reproceso(<%=i%>,<%=j%>);">Consultar</a></td>
			                    <%} %>
	                  
				</tr>
		<% }  %><!-- cierra llave del ciclo for de j  -->
     		</table></div></div>
		<% }  %>
		
		
	    
	    </td>
	 </tr>
<%} /* End for - loop*/ %>

</table></div>
<script>
function _reproceso( index, index2){
     document.forms['formularioForm2'].indice.value = index;
	document.forms['formularioForm2'].indice2.value = index2;
	document.forms['formularioForm2'].submit();
}

function _submit(index, index2){
	document.forms['formularioForm'].indice.value = index;
	document.forms['formularioForm'].indice2.value = index2;
	document.forms['formularioForm'].submit();
}
function __refresh(){
	document.forms['consultaEstadoForm'].submit();
}
</script>
<html:form action="/consulta/estado/reproceso" method="post">
	<html:hidden property="indice"/>
	<html:hidden property="indice2"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
</html:form>
<html:form action="/consultar/formulario/read-only" method="post" target="_formulario">
	<html:hidden property="indice"/>
	<html:hidden property="indice2"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
</html:form>

<div align="center"><input type="image" onclick="printPage3()" src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32"></div>

<div align="center"><br>
				<INPUT class="btn btn-default" onclick="__return()" type=button value="<bean:message key="lbl.retroceder"/>"></div>		
							
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
			<INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/seleccion/estado.do'/>'" type=button value="<bean:message key="lbl.retroceder"/>"></div>
			
			<br> 

<%
}
%>
</div>
    
<!--fin - estado de cuenta-->
<div></div>
<!--nota-->
<div id="notas" style="display:none">
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
<div>
<div id=bk2 align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>" width="260" height="68"></div>





        <div class="panel panel-default">
					 <div class="panel-heading" align="left"><img  src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.aviso.debito.titulo"/></strong></div>


</div>


<br>


<div align="right"><a href="javascript:ocultarNotas();"><INPUT class="btn btn-default" onclick="javascript:ocultarNotas();" type="button" value="<bean:message key="lbl.retroceder"/>"></a></div>





<br>




<div align="center" class="subtitulos"><SPAN id="tituloNota"><bean:message key="lbl.aviso.debito.cuenta.corriente"/></SPAN></div>



<br>
<br>







<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.1"/>:</strong></div>
  <div class="col-md-2" align="left"><SPAN id="nombreCuenta"></SPAN></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
   <div class="col-md-1"></div>
</div>


<br>
                  
                  
                  
                  
                  
  
<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.2"/>:</strong></div>
  <div class="col-md-2" align="left"><SPAN id="numeroCuenta"></SPAN></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
   <div class="col-md-1"></div>
</div>
                  
                  
         <br>      
         
         
         
         
         <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.3"/>:</strong></div>
  <div class="col-md-2" align="left"><SPAN id="fecha"></SPAN></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
   <div class="col-md-1"></div>
</div>   
                  
                  
              <br>      
         
         
         
         
         <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.4"/>:</strong></div>
  <div class="col-md-3" align="left"><SPAN id="moneda"></SPAN></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.5"/></div>
  <div class="col-md-2"><SPAN id="importe"></SPAN></div>
   <div class="col-md-1"></div>
</div>   
                        
              <br>      
         
         
         
         
         <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.6"/>:</strong></div>
  <div class="col-md-3" align="left"><SPAN id="concepto"></SPAN></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
   <div class="col-md-1"></div>
</div>   


              <br>      
         
         
         
         
         <div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><span id="lblAtt" style="display:none"><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.7"/></b></span></strong></div>
  <div class="col-md-2" align="left"><SPAN id="nombreUsuario" style="display:none"></SPAN></div>
  <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
   <div class="col-md-1"></div>
</div>   
  


      </div>
      
      	<br> 
      
          <div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
          
          	<br>
                <div align="center">
					<a href="javascript:__download()"><img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0"><bean:message key="lbl.descargar.pdf"/></a>
					</div>
					
						<br>

      
    
</div>

			
				<br>
<!--fin nota-->
<%@ include file="../footer.jsp"  %>
</div>
</body>
</html:html>
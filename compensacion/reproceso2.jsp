<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@page import="com.arango.common.util.Format" %>
<%@page import="com.arango.internet.banking.EstadoCuenta" %>
<%@page import="com.arango.internet.banking.Movimiento" %>
<%@page import="com.arango.internet.banking.Titular" %>
<%@page import="com.arango.common.util.StringUtilities" %>
<%@page import="com.arango.internet.banking.DetalleMovimiento" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

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
	pageContext.forward(request.getContextPath()+ "/mant/modificar.do");  
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
session.setAttribute("form.back","/consulta/estado/reprocesar");
%>
<%@ include file="../head.jsp"%>

<SCRIPT language=javascript src="<html:rewrite page='/scripts/NotasDebitoCredito.js'/>"></SCRIPT>
<script language=javascript>
function __download(){
	document.forms["pdoc"].submit();
}
function __return(){
	document.forms['movimientoForm'].submit();
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
function __asociar(index, index2){
	document.forms["formularioForm4"].indice.value=index;
	document.forms["formularioForm4"].indice2.value = index2;
	document.forms["formularioForm4"].submit();
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
					<bean:message key="lbl.compensacion.menu.reprocesos"/> - 
					<%
					Object obj = session.getAttribute("con.tipo.mov");
					String tipo = obj == null ? "1" : obj.toString();
					if ("1".equals(tipo)){%>
					<bean:message key="tit.title.consulta.movimientos.dia"/>
					<%}else if ("2".equals(tipo)){%>
					<bean:message key="tit.title.consulta.movimientos.mes.actual"/>
					<%}else if ("3".equals(tipo)){%>
					<bean:message key="tit.title.consulta.movimientos.historico"/>
					<%}%>
					</div></td>
				<td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="__return()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
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
<%if (!"1".equals(tipo)){%>
<table width="40%" border="0" cellpadding="0" cellspacing="2" align="center">
		<tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.desde"/></div></td>
          <td height="15" class="bienvenida" align="right"><%=f.formatFecha((java.util.Date)session.getAttribute("fecha.desde"), locale)%></td>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.hasta"/></div></td>
          <td height="15" class="bienvenida" align="right"><%=f.formatFecha((java.util.Date)session.getAttribute("fecha.hasta"), locale)%></td>
       </tr>
</table>

<%}%>
<html:form action="/reproceso" method="post"> <!-- /asociar-->
	<html:hidden property="indice"/>
	<html:hidden property="indice2"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
	<html:hidden property="est" value="R"/>
	<html:hidden property="unico" value="S"/>
</html:form>
<html:form method="post" action="<%=session.getAttribute("form.back")%>">
<html:hidden property="tipo" value="3"/>
<html:hidden property="cuenta" value="<%=cuentaCSIC%>"/>
<html:hidden property="desde" value="<%=strFechaDesde%>"/>
<html:hidden property="hasta" value="<%=strFechaHasta%>"/>
<html:hidden property="estado" value="<%=session.getAttribute("estado.consulta")%>"/>
</html:form>
<table width="40%" border="0" cellpadding="0" cellspacing="2" align="center">
		<tr> 
		  <td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.numero.cuenta"/></div></td>
          <td align="right" height="15" class="bienvenida"><%=f.formatCuenta(ec.getNumeroCuenta())%></td>
       </tr>
		<tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.titular"/></div></td>
          <td height="15" align="right" class="bienvenida"><%=cliente%></td>
       </tr>
</table>	   
<table width="40%" border="0" cellpadding="0" cellspacing="2" align="center">	   
<tr> 
					  <td height="15" colspan="2" nowrap>
								<div align="left" class="texto-acceso"><br>
									<bean:message key="lbl.cc.descripcion.observacion"/><br></div></td></tr>
</table>
<br>
<table width="100%" border="0" cellpadding="1" cellspacing="2">

<tr class="tabla-acceso">
<tr class="tabla-acceso">
	<td class="texto-acceso" width="20%"><bean:message key="lbl.fecha"/></TD>
    <td class="texto-acceso" width="40%"><bean:message key="lbl.descripcion"/></TD>
 	<td class="texto-acceso" width="20%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="lbl.debito"/></TD>
    <td class="texto-acceso" width="20%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="lbl.credito"/></TD>
    
</tr>
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
    <TD class="bienvenida" align=left width="14%">
    <%if(m.getDetalle()!=null){ %>
    <a href="javascript:__showHideElement('iddeta<%=m.getSecuencia()%>')" title="Ver Detalle">+</a>&nbsp;
    <%} %>
    <%=f.formatFecha(m.getFechaValida(), locale)%></TD>
    
    <% if (0==m.getTipo()){ // Si tipo == movimiento se utilize el td existente (link actual)%>
    <TD class="bienvenida" style="color:blue;CURSOR: hand" 
    <%if ("D".equals(m.getTipoTransaccion())){%>
    onclick="mostrarNotaDebito(<%=i %>,'<bean:message key="lbl.aviso.debito.cuenta.corriente"/>','<bean:message key="lbl.debitamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFechaValida(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(cliente)%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda() %>');" 
    <%}else{%>
	onclick="mostrarNotaCredito(<%=i %>,'<bean:message key="lbl.aviso.credito.cuenta.corriente"/>','<bean:message key="lbl.acreditamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFechaValida(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(cliente)%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda() %>');" 
	<%}%>
    align=left width="30%"><SPAN id=desc style="color:blue;hand;font-size:10px;font-family: Verdana, Arial, Helvetica, sans-serif;"><%=m.getDescripcion()%></SPAN></TD>
    <%}
else{  // si tipo == D se crea Nuevo link %>
<TD class="bienvenida" 
    align=left width="30%" style="color:blue;CURSOR: hand" onclick="location.href='<%=request.getContextPath() %>/detalles/movimiento.do?secuencia=<%=m.getSecuencia() %>'"><SPAN id=desc style="color:blue;hand;font-size:10px;font-family: Verdana, Arial, Helvetica, sans-serif;"><%=m.getDescripcion()%></SPAN></TD>
<%} %>
<TD class="bienvenida" align=right width="5%"><%="D".equals(m.getTipoTransaccion())?f.formatMonto(m.getMonto()):"&nbsp;"%></TD>
    <TD class="bienvenida" align=right width="5%"><%="C".equals(m.getTipoTransaccion())?f.formatMonto(m.getMonto()):"&nbsp;"%></TD>
    
    </TR>
<tr>
	    <td colspan="6">
	    
	    			<% ArrayList detallemov = m.getDetalle();
		if (detallemov != null) { 
			DetalleMovimiento d = null;
	  %>
           <div id="iddeta<%=m.getSecuencia()%>" sytle="display:none;">
			  <table align="right" width="95%" border="0" cellpadding="1" cellspacing="2">
				   <tr class="tabla-acceso">		               
					   <td class="texto-acceso" width="10%">Valor Total del Formulario</td>					 					   
					   <td class="texto-acceso" width="10%">N�mero Declaraci�n</td>
					   <td class="texto-acceso" width="10%">Estado</td>
					   <td class="texto-acceso" width="50%">Formulario</td>
					   <td class="texto-acceso" width="20%"></td></tr>					   
					    
					   
				 </tr>
					<%for (int j=0; j< detallemov.size(); j++) {
						d= (DetalleMovimiento)detallemov.get(j);
						
						if (j % 2 == 0)
							styleClass = "class=\"celda-clave2\"";
						else
							styleClass = "class=\"celda-clave1\"";
						
						%>		
				<tr class="tabla-acceso">				   
				   <td class="bienvenida" align="right"><%=f.formatMonto(d.getValor())%></td>				 				   
				   <td class="bienvenida" align="center"><%=d.getSecuenciaDeclaracion()%></td>		
				   <td class="bienvenida"><bean:message key="<%=getDescEstado(d.getEstado())%>"/></td>
				   <td class="bienvenida"><% if (d.getNombreFormulario() != null){%>
						<a  href="javascript:_submit(<%=i%>,<%=j%>);"><%=d.getCodigoFormulario()%>-<%=d.getNombreFormulario()%></a>
					<%}else{%>
						&nbsp;
					<%}%></td>						   				  
					<td class="bienvenida" align=right width="5%"><input type="button" name="btn<%=i%>" value="Cambio Formulario" onclick="__asociar(<%=i %>,<%=j%>)"/></td>
				</tr>
		<% }  %>
     		</table></div>
		<% }  %><!-- cierra la validacion cuando el detalle es diferente de null -->
		
		
	    
	    </td>
	 </tr>
<%} /* End for - loop*/ %>

</table>
<script>
function _submit(index, index2){
	document.forms['formularioForm'].indice.value = index;
	document.forms['formularioForm'].indice2.value = index2;
	document.forms['formularioForm'].submit();
}
</script>
<html:form action="/consultar/formulario" method="post" target="_formulario">
	<html:hidden property="indice"/>
	<html:hidden property="indice2"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
	<html:hidden property="est" value="R"/>
	<html:hidden property="unico" value="U"/>
</html:form>
<table width="80%" border="0" cellpadding="0" cellspacing="2">
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><input type="image" onclick="printPage3()" src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32"></div></td>
	</tr>
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
				<INPUT class="botton" onclick="__return()" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
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
			<INPUT class="botton" onclick="document.location='<html:rewrite page='/mant/reprocesar.do'/>'" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
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
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@page import="com.arango.common.util.Format"%>
<%@page import="com.arango.internet.banking.Titular"%>
<%@page import="com.arango.internet.banking.EstadoCuenta"%>
<%@page import="com.arango.internet.banking.Movimiento"%>
<%@page import="com.arango.common.util.StringUtilities" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.arango.internet.banking.Analisis" %>
<%! Format f = Format.getFormat();%>
<%!
private String getDescripcion(String text){
    if (text == null)
		return "";
    String temp = StringUtilities.replace(text, "\"","&#034;");
    temp = StringUtilities.replace(temp, "\n", " ");
    temp = StringUtilities.replace(temp, "\r", "\\r");
    temp = StringUtilities.replace(temp, "\"", "\\\"");
    temp = StringUtilities.replace(temp, "'", "\\'");
    temp = temp.replace('\n', ' ');
    temp = temp.replace('\r', ' ');

    return temp;
}
%>

<%! private String formatDocument(String doc){
      String year = doc.substring(doc.length() - 2, doc.length());
      String num = doc.substring(2, doc.length()- 2);
      return num+"-"+year;  
    }
%>

<%@ include file="../head.jsp"  %>

<%
ArrayList plus = (ArrayList)session.getAttribute("plus.special");
Analisis analisis = new Analisis();
analisis =  (Analisis)plus.get(0);
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (plus == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/ib/systemError2.jsp");   
}



String titulares="";
String codigoCliente = "";
  

String tipoEst = "";
String descTipoEst = "";
String backPage="";





if (request.getParameter("backPage") != null)
  backPage=(String)request.getParameter("backPage");
  
String cuentaReq="";
String tipo="";

if (request.getParameterValues("cuentas")!= null)
  cuentaReq =request.getParameterValues("cuentas")[0];

if (request.getParameterValues("tipo")!= null)
  tipo =request.getParameterValues("tipo")[0];
  

String back="do.consulta?cuentas="+cuentaReq+"&tipo="+tipo+"&tipoEst="+tipoEst;
%>

<SCRIPT language=JavaScript src="../scripts/NotasDebitoCredito.js"></SCRIPT>
<script language=javascript>
function __download(){
	document.forms["pdoc"].submit();
}
function __downloadDoc(){
	document.forms["pdoc"].submit();
}


</script>
<SCRIPT language=JavaScript src="../scripts/formatDes.js"></SCRIPT>

<%@ include file="../body.jsp"%>
<!--estado de cuenta-->
<div id="estcta">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	   <tr> 
		<td height="30" class="texto-acceso"><div id=bankdiv align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>"></div></td>
		<td class="texto-acceso"><div align="right">&nbsp;</div></td>
	  </tr>
	  <tr> 
		<td height="40" colspan="2" valign="bottom"><div align="left"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			  <tr> 
				<td width="92%"><div align="left" class="login">Análisis de la Cuenta</div></td>
				<td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="history.back();" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
			  </tr>
			</table></div></td>
	  </tr>
	  <tr> 
		<td valign="top" align="center">
			<table width="100%" border="0" cellspacing="2" cellpadding="2">                   
				<tr> 
				  <td width="55%" height="20" class="catra-texto" align="center">
				 
				 <table width="55%" border="0" cellpadding="2" cellspacing="2" align="center">
					 <tr> 
					  <td height="15" class="celda-clave1">
								<div align="right" class="texto-acceso">Período del Mes</div></td>
					  <td height="15" class="bienvenida" align="right"><%=analisis.getPeriodomes()%></TD>
					</TR>
						<tr> 
					  <td height="15" class="celda-clave1">
								<div align="right" class="texto-acceso">Nombre del Cliente</div></td>
					  <td height="15" class="bienvenida" align="right"><%= analisis.getNombreCliente() %></TD>
					  </TR>
					<tr> 
					  <td height="15" class="celda-clave1">
								<div align="right" class="texto-acceso">Cuenta No.</div></td>
					  <td height="15" class="bienvenida" align="right"><%=f.formatCuenta( analisis.getCta(), "C")%></TD>
					 </TR>
				<tr> 
					  <td height="15" colspan="2">
								<div align="left" class="texto-acceso"><br>
									<bean:message key="lbl.cc.descripcion.observacion"/><br></div></td></tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="2">
<tr>
   <td class="texto-acceso">Descripción de Cargos</td>
</tr>
<tr class="tabla-acceso">
	<td class="texto-acceso" width="10%" nowrap>Descripción</TD>
    <td class="texto-acceso" width="10%">Volumen</TD>
    <td class="texto-acceso" width="39%">Costo por Unidad</TD>
    <td class="texto-acceso" width="8%">Total</TD>    
</TR>
  

<TR valign="top">
	<td class="bienvenida" nowrap>Costo por Transferencias electrónicas</td>
    <td class="bienvenida" nowrap><%= analisis.getCantTrans() %></td>
  	<td class="bienvenida" nowrap><%= f.formatMonto(analisis.getCostoUnidad()) %></td>
  	<td class="bienvenida" nowrap><%= f.formatMonto(analisis.getSubTotal()) %></td>
    
</tr>
<TR valign="top">
	<td class="bienvenida" nowrap>Costo por Transferencias electrónicas</td>
    <td class="bienvenida" nowrap align="center">1</td>
  	<td class="bienvenida" nowrap><%= f.formatMonto(analisis.getCostoFijo()) %></td>
  	<td class="bienvenida" nowrap><%= f.formatMonto(analisis.getCostoFijo()) %></td>
    
</tr>
<tr>
   <td class="bienvenida" nowrap>&nbsp;</td>
   <td class="bienvenida" nowrap>&nbsp;</td>
  	<td class="bienvenida" nowrap>Sub Total</td>
  	<td class="bienvenida" nowrap><%= f.formatMonto(analisis.getTotal()) %></td>
<tr>
  
</tr>

</table>



<table width="100%" border="0" cellpadding="0" cellspacing="2">
<tr>
   <td class="texto-acceso">Detalle de Cargos</td>
</tr>
<tr class="tabla-acceso">
	<td class="texto-acceso" width="10%" nowrap>Descripción</TD>
    <td class="texto-acceso" width="10%">Volumen</TD>
    <td class="texto-acceso" width="39%">Costo por Unidad</TD>
    <td class="texto-acceso" width="8%">Total</TD>    
</TR>
  
<%
String styleClass = "";
Analisis a = null;
for (int i = 0; i < plus.size(); i++){
	a = (Analisis)plus.get(i);	
	if (i % 2 == 0)
		styleClass = "";
	else
		styleClass = "class=\"celda-clave1\"";
%>
<TR valign="top" <%=styleClass%>>
	<td class="bienvenida" nowrap><%=getDescripcion(a.getDescripcion())%></td>
    <td class="bienvenida" nowrap align="center">1</td>
  	<td class="bienvenida" nowrap><%= f.formatMonto(a.getCargosCostoUnidad()) %></td>
  	<td class="bienvenida" nowrap><%= f.formatMonto(a.getCargosTotal()) %></td>
    
</tr>
<%} /* End for - loop */ %>  
<tr>
   <td class="bienvenida" nowrap>&nbsp;</td>
   <td class="bienvenida" nowrap>&nbsp;</td>
  	<td class="bienvenida" nowrap>Sub Total</td>
  	<td class="bienvenida" nowrap><%= f.formatMonto( analisis.getSubTotal()) %></td>
<tr>
  
</tr>

</table>
<table width="100%" border="0" cellpadding="0" cellspacing="2">
<tr>
   <td class="texto-acceso">Detalle de la Cuenta</td>
</tr>

<tr class="tabla-acceso">
	<td class="texto-acceso" width="10%" nowrap>Saldo Promedio Total</TD>
	<td class="bienvenida" nowrap><%= f.formatMonto(analisis.getSaldoPromedioTotal()) %></td>
	<td class="bienvenida" nowrap>&nbsp;</td>
</tr>
<tr>
    <td class="texto-acceso" width="10%">Saldo Promedio Neto</TD>
    <td class="bienvenida" nowrap><%= f.formatMonto(analisis.getSaldoPromedioNeto()) %></td>
    <td class="bienvenida" nowrap>&nbsp;</td>
</tr>
<tr>
    <td class="texto-acceso" width="39%">Intereses sobre Saldo Promedio</TD>
    <td class="bienvenida" nowrap><%=f.formatMonto(analisis.getInteresSaldoPromedio()) %></td>
    <td class="bienvenida" nowrap> <%= analisis.getInteresSaldoPromedioProcentaje() %></td>
</tr>
<tr>
    <td class="texto-acceso" width="8%">Saldo a Favor</TD>   
    <td class="bienvenida" nowrap><%=f.formatMonto(analisis.getSaldoFavor()) %></td> 
    <td class="bienvenida" nowrap>&nbsp;</td>
</TR>
<tr>
     <td class="bienvenida" nowrap>&nbsp;</td>
     <td class="bienvenida" nowrap>&nbsp;</td>
     <td class="bienvenida" nowrap><%=f.formatMonto(analisis.getSubTotal()) %></td>    
</TR>
<tr>
     <td class="bienvenida" nowrap>&nbsp;</td>
     <td class="bienvenida" nowrap>&nbsp;</td>
     <td class="bienvenida" nowrap><%=f.formatMonto(analisis.getCostoFijo()) %></td>    
</TR>
<tr>
     <td class="bienvenida" nowrap>&nbsp;</td>
     <td class="bienvenida" nowrap>Saldo a Favor</td>
     <td class="bienvenida" nowrap><%=f.formatMonto(analisis.getTotal()) %></td>    
</TR>
</table>
<table width="80%" border="0" cellpadding="0" cellspacing="2">
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div></td>
	</tr>
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
				<a href="<html:rewrite page='/consulta/estadoctapdf.jsp'/>" target="_new"><img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0"><bean:message key="lbl.descargar.pdf"/></a>
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br><INPUT class="botton" onclick="history.back();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>	
</table></table></div>
    
<!--fin - estado de cuenta-->

<!--nota-->
<DIV id=notas style="display:none" align="center">
<form name="pdoc" action="<html:rewrite page='/note.download'/>" target="_new" method="post">
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
                <td height="40" colspan="2" valign="bottom"><div align="center"> 
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
                <td colspan="2" align="center" valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="2">
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
                      <td height="20" class="bienvenida" align="left"><b><span id="lblAtt" style="display:none"><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.7"/></span></b></td>
                      <td class="bienvenida" align="left"><SPAN id="nombreUsuario" style="display:none"></SPAN></td>
                    </tr> 
                  </table></td>
              </tr>
              <tr> 
                <td colspan="2" valign="top">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="2" valign="top" class="texto-acceso"><div align="center">                
                <a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
                <div align="center">  <br>
				<a href="javascript:__download()"><img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0"><bean:message key="lbl.descargar.pdf"/></a></div>
				<br></td>
	</tr>
	<tr> 
	<td valign="top" class="texto-acceso"><div align="center"><br>
			<INPUT class="botton" onclick="javascript:ocultarNotas();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>

      </table></DIV>
<!--fin nota-->

<%@ include file="../footer.jsp"  %>
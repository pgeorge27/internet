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
<%@ page import="java.util.Locale" %>

<%! Format f = Format.getFormat();%>
<%!
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
	pageContext.forward("/servicios/movimiento.jsp");   
	return;
}
String cuenta = (String)session.getAttribute("cuenta.banco");
String cliente = ((Titular)ec.Titulares.get(0)).getNombre();
%>

<!DOCTYPE html>
<html:html>

<head>
<%@ include file="../head.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>

<SCRIPT language=javascript src="../scripts/NotasDebitoCredito.js"></SCRIPT>
<script language=javascript>
function __download(){
	document.forms["pdoc"].submit();
}
</script>
<SCRIPT language=javascript src="../scripts/formatDes.js"></SCRIPT>
<%@ include file="../body.jsp"%>


<body>

<div class="container"> 

<div id="estcta" align="left">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr> 
		<td height="30" class="texto-acceso"><div id=bankdiv align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>"  width="116" height="68"></div></td>
		<td class="texto-acceso"><div align="right">&nbsp;</div></td>
	  </tr>

	<div align="left" class="login">
					<%
					Object obj = session.getAttribute("con.tipo.mov");
					String tipo = obj == null ? "1" : obj.toString();
					if ("1".equals(tipo)){%>

				


	<div class="row">
 
  <div class="col-md-10"  style="font-size: 14px;"><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.title.consulta.movimientos.dia"/></strong></div>
</div>




					<%}else if ("2".equals(tipo)){%>					
					

	<div class="row">
 
  <div class="col-md-10"  style="font-size: 14px;"><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.title.consulta.movimientos.mes.actual"/></strong></div>
</div>



					<%}else if ("3".equals(tipo)){%>


	<div class="row">
 
  <div class="col-md-10"  style="font-size: 14px;"><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.title.consulta.movimientos.historico"/></strong></div>
</div>


					<%}%>
					</div>
				
			</div>
	
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
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




<div class="row">
  <div class="col-md-3"><div align="left"" class=""><strong><bean:message key="lbl.desde"/>:</strong></div></div>
  <div class="col-md-3" align="left"><%=f.formatFecha((java.util.Date)session.getAttribute("fecha.desde"), locale)%></div>
  <div class="col-md-3" align="left"><div class=""><strong><bean:message key="lbl.hasta"/>:</strong></div></div>
  <div class="col-md-3" align="left"><%=f.formatFecha((java.util.Date)session.getAttribute("fecha.hasta"), locale)%></div>


</div>


<%}%>



<br>




<div class="row">
  <div class="col-md-3"><div align="left"" class=""><strong><bean:message key="lbl.numero.cuenta"/>:</strong></div></div>
  <div class="col-md-3" align="left"><%=f.formatCuenta(ec.getNumeroCuenta())%></div>
  <div class="col-md-3" align="left"></div>
  <div class="col-md-3" align="left"></div>


</div>


<br>



<div class="row">
  <div class="col-md-3"><div align="left"" class=""><strong><bean:message key="lbl.titular"/>:</strong></div></div>
  <div class="col-md-3" align="left"><%=((Titular)ec.Titulares.get(0)).getNombre()%></div>
  <div class="col-md-3" align="left"></div>
  <div class="col-md-3" align="left"></div>


</div>





<br>



<div class="row">
  <div class="col-md-3"><div align="left"" class=""><strong><bean:message key="lbl.moneda"/>:</strong></div></div>
  <div class="col-md-3" align="left"><%=ec.getMoneda()%></div>
  <div class="col-md-3" align="left"></div>
  <div class="col-md-3" align="left"></div>


</div>


<br>



<br>



<div class="row">
  <div class="col-md-6"><div align="left"" class=""><strong><bean:message key="lbl.cc.descripcion.observacion"/></strong></div></div>

  <div class="col-md-3" align="left"></div>
  <div class="col-md-3" align="left"></div>


</div>


<br>






<div id="no-more-tables">
<table class="col-md-12 table-bordered table-striped table-condensed cf">
<thead class="cf">   

<tr class="tabla-acceso">
	<td class="texto-acceso" ><bean:message key="lbl.fecha"/></TD>
    <td class="texto-acceso" ><bean:message key="lbl.descripcion"/></TD>
    <td class="texto-acceso"><bean:message key="lbl.referencia"/></TD>
    <td class="texto-acceso" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="lbl.debito"/></TD>
    <td class="texto-acceso"  align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="lbl.credito"/></TD></TR></thead> 
  
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
    <TD data-title="Fecha" class="bienvenida" align=left ><%=f.formatFecha(m.getFechaValida(), locale)%></TD>
    <TD data-title="Descripción" class="bienvenida" style="color:blue;CURSOR: hand" 
    <%if ("D".equals(m.getTipoTransaccion())){%>
    onclick="mostrarNotaDebito(<%=i %>,'<bean:message key="lbl.aviso.debito.cuenta.corriente"/>','<bean:message key="lbl.debitamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFechaValida(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(cliente)%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda() %>');" 
    <%}else{%>
	onclick="mostrarNotaCredito(<%=i %>,'<bean:message key="lbl.aviso.credito.cuenta.corriente"/>','<bean:message key="lbl.acreditamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFechaValida(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(cliente)%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda() %>');" 
	<%}%>
    align=left><a><SPAN id=desc style="color:blue;hand;font-size:10px;font-family: Verdana, Arial, Helvetica, sans-serif;"><%=m.getDescripcion()%></SPAN></a></TD>
    <TD data-title="Referencia" class="bienvenida" align=middle ><%=m.getNumeroDocumento()==null?"":m.getNumeroDocumento()%></TD>
    <TD data-title="Débito" class="bienvenida" align=right ><%="D".equals(m.getTipoTransaccion())?f.formatMonto(m.getMonto()):"&nbsp;"%></TD>
    <TD data-title="Crédito" class="bienvenida" align=right ><%="C".equals(m.getTipoTransaccion())?f.formatMonto(m.getMonto()):"&nbsp;"%></TD></TR>
<%} /* End for - loop*/ %>

</table></div>



	<div align="center"><input type="image" onclick="printPage3()" src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32"></div>


<div align="center"><br>
				<INPUT class="btn btn-default" onclick="history.back();" type=button value="<bean:message key="lbl.retroceder"/>"> </div>
				
<%
}
else
{
%>










          <div class="row" style="padding-left: 3%; padding-right: 3%; padding-top: 30px;">

		  <div class="row"><div class="col-md-4 col-md-offset-4">
		
				<div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong>Mensaje</strong></div>
					 
					 <br>
                  					 <div class="row" align="center">
                                        <div class="col-md-4"></div>
 <div class="col-md-4"> <img src="<html:rewrite page='/images/success.gif'/>"></div>
                                       <div class="col-md-4"></div>
                  </div>
                  <br>
					 <div class="row" style="padding-right: 3%; padding-left: 3%;">
                       
					 
  <div class="col-md-2"></div>
  <div class="col-md-8" align="center"><bean:message key="msg.sin.movimentos"/></div>
  <div class="col-md-2"></div>
  <br>
   <br>
  <br>
<div align="center">

<INPUT class="btn btn-default" onclick="history.back();" type=button value="<bean:message key="lbl.retroceder"/>"> </div>
  
   <br>
                        </div>
					 
					 
						 <br>
						
					</div>
				
						</div>
							</div>

                </div>





























<%
}
%>
</table>


</div>
</table>
</div>
    
<!--fin - estado de cuenta-->
<div></div>
<!--nota-->
<div id="notas" style="display:none" align="center">
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
                <td height="30" class="texto-acceso"><div id=bk2 align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>" width="116" height="68"></div></td>
                <td class="texto-acceso">&nbsp;</td>
              </tr>
              <tr> 
                <td height="40" colspan="2" valign="bottom"><div align="left"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td width="92%"><div align="left" class="login"><bean:message key="lbl.aviso.debito.titulo"/></div></td>
                      <td width="8%"><div align="right">&nbsp;
							<!-- a href="javascript:ocultarNotas();"><INPUT class="botton" onclick="javascript:ocultarNotas();" type="button" value="<bean:message key="lbl.retroceder"/>"> </a --> </div></td>
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
                <td colspan="2" valign="top" class="texto-acceso"><div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a>
                <br>
					<a href="javascript:__download()"><img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0"><bean:message key="lbl.descargar.pdf"/></a>
					<br></div></td>
	</tr>
	<tr> 
	<td valign="top" class="texto-acceso"><div align="center"><br>
			<INPUT class="botton" onclick="javascript:ocultarNotas();" type=button value="<bean:message key="lbl.retroceder"/>"> </div></td>
	</tr>
      </table>
</div>
<!--fin nota-->
<%@ include file="../footer.jsp"  %>
</div>
</body>
</html:html>
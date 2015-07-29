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

<!DOCTYPE html>
<html:html>

<head>
<%@ include file="../head.jsp"  %>

<%
String cuentaCISC =  (String)session.getAttribute("cuenta.csic");
EstadoCuenta ec = (EstadoCuenta)session.getAttribute("estado.cta");
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (ec == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/ib/systemError2.jsp");   
}

ArrayList clientes = ec.Titulares;
ArrayList Movimientos = ec.Movimientos;
String titulares="";
String codigoCliente = "";
if (clientes.size() > 0){
  titulares=((Titular)clientes.get(0)).getNombre();
  codigoCliente=((Titular)clientes.get(0)).getCodigoCliente();
}  

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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>

<%@ include file="../body.jsp"%>

<body>



<div align="center" class="container"> 


 <div class="row">
 
 <div class="col-md-2"></div>

          <div class="col-md-8"><div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.title.consulta.estado.cuenta.cc"/></strong></div>
  <div class="panel-body">



<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.desde"/>:</strong></div>
    <div class="col-md-2" align="left"><%=f.formatFecha((java.util.Date)ec.getFechaInicio(), locale)%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2" align="left"><strong><bean:message key="lbl.hasta"/>:</strong></div>
  <div class="col-md-2" align="left"><%=f.formatFecha((java.util.Date)ec.getFechaFin(), locale)%></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-5" align="left"><strong><bean:message key="lbl.cuenta.corriente"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatCuenta(ec.getNumeroCuenta(), "C")%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
  <div class="col-md-1"></div>

 </div>

<br>



<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-5" align="left"><strong><bean:message key="lbl.titular"/>:</strong></div>
    <div class="col-md-3" align="left"><%=((Titular)ec.Titulares.get(0)).getNombre()%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
  <div class="col-md-1"></div>

 </div>

<br>



<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-5" align="left"><strong><bean:message key="lbl.moneda"/>:</strong></div>
    <div class="col-md-4" align="left"><%=ec.getMoneda()%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
  <div class="col-md-1"></div>

 </div>

<br>


<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-5" align="left"><strong><bean:message key="lbl.saldo.inicio.mes"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(ec.getSaldoAnterior())%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
  <div class="col-md-1"></div>

 </div>

<br>



<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-5" align="left"><strong><bean:message key="lbl.total.cheques.otros.debitos" arg0="<%=String.valueOf(ec.getCantidadDebitos())%>"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(ec.getTotalDebitos())%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
  <div class="col-md-1"></div>

 </div>

<br>



<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-5" align="left"><strong><bean:message key="lbl.total.depositos.otros.creditos" arg0="<%=String.valueOf(ec.getCantidadDepositos())%>"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(ec.getTotalDepositos())%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
  <div class="col-md-1"></div>

 </div>

<br>






<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-5" align="left"><strong><bean:message key="lbl.cc.saldo.fecha"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(ec.getSaldoTotal())%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
  <div class="col-md-1"></div>

 </div>

<br>





<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-5" align="left"><strong><bean:message key="lbl.cc.saldo.reserva"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(ec.getSaldoTransito())%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
  <div class="col-md-1"></div>

 </div>

<br>






<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-5" align="left"><strong><bean:message key="lbl.cc.saldo.disponible"/>:</strong></div>
    <div class="col-md-3" align="left"><%=f.formatMonto(ec.getSaldoDisponible())%></div>
    <div class="col-md-1"></div>
  <div class="col-md-2"></div>
  <div class="col-md-2"></div>
  <div class="col-md-1"></div>

 </div>

<br>


					
								<div align="center">
									<bean:message key="lbl.cc.descripcion.observacion"/></div>




<br>



	<div id="no-more-tables">
				<table class="col-md-12 table-bordered table-striped table-condensed cf">
				<thead class="cf">
<tr class="tabla-acceso">
	<td class="texto-acceso" width="10%" nowrap><bean:message key="lbl.fecha"/></TD>
    <td class="texto-acceso" width="49%"><bean:message key="lbl.descripcion"/></TD>
    <td class="texto-acceso" width="8%"><bean:message key="lbl.referencia"/></TD>
    <td class="texto-acceso" width="16%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="lbl.est.cta.monto"/></TD>
    <td class="texto-acceso" width="17%" align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="lbl.est.cta.detalle.saldo"/></TD></TR></thead>
  
<%
String styleClass = "";
ArrayList mov = Movimientos;
Movimiento m = null;
double monto =  0;

if (mov != null && !mov.isEmpty()){
for (int i = 0; i < mov.size(); i++){
	m = (Movimiento)mov.get(i);
	if ("D".equals(m.getTipoTransaccion()))
		monto = m.getMonto() * -1;
	else{
		monto = m.getMonto();
	}	
	if (i % 2 == 0)
		styleClass = "";
	else
		styleClass = "class=\"celda-clave1\"";
%>
<TR valign="top" <%=styleClass%>>
      	      
    <td data-title="Fecha" class="bienvenida" nowrap><%=f.formatFecha(m.getFechaValida(),locale)%></td>
    
    <td data-title="Descripción" class="bienvenida" style="CURSOR: hand" 
        <%if ("D".equals(m.getTipoTransaccion())){%>
		    onclick="mostrarNotaDebito(<%=i %>,'<bean:message key="lbl.aviso.debito.cuenta.corriente"/>','<bean:message key="lbl.debitamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFecha(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(((Titular)ec.Titulares.get(0)).getNombre())%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda()%>');" 
		    <%}else{%>
			onclick="mostrarNotaCredito(<%=i %>,'<bean:message key="lbl.aviso.credito.cuenta.corriente"/>','<bean:message key="lbl.acreditamos.cuenta.corriente.concepto"/>','<%=f.formatFecha(m.getFecha(),locale)%>','<%=getDescripcion(m.getDescripcion())%>','<%=f.formatMonto(m.getMonto())%>','<%=f.formatCuenta(ec.getNumeroCuenta(), "C")%>','<%=getDescripcion(((Titular)ec.Titulares.get(0)).getNombre())%>','<%=getDescripcion(m.getDireccion())%>','<%=getDescripcion(m.getPais())%>','<%=getDescripcion(m.getUsuario())%>', '<%=ec.getMoneda()%>');" 
			<%}%>
        align=left><SPAN id=desc style="color:blue;hand;font-size:10px;font-family: Verdana, Arial, Helvetica, sans-serif;"><%=m.getDescripcion()%></SPAN>
	</TD>
	
	
	
	
    <td data-title="Referencia" class="bienvenida"><%=m.getNumeroDocumento()==null?"":m.getNumeroDocumento()%></td>
    <td data-title="Valor" class="bienvenida" align="right" nowrap><%=f.formatMonto(monto)%></td>
    <td data-title="Saldo" class="bienvenida" align="right"><%=f.formatMonto(m.getSaldo())%></td>
</tr>
<%} /* End for - loop */ %>  
<%} /* End if  */ %>  
</table>

</div>





<br>


























	<br> 
					  	<div align="center" class="visible-lg">
					
					<div align="center"><a href="javascript:printPage3()"><img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0"></a></div>
	
<div align="center"><a href="javascript:__download()"><img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0"><bean:message key="lbl.descargar.pdf"/></a></div>

	<br> 
  	</div>


  	<div align="center">

			<INPUT class="btn btn-default" style="width: 100px" onclick="javascript:ocultarNotas();" type=button value="<bean:message key="lbl.retroceder"/>">

				</div>
							










 </div>


 </div>

 </div>

 </div>








<!--estado de cuenta-->




    
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
                <td height="30" class="texto-acceso"><div id=bk2 align="left" style="display:none"><img src="<html:rewrite page='/images/logo.jpg'/>" width="116" height="68"></div></td>
                <td class="texto-acceso"><div align="right">
					</div></td>
              </tr>
              <tr> 
                <td height="40" colspan="2" valign="bottom"><div align="center"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td width="92%"><div align="left" class="login"><bean:message key="lbl.aviso.debito.titulo"/></div></td>
                     <td width="8%"><div align="right">&nbsp;
							<!--a href="javascript:ocultarNotas();"><INPUT class="botton" onclick="javascript:ocultarNotas();" type="button" value="<bean:message key="lbl.retroceder"/>"></a--></div></td>
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
			<INPUT class="btn btn-default" onclick="javascript:ocultarNotas();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
			
			


      </table>
      

      
      
      
      
      </DIV>
<!--fin nota-->

<%@ include file="../footer.jsp"  %>
</div>
</body>
</html:html>

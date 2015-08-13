<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@page import="com.arango.common.util.Format" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.arango.internet.banking.EstadoCuenta" %>
<%@page import="com.arango.internet.banking.Movimiento" %>
<%@page import="com.arango.internet.banking.Titular" %>
<%@page import="com.arango.common.util.StringUtilities" %>
<%@ page import="java.util.Locale" %>


<%!
Format f = Format.getFormat();
SimpleDateFormat sdf = new SimpleDateFormat("MM/yyyy");
%>
<%!
private String getDescEstado(String estado){
    if ("P".equals(estado)){
        return "lbl.compensacion.estado.pendiente";
    }
    else if ("M".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente.elaborar";
    }
    else if ("A".equals(estado)){
        return "lbl.compensacion.estado.aprobada";
    }
    else if ("T".equals(estado)){
        return "lbl.compensacion.estado.pendiente.aprobar";
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
String cliente = "";
if (ec.Titulares!=null && !ec.Titulares.isEmpty()){
    cliente = ((Titular)ec.Titulares.get(0)).getNombre();
}

%>
<%@ include file="../../head.jsp"%>

<SCRIPT language=javascript src="<html:rewrite page='/scripts/NotasDebitoCredito.js'/>"></SCRIPT>
<script language=javascript>
function __download(){
	document.forms["pdoc"].submit();
}
function __asociar(index){
	document.forms["modificarForm"].indice.value=index;
	document.forms["modificarForm"].submit();
}
</script>
<SCRIPT language=javascript src="<html:rewrite page='/scripts/formatDes.js'/>"></SCRIPT>
<%@ include file="../../body.jsp"%>

<div class="container">
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

  	<div id=bankdiv align="left" style="display:none">
  		<img src="<html:rewrite page='/images/logo.jpg'/>">
  	</div>

    <div class="col-md-12">
      <div class="panel panel-default" >
        <div class="panel-heading" >
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
            Consulta de Relación de Operaciones de Cuentas de Compensación
          </strong>
        </div>

        <div class="panel-body">

        <div align="right">
          <INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/formulario10/seleccion/estado.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
        </div>

        <%
          if (!mov.isEmpty())
          {
        %>

<html:form action="/asociar" method="post">
  <html:hidden property="indice"/>
</html:form>

<p><b><bean:message key="lbl.numero.cuenta"/></b>
<%=f.formatCuenta(ec.getNumeroCuenta())%></p>

<p><b><bean:message key="lbl.titular"/></b>
<%=cliente%></p>

<hr>

<div class="col-xs-4 hidden-xs">
  <p><b>Período</b></p>
</div>

<div class="col-xs-4 hidden-xs">
  <p><b><bean:message key="lbl.compensacion.consulta.estado.nombre"/></b></p>
</div>

<div class="col-xs-4 hidden-xs">
  <p><b>Estado</b></p>
</div>

 <%
String styleClass = "";
  String est = null;
  String estado = null;  
Movimiento m = null;
for (int i = 0; i < mov.size(); i++){
  m = (Movimiento)mov.get(i);
  if (i % 2 == 0)
    styleClass = "";
  else
    styleClass = "class=\"celda-clave1\"";
  
  est= m.getEstado();
  if("A".equals(est)){
    estado= "Aprobado";
  }else if ("E".equals(est)){
    estado = "Pendiente por Elaborar";
  }else if ("P".equals(est)){
    estado = "Guardado Temporalmente";
  }else if ("T".equals(est)){
    estado = "Pendiente por Aprobar";
  }else if ("X".equals(est)){
    estado = "Rechazados";
  }else if ("R".equals(est)){
    estado = "Reproceso";
  }
  
%>

<div class="col-md-4 visible-xs">
  <p><b>Período</b></p>
    <p><%=sdf.format(m.getFechamovimiento())  %></p>
</div>

<div class="col-md-4 visible-xs">
  <p><b><bean:message key="lbl.compensacion.consulta.estado.nombre"/></b></p>
  <p><a  href="javascript:_submit(<%=i%>);"><%=m.getFormulario() %> - <%=m.getNombre()%></a></p>
</div>

<div class="col-md-4 visible-xs">
  <p><b>Estado</b></p>
  <p><%=estado %></p>
</div>


<div class="col-xs-4 hidden-xs">
    <p><%=sdf.format(m.getFechamovimiento())  %></p>
</div>

<div class="col-xs-4 hidden-xs">
  <p><a  href="javascript:_submit(<%=i%>);"><%=m.getFormulario() %> - <%=m.getNombre()%></a></p>
</div>

<div class="col-xs-4 hidden-xs">
  <p><%=estado %></p>
</div>


<%} /* End for - loop*/ %>

<script>
function _submit(index){
  document.forms['formularioForm'].indice.value = index;
  document.forms['formularioForm'].submit();
}
</script>

<html:form action="/consultar/formulario" method="post" target="_formulario">
  <html:hidden property="indice"/>
  <html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
  <html:hidden property="unico" value="cf10"/>
  <html:hidden property="est" value="."/>
</html:form>

<div class="row"></div>

<div align="center">
  <input class="visible-lg" type="image" onclick="printPage3()" src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32">
</div>

<div align="center">
  <INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/formulario10/seleccion/estado.do'/>'" type=button value="<bean:message key="lbl.retroceder"/>">
</div>

<%
}
else
{
%>

<div align="center">
<p><bean:message key="msg.sin.movimentos"/></p>

<p><INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/formulario10/seleccion/estado.do'/>'" type=button value="<bean:message key="lbl.retroceder"/>"></p>
</div>

<%
}
%>

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

<p><img src="<html:rewrite page='/images/logo.jpg'/>"></p>
<p><bean:message key="lbl.aviso.debito.titulo"/></p>

<p><a href="javascript:ocultarNotas();"><INPUT class="botton" onclick="javascript:ocultarNotas();" type="button" value="<bean:message key="lbl.retroceder"/>"></a></p>

<p><SPAN id="tituloNota"> <bean:message key="lbl.aviso.debito.cuenta.corriente"/></SPAN></p>

<p><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.1"/></b><SPAN id="nombreCuenta"></SPAN></p>

<p><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.2"/></b><SPAN id="numeroCuenta"></SPAN></p>

<p><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.3"/></b><SPAN id="fecha"></SPAN></p>

<p><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.4"/></b><SPAN id="moneda"></SPAN></p>

<p><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.5"/></b><SPAN id="importe"></SPAN></p>

<p><b><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.6"/></b><SPAN id="concepto"></SPAN></p>

<p><b><span id="lblAtt" style="display:none"><bean:message key="lbl.aviso.db.cr.cuenta.corriente.linea.7"/></b></span><SPAN id="nombreUsuario" style="display:none"></SPAN></p>

<div class="row"></div>

<div align="center">
  <a href="javascript:printPage3()">
    <img src="<html:rewrite page='/images/printer2.jpg'/>" width="37" height="32" border="0">
  </a>
</div>

<div class="row"></div>

<div align="center">
  <a href="javascript:__download()">
    <img src="<html:rewrite page='/images/icono_acrobat.gif'/>" border="0">
      <bean:message key="lbl.descargar.pdf"/>
  </a>
</div>

<div class="row"></div>

<div align="center">
  <INPUT class="botton" onclick="javascript:ocultarNotas();" type=button value="<bean:message key="lbl.retroceder"/>">
</div>

</div>
        </div>

      </div>
    </div>
  </div>
</div>
<!--fin nota-->
<%@ include file="../../footer.jsp"  %>

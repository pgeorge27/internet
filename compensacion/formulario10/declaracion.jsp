<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="com.arango.common.util.Format" %>
<%@page import="com.arango.internet.banking.Movimiento" %>
<%@page import="com.arango.internet.banking.EstadoCuenta" %>
<%@page import="com.arango.internet.banking.Titular" %>

<%! Format f = Format.getFormat();%>
<%@ include file="../../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
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

if (ec == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/compensacion/seleccion.jsp");   
	return;
}
String cuenta = (String)session.getAttribute("cuenta.banco");
String cliente = (String)session.getAttribute("titular");
Integer indice = (Integer)session.getAttribute("indice");
if (indice != null){
    Movimiento movimiento = (Movimiento)mov.get(indice.intValue());
    movimiento.setRuta(null);
}
%>

<script>
function _submit(_path){
    document.forms[0].ruta.value = ""+_path;	
	openwin("<html:rewrite page='/compensacion/formulario10/formulario4.jsp'/>?cuenta=<%=session.getAttribute("cuenta.csic")%>&indice=<%=indice%>&ruta="+_path);
	document.location="<html:rewrite page='/formulario10/mant/cuenta.do'/>";
}
function openwin(url)
{
	nwin=window.open(url, "nwin",config="scrollbars=no,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no");
	nwin.focus();
}
</script>
<html:form action="/formulario10/elaborar/formulario" method="post" target="_formulario">
	<html:hidden property="indice" value="<%=session.getAttribute("indice").toString()%>"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>
	<html:hidden property="ruta" />
</html:form>
<%@ include file="../../body.jsp" %>



<div class="container">
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

	<logic:messagesPresent>
		<div align="center" class="well col-md-4 col-md-offset-4">
			<p><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>"></p>
			<p><b><bean:message key="errors.header"/></b></p>
			<html:messages id="error">
				<p class="bienvenida"> - <bean:write name="error" /></p>
			</html:messages>
		</div>
	</logic:messagesPresent>

    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-default" >
        <div class="panel-heading" >
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
            <bean:message key="lbl.compensacion.formulario.10.movimiento.titulo"/>
          </strong>
        </div>

        <div class="panel-body">

			<div align="right">
				<INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/formulario10/mant/cuenta.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
			</div>

          <div class="col-md-4">
            <p><b>
              <bean:message key="lbl.numero.cuenta"/>
            </b></p>
          </div>

          <div class="col-md-8">
            <p>
				<%=f.formatCuenta(ec.getNumeroCuenta())%>
            </p>
          </div>

           <div class="col-md-4">
            <p><b>
              <bean:message key="lbl.titular"/>
            </b></p>
          </div>

          <div class="col-md-8">
            <p>
				<%=cliente %>
            </p>
          </div>


          <div align="center">
            <h5>
				<b> FORMULARIOS 2REGIMEN CAMBIARIO </b>
            </h5>
          </div>
		<hr>
          <div class="col-md-6">
            <p>
              <a  href="javascript:_submit('Formulario10.pdf');">
								Formulario No. 10 - Relación de Operaciones Cuenta Corriente de Compensación</a>
            </p>
          </div>

          <div class="col-md-6">
            <p>
              <img src="<html:rewrite page='/images/icono_acrobat.gif'/>" width="16" height="16" hspace="10" vspace="4" border="0" align="absmiddle">
								<a target="new"  href="https://quimbaya.banrep.gov.co/secinternet/instructivos/Instr1020031201.pdf">
								Instrucciones</a>
            </p>
          </div>

          <div class="col-xs-12" align="center">
            <INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/formulario10/mant/cuenta.do'/>'" type=button value="<bean:message key="lbl.retroceder"/>">
          </div>

        </div>

      </div>
    </div>
  </div>
</div>


<%@ include file="../../footer.jsp"  %>	
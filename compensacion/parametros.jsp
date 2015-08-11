<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>

<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>

<script language="javascript">
function __retornar(){
	document.location="<html:rewrite page='/mant/representante.do'/>";
}	
function __submit()
{
	document.forms[3].submit();
}
function __edit(index)
{
	document.forms[1].cuenta.value=document.forms[3].cuenta.value;
	document.forms[1].indice.value=index;
	document.forms[1].submit();
}
function __delete(index)
{
	document.forms[2].cuenta.value=document.forms[3].cuenta.value;
	document.forms[2].indice.value=index;
	document.forms[2].submit();
}	
function __create()
{
	if (document.forms[3].cuenta.value!= ""){
		document.forms[0].submit();
	}
	else{
		alert("<bean:message key="msg.seleccionar.cuenta"/>");
	}
}

</script>

<!--  Funcion para Rellenar de Ceros -->
<%! String valores(int numero)
{
	String cad = String.valueOf(numero);
	String resp = "0";
	if (cad.length() < 2)
	{
		resp += cad;
	}
	else
		resp = cad;
	return resp;
}
%>
<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
Calendar cal = Calendar.getInstance();
int dia = cal.get(Calendar.DAY_OF_MONTH);
int ano = cal.get(Calendar.YEAR);
int mes = cal.get(Calendar.MONTH) + 1;
String anoCorto = String.valueOf(ano).substring(2,4);
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>
<%@ include file="../body.jsp" %>

<div class="container">
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

    <logic:messagesPresent>
    <div align="center" class="well col-md-4 col-md-offset-4">
      <p><img src="<html:rewrite page='/images/warning.gif'/>"></p>
      <p><b><bean:message key="errors.header"/></b></p>
      <html:messages id="error">
      <p class="bienvenida"> - <bean:write name="error" /></p>
      </html:messages>
    </div>
  </logic:messagesPresent>

  <div class="col-md-12">
    <div class="panel panel-default" >
      <div class="panel-heading" >
        <img src="<html:rewrite page='/images/logo_icon.png' />" />
        <strong>
          <bean:message key="lbl.compensacion.parametro.titulo" />
        </strong>
      </div>

      <div class="panel-body">

        <html:form method="post" action="/create/parametro">
        <html:hidden property="cuenta"/>
        </html:form>
        <html:form method="post" action="/edit/parametro">
        <html:hidden property="indice"/>
        <html:hidden property="cuenta"/>
        </html:form>
        <html:form method="post" action="/delete/parametro">
        <html:hidden property="indice"/>
        <html:hidden property="cuenta"/>
        </html:form>

        <html:form method="post" action="/mant/parametro">

          <div class="col-md-4">
            <p><bean:message key="lbl.compensacion.parametro.cuenta" />(<font color="#FF0000">*</font>)</p>
          </div>
          <div class="col-md-8">
            <p>
              <html:select property="cuenta" styleClass="form-control" onchange="__submit();">
                <logic:notEmpty name="cuentasCompensacion">
                  <html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
                  <bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
                  <html:options collection="cp" property="codigoCSIC" labelProperty="tag"/>
                </logic:notEmpty>
                <logic:empty name="cuentasCompensacion">
                  <html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
                </logic:empty>
              </html:select>
            </p>
          </div>

          <div class="col-md-4">
            <p><bean:message key="lbl.compensacion.parametro.cliente" /></p>
          </div>

          <div class="col-md-8">
            <p>
              <div id="nombreCliente" class="form-control" style="width:300px">
                <bean:write name="parametroForm" property="nombreCliente"/>
              </div>
            </p>
          </div>

          <div align="center">
            <input class="btn btn-default" type="button" name="btnnew" value="<bean:message key='lbl.compensacion.parametro.nuevo' />" onclick="__create();"/>
          </div>

        </html:form>

      </div>
    </div>
  </div>

    <div id="no-more-tables">
      <table class="col-md-12 table-bordered table-striped table-condensed cf" width="100%" border="0" cellpadding="1" cellspacing="2">
        <thead class="cf">
          <tr class="tabla-acceso">
            <td class="texto-acceso" width="10%" nowrap><bean:message key="lbl.compensacion.parametro.tipo.numeracion"/></td>
            <td class="texto-acceso" width="35%"><bean:message key="lbl.compensacion.parametro.formulario"/></td>         
            <!--    <td class="texto-acceso" width="10%"><bean:message key="lbl.compensacion.parametro.cuenta.compensacion"/></td>  -->
            <td class="texto-acceso" width="10%"><bean:message key="lbl.compensacion.parametro.tipo.periodo"/></td>
            <td class="texto-acceso" width="10%"><bean:message key="lbl.compensacion.parametro.secuencia.actual"/></td>
            <td class="texto-acceso" width="10%">D�as Aviso Banco de la Rep�blica</td>
            <td class="texto-acceso" width="10%">D�as Aviso Dian</td>
            <td class="texto-acceso" width="15%"></td></tr>
            <logic:notEmpty name="parametros.cuenta">
            <logic:iterate name="parametros.cuenta" id="row"
            type="com.arango.internet.banking.ParametroCuentaCompensacion" indexId="resultNo" >
            <bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>     
            <logic:equal name="remainder" value="0">
            <tr>
            </logic:equal>
            <logic:notEqual name="remainder" value="0">
            <tr class="celda-clave1">
            </logic:notEqual>
            <td class="bienvenida">
              <logic:equal name="row" property="tipoNumeracion" value="G" >
              <bean:message key="lbl.compensacion.parametro.tipo.numeracion.global" />
            </logic:equal>
            <logic:equal name="row" property="tipoNumeracion" value="F" >
            <bean:message key="lbl.compensacion.parametro.tipo.numeracion.por.formulario" />
          </logic:equal></td>
          <td class="bienvenida">

            <bean:write name="row" property="formulario"/> - 
            <bean:write name="row" property="nombreFormulario"/></td>
            <!--  <td class="bienvenida"><bean:write name="row" property="cuentaCompensacion"/></td>  -->
            <td class="bienvenida">
              <logic:equal name="row" property="tipoPeriodo" value="A" >
              <bean:message key="lbl.compensacion.parametro.tipo.periodo.anual" />
            </logic:equal>
            <logic:equal name="row" property="tipoPeriodo" value="S" >
            <bean:message key="lbl.compensacion.parametro.tipo.periodo.semestral" />
          </logic:equal>
          <logic:equal name="row" property="tipoPeriodo" value="T" >
          <bean:message key="lbl.compensacion.parametro.tipo.periodo.trimestral" />
        </logic:equal>
        <logic:equal name="row" property="tipoPeriodo" value="B" >
        <bean:message key="lbl.compensacion.parametro.tipo.periodo.bimestral" />
      </logic:equal>
      <logic:equal name="row" property="tipoPeriodo" value="M" >
      <bean:message key="lbl.compensacion.parametro.tipo.periodo.mensual" />
    </logic:equal>
    <logic:equal name="row" property="tipoPeriodo" value="D" >
    <bean:message key="lbl.compensacion.parametro.tipo.periodo.diario" />
    </logic:equal></td>
    <td class="bienvenida"><bean:write name="row" property="secuenciaActual"/></td>
    <td class="bienvenida"><bean:write name="row" property="diasAviso"/></td>
    <td class="bienvenida"><bean:write name="row" property="diasAvisoDian"/></td>
    <td class=""><input type="button" class="btn btn-defaul btn-xs" name="btnedit" onclick="__edit(<%=resultNo.intValue()%>)" value="<bean:message key='lbl.compensacion.parametro.editar' />"/>&nbsp;
      <input type="button" class="btn btn-defaul btn-xs" name="btndel" onclick="__delete(<%=resultNo.intValue()%>)" value="<bean:message key='lbl.compensacion.parametro.eliminar' />"/></td>
    </logic:iterate>
    </logic:notEmpty>
    </table>

    <div align="center">
      <input type="button" class="btn btn-default" name="btnpc" onclick="__retornar()" value="<bean:message key='lbl.compensacion.parametro.titulo.2' />"/>
    </div>

    </div>

  </div>
</div>


<%@ include file="../footer.jsp"  %>	
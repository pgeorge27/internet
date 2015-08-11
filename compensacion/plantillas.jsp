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
	history.back();
}	
function __submit()
{
	document.forms['listaPlantillaForm'].submit();
}

function __edit(index, secuencia)
{
	document.forms['plantillaForm'].indice.value=index;
	document.forms['plantillaForm'].secuencia.value=secuencia;
	document.forms['plantillaForm'].submit();
}
function __delete(index, secuencia)
{
	if(confirm("¿Desea eliminar el registro seleccionado?")){
		document.forms['eliminarForm'].indice.value=index;
		document.forms['eliminarForm'].secuencia.value=secuencia;
		document.forms['eliminarForm'].submit();
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


    <html:form method="post" action="/edit/plantilla">
      <html:hidden property="indice"/>
      <html:hidden property="secuencia"/>
    </html:form>

    <html:form method="post" action="/delete/plantilla">
      <html:hidden property="indice"/>
      <html:hidden property="secuencia"/>
    </html:form>


    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-default" >
        <div class="panel-heading" >
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
            <bean:message key="lbl.transf.inter.plantilla" />
          </strong>
        </div>

        <div class="panel-body">
          <html:form method="post" action="/mant/plantilla">

          <div class="col-md-4">
            <p>
              <bean:message key="lbl.transf.inter.cliente" /> (<font color="#FF0000">*</font>)
            </p>
          </div>

          <div class="col-md-8">
            <p>
              <html:select property="cliente" styleClass="btn btn-default" onchange="__submit();">
                <logic:notEmpty name="clientes.plantillas">
                  <html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
                  <bean:define id="cp" scope="session" name="clientes.plantillas" type="java.util.ArrayList"/>
                  <html:options collection="cp" property="codigo" labelProperty="nombre"/>
                </logic:notEmpty>
                <logic:empty name="clientes.plantillas">
                  <html:option value=""><bean:message key="lbl.seleccione.no.hay.clientes"/></html:option>
                </logic:empty>
              </html:select>
            </p>
          </div>
          </div>
          </div>
          </div>

        <table class="table" width="100%" border="0" cellpadding="1" cellspacing="2">
          <tr class="tabla-acceso">
            <td class="texto-acceso" width="85%" nowrap><bean:message key="lbl.transf.inter.plantilla"/></td>
            <td class="texto-acceso" width="15%"></td>
          </tr>
          <logic:notEmpty name="plantillas">
            <logic:iterate name="plantillas" id="row" type="com.arango.common.beans.TransferenciaInternacional" indexId="resultNo" >
              <bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>
              <logic:equal name="remainder" value="0">
                 <tr>
              </logic:equal>
              <logic:notEqual name="remainder" value="0">
                 <tr class="celda-clave1">
              </logic:notEqual>
              <td class="bienvenida"><bean:write name="row" property="nombreEmisor" />&nbsp;/&nbsp;<bean:write name="row" property="nombreBeneficiario" /></td>
              <td class="bienvenida">
              <p>
                <input type="button" class="btn btn-default btn-xs" name="btnedit" onclick="__edit(<%=resultNo.intValue()%>, <bean:write name="row" property="secuencia" />)" value="<bean:message key='lbl.compensacion.parametro.editar' />"/>&nbsp;
                <input type="button" class="btn btn-default btn-xs" name="btndel" onclick="__delete(<%=resultNo.intValue()%>, <bean:write name="row" property="secuencia" />)" value="<bean:message key='lbl.compensacion.parametro.eliminar' />"/>
                </p>
              </td>
            </tr>
            </logic:iterate>
          </logic:notEmpty>
        </table>

      </html:form>

  </div>
</div>

<%@ include file="../footer.jsp"  %>
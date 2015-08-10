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
	document.location="<html:rewrite page='/mant/parametro.do'/>";
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
	    document.forms[0].cuenta.value=document.forms[3].cuenta.value;
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
session.removeAttribute("representante.accion.nuevo");
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

    <div class="col-md-6 col-md-offset-3">
      <div class="panel panel-default" >
        <div class="panel-heading" >
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
            <bean:message key="lbl.compensacion.parametro.titulo.2" />
          </strong>
        </div>

        <div class="panel-body">
          <html:form method="post" action="/create/representante">
            <html:hidden property="cuenta"/>
          </html:form>
          <html:form method="post" action="/edit/representante">
            <html:hidden property="indice"/>
            <html:hidden property="cuenta"/>
          </html:form>
          <html:form method="post" action="/delete/representante">
            <html:hidden property="indice"/>
            <html:hidden property="cuenta"/>
          </html:form>
          <html:form method="post" action="/mant/representante">

          <div class="col-md-5">
            <p>
              <bean:message key="lbl.compensacion.parametro.cuenta" /><span class="texto-acceso"> (<font color="#FF0000">*</font>)</span>
            </p>
          </div>

          <div class="col-md-7">
            <p>
              <html:select property="cuenta" styleClass="form-control" onchange="__submit();">
                <logic:notEmpty name="cuentasCompensacion">
                  <html:option value="">
                    <bean:message key="lbl.seleccione.una.cuenta"/>
                  </html:option>
                  <bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
                  <html:options collection="cp" property="codigoCSIC" labelProperty="tag"/>
                </logic:notEmpty>
                <logic:empty name="cuentasCompensacion">
                  <html:option value="">
                    <bean:message key="lbl.seleccione.no.hay.cuentas"/>
                  </html:option>
                </logic:empty>
              </html:select>
            </p>
          </div>

				<div class="col-md-12" align="center">
					<p><input class="btn btn-default" type="button" name="btnnew" value="<bean:message key='lbl.compensacion.parametro.nuevo' />" onclick="__create();"/></p>
				</div>

		</div>
	</div>
	</div>

		<div class="col-md-12">
          <div id="no-more-tables">
            <table class="col-md-12 table-bordered table-striped table-condensed cf" width="100%" border="0" cellpadding="1" cellspacing="2">
              <thead class="cf">
                <tr class="tabla-acceso">
                  <th class="texto-acceso" width="20%" nowrap><bean:message key="lbl.compensacion.parametro.identificacion"/></th>
                  <th class="texto-acceso" width="20%"><bean:message key="lbl.compensacion.parametro.nombre"/></th>
                  <th class="texto-acceso" width="15%"><bean:message key="lbl.compensacion.parametro.telefono"/></th>
                  <th class="texto-acceso" width="20%"><bean:message key="lbl.compensacion.parametro.email"/></th>
                  <th class="texto-acceso" width="20%"><bean:message key="lbl.compensacion.parametro.ciudad"/></th>
                  <th class="texto-acceso" width="5%"></th></tr>
                </thead>
                <logic:notEmpty name="parametros.repLegal">
                <logic:iterate name="parametros.repLegal" id="row"
                type="com.arango.internet.banking.ParametroCuentaCompensacion" indexId="resultNo" >
                <bean:define id="remainder" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>
                <logic:equal name="remainder" value="0">
                <tr>
                </logic:equal>
                <logic:notEqual name="remainder" value="0">
                <tr class="celda-clave1">
                </logic:notEqual>
                <td data-title="<bean:message key="lbl.compensacion.parametro.identificacion"/>" class="bienvenida"><bean:write name="row" property="identificacion" /></td>
                <td data-title="<bean:message key="lbl.compensacion.parametro.nombre"/>" class="bienvenida"><bean:write name="row" property="nombre"/></td>
                <td data-title="<bean:message key="lbl.compensacion.parametro.telefono"/>" class="bienvenida"><bean:write name="row" property="telefono"/></td>
                <td data-title="<bean:message key="lbl.compensacion.parametro.email"/>" class="bienvenida"><bean:write name="row" property="email"/></td>
                <td data-title="<bean:message key="lbl.compensacion.parametro.ciudad"/>" class="bienvenida"><bean:write name="row" property="ciudad"/></td>
                <td data-title="Code" class="bienvenida">
                  <input type="button" class="btn btn-default btn-sm" name="btnedit" onclick="__edit(<%=resultNo.intValue()%>)" value="<bean:message key='lbl.compensacion.parametro.editar' />"/>
                  <input type="button" class="btn btn-default" name="btndel" onclick="__delete(<%=resultNo.intValue()%>)" value="<bean:message key='lbl.compensacion.parametro.eliminar' />"/>
                </td>
              </logic:iterate>
            </logic:notEmpty>
          </table>
        </div>


          <div align="center">
            <input type="button" class="btn btn-default" name="btnpc" onclick="__retornar()" value="<bean:message key='lbl.compensacion.parametro.titulo' />"/>
          </div>

          </html:form>
			</div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="../footer.jsp"  %>	
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
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

<br>

<div class="container"> 
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="panel panel-default" >

				<div class="panel-heading">
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<!-- TItulo del panel header -->
						<bean:message key="lbl.beneficiarios.aprobados.menu" />
					</strong>
				</div>

				<div class="panel-body">

					<logic:messagesPresent>
						<p>
							<img src="<html:rewrite page='/images/logo_icon.png' />" />
							<strong>
								<bean:message key="errors.header"/>
							</strong>
						</p>
						<html:messages id="error">
							<p class="bienvenida"> - <bean:write name="error" /></p>
						</html:messages>
					</logic:messagesPresent>

					<html:form method="post" action="/edit/plantilla">
						<html:hidden property="indice"/>
						<html:hidden property="secuencia"/>

					</html:form>

					<html:form method="post" action="/delete/plantilla">
						<html:hidden property="indice"/>
						<html:hidden property="secuencia"/>

					</html:form>

					<html:form method="post" action="/consultaAprovados.do">
						<p>
							<bean:message key="lbl.transf.inter.cliente" /> (<font color="#FF0000">*</font>)
						</p>

						<html:select property="cliente" onchange="__submit()" styleClass="botton-acceso form-control">
							<html:option value="">
								<bean:message key="lbl.transf.inter.seleccione"/>
							</html:option>
							<csic:forEachCliente orderBy="NAME_ORDER">
								<html:option value="<%=codigo%>" ><%=nombre%>&nbsp;<%=apellido%></html:option>
							</csic:forEachCliente>
						</html:select> 

						<%@ include file="../divFooter.jsp"%>

					</html:form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../footer.jsp"  %>
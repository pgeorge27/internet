<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

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
	if (document.forms[0].cuenta.value == "")
		{
		   alert("<bean:message key="msg.seleccionar.cuenta"/>");
		   document.forms[0].cuenta.focus();
		   return false;
		}
	if(ValidaFechas(document.forms[0].desde.value))	
		{
			alert("La fecha NO puede ser mayor al día de Hoy");
			document.forms[0].desde.focus();
			 return false;
		}	
		else
			document.forms[0].submit();
}
function ValidaFechas(date)
{
  var x=new Date();
      var fecha = date.split("-");
      x.setFullYear(fecha[2],fecha[1]-1,fecha[0]);
      var today = new Date();
 
      if (x <= today)
        return false;
      else
        return true;
}



</script>


<!DOCTYPE html>
<html:html>

<head>

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
<%
SimpleDateFormat df = new SimpleDateFormat("yyyy");
Date pDate = new java.util.Date(System.currentTimeMillis());
String pYear = df.format(pDate);

df.applyPattern("MM");
String pMonth = df.format(pDate);

df.applyPattern("dd");
String pDay = df.format(pDate);

df.applyPattern("dd-MM-yyyy");

String fecha = df.format(pDate);

%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>

<body>
<%@ include file="../body.jsp" %>


<div align="center" class="container"> 


<logic:messagesPresent>
  <div>
	
			 <div>
				  <div><div><img src="<html:rewrite page='/images/warning.gif'/>"></div>
								   <div class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
	<div class="bienvenida">
		<table width="80%">
		<html:messages id="error">					
			<div><div class="bienvenida">- <bean:write name="error" /></div></div>
		</html:messages>
		</table>
	</div><br>
								   </div></div>
			 </div>
		  </div>
</logic:messagesPresent>



		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.title.conexion.helmbank"/></strong></div>
					  <div class="panel-body">
					
<html:form method="post" action="/multicash/links">
  	 
					
									<label style="text-align:left">	<h5><strong>
				
						<font color="#FF0000" >*</font>&nbsp;<bean:message key="lbl.cuentas"/>:
					
						</strong></h5>
			</label>
			
			  
  	  	<div class="row">
  <div class=".col-md-2" style="align: right"></div>
  <div class=".col-md-6" style="align: center; padding-right: 3%; width: 90%;" ><html:select property="cuenta" styleClass="form-control">
									<logic:notEmpty name="cuentasMulticash">
											<html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
											<bean:define id="cp" scope="session" name="cuentasMulticash" type="java.util.ArrayList"/>
				                            <html:options collection="cp" property="codigoCSIC" labelProperty="tag"/>
										   
									</logic:notEmpty>
									<logic:empty name="cuentasMulticash">
										<html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
									</logic:empty>
									</html:select> </div>
 
</div>

<br>

							
							<div class="row">
  <div class="col-md-2">								<label style="text-align:left">	<h5><strong>
				
							<bean:message key="lbl.fecha"/>:
					
						</strong></h5>
			</label></div>
  <div class="col-md-5" align="center"><input name="desde" id="desde" type="text" class="form-control" size="20" maxlength="12" value="<%=fecha%>"></div>
  <div class="col-md-5"> <input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-y');" >[<b>dd-mm-yyyy</b>]	</div>
					
								</div>
								<br>


 <div align="center"> 
			<input name="botonEnviar" onclick="__submit();" type="button" class="btn btn-default" value="<bean:message key="btn.consultar"/>">
			  <input TYPE="BUTTON" class="btn btn-default" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
			
		  </div> 



	<br>
		 
				<div>
					<div class="texto-acceso">
						<h6 style="color:#95A5A6 "><bean:message key="lbl.mensaje.campo.requerido"/></h6>
							<%@ include file="../divFooter.jsp"%>
					</div>
				</div>	

 </html:form>
					</div>

		</div>
	
	</div>
	</div>
	
		</div>  
					  



</body>
<%@ include file="../footer.jsp"  %>	

</html:html>
<% session.setAttribute("selected", "transfer"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="com.arango.internet.services.interfaces.ITransferencia"  %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Locale"%>


<%@ include file="../head.jsp"  %> 
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<%
Calendar cal = Calendar.getInstance();
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
Date pDate = new java.util.Date(System.currentTimeMillis());

cal.set(Calendar.DATE, 1);
String fechaInicio = df.format(cal.getTime());
String fechaFin = df.format(pDate);

Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript">
var calendar = null; // remember the calendar object so that we reuse it and
                     // avoid creation other calendars.

// code from http://www.meyerweb.com -- change the active stylesheet.
function setActiveStyleSheet(title) {
  var i, a, main;
  for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
    if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {
      a.disabled = true;
      if(a.getAttribute("title") == title) a.disabled = false;
    }
  }
  document.getElementById("style").innerHTML = title;
  return false;
}

// This function gets called when the end-user clicks on some date.
function selected(cal, date) {
  cal.sel.value = date; // just update the date in the input field.
  if (cal.sel.id == "fechaSolicitud")
    // if we add this call we close the calendar on single-click.
    // just to exemplify both cases, we are using this only for the 1st
    // and the 3rd field, while 2nd and 4th will still require double-click.
    cal.callCloseHandler();
}

// And this gets called when the end-user clicks on the _selected_ date,
// or clicks on the "Close" button.  It just hides the calendar without
// destroying it.
function closeHandler(cal) {
  cal.hide();                        // hide the calendar

  // don't check mousedown on document anymore (used to be able to hide the
  // calendar when someone clicks outside it, see the showCalendar function).
  Calendar.removeEvent(document, "mousedown", checkCalendar);
}

// This gets called when the user presses a mouse button anywhere in the
// document, if the calendar is shown.  If the click was outside the open
// calendar this function closes it.
function checkCalendar(ev) {
  var el = Calendar.is_ie ? Calendar.getElement(ev) : Calendar.getTargetElement(ev);
  for (; el != null; el = el.parentNode)
    // FIXME: allow end-user to click some link without closing the
    // calendar.  Good to see real-time stylesheet change :)
    if (el == calendar.element || el.tagName == "A") break;
  if (el == null) {
    // calls closeHandler which should hide the calendar.
    calendar.callCloseHandler();
    Calendar.stopEvent(ev);
  }
}

// This function shows the calendar under the element having the given id.
// It takes care of catching "mousedown" signals on document and hiding the
// calendar if the click was outside.
function showCalendar(id, format) {
  var el = document.getElementById(id);
  if (calendar != null) {
    // we already have some calendar created
    calendar.hide();                 // so we hide it first.
  } else {
    // first-time call, create the calendar.
    var cal = new Calendar(true, null, selected, closeHandler);
    calendar = cal;                  // remember it in the global var
	var cal2 = new Calendar(true, null, selected, closeHandler);
        <% cal2.add(Calendar.YEAR,1); %>
    cal.setRange(2007,  <%=cal2.get(Calendar.YEAR)%>);        // min/max year allowed.
    cal.create();
  }
  calendar.setDateFormat(format);    // set the specified date format
  calendar.parseDate(el.value);      // try to parse the text in field
  calendar.sel = el;                 // inform it what input field we use
  calendar.showAtElement(el);        // show the calendar below it

  // catch "mousedown" on document
  Calendar.addEvent(document, "mousedown", checkCalendar);
  return false;
}

var MINUTE = 60 * 1000;
var HOUR = 60 * MINUTE;
var DAY = 24 * HOUR;
var WEEK = 7 * DAY;

// If this handler returns true then the "date" given as
// parameter will be disabled.  In this example we enable
// only days within a range of 10 days from the current
// date.
// You can use the functions date.getFullYear() -- returns the year
// as 4 digit number, date.getMonth() -- returns the month as 0..11,
// and date.getDate() -- returns the date of the month as 1..31, to
// make heavy calculations here.  However, beware that this function
// should be very fast, as it is called for each day in a month when
// the calendar is (re)constructed.
function isDisabled(date) {
  var today = new Date();
  return (Math.abs(date.getTime() - today.getTime()) / DAY) > 10;
}

function flatSelected(cal, date) {
  var el = document.getElementById("preview");
  el.innerHTML = date;
}

function showFlatCalendar() {
  var parent = document.getElementById("display");

  // construct a calendar giving only the "selected" handler.
  var cal = new Calendar(true, null, flatSelected);

  // We want some dates to be disabled; see function isDisabled above
  cal.setDisabledHandler(isDisabled);
  cal.setDateFormat("dd-mm-y");

  // this call must be the last as it might use data initialized above; if
  // we specify a parent, as opposite to the "showCalendar" function above,
  // then we create a flat calendar -- not popup.  Hidden, though, but...
  cal.create(parent);

  // ... we can show it here.
  cal.show();
}
var t;
function setValue(_value){
	t = _value;
	if(t == "4"){
	document.forms['consultaForm'].desde.disabled = true;
	document.forms['consultaForm'].hasta.disabled = true;
	}else{
	document.forms['consultaForm'].desde.disabled = false;
	document.forms['consultaForm'].hasta.disabled = false;
	}
}
function send(){
	
		
		if(document.forms['consultaForm'].cliente.value == ""){
			alert(" - Cliente es requerido. "); 
			document.forms['consultaForm'].desde.focus();
			return;
		}

		if(!CompareDates(document.forms['consultaForm'].desde.value, document.forms['consultaForm'].hasta.value)){
			alert("<bean:message key="lbl.compensacion.movimiento.error.fechas"/>"); 
			document.forms['consultaForm'].cliente.focus();
			return;
		}

		if (document.forms['consultaForm'].desde.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['consultaForm'].desde.focus();
			return;
		}
		if (document.forms['consultaForm'].hasta.value == ""){
			alert("<bean:message key="msg.seleccionar.fecha"/>");
			document.forms['consultaForm'].hasta.focus();
			return;
		}
	
	document.forms['consultaForm'].submit();
}

 function CompareDates(fechaDesde, fechaHasta)
 {
     var str1 = fechaDesde;//document.getElementById("Fromdate").value;
     var str2 = fechaHasta;//document.getElementById("Todate").value;
     var dt1  = parseInt(str1.substring(0,2),10);
     var mon1 = parseInt(str1.substring(3,5),10);
     var yr1  = parseInt(str1.substring(6,10),10);
     var dt2  = parseInt(str2.substring(0,2),10);
     var mon2 = parseInt(str2.substring(3,5),10);
     var yr2  = parseInt(str2.substring(6,10),10);
     var date1 = new Date(yr1, mon1, dt1);
     var date2 = new Date(yr2, mon2, dt2);

     if(date2 < date1)
     {
         return false;
     }
     else
     {
         return true;
     }
 } 
</script>
<%@ include file="../body.jsp"%>

<br>
<logic:messagesPresent>
  <table align="center" cellpadding="1" cellspacing="1" width="750" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
	<span class="bienvenida">
		<table width="80%">
		<html:messages id="error">					
			<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
		</html:messages>
		</table>
	</span><br>
								   </td></tr>
			 </table></td></tr>
		  </table>
</logic:messagesPresent>
<div align="center">
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
		    <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
			<td><div align="left" class="login"><bean:message key="lbl.transf.inter.consulta"/> Multipagos</div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top" align="center" >
	<html:form method="post" action="/multipagos/Consulta/autorizaciones">
	<html:hidden property="tipo" value="2" /> 
	<%@ include file="../divHeader.jsp"%>
		<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
		
		  <tr> 
			<td colspan="1"  height="20"  width="30%" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.transf.inter.cliente"/></div></td>
			<td  colspan="5" width="100%"><html:select property="cliente" styleClass="botton-acceso">
										<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
										<csic:forEachCliente orderBy="NAME_ORDER">  
											<html:option value="<%=codigo%>" ><%=nombre%>&nbsp;<%=apellido%></html:option>	
										 </csic:forEachCliente>
								   </html:select> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
		  <tr> 
			<td colspan="1" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.transf.inter.estado"/></div></td>
			<td colspan="5" nowrap><html:select property="estado" styleClass="botton-acceso">
										<html:option value=""><bean:message key="lbl.transf.inter.todos"/></html:option>
										<html:option value="<%=ITransferencia.PENDIENTE %>"><bean:message key="lbl.transf.inter.pendiente"/></html:option>                 
										<html:option value="<%=ITransferencia.RECHAZADA %>"><bean:message key="lbl.transf.inter.rechazada"/></html:option>
										<html:option value="<%=ITransferencia.APROBADA %>"><bean:message key="lbl.transf.inter.aprobada"/></html:option>
										<html:option value="<%=ITransferencia.RECHAZADA_BANCO %>"><bean:message key="lbl.transf.inter.rechazada.banco"/></html:option>	
										<html:option value="<%=ITransferencia.EN_PROCESO %>"><bean:message key="lbl.transf.inter.en.proceso"/></html:option>
										<html:option value="<%=ITransferencia.PROCESADA %>"><bean:message key="lbl.transf.inter.completada"/></html:option>										
								   </html:select>
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
		   <tr> 
                        <td colspan="1" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.desde"/></div></td>
                        <td colspan="5" class="bienvenida"><html:text property="desde" styleId="desde" styleClass="botton-acceso" size="20" maxlength="12" value="<%=fechaInicio%>"/>
                          <input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-y');" > [<b>dd-mm-yyyy</b>]
                          
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="1" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.hasta"/></div></td>
                        <td colspan="5" class="bienvenida"><html:text property="hasta" styleId="hasta" styleClass="botton-acceso" size="20" maxlength="12" value="<%=fechaFin%>"/>
                          <input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('hasta', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]</td>
                      </tr>
		  <tr> 
			<td colspan="3" align="center"><br>
			<input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<html:reset styleClass="botton"><bean:message key="btn.limpiar"/></html:reset>
			</td>
		  </tr>
		</table>
		<%@ include file="../divFooter.jsp"%>
	  </html:form></td>
  </tr>
  
  <tr>
	<td height="20" valign="middle" class="texto-acceso" align="center"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table></div>

<%@ include file="../footer.jsp"  %>
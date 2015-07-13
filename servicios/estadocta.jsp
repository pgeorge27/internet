<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale"%>
<%@ page import="com.arango.common.util.i18n.ASIResourceBundle" %>

<%!
private String getProducto(String tipo){
	String product = "tit.title.consulta.estado.cuenta.ca";
	if ("CA".equals(tipo))
		product = "tit.title.consulta.estado.cuenta.ca";
	else if ("CC".equals(tipo))
		product = "tit.title.consulta.estado.cuenta.cc";
	else if ("DP".equals(tipo))
		product = "tit.title.consulta.estado.cuenta.do";
	else if ("PR".equals(tipo))
		product = "tit.title.consulta.estado.cuenta.pr";
	
	return product;	
}

%>
<%
String prod = "ALL";
if (request.getParameterValues("prod") != null)
{
  prod = request.getParameterValues("prod")[0];
} 

String tipo = "CON";
if (request.getParameterValues("tipo") != null)
{
  tipo = request.getParameterValues("tipo")[0];
} 

Locale localecc = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (localecc == null) {
   // algunos browser no detectan el idioma de forma adecuada con version java 1.4
   // por defecto toma el idioma espanol
   localecc = ASIResourceBundle.getDefaultLocale();
}

Date[] desde = null;
Date[] hasta = null;
Calendar cal = Calendar.getInstance();

cal.setTime(new Date (System.currentTimeMillis()));

//System.out.println("Calendar Month..........................: "+cal.get(Calendar.MONTH));

cal.add(Calendar.MONTH, -6);

desde = new Date[6];
hasta = new Date[6];
Date fecha = cal.getTime();

for (int i = 0; i < 6; i++){	
	cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
	hasta[i] = cal.getTime();

	cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
	desde[i] = cal.getTime();
	
  cal.add(Calendar.MONTH,1);
}

SimpleDateFormat df = new SimpleDateFormat("MMMMM-yyyy", localecc);
                      
session.setAttribute("periodo.desde", desde);
session.setAttribute("periodo.hasta", hasta);
%>

<%@ include file="../head.jsp"  %> 

<script language="JavaScript">
function send(){ 
        if (document.forma.cuentas.value == "-1")
		{
		   alert("<bean:message key="msg.seleccionar.cuenta"/>");

		   document.forma.cuentas.focus();
		}
		else
			document.forma.submit();
}
function retornar(){
	history.back();
}	  
</script>
<%@ include file="../body.jsp"%>

<div align="center"> 
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" >
		  <tr> <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
			<td><div align="left" class="login"><bean:message key="<%=getProducto(prod)%>"/></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
	<form name=forma method=POST action="<html:rewrite page='/do.consulta'/>">
	  <input type="hidden" name="tipo" value="ESTV">
	  <input type="hidden" name="backPage" value="../servicios/estadocta.jsp?prod=<%=prod%>" >
		 <%@ include file="../divHeader.jsp"%>
		<table width="72%" border="0" align="center" cellpadding="5" cellspacing="5">
		  <tr> 
			<td width="31%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cuentas"/></div></td>
			<td width="34%" nowrap><csic:ListaCuentas classname="botton-acceso" name="cuentas" acceso="CON" producto="<%=prod%>"/>  
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
		   <tr> 
			<td width="31%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.periodo"/></div></td>
			<td width="34%" nowrap><table>
			    <%
			    String checked = "checked";
			    String styleClass = "";
			    
			    for (int i = 0; i < 6; i++){
					styleClass = i % 2 == 0 ? "" : "class=\"celda-clave1\"";%>
				<tr>
					<td class = "bienvenida" nowrap align="left"><input type="radio" value="<%=i%>" name="periodo" <%=checked%>></input><%=df.format(hasta[i])%></td>
					</tr>
				<%
				checked = "";
				} %> </table></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
		
		  <tr> 
			<td>&nbsp;<br><br></td>
			<td colspan="2"><input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
			  <input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
			</td>
		  </tr>
		</table>
		  <%@ include file="../divFooter.jsp"%>
	  </form></td>
  </tr>
  
  <tr>
	<td height="20" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table></div>
<%@ include file="../footer.jsp"  %>
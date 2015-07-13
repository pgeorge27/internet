<% session.setAttribute("selected", "custodia"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@page import="com.arango.common.util.Format" %>

<%@page import="com.arango.internet.banking.Custodia" %>


<%@page import="com.arango.common.util.StringUtilities" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import = "com.arango.common.services.ManagerBean"%>
<%@page import="com.arango.common.beans.Parametro"%>

<%! Format f = Format.getFormat();
private String getDescEstado(String estado){
    if ("P".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente";
    }
    else if ("M".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente.elaborar";
    }
    else if ("A".equals(estado)){
        return "lbl.compensacion.consulta.estado.aprobado";
    }
    else if ("T".equals(estado)){
        return "lbl.compensacion.consulta.estado.pendiente.aprobar";
    }
    else if ("X".equals(estado)){
        return "lbl.compensacion.consulta.estado.rechazado";
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



//java.util.ArrayList mov = (java.util.ArrayList)session.getAttribute("custodia");
ManagerBean mb = new ManagerBean();
Parametro paran = mb.getParametro();


Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
/*
if (mov == null){   
	session.setAttribute("csic.exception", new Exception("Api de custodia retorna Cuenta = NULL"));
	pageContext.forward(request.getContextPath()+ "/custodia/seleccion.do");  
	return;
}
*/
String cuenta = (String)session.getAttribute("cuenta.banco");
String cliente = "";

SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
String strFechaDesde = "";
String strFechaHasta = "";
Date desde = (Date)session.getAttribute("fecha.desde");
Date hasta = (Date)session.getAttribute("fecha.hasta");
if (desde != null){
    strFechaDesde = df.format(desde);
}
if (hasta != null){
    strFechaHasta = df.format(hasta);
}
String cuentaCSIC = (String)session.getAttribute("cuenta.csic");
Date fechaCustodia = (Date)session.getAttribute("fecha.consulta.custodia");
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";

String user = (String) session.getAttribute("user.id");
String codigo = (String) session.getAttribute("codigo.usuario");
//String cuentaCustodia = (String) session.getAttribute("cuentaCustodia");
String url = paran.getHelmCustodia() + "Novedades.jsp"  +"?user=" + user;

%>
<%@ include file="../head.jsp"%>

<SCRIPT language=javascript src="<html:rewrite page='/scripts/NotasDebitoCredito.js'/>"></SCRIPT>
<script language=javascript>
function __download(){
	document.forms["pdoc"].submit();
}
function __asociar(index){
	document.forms["modificarForm"].indice.value=index;
	document.forms["modificarForm"].submit();
}
function __showHideElement(element){
	var obj;
	if (document.getElementById){
		obj = document.getElementById(element);
	}
	else{
		eval("obj = " + element);
	}
	if (obj.style.display == "none")
		obj.style.display = "";
	else	
		obj.style.display = "none";
}

function Detalle( indice ){
    
    var win2;
    if (window.showModalDialog) {
    
 	 window.showModalDialog("<html:rewrite page='/custodia/DescripcionDetalle.jsp'/>?index="+indice+"", "","center=yes; resizable=no; dialogWidth=450px; dialogHeight=350px");
	}
	else{
     win2 = open("<html:rewrite page='/custodia/DescripcionDetalle.jsp'/>?index="+indice+"", "","center:yes; resizable:no; Width:450px; Height:350px");
     if (!win2.closed)
       {
         win2.focus();
       }
    }   
}
</script>
<SCRIPT language=javascript src="<html:rewrite page='/scripts/formatDes.js'/>"></SCRIPT>
<script type="text/javascript" src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>

<script type="text/javascript">
	$(document).ready(function(){
		$("#Table_02").remove();
		
		
		
		//$("#remoteSite").iframeAutoHeight();
		
	});
</script>
<style type="text/css">
#derechos{
	width: 100%;	 
	background-color:#4D4F53;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #FFFFFF;
	position: fixed; 
	bottom:0;	
	vertical-align: middle;
	padding-bottom: 8px;
	padding-top: 8px;
	text-align: center;
}
</style>
<%@ include file="../body.jsp"%>

</td></tr>
	</table></td></tr>
   </table></td></tr></table>

<table width="100%" border="0" cellpadding="2" cellspacing="2" class="linea-botton">
			  <tr> 
				<td width="92%"><div align="left" class="login">
					<img src="<html:rewrite page='/images/gancho.gif' />"/>Novedades</div></td>
				<td width="8%"><div align="right">&nbsp;
							</div></td>
			  </tr>
			</table>


<iframe id="remoteSite" frameborder="0" height="1500" scrolling="yes" width="100%" src="<%=url%>">
</iframe>
		
 
	
<!-- Div que contiene el cintillo de los derechos reservados -->
	<div id="derechos">
		<bean:message key="<%=copyrigth %>"
			arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>' />
	</div>


</body>
</html> 
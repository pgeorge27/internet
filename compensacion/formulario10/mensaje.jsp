<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%@ include file="../../head.jsp"%>

<%@ include file="../../body.jsp" %>
	<br><br>
	<%
String fechaInicioStart=null;
String fechaFinalStart=null;
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
Calendar cal = Calendar.getInstance();
fechaFinalStart=df.format(cal.getTime());
cal.set(Calendar.DATE, 1); 
fechaInicioStart=df.format(cal.getTime());
%>
<html:form method="post" action="/consulta/estado">
	<html:hidden property="cuenta"/>
	<html:hidden property="estado" value="P"/>
	<html:hidden property="desde" value="<%=fechaInicioStart%>"/>
	<html:hidden property="hasta" value="<%=fechaFinalStart%>"/>
</html:form>
<script>
function _consulta(cta){
	document.forms["consultaEstadoForm"].cuenta.value=cta;
	document.forms["consultaEstadoForm"].submit();
}
</script>
	<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
       <tr> 
         <td><div align="center">                     
               <table width="400" height="200" border="0" cellpadding="0" cellspacing="0" class="tabla-acceso">
                 <tr> 
                   <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                       <tr> 
                         <td width="46%" rowspan="2"><div align="center"> 
                       
                                 <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="bienvenida"><bean:message key="lbl.compensacion.formulario.10.no.disponible"/><br>
	 Si desea consultar los movimientos pendientes haga CLICK <a href="javascript:_consulta(<%=session.getAttribute("cuenta.formulario10") %>);">Aquí</a>
								   </td></tr>
			 </table></td></tr>
		  </table>
								 </td>
                               </tr>
                             </table>
						</td>                                
                       </tr>
				</table></td></tr></div></td>
       </tr>
     </table>
<%@ include file="../../footer.jsp" %>

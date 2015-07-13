<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");

String strEstado = "";
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

strEstado = (String)session.getAttribute("estado.consulta");

%>
<%@ include file="/head.jsp"%> 
<script language=javascript>
function __retornar(){
	document.forms["consultaEstadoForm"].submit();
}
</script>
<%@ include file="/body.jsp"%>
<html:form method="post" action="/consulta/impresionMasiva"> 
	<html:hidden property="estado" value="<%=strEstado%>"/>
	<html:hidden property="tipo" value="3"/>
	<html:hidden property="cuenta" value="<%=session.getAttribute("cuenta.csic").toString()%>"/>	
	<html:hidden property="desde" value="<%=strFechaDesde%>"/>
	<html:hidden property="hasta" value="<%=strFechaHasta%>"/>
	
</html:form>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
       <tr> 
         <td><div align="center">                     
               <table width="400" height="200" border="0" cellpadding="0" cellspacing="0" class="tabla-acceso">
                 <tr> 
                   <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                       <tr> 
                         <td width="46%" rowspan="2"><div align="center">                            
                             <table width="100%" border="0" cellspacing="2" cellpadding="2">
                               <tr> 
                                 <td><div align="center"><img src="<html:rewrite page='/images/success.gif'/>"></div></td>
                               </tr>
                               <tr> 
                                 <td class="bienvenida">Operación realizada</td>
                               </tr>
							   <tr>
								 <td class="bienvenida">Impresión de Formulario(s) realizada exitósamente.</td>
							   </tr>
							   <tr><td><div align="right">&nbsp;
							<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
                             </table>
							</div>   
						</td>                      
                       </tr>
                       </table>
					</td>                           
                 </tr>
				</table>
				</div></td></tr>
     </table>
<%@ include file="/footer.jsp" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ include file="/head.jsp"%> 

<%
 String tranferCounter =  (String)session.getAttribute("multipagos.transferencias.counters.total");
 String tranferInValid =  (String)session.getAttribute("multipagos.transferencias.counters.invalid");
 String tranferValid =    (String)session.getAttribute("multipagos.transferencias.counters.valid");
 
if (tranferCounter == null) {tranferCounter = "";}
if (tranferInValid == null) {tranferInValid = "";}
if (tranferValid == null) {tranferValid = "";}

session.removeAttribute("multipagos.transferencias.counters.total");
session.removeAttribute("multipagos.transferencias.counters.invalid");
session.removeAttribute("multipagos.transferencias.counters.valid");
%>
<script language=javascript>
function __retornar(){
	document.location="<html:rewrite page='/multipagos/CargaArchivo.jsp'/>"
}
</script>
<%@ include file="/body.jsp"%> 

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
								 <td class="bienvenida">Pagos Por archivo : <%=tranferCounter%></td>
							   </tr>
							    <tr>
								 <td class="bienvenida">Pagos Procesados Correctamente  : <%=tranferValid%></td>
							   </tr>
							    <tr>
								 <td class="bienvenida">Pagos no procesados   : <%=tranferInValid%></td>
							   </tr>
							   <tr><td><div align="right">&nbsp;
							<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
                             </table>
						</td>                                
                       </tr>
					</td>                           
                 </tr>
				</table></td></tr></div></td>
       </tr>
     </table>

<%@ include file="/footer.jsp" %>
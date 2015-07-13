<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.util.*"%>
<%
String url = request.getContextPath()+"/dian/xml/"+ session.getAttribute("formulario")+ ".jsp";%>
<%@ include file="/head.jsp"%> 
<%@ include file="/body.jsp"%> 
<%

 	
%>
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
                                 <td class="bienvenida">Proceso realizado exitosamente</td>
                               </tr>
							   <tr>
								 <td class="bienvenida">El archivo EXCEL ha sido generado exitósamente. Haga click <a href="<html:rewrite page='/exportar/excel'/>">aquí</a> para descargar</td>
							   </tr>
                             </table>
						</td>                                
                       </tr>
					</td>                           
                 </tr>
				</table></td></tr></div></td>
       </tr>
     </table>

<%@ include file="/footer.jsp" %>
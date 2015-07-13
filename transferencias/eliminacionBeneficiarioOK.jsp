<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>


<%@ include file="../head.jsp"%>

<%@ include file="../body.jsp" %>
	<br><br>
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
                                 <td class="bienvenida"><bean:message key="lbl.beneficiarios.eliminacion"/></td>
                               </tr>
                             </table>
						</td>                                
                       </tr></table>
					</td>                           
                 </tr>
				</table></td></tr></div></td>
       </tr>
     </table>
     <br>
<div align="center">
<INPUT class="botton" onclick="document.location='<html:rewrite page='/mant/beneficiarios.do'/>';" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
<%@ include file="../footer.jsp" %>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ include file="../head.jsp"%> 
<script language=javascript>
  function __retornar(){	
	history.back();
	
} 
</script>
<%@ include file="../body.jsp"%> 
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
                                 <td><div align="center"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>"></div></td>
                               </tr>
                               <tr> 
                                 <td class="bienvenida"></td>
                               </tr>
							   <tr>
								 <td class="bienvenida" align="center">El Registro ya Existe.</td>
							   </tr>
							   <tr><td><div align="right">&nbsp;
							   <INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div>
							</td></tr>
                             </table>
						</td>                                
                       </tr>
					</td>                           
                 </tr>
				</table></td></tr></div></td>
       </tr>
     </table>

<%@ include file="/footer.jsp" %>
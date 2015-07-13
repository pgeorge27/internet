<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>

<%@ include file="/head.jsp"%>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}

%>
<script type="text/javascript"></script>

<%@ include file="/body.jsp" %>



<br><br>
	<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
       <tr> 
         <td>
            <div align="center">                     
               <table width="400" height="200" border="0" cellpadding="0" cellspacing="0" class="tabla-acceso">
                 <tr> 
                   <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                       <tr> 
                         <td width="46%" rowspan="2"><div align="center"> 
                             <table width="100%" border="0" cellspacing="2" cellpadding="2">
                               <tr> 
                                 <td><div align="center"><img src="<html:rewrite page='/images/warning.gif'/>"></div></td>
                               </tr>
	                               <tr> 
	                                 <td class="bienvenida" align="center"><bean:message key="lbl.compensacion.formulario10.no.aprobado.no.genera.xml"/></td>
	                               </tr> 
                             </table>
						</td>                                
                       </tr>
                       
					</td>                           
                 </tr>
				</table>
			</div>
		   </td>		 
       </tr>      
     </table>				
	<table>
	   <tr>
	         <td align="center"><INPUT class="botton" onclick="document.location='<html:rewrite page='/formulario10/generar/xml/consulta.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
      </tr>
	</table>

<%@ include file="/footer.jsp"  %>	
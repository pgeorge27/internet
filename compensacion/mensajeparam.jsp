<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>

<%@ include file="../head.jsp"%>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}

%>
<script type="text/javascript"></script>

<%@ include file="../body.jsp" %>

<html:form method="post" action="/grabar/parametro">
	<html:hidden property="cuenta"/>
	<html:hidden property="tipoNumeracion"/>
	<html:hidden property="formulario"/>
	<html:hidden property="tipoPeriodo"/>
	<html:hidden property="secuenciaInicial"/>
	<html:hidden property="secuencia"/>
	<html:hidden property="mostrarNit"/>
	<html:hidden property="diasAviso"/>
	<html:hidden property="nombre"/>
	<html:hidden property="tipoIdentificacion"/>
	<html:hidden property="identificacion"/>
	<html:hidden property="direccion"/>
	<html:hidden property="ciu"/>
	<html:hidden property="ciudad"/>
	<html:hidden property="telefono"/>
	<html:hidden property="email"/>
	<html:hidden property="grabar" value="S"/>

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
                                 <td><div align="center"><img src="<html:rewrite page='/images/warning.gif'/>"></div></td>
                               </tr>
                               <tr> 
                                 <td class="bienvenida"><bean:message key="lbl.compensacion.parametro.parametrizacion.anterior.existe"/></td>
                               </tr>
                               <tr>
                               	<td align="center"><span><html:submit styleClass="botton"><bean:message key="lbl.afirmacion"/></html:submit></span>&nbsp;&nbsp;<span><input type="button" class="botton" onclick="document.location='<html:rewrite page='/mant/parametro.do'/>';" value="<bean:message key='lbl.negacion'/>"></span></td>
                               </tr>
                             </table>
                             </div>
						</td>                                
                       </tr></table>
					</td>                           
                 </tr>
				</table></div></td>
       </tr>
     </table>				
		
</html:form>
<%@ include file="../footer.jsp"  %>	
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
    <div align="center" style="width:400px; height:200px;" class="tabla-acceso"> 
        <div align="center" style="margin:10%">
            <div>
            	<img alt="Error" src="<html:rewrite page='/images/warning.gif'/>">
            </div>
            <p><bean:message key="lbl.compensacion.formulario10.no.aprobado.no.genera.xml"/></p>
        </div>
    </div><br/><br/>
	<div>
		<INPUT class="botton" onclick="document.location='<html:rewrite page='/formulario10/generar/xml/consulta.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
	</div>

<%@ include file="/footer.jsp"  %>	
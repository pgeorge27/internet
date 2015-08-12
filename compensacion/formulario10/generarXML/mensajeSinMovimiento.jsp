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

<div class="container">
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

    <div class="col-md-6 col-md-offset-3">

        <div class="well">
          <div align="center">
            <p>
              <img src="<html:rewrite page='/images/warning.gif'/>">
            </p>
            <p><bean:message key="lbl.compensacion.formulario10.no.aprobado.no.Movimientos.xml"/></p>
            <p>
              <INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/formulario10/generar/xml/consulta.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
            </p>
          </div>
        </div>
    </div>
  </div>
</div>


<%@ include file="/footer.jsp"  %>	
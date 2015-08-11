<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>

<%@ include file="../../head.jsp"%>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}

%>
<script type="text/javascript"></script>

<%@ include file="../../body.jsp" %>

<div class="container">
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

    <div class="col-md-4 col-md-offset-4">
      <div class="panel panel-default" >
        <div class="panel-heading" >
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
            <bean:message key="lbl.compensacion.menu.reprocesos"/>
          </strong>
        </div>

        <div class="panel-body">
          <div align="center">
            <img src="<html:rewrite page='/images/warning.gif'/>">

            <p>
              <%=session.getAttribute("validacion.xml") %>
            </p>

            <INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/formulario10/mant/cuenta.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="../../footer.jsp"  %>	
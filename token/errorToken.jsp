<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../head.jsp"  %>
<%@ include file="../body.jsp"  %>


<div class="container"> 
  <div class="row">

    <div align="right">
      <img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
    </div>

    <div class="col-md-4 col-md-offset-4">
      <div class="panel panel-default" >
        <div class="panel-heading">
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
            <!-- TItulo del panel header -->
          </strong>
        </div>
        <div class="panel-body">
          <div align="center">
            <img src="<html:rewrite page='/images/error.gif'/>">
          </div>
          <p class="bienvenida"><bean:message key="error.token.generic.msg"/></p>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="../footer.jsp"  %>

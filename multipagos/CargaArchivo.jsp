
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.*"%>
<%@ page import="org.apache.struts.util.LabelValueBean"%>
<%@ page import="com.arango.common.util.StringUtilities" %>
<%
String prod = "ALL";
if (request.getParameterValues("prod") != null)
{
  prod = request.getParameterValues("prod")[0];
}
String cuenta = "-1";
String tipo = "1";
if (request.getParameter("cuenta") != null && request.getParameter("cuenta").length() > 0)
{
 cuenta = request.getParameter("cuenta");
}
if (request.getParameterValues("tipo") != null)
{
  tipo = request.getParameterValues("tipo")[0];
}
String backPage = "seleccion";
if (request.getParameter("back") != null){
	backPage="consulta";	
}

%>
<%@ include file="../head.jsp"  %>


<script language='javascript'>


var t;
function send(){

		if (document.forms['cargaArchivo'].archivo.value == ""){
			alert(" Cargue un archivo ");
			document.forms['cargaArchivo'].archivo.focus();
			return;
		}
		

	
	document.forms['cargaArchivo'].submit();
}
function setValue(_value){
	t = _value;
}
function retornar(){
	history.back();
}
<%
String cuentas = "";

%>
      <csic:forEachCuentaPerfil producto="CC" formatAccount="C" mancomunada="true">
      	<%if ("true".equals(mancomunada)) {
	      cuentas = numCtaCSIC;
	    }%>  
      </csic:forEachCuentaPerfil>

</script>

<%@ include file="../body.jsp"%>

<div class="container">
  <div class="row">

    <div class="col-md-4 col-md-offset-4">
      <div class="panel panel-default" >
        <div class="panel-heading" >
          <img src="<html:rewrite page='/images/logo_icon.png' />" />
          <strong>
          MultiPagos - Carga de Archivo
          </strong>
        </div>

        <div class="panel-body">
          <html:form method="post" action="/multipagos/verificacionArchivo" method="post" enctype="MULTIPART/FORM-DATA">
            <html:hidden property="numcuentaCsic" value="<%=cuentas%>" />

            Archivo <span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
            <html:file styleClass="btn" property="archivo" accept="text/plain"/>
            <div align="center">
            <br>
              <input name="botonEnviar" onclick="send();" type="button" class="btn btn-default" value="Cargar">
              <input TYPE="button" class="btn btn-default" VALUE="<bean:message key="btn.cancelar"/>" onclick="retornar()">
              <br><br>
              <p><bean:message key="lbl.mensaje.campo.requerido"/></p>
            </div>


          </html:form>
        </div>

      </div>
    </div>
  </div>
</div>

<%@ include file="../footer.jsp"  %>
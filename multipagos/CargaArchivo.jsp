
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
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="center"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
                        <td><div align="left" class="login">MultiPagos - Carga de Archivo</div></td>
                      
                      </tr>
                    </table>
                  </div></td>
              </tr>
              <tr> 
                <td valign="top" align="center" >
				<html:form method="post" action="/multipagos/verificacionArchivo" method="post" enctype="MULTIPART/FORM-DATA">
				<html:hidden property="numcuentaCsic" value=<%=cuentas%> />
				  <%@ include file="../divHeader.jsp"%>
					<table  border="0" align="center" cellpadding="5" cellspacing="5">
					    <tr>  
							<td width="45%" height="20" class="celda-clave1"><div align="right" class="texto-acceso">Archivo <span class="texto-acceso">(<font color="#FF0000">*</font>)</span> </div> </td>
            	      		<td>  <html:file  property="archivo" accept="text/plain"/><!--input type="file" name="" accept="text/plain" /--> </td>
					   </tr>
					    <tr>
							<td>&nbsp;&nbsp;</td>
      				  		<td> <input name="botonEnviar" onclick="send();" type="button" class="botton" value="Cargar">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
					  		 <input TYPE="BUTTON" class="botton" VALUE="<bean:message key="btn.cancelar"/>" onclick="retornar()"></td>
                       </tr>
				   </table>
                    <%@ include file="../divFooter.jsp"%>
                  </html:form></td>
              </tr>
              <tr>
                <td height="25" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
              </tr>
            </table>

<%@ include file="../footer.jsp"  %>
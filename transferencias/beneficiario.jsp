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
<%!
private String getNombre(String text){
    if (text == null)
		return "";
    String temp = StringUtilities.replace(text, "\"","&#034;");
    temp = StringUtilities.replace(temp, "\n", "\\n");
    temp = StringUtilities.replace(temp, "\r", "\\r");
    temp = StringUtilities.replace(temp, "\"", "\\\"");
    temp = StringUtilities.replace(temp, "'", "\\'");
    temp = temp.replace('\n', ' ');
    temp = temp.replace('\r', ' ');

    return temp;
}
%>
<!DOCTYPE html>
<html:html>

<head>
<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>

</head>
<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>

<script type="text/javascript">
	
	function validate()
	{
		var flag = false;
		
		var nombre = _trim(document.getElementById('nombreId').value);
		var banco = _trim(document.getElementById('bancoId').value);
		var cuenta = _trim(document.getElementById('cuentaId').value);
		
		if(nombre != "" && banco != "" && cuenta != ""){
			flag = true;			
		}
		return flag;
	}
	
	function send(){
		var msg = "<bean:message key="lbl.beneficiario.validacion.msg"/>";
		
		if(validate()){
			document.forms[0].submit();	
		}
		else{
			alert(msg);
		}
	}
	
	function _trim(str){
		while(''+str.charAt(0)==' ')
			str=str.substring(1,str.length);
		return str;	
	}
</script>

<script language="javascript">
	<%int i = 0;%>
    <csic:forEachCuentaPerfil producto="CC" formatAccount="C" mancomunada="true">
      	<%if ("true".equals(mancomunada)) {%>
	      accounts[<%=i++%>]=new Account('<%=numCtaCSIC%>', '<%=getNombre(nombreTitular)%>', '<%=moneda%>');
	    <%}%>
    </csic:forEachCuentaPerfil>
</script>
<%@ include file="../body.jsp" %>

<body>

<div class="container">

<logic:messagesPresent>
	<table cellpadding="1" align="center" cellspacing="1" width="80%" class="tabla-acceso">
		<tr>
			<td>
			<table border="0" cellpadding="1" cellspacing="0" width="100%">
				<tr valign="top">
					<td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
					<td width="95%" class="msg">
						<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
						<span class="bienvenida">
							<table width="80%">
							<html:messages id="error">					
								<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
							</html:messages>
							</table>
						</span><br>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</logic:messagesPresent>



	<html:form method="post" action="/grabar/beneficiario" onsubmit="document.forms[0].action.value='validate'">
	<html:hidden property="action" />
	<html:hidden property="mode" value="create"/>
	<html:hidden property="secuencia" />

<div class="row" style="padding-top:20px;">


  <div class="col-md-3"></div>
  <div class="col-md-6">

  			<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.beneficiarios.general.mnu"/></strong></div>
						
									
					 <br> 
					       <div  style="width: 90%; padding-left: 10%;"> 
            	
              <div class=""><strong><span class="texto-acceso" style="magin-left: 2em;">(<font color="#FF0000">*</font>)</span>&nbsp;<bean:message key="lbl.beneficiario.nombre"/>:</strong></div>
                <div><html:text property="nombre" size="50" styleId="nombreId" styleClass="form-control"/>
                </div>
            </div>
            <br>
            <div  style="width: 90%; padding-left: 10%;"> 
          
              <div class=""><strong><span class="texto-acceso" style="magin-left: 2em;">(<font color="#FF0000">*</font>)</span>&nbsp;<bean:message key="lbl.beneficiario.cuenta"/>:</strong></div>
                <div><html:text property="cuenta" size="50" styleId="cuentaId" styleClass="form-control"/>

            </div>
            </div>
             <br>
         
           <div style="width: 90%; padding-left: 10%;">  
         
                <div>
	                <div>
	                	 <div><strong><span class="texto-acceso" style="magin-left: 2em;">(<font color="#FF0000">*</font>)</span>&nbsp;<bean:message key="lbl.beneficiario.banco"/>:</strong></div>
	                </div>
                </div>
                <div><html:text property="banco" size="50"  styleId="bancoId" styleClass="form-control"/>
           
            </div>
            </div>
              <br> 
            <div align="center">
            
				<div style="color:#7f8c8d"><bean:message key="lbl.mensaje.campo.requerido"/></div>
  			</div>
  			<br>
  			
<div align="center">
      
 <input type="button" class="btn btn-default" onclick="send();" value="Aceptar"/>

        <input type="button" class="btn btn-default" onclick="document.location='<html:rewrite page='/mant/beneficiarios.do'/>'" value="Cancelar"/>
	</div>
	<br>

					</div>
					 <br> 

					</div>
  <div class="col-md-3"></div>

</div>

	<script>
	function __initialize(){
		_refresh();
	}
	__initialize();
	</script>

</html:form>
</div>
</body>
</html:html>
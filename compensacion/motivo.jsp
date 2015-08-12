<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<!DOCTYPE html>
<html:html>

<head>

<script language="javascript" src="<html:rewrite page='/dian/elaborar/edit/js/jfunciones.js'/>"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
<%@ include file="/head.jsp"  %>

</head>


<body>
<%@ include file="/body.jsp"%>

<div class="container">

<div align="right"><INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/compensacion/autorizar2.jsp'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></div>


 <div class="row">
 
 <div class="col-md-1"></div>

          <div class="col-md-10"><div class="panel panel-default">
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong>Motivo de Rechazo</strong></div>
  <div class="panel-body">


</table>         <logic:messagesPresent>
  <table cellpadding="1" align="center" cellspacing="1" width="80%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
	<span class="bienvenida">
		<table width="80%">
		<html:messages id="error">					
			<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
		</html:messages>
		</table>
	</span><br>
								   </td></tr>
			 </table></td></tr>
		  </table>
</logic:messagesPresent>



               <html:form   action="/compensacion/ejecutar/rechazar">
                     	<%
                     	String[] indices = request.getParameterValues("indice");
                     	if (indices != null){
                     		for (int i = 0; i < indices.length; i++){%>                     	
                     		<input type="hidden" name="indice" value="<%=indices[i]%>"/>
					 <%		}
                     	}%>
                     	
                     	
                     	<div class="row">
  <div class="col-md-1"></div>
  <div class="col-md-3"><b>Motivo del rechazo</b></div>
 
  <div class="col-md-6"><textarea name="motivo" cols="40" rows="4" onkeypress="alphabetic();validateLength(this, 1000)"class="form-control" id="motivo"></textarea></div>
    <div class="col-md-1"></div>
                     	
                     	
             </div>          	
                     	
                     	
                       <br>	
                     	
                     	
  <div align="center">
  <input type="submit" class="btn btn-default" style="width: 100px" value="Continuar"/>&nbsp;
  
  <INPUT class="btn btn-default" style="width: 100px" onclick="document.location='<html:rewrite page='/compensacion/autorizar2.jsp'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
  </div>
					    
	                <br>	
	          
              
		</html:form>


</div>
</div>
</div>
</div>

<%@ include file="/footer.jsp"  %>
</div>
</body>
</html:html>
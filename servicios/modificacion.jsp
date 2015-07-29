<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../head.jsp"  %> 

<!DOCTYPE html>
<html:html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
</head>

<%@ include file="../body.jsp"%>

<body>

<div align="center" class="container"> 

<logic:messagesPresent>
  <table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso">
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

		<div class="row">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.transf.inter.modificacion"/></strong></div>
					  <div class="panel-body">
					  
					<html:form method="post" action="/query3">
<html:hidden property="estado"  /> 
					

  	 
					
									<label style="text-align:left">	<h5><strong>
				
						<font color="#FF0000" >*</font>&nbsp;<bean:message key="lbl.transf.inter.cliente"/>:
					
						</strong></h5>
			</label>
			
			  
  	  	<div class="row">
  <div class=".col-md-2" style="align: right"></div>
  <div class=".col-md-6" style="align: center; padding-right: 3%; width: 90%;" ><html:select property="cliente" styleClass="form-control">
										<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
										<csic:forEachCliente orderBy="NAME_ORDER">  
											<html:option value="<%=codigo%>" ><%=nombre%>&nbsp;<%=apellido%></html:option>	
										 </csic:forEachCliente>
								   </html:select>    </div>
 
</div>

<br>

	  <div> 
			<html:submit styleClass="btn btn-default"  style="width: 110px;"><bean:message key="btn.consultar"/></html:submit>
		
						<html:reset styleClass="btn btn-default" style="width: 110px;"><bean:message key="btn.limpiar"/></html:reset>
			
		  </div>

				 </form>
	<br>
		 
				<div>
					<div class="texto-acceso">
						<h6 style="color:#95A5A6 "><bean:message key="lbl.mensaje.campo.requerido"/></h6>
						
					</div>
				</div>	

 </html:form>
					</div>

		</div>
	
	</div>
	</div>
	
		</div>

</div>
</body>
</html:html>
<% session.setAttribute("selected", "consultas"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%!
	private String getProducto(String tipo){
		String product = "tit.consulta.saldo";
		if ("CA".equals(tipo))
			product = "tit.consulta.saldo.ca";
		else if ("CC".equals(tipo))
			product = "tit.consulta.saldo.cc";
		else if ("DP".equals(tipo))
			product = "tit.consulta.saldo.dp";
		else if ("PR".equals(tipo))
			product = "tit.consulta.saldo.pr";
		
		return product;	
	}
%>

<%
	String prod = "ALL";
	if (request.getParameterValues("prod") != null)
	{
	  prod = request.getParameterValues("prod")[0];
	} 
	
	String tipo = "CON";
	if (request.getParameterValues("tipo") != null)
	{
	  tipo = request.getParameterValues("tipo")[0];
	} 
%>

<%@ include file="../head.jsp"  %> 

<script language="JavaScript">
	function send(){ 
	        if (document.forma.cuentas.value == "-1")
			{
			   alert("<bean:message key="msg.seleccionar.cuenta"/>");
	
			   document.forma.cuentas.focus();
			}
			else
				document.forma.submit();
	}
	function retornar(){
		history.back();
	}	  
</script>

<!DOCTYPE html>
<html:html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>

<body>

<%@ include file="../body.jsp"%>



<div align="center" class="container"> 



		<div class="row">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="<%=getProducto(prod)%>"/></strong></div>
					  <div class="panel-body">
					
	<form name=forma method=POST action="<html:rewrite page='/do.consulta'/>">

		<input type="hidden" name="tipo" value="CON_SO">
	  	<input type="hidden" name="producto" value="<%=prod%>">
	  	<input type="hidden" name="backPage" value="../servicios/seleccion.jsp?prod=<%=prod%>" >
  	 
					
									<label style="text-align:left">	<h5><strong>
				
						<font color="#FF0000" >*</font>&nbsp;<bean:message key="lbl.cuentas"/>:
					
						</strong></h5>
			</label>
			
			  
  	  	<div class="row">
  <div class=".col-md-2" style="align: right"></div>
  <div class=".col-md-6" style="align: center; padding-right: 3%; width: 90%;" ><csic:ListaCuentas classname="form-control" name="cuentas" acceso="CON" producto="<%=prod%>"/>  </div>
 
</div>

<br>


	<div>
					<input name="botonEnviar" style="width: 100px" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
					
					
				
					
					
					
				  	<input TYPE="BUTTON" style="width: 100px" class="btn btn-default" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
				</div>
	<br>
		 
				<div>
					<div class="texto-acceso">
						<h6 style="color:#95A5A6 "><bean:message key="lbl.mensaje.campo.requerido"/></h6>
							<%@ include file="../divFooter.jsp"%>
					</div>
				</div>	
				
	
  
					
					</div>
					
				<%@ include file="../divFooter.jsp"%>
			

	</form>
	
		</div>
	
	</div>
	</div>
	
		</div>
	  
</div>


</body>




</html:html>

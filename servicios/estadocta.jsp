<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale"%>
<%@ page import="com.arango.common.util.i18n.ASIResourceBundle" %>

<%!
	private String getProducto(String tipo){
		String product = "tit.title.consulta.estado.cuenta.ca";
		if ("CA".equals(tipo))
			product = "tit.title.consulta.estado.cuenta.ca";
		else if ("CC".equals(tipo))
			product = "tit.title.consulta.estado.cuenta.cc";
		else if ("DP".equals(tipo))
			product = "tit.title.consulta.estado.cuenta.do";
		else if ("PR".equals(tipo))
			product = "tit.title.consulta.estado.cuenta.pr";
		
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
	
	Locale localecc = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
	if (localecc == null) {
	   // algunos browser no detectan el idioma de forma adecuada con version java 1.4
	   // por defecto toma el idioma espanol
	   localecc = ASIResourceBundle.getDefaultLocale();
	}
	
	Date[] desde = null;
	Date[] hasta = null;
	Calendar cal = Calendar.getInstance();
	
	cal.setTime(new Date (System.currentTimeMillis()));
	
	//System.out.println("Calendar Month..........................: "+cal.get(Calendar.MONTH));
	
	cal.add(Calendar.MONTH, -6);
	
	desde = new Date[6];
	hasta = new Date[6];
	Date fecha = cal.getTime();
	
	for (int i = 0; i < 6; i++){	
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		hasta[i] = cal.getTime();
	
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMinimum(Calendar.DAY_OF_MONTH));
		desde[i] = cal.getTime();
		
	  cal.add(Calendar.MONTH,1);
	}
	
	SimpleDateFormat df = new SimpleDateFormat("MMMMM-yyyy", localecc);
	                      
	session.setAttribute("periodo.desde", desde);
	session.setAttribute("periodo.hasta", hasta);
%>

<%@ include file="../head.jsp"  %> 

<!DOCTYPE html>
<html:html>


<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

<script>
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

</head>

<body>

<%@ include file="../body.jsp"%>

<div class="container"> 









	<div class="row">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="<%=getProducto(prod)%>"/></strong></div>
					  <div class="panel-body">

	<form name=forma method=POST class="" action="<html:rewrite page='/do.consulta'/>">
  		<input type="hidden" name="tipo" value="ESTV">
  		<input type="hidden" name="backPage" value="../servicios/estadocta.jsp?prod=<%=prod%>" >

	<div style="align: left">
	            	
								<label style="text-align:left">	<h5><strong>
				
						<font color="#FF0000" >*</font>&nbsp;<bean:message key="lbl.cuentas"/>:
					
						</strong></h5>
			</label>
			
			
				</div>

	        	
	        	
	        	
	        	
	        	  	  	<div class="row">
  <div class=".col-md-2"></div>
  <div class=".col-md-6" style="width: 90%; padding-left: 10%;" ><csic:ListaCuentas classname="form-control" name="cuentas" acceso="CON" producto="<%=prod%>"/></div>
 
</div>
	        	
	        	
	        	
	        	
	        		<br>
	        									
	        									<label style="text-align:left">	<h5><strong>
				
						<font color="#FF0000" >*</font>&nbsp;<bean:message key="lbl.periodo"/>:
					
						</strong></h5>
			</label>
	        	
	        	
	        				<table width="100%" class="">
					    <%
					    String checked = "checked";
					    String styleClass = "";
					    
					    for (int i = 0; i < 6; i++){
							styleClass = i % 2 == 0 ? "" : "class=\"celda-clave1\"";%>
						
						<tr>
							
							<td class = "bienvenida" nowrap align="left"><h6 style="text-transform: capitalize">
							
								
								&nbsp;&nbsp;<input type="radio" value="<%=i%>" name="periodo" <%=checked%>/>
							
								&nbsp;&nbsp;<%=df.format(hasta[i])%>
							</h6></td>
						</tr>
						<%
						checked = "";
						} %> 
					</table>
	        	
	        		<br>
	        	
	        	
				<div align="center">
					<input name="botonEnviar" onclick="send();" type="button" style="width: 100px" class="btn btn-default" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
				  	<input TYPE="BUTTON" class="btn btn-default" style="width: 100px" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
				</div>
				
				
	 
	  		<br>
	  		  	  	
		<div>
					<div class="texto-acceso" align="center">
						<h6 style="color:#95A5A6 "><bean:message key="lbl.mensaje.campo.requerido"/></h6>
							<%@ include file="../divFooter.jsp"%>
					</div>
				</div>	
		
	  	<%@ include file="../divFooter.jsp"%>
	</form>			
	  		
	  	</div>			
	  	</div>	
	  	</div>	
	  	</div>	
	  	</div>	
	  		</div>	
	  		
	  		</body>
	  		
	  		</html:html>
	  		
	  
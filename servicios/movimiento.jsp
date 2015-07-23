<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>

<%
	SimpleDateFormat df = new SimpleDateFormat("yyyy");
	Date pDate = new java.util.Date(System.currentTimeMillis());
	String pYear = df.format(pDate);
	
	df.applyPattern("MM");
	String pMonth = df.format(pDate);
	
	df.applyPattern("dd");
	String pDay = df.format(pDate);
	
	df.applyPattern("dd-MM-yyyy");
	
	String fecha = df.format(pDate);	

%>

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

<!DOCTYPE html>
<html:html>

<head>

<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>

<%
	Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
	if (locale == null){
		locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
		session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
	}
	String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>

<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar.js'/>"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

</head>

<body>


<script language='javascript'>
	var t;
	function send(){
	    if (document.forma.cuentas.value == "-1")
		{
		   alert("<bean:message key="msg.seleccionar.cuenta"/>");
		   document.forma.cuentas.focus();
		   return;
		}
		if (t == "3"){
			if (document.forma.desde.value == ""){
				alert("<bean:message key="msg.seleccionar.fecha"/>");
				document.forma.desde.focus();
				return;
			}
			if (document.forma.hasta.value == ""){
				alert("<bean:message key="msg.seleccionar.fecha"/>");
				document.forma.hasta.focus();
				return;
			}
		}
		
		document.forma.submit();
	}
	function setValue(_value){
		t = _value;
	}
	function retornar(){
		history.back();
	}
</script>

<script language="javascript" src="../scripts/utilidades.js"></script>
<script language="javascript" src="../scripts/objetoFecha.js"></script>

<%@ include file="../body.jsp"%>




<div class="container">



		<div class="row">

		  <div class="row">
		<div class="col-md-4 col-md-offset-4">

	<div class="panel panel-default" >
					 <div class="panel-heading" align="justify" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="tit.title.consulta.movimientos"/></strong></div>
					  <div class="panel-body">
					  
					  
					  

	<form name="forma" class="" method="post" action="<html:rewrite page='/do.consulta'/>">
		<input type="hidden" name="tipo" value="MOV_EXT">
		<input type="hidden" name="prod" value="<%=prod%>">
		<input type="hidden" name="mesesAtras" value="1">

	<div style="align: left">
	            	
	            								<label style="text-align:left">	<h5><strong style="align: left">
				
						<bean:message key="lbl.movimiento.tipos"/>:
					
						</strong></h5>
			</label>
			
			
				</div>
	            	
	            	

	        	<div>

	        	
	        	
	        	
	        	
	        	<div class="row">
  <div class="col-md-3" >     <div>
		                    	<input name="tipoMov" id="TipoOperacion" type="radio" value="1" checked onclick="setValue(1);">
		                      	<span class="">	<h7>
		                      		<bean:message key="lbl.movimientos.dia"/> </h7>
		                      </div></div>
  <div class="col-md-5" >        <div>
		                    	<input type="radio" name="tipoMov" id="TipoOperacion" value="2" onclick="setValue(2);">
		                      	<span class=""><h7>
		                      		<bean:message key="lbl.movimientos.mes"/></h7>
		                      	</span>
		                    </div></div>
  <div class="col-md-4">             <div>
		                    	<input type="radio" name="tipoMov" id="TipoOperacion" value="3" onclick="setValue(3);">
		                    	<span class=""><h7>
		                    		<bean:message key="lbl.movimientos.historicos"/></h7>
		                    	</span>
		                    </div>
	               </div>
	                  </div>
  

		
		
			
					<div>
				
							<div>
							<br>
						<label style="text-align:left">	<h5><strong>
				
						<font color="#FF0000" >*</font>&nbsp;<bean:message key="lbl.cuentas"/>:
					
						</strong></h5>
			</label>
			
			
			
			
			
			
							</div>
						
							
							
							<div class="row">
							
							 <div class="col-md-1"></div>

  <div class="col-md-10"><csic:ListaCuentas classname="form-control" name="cuentas" acceso="CON" producto="<%=prod%>" cuentaDefault="<%=cuenta%>"/> </div>
							
							
							</div>
							
							
							
							
							
								
					
							
				<br>
					
							
							
							
							
							
							
							
							<div class="row">
  <div class="col-md-2">								<label style="text-align:left">	<h5><strong>
				
							<bean:message key="lbl.desde"/>:
					
						</strong></h5>
			</label></div>
  <div class="col-md-5" align="center"><input name="desde" id="desde" type="text" class="form-control" size="20" maxlength="12" value="<%=fecha%>"></div>
  <div class="col-md-5"><input type="button" class="calendar2" value=" " id="date_trigger1" onclick="return showCalendar('desde', 'dd-mm-y');" > [<b>dd-mm-yyyy</b>]	</div>
					
								</div>
							
								
								
	
								
								
								
								
								
								
								
								
								
								
									<br>
								
						
							
							
							
							
													<div class="row">
  <div class="col-md-2">								<label style="text-align:left">	<h5><strong>
				
							<bean:message key="lbl.hasta"/>:
					
						</strong></h5>
			</label></div>
  <div class="col-md-5" align="center"><input name="hasta" id="hasta" type="text" class="form-control" size="20" maxlength="12" value="<%=fecha%>"></div>
  <div class="col-md-5"><input type="button" class="calendar2" value=" " id="date_trigger2" onclick="return showCalendar('hasta', 'dd-mm-y');"> [<b>dd-mm-yyyy</b>]</div>
					
								</div>	
							
							<br>
			
							
							
						
	<div align="center">
	<input name="botonEnviar" onclick="send();" type="button" style="width: 100px" class="btn btn-default" value="<bean:message key="btn.consultar"/>">  
		
<input TYPE="BUTTON" class="btn btn-default" style="width: 100px" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
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

</div>

</body>

</html:html>
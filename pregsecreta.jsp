<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import = "com.arango.common.beans.UserInfo"%>
<%@ page import = "com.arango.common.services.ManagerBean"%>
<%@ page import = "com.arango.common.beans.PreguntaUsuario"%>
<%@ page import = "java.util.ArrayList"%>
<% 
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
%>
<!DOCTYPE html>
<html:html>
<head>
<script type="text/javascript">
<!--
if (typeof window.event != 'undefined') // IE
document.onkeydown = function() // IE
 {
 var t=event.srcElement.type;
 var kc=event.keyCode;
 return ((kc != 8 ) || ( t == 'text'  ) ||
          (t == 'textarea') || ( t == 'submit' ) || (t =='password'))
 }
else
document.onkeypress = function(e)  // FireFox/Others 
 {
 var t=e.target.type;
 var kc=e.keyCode;
 if ((kc != 8 ) || ( t == 'text'  ) ||
     (t == 'textarea') || ( t == 'submit' ) || (t =='password'))
     return true
 else {
     return false
 }
}
//-->
</script>

<script language="javascript">
function send(){
    if(validateQuestion())/* && validatePreg(document.forma.respuesta1)
    		&& validatePreg(document.forma.respuesta2) && validatePreg(document.forma.respuesta3) && validatePreg(document.forma.pregunta3))*/
    {
  		document.forma.submit();
    }  
}

function validateQuestion(){
	var tem1;
	var tem2;
	/*if (document.forma.pregunta1.value == "-1")
	{
		alert("Debe seleccionar la pregunta 1");
		return false;
	}*/
  	if (document.forma.respuesta1.value == "")
  	{
     	 alert("El campo de respuesta 1 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirma1.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 1 no puede estar vacio");
     	 return false;
  	}  	
  	tem1 =document.forma.respuesta1.value;
  	tem2 =document.forma.confirma1.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
		 alert("La respuesta a la pregunta 1 no coincide con la confirmación");
		 return false;
	}
	/*if (document.forma.pregunta2.value == "-1")
	{
		alert("Debe seleccionar la pregunta 1");
		return false;
	}*/
  	if (document.forma.respuesta2.value == "")
  	{
     	 alert("El campo de respuesta 2 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirma2.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 2 no puede estar vacio");
     	 return false;
  	}
  	
  	tem1 =document.forma.respuesta2.value;
  	tem2 =document.forma.confirma2.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
		 alert("La respuesta a la pregunta 2 no coincide con la confirmación");
		 return false;
  	}
  	if (document.forma.pregunta3.value == "")
  	{
     	 alert("El campo de pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirmapreg3.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	
  	tem1 =document.forma.confirmapreg3.value;
  	tem2 =document.forma.pregunta3.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
     	 alert("La pregunta 3 y su confirmación no contienen los mismos valores, verifique.");
     	 return false;
  	}
  	if (document.forma.respuesta3.value == "")
  	{
     	 alert("El campo de respuesta 3 no puede estar vacio");
     	 return false;
  	}
  	
  	if (document.forma.confirma3.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	tem1 =document.forma.respuesta3.value;
  	tem2 =document.forma.confirma3.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
		 alert("La respuesta a la pregunta 3 no coincide con la confirmación");
		 return false;
  	}
	 	
  	return true;    				 
}

function validatePreg(campo) {
    var RegExPattern = /([a-zA-Z0-9 ]{4,10})$/;
    var resp = false;
    var errorMessage = 'Los campos solo pueden contener caracteres alfanumericos y deben poseer de 4 a 50 caracteres.';
    if ((campo.value.match(RegExPattern)) && (campo.value!='')) {
        resp = true;
    } else {
        alert(errorMessage);
        resp = false;
    }
    return resp;
}

</script>
<SCRIPT language="Javascript">
var mensaje = "<bean:message key='<%=copyrigth %>' arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>";
function noViewSource(btnClick)
{
	if (navigator.appName == "Netscape" && btnClick.which == 3)
	{   alert(mensaje);
		return false;
	}
	else if (navigator.appName =="Microsoft Internet Explorer" && event.button == 2)
	{	alert(mensaje);
		return false;
	}
}
document.onmousedown = noViewSource;
if (navigator.appName =="Microsoft Internet Explorer")
   document.oncontextmenu = noViewSource;
</SCRIPT>

<SCRIPT language="JavaScript">
function protect(evt){
 if (navigator.appName != "Microsoft Internet Explorer"){
 if (evt.which != 3)
 return true;
};
return false;
}

function trap(){
 if(document.images){
 if(navigator.appName != "Microsoft Internet Explorer"){
 document.onmousedown = protect;}
 else{
document.oncontextmenu = protect;}}}
window.statusbar=' ';
</SCRIPT>
<script language="javascript" src="./scripts/campos.js"></script>
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/teclado.css'/>">
<script type="text/javascript" src="<html:rewrite page='/scripts/tecladoUpdate.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">
</head>

<body style="padding-top: 30px;"  onLoad="reset();" >


  <div class="row">
  <div class="col-md-4"></div>
  <div class="col-md-7"><img class="img-responsive" alt="Responsive image" border="0" align="right" src="<html:rewrite page='/images/logo.jpg'/>"/></div>
<div class="col-md-1"></div>
  </div>

<div class="container" style="padding-top: 30px;">


<logic:present name="msg">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabla-acceso">
	<tr> 
		<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
		<td valign="top">
			<table>
				<tr><td class="bienvenida"><b><bean:message key="errors.header"/></b></td></tr>
				<tr><td class="bienvenida">
		        <%
		            String errors[] = session.getAttribute("msg").toString().split(";");
		            for(int i=0; i<errors.length; i++){
		        %>
					    - <bean:message key="<%=errors[i] %>"/>
					    
		        <% out.println("<BR>"); }	%>	
				</td></tr>
			</table>
		</td>
	</tr>
</table>   
</logic:present>
<%
   session.removeAttribute("msg");
   ManagerBean mb = new ManagerBean();
   UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
%>

<form name="forma" action="<html:rewrite page='/do.preguntas'/>" method="post">
<%
if (session.getAttribute("pregOK") != null)
{
%>
<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="580">
<TR>
      <TD class="bienvenida">
        <h4><font color="#CC6600"><bean:message key='<%=session.getAttribute("pregOK").toString()%>'/></font></h4>
      </TD>
 </TR></TABLE>
<%
session.removeAttribute("pregOK");
}
%>

  <br>

          <div class="col-md-6">

          <div class="panel panel-default">
					 <div class="panel-heading" align="left" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.pregunta.tips.titulo"/></strong></div>
  <div class="panel-body" align="justify" style="padding-right: 8%;" >

  <UL>
	     		<li><bean:message key="lbl.preg.secreta.obs1"/></li>
	     		<li><bean:message key="lbl.preg.secreta.obs2"/></li>
		     	<li><bean:message key="lbl.preg.secreta.obs3"/></li>
	   		    <li><bean:message key="lbl.preg.secreta.obs6"/></li>
	     		<li><bean:message key="lbl.preg.secreta.obs7"/></li>	
     	    </UL>
 
  
  </div>
</div>

          </div>

		
        
          <div class="col-md-6"><div class="panel panel-default">
					 <div class="panel-heading" align="left" ><img src="<html:rewrite page='/images/logo_icon.png' />" /><strong><bean:message key="lbl.preg.secreta.titulo1a"/></strong></div>
  <div class="panel-body">


									<label style="text-align:left">	<h5><strong>
				
						1. <bean:message key="lbl.preg.secreta1"/>:
					
						</strong></h5>
			</label>
			
			  
  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%; " >	   <select class="form-control" name="pregunta1">
			   <option value="-1"><bean:message key="lbl.seleccion.pregunta"/></option>
			   <%
			   		ArrayList lista = mb.getPreguntasCuestionario(userInfo);
			   		PreguntaUsuario pregunta = null;
			   		int preg1 = Integer.parseInt((request.getParameter("pregunta1")==null || request.getParameter("pregunta1").equals(""))?"0":request.getParameter("pregunta1"));
			   		int preg2 = Integer.parseInt((request.getParameter("pregunta2")==null || request.getParameter("pregunta2").equals(""))?"0":request.getParameter("pregunta2"));
			   		String preg3 = (request.getParameter("pregunta3")!=null)?request.getParameter("pregunta3"):"";
			   		String respuesta1 = (request.getParameter("respuesta1")!=null)?request.getParameter("respuesta1"):"";
			   		String respuesta2 = (request.getParameter("respuesta2")!=null)?request.getParameter("respuesta2"):"";
			   		String respuesta3 = (request.getParameter("respuesta3")!=null)?request.getParameter("respuesta3"):"";
			   	
			   		
			   		for (int i=0; i<8; i++)
			   		{
			   			pregunta = (PreguntaUsuario)lista.get(i);
			   			String selected = (preg1==pregunta.getCodigoPregunta()) ? " selected " : "";
			   	        out.println("<option value=\"" + pregunta.getCodigoPregunta() + "\""+ selected + ">");
			   			if (pregunta.getNombreEtiqueta() != null){
			   			%>	
			   				<bean:message key="<%=pregunta.getNombreEtiqueta() %>"/>
			   		    <%
			   			}else
				   		    out.print(pregunta.getDescripcionPregunta());
			   			out.print("</option>");
			   		}
			   		%>
				</select> </div>
 
</div>

<br>

									<label style="text-align:left; padding-left: 3%;">	<h5><strong>
				
						<bean:message key="lbl.resp.secreta1"/>:
					
						</strong></h5>
			</label>

  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%;"><input name="respuesta1" type="text" class="form-control" size="20" maxlength="50" value="<%=respuesta1 %>"></div>
 
</div>

<br>

									<label style="text-align:left; padding-left: 3%;">	<h5><strong>
				
						<bean:message key="lbl.preg.secreta.conf.resp"/>:
					
						</strong></h5>
			</label>




  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%;"><input name="confirma1" type="text" class="form-control" size="20" maxlength="50" value="<%=respuesta1 %>"><bean:message key="lbl.preg.secreta.rango"/></div>
 
</div>

<br>

									<label style="text-align:left">	<h5><strong>
				
						2.<bean:message key="lbl.preg.secreta2"/>:
					
						</strong></h5>
			</label>

  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%;">
  	   <select class="form-control" name="pregunta2">
			   	  <option value="-1"><bean:message key="lbl.seleccion.pregunta"/></option>
			   <%
			   		for (int i=0; i<8; i++)
			   		{
			   			pregunta = (PreguntaUsuario)lista.get(i+8);
			   			String selected = (preg2==pregunta.getCodigoPregunta()) ? " selected " : "";
			   			out.println("<option value=\"" + pregunta.getCodigoPregunta() + "\""+ selected + ">");
			   			if (pregunta.getNombreEtiqueta() != null){
			   			%>	
			   				<bean:message key="<%=pregunta.getNombreEtiqueta() %>"/>
			   		    <%
			   			}else
				   		    out.println(pregunta.getDescripcionPregunta());
			   			out.print("</option>");
			   		}
			    %>
				</select>
						
  </div>
 
</div>

<br>

									<label style="text-align:left; padding-left: 3%;">	<h5><strong>
				
						<bean:message key="lbl.resp.secreta2"/>:
					
						</strong></h5>
			</label>

  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%;"><input name="respuesta2" type="text" class="form-control" size="20" maxlength="50" value="<%=respuesta2 %>">
  <bean:message key="lbl.preg.secreta.rango"/></div>
 
</div>

<br>

				<label style="text-align:left; padding-left: 3%;">	<h5><strong>
				
						<bean:message key="lbl.preg.secreta.conf.resp"/>:
					
						</strong></h5>
			</label>

  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%;"><input name="confirma2" type="text" class="form-control" size="20" maxlength="50" value="<%=respuesta2 %>">
  <bean:message key="lbl.preg.secreta.rango"/></div>
 
</div>

<br>
						<label style="text-align:left;">	<h5><strong>
				
						3.<bean:message key="lbl.preg.secreta3"/>:
					
					
						</strong></h5>
			</label>



<br>
							<label style="text-align:left; padding-left: 3%;">	<h5><strong>
				
						<bean:message key="lbl.preg.secreta3.texto"/>:
				
					
						</strong></h5>
			</label>

  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%;"><input name="pregunta3" type="text" class="form-control" size="40" maxlength="50" value="<%=preg3 %>"> 
</div>
 
</div>

<br>

									<label style="text-align:left; padding-left: 3%;">	<h5><strong>
				
						<bean:message key="lbl.preg.secreta3.confirm"/>:
				
					
						</strong></h5>
			</label>

  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%;"><input name="confirmapreg3" type="text" class="form-control" size="40" maxlength="50" value="<%=preg3 %>"> 
</div>
 
</div>

<br>

									<label style="text-align:left; padding-left: 3%;">	<h5><strong>
				
						<bean:message key="lbl.resp.secreta3"/>:
				
					
						</strong></h5>
			</label>

  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%;"><input name="respuesta3" type="text" class="form-control" size="20" value="<%=respuesta3 %>">
</div>
 
</div>

<br>

									<label style="text-align:left; padding-left: 3%;">	<h5><strong>
				
						<bean:message key="lbl.preg.secreta.conf.resp"/>:
				
					
						</strong></h5>
			</label>

  	  	<div class="row">
  <div class=".col-md-2" ></div>
  <div class=".col-md-6" style="padding-right: 0%; width: 90%; padding-left: 8%;"><input name="confirma3" type="text" class="form-control" size="20" value="<%=respuesta3 %>">
</div>
 
</div>


<br>


				<div class="row">
										 <div class="col-md-3"></div>	
  <div class="col-md-2">	<div align="center">
                                      
                                        	<input type="hidden" name="marca" id="marca" value="">
                                        	<input name="button" type="button" onclick="send()" class="btn btn-default" style="width: 110px;" value="Enviar"> 
			  				
			  							
			  							</div></div>
			  							
			  							 <div class="col-md-1"></div>	
			  							
			  							
  <div class="col-md-2">	<div align="center">
			  						
			  							
									<input name="Submit2" type="reset" class="btn btn-default" style="width: 110px;" value="Limpiar"> 
									
										
										</div></div>
										
										 <div class="col-md-4"></div>	
										
							</div>
										
										<br>
	



</form> 

</div> 
</body> 

</html:html>
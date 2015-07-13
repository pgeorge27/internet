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
<html>
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
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="reset();" >
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
   <tr> 
        <td ><br>
		<table width="100%" border="0" cellpadding="10" cellspacing="0">
			<tr><td align="right"><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
			<br></td>
    <td>&nbsp;</td>
    
  </tr>
  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="width:254;height:26;background-color:#EFEFEF;"><div  class="bienvenida"></div></td>
  </tr>
  <tr valign="top"> 
    <td colspan="4">
   
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
<div align="center"> 
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
<table width="800" align="left">
<tr><td width="30">&nbsp;</td>
<td width="1000" align="left">
<table width="1000" border="0" align="left" cellpadding="0" cellspacing="0">
<tr> 
	<td height="20" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="60%"><div align="left" class="login"><bean:message key="lbl.preg.secreta.titulo1a"/></div></td>
			<td width="40%"><div align="right"></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr><td>&nbsp;</td></tr> 
  <tr><td>&nbsp;</td></tr>
  <tr> 
	<td valign="top" align="left">
	 <table>
	 <tr valign="top">
	    <td>
	    <!--  Tabla con Preguntas -->
		<table width="400" border="0" cellpadding="0" cellspacing="2">
		  <tr>
		    <td class="bienvenida2">1. <bean:message key="lbl.preg.secreta1"/></td>
		  </tr>
		  <tr><td>&nbsp;</td></tr>
		  <tr> 
			<td align="center">
			   <select name="pregunta1">
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
				</select>
		    </td>
		  </tr>
		 <tr> 
			<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.resp.secreta1"/></td>
		 </tr>
		 <tr>
			<td align="center"><input name="respuesta1" type="text" class="caja-acceso" size="20" maxlength="50" value="<%=respuesta1 %>"></td>
		  </tr>
		  <tr> 
			<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.preg.secreta.conf.resp"/></td>
		 </tr>
		 <tr>
			<td align="center"><input name="confirma1" type="text" class="caja-acceso" size="20" maxlength="50" value="<%=respuesta1 %>"></td>
		  </tr>
		 <tr>
		    <td class="texto-acceso" align="center"><bean:message key="lbl.preg.secreta.rango"/></td>
		 </tr>
		 <tr><td>&nbsp;</td></tr>
		  <tr>
		    <td class="bienvenida2">2. <bean:message key="lbl.preg.secreta2"/></td>
		  </tr>
		  <tr><td>&nbsp;</td></tr>
		  <tr>
			<td align="center">
			   <select name="pregunta2">
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
		    </td>
		  </tr>
		 <tr> 
			<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.resp.secreta2"/></td>
	     </tr>
	     <tr>
			<td align="center"><input name="respuesta2" type="text" class="caja-acceso" size="20" maxlength="50" value="<%=respuesta2 %>"></td>
		  </tr>
		  <tr> 
			<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.preg.secreta.conf.resp"/></td>
		 </tr>
		 <tr>
			<td align="center"><input name="confirma2" type="text" class="caja-acceso" size="20" maxlength="50" value="<%=respuesta2 %>"></td>
		  </tr>
		 <tr>
		    <td class="texto-acceso" align="center"><bean:message key="lbl.preg.secreta.rango"/></td>
		 </tr>
		 <tr><td>&nbsp;</td></tr>
		  <tr>
		    <td class="bienvenida2">3. <bean:message key="lbl.preg.secreta3"/>&nbsp;
		    <span class="texto-acceso"><bean:message key="lbl.preg.secreta.rango"/></span></td>
		  </tr>
		  <tr><td>&nbsp;</td></tr>
		  <tr>
		   <td class="bienvenidaBold" align="left">&nbsp;&nbsp;<bean:message key="lbl.preg.secreta3.texto"/></td></tr>
		  <tr> 
			<td class="bienvenidaBold" align="left">&nbsp;&nbsp;<input name="pregunta3" type="text" class="caja-acceso" size="40" maxlength="50" value="<%=preg3 %>"> 
			  </td>
		  </tr>
		 <tr>
		   <td class="bienvenidaBold" align="left">&nbsp;&nbsp;<bean:message key="lbl.preg.secreta3.confirm"/></td></tr>
		  <tr> 
			<td class="bienvenidaBold" align="left">&nbsp;&nbsp;<input name="confirmapreg3" type="text" class="caja-acceso" size="40" maxlength="50" value="<%=preg3 %>"> 
			  </td>
		  </tr>
		  <tr> 
			<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.resp.secreta3"/></td>
		  </tr>
		  <tr>
			<td align="center"><input name="respuesta3" type="text" class="caja-acceso" size="20" value="<%=respuesta3 %>"></td>
		  </tr>
 		 <tr> 
			<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.preg.secreta.conf.resp"/></td>
		 </tr>
		 <tr>
			<td align="center"><input name="confirma3" type="text" class="caja-acceso" size="20" value="<%=respuesta3 %>"></td>
		  </tr>
		  <tr><td>&nbsp;</td></tr>
		  <tr> 
			<td align="center"><input name="button"  type="button" onclick="send()" class="botton" value="<bean:message key="btn.enviar"/>"> 
			  &nbsp;&nbsp;<input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>"> 
			</td>
		  </tr>
		</table>
		<!--  FIn de Tabla con Preguntas -->
		</td>
		<td>
		<!--  Tabla con Tips -->
		<%@ include file="divHeader.jsp"%>
		<table cellspacing="0"  >
         <tr><td colspan="2">&nbsp;</td></tr>
         <tr>
      	   <td width="5%"><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	       <td><p class="bienvenida_2"><B><bean:message key="lbl.pregunta.tips.titulo"/></B></p></td>
	     </tr>
	     <tr>
           <td class="bienvenida_2" colspan="2">
     	     <UL>
	     		<li><bean:message key="lbl.preg.secreta.obs1"/></li>
	     		<li><bean:message key="lbl.preg.secreta.obs2"/></li>
		     	<li><bean:message key="lbl.preg.secreta.obs3"/></li>
	   		    <li><bean:message key="lbl.preg.secreta.obs6"/></li>
	     		<li><bean:message key="lbl.preg.secreta.obs7"/></li>	
     	    </UL>
          </td>
        </tr>
	  </table>
	  <%@ include file="divFooter.jsp"%>
		<!--  Fin de Tabla con Tips -->
		</td>
		</tr>
		</table>
	 </td>
  </tr>
</table> 
</td></tr></table>
<br>

</form> 
</div>
</td>
</tr>
  <tr style=" width : 1000px;">
    <td height="31" colspan="6" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">&copy; 
        <bean:message key="<%=copyrigth %>"  arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div></td>
   </tr>
</table> 
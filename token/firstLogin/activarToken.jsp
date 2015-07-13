<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import = "com.arango.common.beans.UserInfo"%>

<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.aplicar.regla.password", "true");
String role = session.getAttribute("role.user").toString();
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";

%>

<%@ include file="../../head.jsp"%>
<%@ include file="jsScripts.jsp"%>

<script language="javascript"> src="<html:rewrite page='/scripts/campos.js'/>"</script>
<script language="javascript"> src="<html:rewrite page='/scripts/ValidaFirmaDigital.js'/>"</script>

<script language="javascript">
function campoChange(campo){
if(1 == campo){
document.forma.Foco.value = "claveold"
}else if(2 == campo){
document.forma.Foco.value = "clavenew"
}else if(3 == campo){
document.forma.Foco.value = "claveconf"
}
}


//validamos pass
function validatePass(){
	if(document.getElementById('claveold').value=="")
	{
		alert("<bean:message key="lbl.actualiza.campos.requeridos"/>");
		return false;
	}
	else if(document.getElementById('claveold').value.length<8)
	{	
		alert("<bean:message key="error.token.activarToken.largo"/>");
		return false;
	}
	else
	{
		return true;
	}

}

function send(){
	 if (validatePass()) {
	     $.blockUI({
	         message: $('#esperar'),
	         css: {
	             width: '400px'
	         }
	     });
	     setTimeout(function () {
	         $.unblockUI({
	             onUnblock: function () {
	                 $.blockUI({
	                     message: $('#registro1'),
	                     css: {
	                         width: '400px'
	                     }
	                 })
	                
	             }
	         });
	     }, 1000);
	 }
}

function yes2Click()
{
	 $.unblockUI({
		 onUnblock: function () {
			 document.forma.submit();
		 }
	 });
}


var option = "0"; // Solamente teclado numerico   
</script>
<!--%@ include file="../body.jsp"%-->
<!-- Body -->
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/teclado.css'/>">
<script type="text/javascript"  src="<html:rewrite page='/scripts/statusbar.js'/>"></script>

<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>
</HEAD>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.forms[0].reset(); ">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
   <tr> 
        <td ><br>
		<table width="100%" border="0" cellpadding="10" cellspacing="0">
			<tr><td align="right" ><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
			<br></td>
    <td>&nbsp;</td>
    
  </tr>
  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF;" class="bienvenida"><div  class="bienvenida" align="right"><bean:message key="tit.title.first.login.paso4"/></div></td>
  </tr>
  <tr valign="top"> 
    <td colspan="4">
    
<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td height="300" valign="middle"><table border="0" align="left" cellpadding="0" cellspacing="0">
              <tr> 
                <td>
 <br>
<!-- Body -->
<%@ include file="blockDiv.jsp"%>
<logic:present name="msg">
<table width="100%" border="0" cellspacing="1" cellpadding="1" class="tabla-acceso" >
	<tr> 
		<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
		<td valign="top">
			<table>
				<tr><td class="bienvenida"><b><bean:message key="errors.header"/></b></td></tr>
				<tr><td class="bienvenida">
		        <%String error = session.getAttribute("msg").toString();%>
					<bean:message key="<%=error%>"/></td></tr>
			</table>
		</td>
	</tr>
</table>   
</logic:present>
<%
   session.removeAttribute("msg");

	if (session.getAttribute("act")!=null){	
		%>
		<script language="javascript">
			$.blockUI({ message: $('#msgExito'), css: { width: '350px' } });
		</script> 
		<%
		session.removeAttribute("act");
	}

%>
<div align="center">
<table width="100%" align="left">
  <tr> 
	<td height="40" valign="top" colspan="4">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<!-- td width="92%"><div align="left" class="login"><bean:message key="tit.title.cambio.clave.especial"/></div></td>
			<td width="8%"><div align="right"></div></td-->
			<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
				<td width="100%"><div align="left" class="login"><bean:message key="tit.title.registro.token"/></div></td>
				<td width="8%"><div align="right"></div></td>
		  </tr>
		  <tr>
		  	<td width="50px">&nbsp;</td>
		  	<td width="100%" class="bienvenida"><bean:message key="lbl.title.registro.token.otp1"/></td>
		  	<td width="8%"><div align="right"></div></td>
		  </tr>
		  
		  <tr>		 
		  	<td width="50px">&nbsp;</td> 	
		  	<td class="bienvenida"><bean:message key="lbl.title.registro.token.pasos" /></td>
		  	<td width="8%">&nbsp;</td>
		  </tr>																							
		  <tr>
		  	<td width="50px">&nbsp;</td>
		  	<td width="100%">
		  	 <dl>
		  	 	<dt class="bienvenida"><bean:message key="lbl.pasos.registro.token.paso1" /><img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15"></li>
		  	 	<dt class="bienvenida"><bean:message key="lbl.pasos.registro.token.paso2" /><img src="<html:rewrite page='/images/TokenClave.png'/>" height="15"></li>
		  	 	<dt class="bienvenida"><bean:message key="lbl.pasos.registro.token.paso3" /></li>
		  	 </dl>
		  	</td>
		  	<td width="8%">&nbsp;</td>
		  </tr>
		  
		</table>
	  </div></td>
  </tr>
<tr><td>
<form method="post" action="<html:rewrite page='/do.activarToken'/>" name="forma">
<table width="95%" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr valign="top">
     <td>
     <!--  Tabla con Cajas -->     
		<input type="hidden" name="Foco" value="claveold" id="Foco" >
		<input type="hidden" name="paso" value="1" id="paso" >
		<table width="600" border="0" cellpadding="0" cellspacing="2">
		  
		  <tr> 
		  	<td width="3%">&nbsp;</td>
			<td width="31%" height="20" class="celda-clave1" align="left"><div  class="texto-acceso"><bean:message key="lbl.registro.token.clave.generada" /></div></td>
			<td><input type="text" name="otp1" class="inputf" maxlength="8"  onclick="campoChange(1);" id="claveold"/> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>	  
		  </tr>
		  <tr>
		  		<td width="5%">&nbsp;</td>
				<td colspan="2" align="center"class="texto-acceso">
						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
				</td>
			</tr>
				
				<tr><td colspan="3" align="center"><input name="button" onclick="send();" type="button" class="botton" value="<bean:message key="btn.enviar"/>"/><input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>"/></td></tr>
		 

		  <tr> 
			<td>&nbsp;</td><!---->
			<td colspan="2"> 
			   
			</td>
		  </tr>
		</table>
	  </form>
     </td>
   <td>
	</td>
     </tr>
     <tr>
	<td height="20" valign="middle" class="texto-acceso" align="center"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table>
</tr>
</table>

</div>
</td>
</tr></table></td></tr>
 <tr>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">&copy; 
        <bean:message key="<%=copyrigth %>"  arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div></td>
  </tr>
</table></td></tr></table></body></html>
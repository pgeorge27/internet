<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="com.arango.internet.beans.IBAfiliacion" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ page import="com.arango.common.beans.Usuario" %>
<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>
<%@ page import="java.util.ArrayList" %>
<%! 
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();


%>
<% 
String descripcion = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "lbl.mant.imagen.obs3" :  "lbl.mant.imagen.obs4";
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
%>
<%@ include file="head.jsp"  %>
<style type="text/css">
#derechos{
	width: 100%;	 
	background-color:#4D4F53;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #FFFFFF;
	position: fixed; 
	bottom:0;	
	vertical-align: middle;
	padding-bottom: 8px;
	padding-top: 8px;
	text-align: center;
}
</style>
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
<script type="text/javascript"	src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script language="javascript" src="./scripts/campos.js"></script>
<SCRIPT language="Javascript">
var mensaje = "<bean:message key='msg.derechos.reservados' arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>";
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

var imgRe = /^.+\.(jpg|jpeg|gif|png)$/i;
function previewImage(pathField, previewName)
{       
    var path = pathField.value;
    if (path.search(imgRe) != -1)
    {   
        document[previewName].src = 'file://'+path;
    }       
    else    
    {   
        alert("JPG, PNG, and GIFs only!");
    }   
}

var imgRe = /^.+\.(jpg|jpeg|gif|png)$/i;
function previewImage(pathField, previewName)
{       
    var path = pathField.value;
    if (path.search(imgRe) != -1)
    {   
        document[previewName].src = 'file://'+path;
    }       
    else    
    {   
        alert("JPG, PNG, and GIFs only!");
    }   
}


function userElection()
{


}
var login = <%=Integer.parseInt(session.getAttribute("flag").toString())%>
function cancelar()
{
	window.location.href = "<html:rewrite page='/mant/AdminIMG.jsp'/>";
}

$(document).ready(function()
{
	$("#forma").submit(function(event) 
	{
		if ($('#file').val() == "") 
		{
			alert("<bean:message key="msg.imagen.carga"/>"); 
			return false; 
		}
	});
});
</script>
<link rel="stylesheet" type="text/css" 	href="<html:rewrite page='/style/flujos.css'/>" />



<%@ include file="body.jsp"  %>

<table width="100%" border="0" cellspacing="2" cellpadding="2">
				<tr> 
					<td height="300" valign="middle">
						<table border="0" align="center" cellpadding="0" cellspacing="0">
							<tr> 
								<td>
									<br>
									<logic:present name="msg">
									<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabla-acceso">
										<tr> 
											<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
											<td valign="top">
												<table>
													<tr><td class="bienvenida3"><b><bean:message key="errors.header"/></b></td></tr>
													<tr><td class="bienvenida3">
													<%String error = session.getAttribute("msg").toString();%>
														<bean:message key="<%=error%>"/></td></tr>
												</table>
											</td>
										</tr>
									</table>   
									</logic:present>
									<%
									   session.removeAttribute("msg");
									%>
									<div align="center"> 
									<%@ include file="divHeader.jsp"%>
										<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
										  <tr> 
											<td height="20" valign="bottom">
											<div align="left"> 
												<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
												  <tr> 
													<td width="100%"><div align="center" class="fuente-titulo"> <bean:message key="tit.seleccion.marca.indentidad.personal"/> </div></td>			
												  </tr>
												</table>
											  </div></td>
										  </tr>
										  <tr> 
											<td valign="top">
											
											<form name="forma" id="forma" action='<html:rewrite page="/do.SetImage"/>' method="post" enctype="multipart/form-data"><br><br>

											<table width="400px" align="center" border=0 >
												<tr>
													<td align="center" colspan=2 style="font-weight:bold;font-size:20pt;">     </td>
												</tr>
												<tr>
													<td height="30" class="fuente-obligatorio"> <bean:message key="lbl.seleccion.marca.nombre.imagen"/> </td>
													<td class="texto-acceso">   <input   type="file" name="file" id="file" style=" width : 311px;"/></td>
												</tr>     
												<tr>
													<td align="center" colspan=2 height="10"></td>
												</tr>

												<tr> 
													<table>
														<tr>
															<td align="center" width="200" ><input type="submit" class="botton" name="Submit" value="<bean:message key="lbl.seleccion.marca.subir"/>"></td>
															<td align="center" width="200"><input type="button" class="botton" onclick="cancelar();" value="<bean:message key='btn.cancelar'/>"></td>
														</tr>
													</table>
												</tr>
												<tr>   
													<td colspan="2">&nbsp;</td>
												</tr>
											</table>
											<%@ include file="divFooter.jsp"%>
										  </form>
												
											</td>
										  </tr>
										  
										  <tr> 
											<td height="20" valign="middle" align="center" class="fuente-obligatorio"><bean:message key="lbl.mensaje.campo.requerido"/></td>
										  </tr>
										</table>
									</div>
								</td>
							</tr>

						</table>
					</td>
				</tr>
				
			</table>

</td></tr>
	</table></td></tr>
   </table></td></tr></table>
   	
   	<!-- Div que contiene el cintillo de los derechos reservados -->
	<div id="derechos">
		<bean:message key="<%=copyrigth %>"
			arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>' />
	</div>
	
</body>
</html>   
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
session.setAttribute("no.aplicar.regla.password", "true");
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
%>

<html>
<head>
<script type="text/javascript"	src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>

<script language="javascript" src="<html:rewrite page='/scripts/campos.js'/>"></script>
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

<script language="javascript">
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
</script>
<script language="javascript">
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
</script>
<script language="javascript">
function userElection()
{


}
var login = <%=Integer.parseInt(session.getAttribute("flag").toString())%>
function cancelar(){

// 	if (login >= 8)
// 	{
// 		window.location.href = "<html:rewrite page='/firstLogInSC.jsp'/>";
// 	}
// 	if (login == 7)
// 	{window.location.href = "<html:rewrite page='/mant/AdminIMG.jsp'/>";
// 		}
	document.forma.action =  "<html:rewrite page='/cambioImagenToken.do'/>";
	document.forma.submit();
	

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
<!--<script type="text/javascript" src="imageGallery.js"></script>-->
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
   <tr> 
        <td>
			<br>
			<table width="100%" border="0" cellpadding="10" cellspacing="0">
				<tr><td align="right"><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
				<br>
		</td>    
  </tr>
  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF;"><div  class="fuente-principal"><bean:message key="tit.title.first.login.paso2"/></div></td>
  </tr>
 
	<tr>    
		<td>
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
									<%@ include file="../../divHeader.jsp"%>
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
											
											<form name="forma" id="forma" action='<html:rewrite page="/do.SetImageToken"/>' method="post" enctype="multipart/form-data"><br><br>

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
											<%@ include file="../../divFooter.jsp"%>
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
				<tr>
					<td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">
						<bean:message key="<%=copyrigth %>" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div>
					</td>
				</tr>
			</table>
		</td>
	</tr>

</table>

</body>
</html>
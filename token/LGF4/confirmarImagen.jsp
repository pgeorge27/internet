<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados" : "msg.derechos.reservados2";
String clienteExiste = (String)session.getAttribute("cliente.existe");
%>

<HTML>
<HEAD>
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

function close(){
	window.close();
}

function makeSubmit(){
	
	var campo = document.getElementById('mark');
	if(campo.value ==  ""){
		alert("Debe darle un nombre a la imagen");
	}
	else{
		 document.getElementById('marca').value = campo.value; 
		 document.forms[0].submit();
	}
	
}

/*
function evaluar()
{       
	var radioButtons = document.getElementsByName("selection");

	for (var i=0; i < radioButtons.length; i++)
	   {           
	   if (radioButtons[i].checked)
	      {
		   document.forms[0].action = radioButtons[i].value;
		   document.getElementById("pantalla").value = radioButtons[i].id

	      }
	   }	   
}  */
	


</SCRIPT>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<LINK REL="stylesheet" TYPE="text/css" HREF="../../style/estilo.css">
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

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
    <td ><br>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr><td align="right" ><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
			<br></td>
    <td>&nbsp;</td>
    
  </tr>
  <tr>
  	<td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF;"><div  class="fuente-principal"><bean:message key="lbl.login.cliente.existente3"/></div></td>
  </tr>
  <tr valign="top"> 
    <td colspan="4">
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td height="300" valign="middle"><table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center"> 
                    
                      <table width=100%" height="200" border="0" cellpadding="0" cellspacing="0" >
                        <tr> 
                          <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                              <tr> 
                                <td width="46%" rowspan="2"><div align="center"> 
                                    <table width="70%" border="0" cellspacing="2" cellpadding="2">
                                      <tr>
                                      	<td>
                                      	
                                      	<%@ include file="../../divHeader.jsp"%>
                                      		<table>
                                      			<tr valign="baseline">
                                      				<td><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
                                      				<td class="fuente-titulo"><bean:message key="lbl.confirmar.imagen.indicacion"/></td>
                                      			</tr>	
                                      		</table>
                                      	<%@ include file="../../divFooter.jsp"%>
                                      	
                                      	</td> 
                                      </tr>	
                                      <tr> 
                                        <td><div align="right" ><img src="<html:rewrite page='/do.GetImage'/>"  style=" width : 325px; height : 325px;"></div></td>
                                      </tr>
                                      <tr> 
                                        <td align="right" >
                                        <table width="100%">
                                        <tr>
                                        	<td width="60%"><div class="fuente-principal"><h3><bean:message key="lbl.token.cambio.imagen.nombreImagen" /></h3></div></td>
                                        	<td><div align="right"><input size="35" id="mark" type="text" maxlength="12" style="text-transform: uppercase"></div></td>
                                       	</tr>
                                        <tr><td>
                                        <html:form method="post" action="/seleccionImagen.do">                                        
                                        	<input type="hidden" name="pantalla" value="success">
                                        	<html:hidden property="marca"  styleId="marca" value=""/>
                                        	<div align="right"><input name="baceptar"  onclick="makeSubmit();" type="button" class="botton" value="<bean:message key="btn.confirmar.imagen"/>"></div> 
			  							</html:form>
										</td><td>
			  							<html:form method="post" action="/seleccionImagen.do">			  								
			  								<input type="hidden" name="pantalla" value="seleccionImagenLGF4">
											<input name="btCancelar" onclick="submit();" type="button" class="botton" value="<bean:message key="btn.cancelar"/>"  > 
										</html:form>
										</td></tr>
										</table>
                                        </td>
                                      </tr>
                                    </table>
                                  </div></td>                                
                              </tr>
                            </table></td>
                        </tr>
                      </table>
                  </div></td>
              </tr>
              <tr> 
                <td></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">&copy; 
        <bean:message key="<%=copyrigth %>"  arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div></td>
  </tr>
</table>
</body>

</html>
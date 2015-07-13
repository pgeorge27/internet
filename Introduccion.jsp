<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext()); 
String serv = session.getAttribute("codigo.servicio").toString();
String  copyrigth = (serv.equals("1")) ? "msg.derechos.reservados" : "msg.derechos.reservados2";
String  introduccion = (serv.equals("1")) ? "msg.introduccion.texto.cliente.panama" : "msg.introduccion.texto.cliente.cayman";

boolean Actualiza = false;
try{
ArrayList codigos = (ArrayList)session.getAttribute("codigos.Banco.formularios");	
	if (codigos != null && codigos.size() > 0  ){
		Actualiza = true;
	}
}catch(Exception ex){
	Actualiza = false;
}
%>


<%@page import="com.arango.common.beans.UserInfo"%>
<%@page import="java.util.ArrayList"%><HTML>
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
</SCRIPT>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<LINK REL="stylesheet" TYPE="text/css" HREF="./style/estilo.css">

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
    <td ><br>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr><td align="right"><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr></table>
			<br></td>
    <td>&nbsp;</td>
    
  </tr>
  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="width:254;height:26;background-color:#EFEFEF;"><div  class="bienvenida"></div></td>
  </tr>
  <tr valign="top"> 
    <td colspan="4">
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td height="300" valign="middle"><table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center"> 
                      <table width="400" height="200" border="0" cellpadding="0" cellspacing="0" >
                        <tr> 
                          <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                              <tr> 
                                <td width="46%" rowspan="2"><div align="center"> 
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                      <tr> 
                                        <td><div align="center">
                                         </div></td>
                                      </tr>
                                      <tr> 
                                       <td class="bienvenida_2"><img src="<html:rewrite page='/images/gancho.gif' />"border="0" /><bean:message key="msg.introduccion.saludo"/>
										<p align="justify"><bean:message key="<%=introduccion %>"/></p>
										<UL>
										
										<%int Flag =  Integer.parseInt(session.getAttribute("flag").toString());
										
											if(Flag != 7){ 
											while( Flag <= 13){
												if (8 ==Flag){%>
													<li><bean:message key="lbl.flujo.login.password" /></li>
									           	<%} %>
									           	
									           	<!-- Introduzco nuevo pazo en el flujo basico :Cambio de usuario -->
									           	<%if (9 == Flag){%>
													<li><bean:message key="lbl.flujo.login.usuario" /></li>
									          	<%} %>	
									           	
									            <%if (10 == Flag){%>
													<li><bean:message key="lbl.flujo.login.imagen" /></li>
									          	<%} %>	
									            	
									          	<%if("50".equals(userInfo.getRole()) ||"70".equals(userInfo.getRole())){ %>
										          	<%if (11 == Flag){%>
														<li><bean:message key="lbl.flujo.login.firma" /></li>
										            	<%} %>
											        <%if (12 == Flag){%>
														<li><bean:message key="lbl.flujo.login.preguntas" /></li>
											            <%} %>   	
											        <%if (13 == Flag && Actualiza){%>
													    <li><bean:message key="lbl.flujo.login.actualizacion.formulario" /></li>
													    <%} %>    
									        <%}
									       Flag++; }
									        }%>
								          </UL>
										</td>
										
                                      </tr>
                                      <tr>
                                       <td align="center">
	        								<form name="formConfirma" action="<html:rewrite page='/do.primerinicio'/>" >
                                       			 <input name="baceptar"  onclick="submit();" type="button" class="botton" value="CONTINUAR"> 							</form >
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
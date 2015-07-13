<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../head.jsp"%>
<%
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";

%>
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
<%

session.setAttribute("flag","13");
	try{
		if (session.getAttribute("codigos.Banco.formularios") != null){
			ArrayList codigosBanco = (ArrayList)session.getAttribute("codigos.Banco.formularios") ;
			codigosBanco.remove(0);
			session.setAttribute("codigos.Banco.formularios",codigosBanco);
		}
	}catch(Exception ex){
		
	}
%>
<table>
	<tr>
		<td height="26">
					
		</td>
	</tr>
</table>
<div align="center"> 
	<table cellpadding="4" width="30%" border="0" cellspacing="2">        
	  <tr valign="middle">
			<td class="bienvenida"><bean:message key="lbl.actualiza.mensaje.resultado"/></td></tr>      
	  <tr valign="middle">
	        <td class="bienvenida"><bean:write name="resultado_secuencia"/></td></tr>
	  <tr valign="middle">
	        <td class="bienvenida"><bean:write name="resultado_fecha"/></td></tr>
	  <tr valign="middle">
	  <td align="center">
	        <form name="formConfirma" action="<html:rewrite page='/do.primerinicio'/>" >
                                        <input name="baceptar"  onclick="submit();" type="button" class="botton" value="<bean:message key="btn.confirmar"/>"> 							</form >
	  </td></tr>
	  </table>
</div>
</td>
</tr>
<tr>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">
        <bean:message key="<%=copyrigth %>" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div></td>
  </tr>
</table></body>
<%@page import="java.util.ArrayList"%></html>



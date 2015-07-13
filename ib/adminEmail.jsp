<% session.setAttribute("selected", "administracion"); %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ include file="../head.jsp"%>


<script language="javascript" src="../scripts/campos.js"></script>
<script language="javascript">


function ValidaMail(mail) { 
	var exr = /^[0-9a-zA-Z_\-\.]+@[0-9a-zA-Z\-\.]+\.[a-z]{2,4}$/
	return exr.test(mail); 
	}


function send(){
    if(validatePass())
    {
    	document.forma.submit();
	}  
}
function validatePass(){
	if (document.forma.email1.value == "")
		{ 
		alert("<bean:message key="lbl.email.admin.observacion3"/>");
	  		return false;
		}
		
  	if (document.forma.email1.value ==  document.forma.email2.value || document.forma.email1.value == document.forma.email3.value  )
  	{
  	    alert("<bean:message key="lbl.email.admin.error1"/>");
  	   return false;
  	 
  	}

  if( document.forma.email2.value == document.forma.email3.value && document.forma.email2.value != "" && document.forma.email3.value != "" )
	  {
	   alert("<bean:message key="lbl.email.admin.error1"/>");
 	   return false;
	  }
  
  if(!ValidaMail(document.forma.email1.value) ) { 
  		alert("El primer <bean:message key="lbl.email.admin.error2"/>"); 
  		return false;
    	}
  	 if(document.forma.email2.value != "" && !ValidaMail(document.forma.email2.value)) { 
 		alert("El segundo <bean:message key="lbl.email.admin.error2"/>"); 
   		return false;
   	} if(document.forma.email3.value != "" && !ValidaMail(document.forma.email3.value)) { 
 		alert("El tercer <bean:message key="lbl.email.admin.error2"/>"); 
   		return false;
   	}
  	return true;    				 
}

</script>
<%@ include file="../body.jsp"%>

<logic:present name="msg">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabla-acceso">
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
%>
<table width="850" align="left"><tr><td width="20">&nbsp;</td>
<td>
<table width="830" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr> 
	<td colspan="2" height="40" valign="bottom">
	<div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="92%"><div align="left" class="login"><bean:message key="tit.title.admin.email"/></div></td>
			<td width="8%"><div align="right"></div></td>
		  </tr>
		</table>
	  </div></td>
  </tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr valign="top">
     <td>
     <!--  Tabla con Cajas -->
    <%
    UserInfo user = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
    String[] correos = user.getEmail().split(";");
    String mail1 = null;
    String mail2 = null;
    String mail3 = null;
    
    try{  mail1 = correos[0];  }catch(Exception ex){ mail1 = "";  }
    try{  mail2 = correos[1];  }catch(Exception ex){ mail2 = "";  }
    try{  mail3 = correos[2];  }catch(Exception ex){ mail3 = "";  }
    
        %>
     
     
     <form method="post" action="<html:rewrite page='/do.AdminEmail'/>" name="forma">
		<input type="hidden" name="Foco" value="claveold" id="Foco" >
		<table width="450" border="0" align="center" cellpadding="0" cellspacing="2">
		  <tr> 
			<td width="31%" height="20" class="celda-clave1"><div align="center" class="texto-acceso"><bean:message key="lbl.email.obligatorio"/></div></td>
			<td colspan="2"><input type="text" name="email1"  size="25"  value="<%=mail1 %>"/> 
			  <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
		  </tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div align="center" class="texto-acceso"><bean:message key="lbl.email.opcional1"/></div></td>
			<td colspan="2"><input type="text" name="email2"  size="25" value="<%=mail2 %>"  />  
			 </td>
		  </tr>
		  <tr> 
			<td height="20" class="celda-clave1"><div align="center" class="texto-acceso"><bean:message key="lbl.email.opcional2"/></div></td>
			<td colspan="2"><input type="text" name="email3" size="25" value="<%=mail3 %>" />  
			</td>
		  </tr>
		  			<tr>
			</tr>
		  <tr><td colspan="3">&nbsp;</td></tr>
		  <tr> 
			<td>&nbsp;</td>
			<td colspan="2"><input name="button" onclick="send();" type="button" class="botton" value="<bean:message key="btn.enviar"/>"> 
			  <input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>"> 
			</td>
		  </tr>
		</table>
	  </form>
     </td>
   <td>
	<!--  Tabla con Tips -->
	<%@ include file="../divHeader.jsp"%>
	  <table cellspacing="0"  >
        <tr valign="top">
      	  <td colspan="2">
      	  <table><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><p class="bienvenida"><B><bean:message key="lbl.preg.secreta.observacion"/></B></p></td>
	      </tr>
	      </table>
	      </td>
	    </tr>
	    <tr valign="top">
	       <td colspan="2" class="bienvenida">
	          <UL>
	          	<li><bean:message key="lbl.email.admin.observacion1" /></li>
	          	<li><bean:message key="lbl.email.admin.observacion2" /></li>
	            <li><bean:message key="lbl.email.admin.observacion3" /></li>
	          </UL>
	       </td>
	    </tr>
	  </table>
	  <%@ include file="../divFooter.jsp"%>
	</td>
     </tr>
  <tr>
	<td height="20" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table>
<tr><td height="200">&nbsp;</td></tr></table>

<%@ include file="../footer.jsp" %>
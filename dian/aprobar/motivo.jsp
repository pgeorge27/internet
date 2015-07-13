<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<script language="javascript" src="<html:rewrite page='/dian/elaborar/edit/js/jfunciones.js'/>"></script>
<%@ include file="/head.jsp"  %>

<%@ include file="/body.jsp"%>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="center"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login">Motivo de Rechazo</div></td>
                        </tr>
                    </table>
                  </div></td>
              </tr>
              <tr> 
                <td height="40" class="texto-acceso">&nbsp;</td>
              </tr>
</table>         <logic:messagesPresent>
  <table cellpadding="1" align="center" cellspacing="1" width="80%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
	<span class="bienvenida">
		<table width="80%">
		<html:messages id="error">					
			<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
		</html:messages>
		</table>
	</span><br>
								   </td></tr>
			 </table></td></tr>
		  </table>
</logic:messagesPresent>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">               
              <tr> 
                <td valign="top">
               
				
                    <table cellpadding="1" style="overflow:scroll;width:50%">
                     <html:form   action="/dian/ejecutar/rechazar">
                     	<%
                     	String[] indices = request.getParameterValues("indice");
                     	if (indices != null){
                     		for (int i = 0; i < indices.length; i++){%>                     	
                     		<input type="hidden" name="indice" value="<%=indices[i]%>"/>
					 <%		}
                     	}%>
                     <tr align="center">
                        <td ><b>Motivo del rechazo</b></td>
                        <td class="bienvenida"><textarea name="motivo" cols="40" rows="4" onkeypress="alphabetic();validateLength(this, 450)"class="txtTexto" id="motivo">
                        </textarea></td>
                     </tr>
                    <tr>
	    <td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
	       <input type="submit" class="botton" value="Continuar"/>
	    </div></td>
	</tr>
                    </table>
		
			</html:form>
			</td></tr></table>
<%@ include file="/footer.jsp"  %>
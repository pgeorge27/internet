<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="com.arango.common.token.AdministrationToken"%>
<%@ page import="com.arango.common.beans.*"%>

<%@ page import="com.arango.common.token.db.DBEmpresa"%>
<%@ page import="com.arango.common.token.db.DynaBean"%>

<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>
<% //Valida si tiene token para redireccionar a la pagina de ingreso de clave dinamica 
	Usuario u = (Usuario) session.getAttribute("usuario.temp");
	

	String token = (String) session.getAttribute("tieneToken");
	if (token != null && token.equals("S")){
		%>
		<script language="javascript">
			window.location = "../token/claveToken.jsp"					
		</script>
		<%
	}
%>
<logic:messagesPresent>
  <table cellpadding="1" cellspacing="1" width="750" class="tabla-acceso1">
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


<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
		    <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
			<td><div align="left" class="login"><bean:message key="tit.title.cambio.clave.especial2"/></div>
			</td>
		  <td width="8%"><div align="right">&nbsp;</div></td>
		  </tr>
		</table>
	  </div>
	 </td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
			<table>
			 <tr valign="top">
			    <td width="200">
			    <!-- Tabla con Formulario -->
			    <html:form method="post" action="/clave">
			<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">
		  <tr> 
			<td width="30%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.clave"/></div></td>
		 	<td width="34%" align="center" nowrap><html:password property="claveToken" styleClass="botton-acceso" maxlength="4" redisplay="false" readonly="true" styleId="clave"/></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
										  
			<tr>
				<td colspan="3"  align="center"class="texto-acceso">
						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
				</td>
			</tr>
				<tr><td width="30%"><div align="right"></div></td>
			    	<td colspan="3"align="center">
				    	<div id="teclado">
							<div id="lower" style="display: none;"></div>
							<div id="upper"></div>
							<div id="cls" align="bottom"></div>		
						</div>
					</td>
			     </tr>
			     <tr><td colspan="3">&nbsp;</td></tr>
			     <tr>
				    <td width="30%"><div align="right"></div></td>
				    <td  width="34%" align="center"><html:submit styleClass="botton"><bean:message key="btn.enviar"/></html:submit></td>
				    <td width="35%"><div align="right"></div></td>
		         </tr>
		</table>
                    </html:form>
			    </td>
			    <td>
			    <!--  Cuadro de Tips -->
			    <%@ include file="../divHeader.jsp"%>
			    <table cellspacing="3" cellpading="3"  width="350">
        <tr valign="top">
      	  <td colspan="2">
      	  <table><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><B><p class="bienvenida"><bean:message key="lbl.preg.secreta.observacion"/></p></B></td>
	      </tr></table>
	      </td>
	    </tr>
	    <tr>
	       <td colspan="2" class="bienvenida">
	          <UL>
	          	<li><bean:message key="lbl.transferencia.clave" /></li>
	          </UL>
	       </td>
	    </tr>
	  </table>	
	  <%@ include file="../divFooter.jsp"%>	                   
      </td>                                
  </tr>
 </table>
 </td></tr></table>
<%@ include file="../footer.jsp" %> 
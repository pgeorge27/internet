<% session.setAttribute("selected", "depositos"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%!
private String getProducto(String tipo){
	String product = "tit.consulta.saldo";
	if ("CA".equals(tipo))
		product = "tit.consulta.saldo.ca";
	else if ("CC".equals(tipo))
		product = "tit.consulta.saldo.cc";
	else if ("DP".equals(tipo))
		product = "mnu.deposito.plazo";
	else if ("PR".equals(tipo))
		product = "tit.consulta.saldo.pr";
	
	return product;	
}

%>
<%
String prod = "ALL";
String ayuda = "MU_CON_Inversiones";
if ("DP".equals(prod))
	ayuda = "MU_CON_Inversiones";
else if ("PR".equals(prod))
	ayuda = "MU_CON_Prestamos";
		
if (request.getParameterValues("prod") != null)
{
  prod = request.getParameterValues("prod")[0];
} 

String tipo = "CON";
if (request.getParameterValues("tipo") != null)
{
  tipo = request.getParameterValues("tipo")[0];
} 

%>

<%@ include file="../head.jsp"  %> 

<script language="JavaScript">
function send(){ 
        if (document.forma.cuentas.value == "-1")
		{
		   alert("<bean:message key="msg.seleccionar.cuenta"/>");

		   document.forma.cuentas.focus();
		}
		else
			document.forma.submit();
}
function retornar(){
	history.back();
}	  
</script>
<%@ include file="../body.jsp"%>

<div align="center"> 
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
  <tr> 
	<td height="40" valign="bottom">
	<div> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr>
		    <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>		
			<td><div align="left" class="login"><bean:message key="<%=getProducto(prod)%>"/>	 		</div>
			</td>
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
	<form name=forma method=POST action="<html:rewrite page='/do.consulta'/>">
	  <input type="hidden" name="tipo" value="CON_SO">
	  <input type="hidden" name="producto" value="<%=prod%>">
	  <input type="hidden" name="backPage" value="../servicios/seleccion.jsp?prod=<%=prod%>" >
  	    <%@ include file="../divHeader.jsp"%>
		<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">
		  <tr> 
			<td width="31%" height="20" class="celda-clave1">
			<div align="right" class="texto-acceso"><bean:message key="lbl.cuentas"/></div></td>
			<td width="34%" nowrap>
			<select name="cuentas" class="botton-acceso">
				   <option value="-1" selected><bean:message key="lbl.seleccione.una.cuenta"/>					 </option>
				   <csic:forEachCuentaSO cliente="ALL" producto="<%=prod%>" formatAccount="C" >						
						 <option value="<%=numCtaCSIC%>~<%=titular%>"><%=numCta%> <%=moneda%>						  </option>
				   </csic:forEachCuentaSO>
				   
             </select>  
			 <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
		  <tr> 
			<td>&nbsp;<br><br></td>
			<td colspan="2"><input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
			  <input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
			</td>
		  </tr>
		</table>
		<%@ include file="../divFooter.jsp"%>
	  </form>
	 </td>
  </tr>
  
  <tr>
	<td height="20" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
</table></div>

<%@ include file="../footer.jsp"  %>
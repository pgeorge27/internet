<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="com.arango.common.beans.TransferenciaInternacional"%>
<%@ page import="com.arango.common.beans.DetalleTransferencia"%>
<%@ page import="com.arango.internet.services.interfaces.ITransferencia"  %>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
TransferenciaInternacional t = (TransferenciaInternacional)session.getAttribute("transferAprobacion");
session.setAttribute("autorizada",null);

String tieneToken = (String) session.getAttribute("tieneToken");
String aprobacion = response.encodeRedirectURL(request.getContextPath()+"/transferencias/aprobacion.jsp");
if(tieneToken != null && tieneToken.equals("S")){
	aprobacion = response.encodeRedirectURL(request.getContextPath()+"/transferencias/aprobacionMasiva.jsp");	
}
%>
<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>
<script type="text/javascript" src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script src="<html:rewrite page='/scripts/jquery.numeric.js'/>" type="text/javascript"></script>

<style>
.infoMensaje {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #ffffff;
	font-weight:bold;
	text-align: justify;
	background-color: #4b4b4b;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		$("#clave").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
		
		$("form").submit(function(){
			autorizar();
			return false;		
		});
	});
	
function __aprobar(){
	return true; 
}
function set(target){
	if(validatePass())
    {
		var aprobacion = "<bean:message key="lbl.transf.confirma.autorizar.beneficiario"/>";
		var rechazo = "<bean:message key="lbl.transf.confirma.rechazar.beneficiario"/>";
	    var msg = "";
	    if (__aprobar()){
		    if (target == "<%=ITransferencia.AUTORIZAR_BENEFICIARIO%>"){
		        msg = aprobacion;
		    }
		    else{
		    	msg = rechazo;
		    }
		    //if (confirm(msg)){
				document.forms[0].tipo.value=target;
				document.forms[0].submit();
			//}
		}
	}
}
function __reject(){
	document.forms[0].tipo.value="<%=ITransferencia.RECHAZADA_BANCO %>";
	document.forms[0].submit();
}

function __update(){
	document.forms[0].tipo.value="Z";
	document.forms[0].submit();
}

function validatePass(){
	if(document.getElementById('clave').value=="")
	{
		alert("<bean:message key="lbl.actualiza.campos.requeridos"/>");
		return false;
	}
	else if(document.getElementById('clave').value.length<8)
	{	
		alert("<bean:message key="error.token.activarToken.largo"/>");
		return false;
	}
	else
	{
		return true;
	}
}

function modificarSession(id,valor)
{
	$.ajax({
		  type: "POST",
		  url: "<html:rewrite page='/token/modificarSessionToken.jsp'/>",
		  data: { id: id, valor: valor },
		  success: function(data){
		  	  if(valor=="S")
		  	  {
				  set('<%=ITransferencia.AUTORIZAR_BENEFICIARIO%>');
				  //console.info(data);
			  }
		  }
		});
}

function autorizar()
{
	if(validatePass()){
		modificarSession("autorizada","S");
	}
	else{
		return false;	
	}
}

function retroceder()
{
	modificarSession("autorizada","null");
	document.location="<%=aprobacion%>";	
}
</script>

<script type="text/javascript">
function escribir(A){
	if(A.charCodeAt(0)!=160){
      if(document.getElementById("Foco")){
    	  if(document.getElementById(document.getElementById("Foco").value).value.length<8){
    			 document.getElementById(document.getElementById("Foco").value).value=document.getElementById(document.getElementById("Foco").value).value+A;
    			 window.status="";
    			 focusContinueControl();
    			return true
    			}
    	  
      }else if(document.getElementById("clave")){
    	  if(document.getElementById("clave").value.length<8){
		 document.getElementById("clave").value=document.getElementById("clave").value+A;
		 window.status="";
		 focusContinueControl();
		return true
		}}
      else if(document.getElementById("segundaClave")){
    	  if(document.getElementById("segundaClave").value.length<4){
		 document.getElementById("segundaClave").value=document.getElementById("segundaClave").value+A;
		 window.status="";
		 focusContinueControl();
		return true
		}}
      else
    	  {
 			 document.getElementById(Foco).value=document.getElementById(Foco).value+A;
 			 window.status="";
 			 focusContinueControl();
 			return true
 			}
	}
}
</script>

<logic:messagesPresent>
<table cellpadding="1" cellspacing="1" width="750" class="tabla-acceso1">
	<tr>
		<td>
			<table border="0" cellpadding="1" cellspacing="0" width="100%">
				<tr valign="top">
					<td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
					<td width="95%" class="msg">
						<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
						<span class="bienvenida">
							<table width="80%">
							<html:messages id="error">					
								<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
							</html:messages>
							</table>
						</span><br>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</logic:messagesPresent>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
		    <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
			<td><div align="left" class="login"><bean:message key="tit.title.autorizar.beneficiario.token"/></div>
			</td>
		  <td width="8%"><div align="right">&nbsp;</div></td>
		  </tr>
		</table>
	</div>
	</td>
  </tr>
  <tr> 
	<td>
		<br>
		<table border="1" bordercolor="#A4A4A4" width="81%" cellspacing="1" cellpadding="4" >
			<tr>
				<td class="infoMensaje">
					Alerta de Seguridad:<br>
					Va a aprobar un nuevo beneficiario (Nombre, número de cuenta y banco). Sí recibió esta información 
					a través de correo electrónico, por razones de seguridad favor reconfirmar con el beneficiario dicha 
					información utilizando un medio de comunicación distinto al del correo electrónico recibido.
					<br>
				</td>
			</tr>
		</table>
		<br>
	</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
		<table>
			<tr valign="top">
			    <td width="200">
			    <!-- Tabla con Formulario -->
			    <html:form method="post" action="/autoriza">
			    <html:hidden styleId="tipos" property="indice" value="1" />
			    <table border="1" bordercolor="#A4A4A4" width="400" cellspacing="0" cellpadding="0" >
			    	<tr>
			    		<td>
				    		<table width="400">
						    	<tr bgcolor="#D8D8D8"> 
						    		<td colspan="2" class="bienvenida"><b><bean:message key="lbl.detalle.beneficiario.token" /></b></td>
						    	</tr>
						    	<tr>
						    		<td class="bienvenida"><b><font color="#e96b10"><bean:message key="lbl.nombre.beneficiario.token" /></font></b></td>
						    		<td class="bienvenida"><b><font color="#e96b10"><%=StringUtilities.getValue(t.getNombreBeneficiario())%></font></b></td>
						    	</tr>
						    	<tr>
						    		<td class="bienvenida"><b><font color="#e96b10"><bean:message key="lbl.cuenta.beneficiario.token" /></font></b></td>
						    		<td class="bienvenida"><b><font color="#e96b10"><%=StringUtilities.getValue(t.getCuentaBeneficiario())%></font></b></td>
						    	</tr>
						    	<tr>
						    		<td class="bienvenida"><b><font color="#e96b10"><bean:message key="lbl.nombre.banco.beneficiario.token" /></font></b></td>
						    		<td class="bienvenida"><b><font color="#e96b10"><%=StringUtilities.getValue(t.getNombreBancoIntermediario())%></font></b></td>
						    	</tr>
						    </table>
			    		</td>
			    	</tr>
			    </table>
			    
			    <html:hidden property="tipo" />
			    
				<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">
				<tr> 
					<td width="30%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.clave.token"/></div></td>
					<td width="34%" align="center" nowrap><input type="text" name="clave" maxlength="8" class="botton-acceso"  id="clave" /></td>		 	
					<td width="35%"><div align="right"></div></td>
				</tr>
				<tr>
					<td colspan="3"  align="center"class="texto-acceso">
						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
					</td>
				</tr>
				<tr>
					<td width="30%"><div align="right"></div></td>
			    	<td align="center">
						<table width="100%">
							<tr valign="baseline">
								<td><input type="button" class="botton"	value="<bean:message key="lbl.transf.inter.autorizar"/>" onclick="autorizar();">&nbsp;&nbsp;</td>
								<td><input type="button" class="botton"	value="<bean:message key="lbl.transf.inter.rechazar"/>"	onclick="__reject();"></td>
								<td><INPUT type="button" class="botton" value="<bean:message key="lbl.retroceder"/>" onclick="retroceder();" ></td>
							</tr>
						</table>
					</td>
					<td></td>
			    </tr>
			    <tr><td colspan="3">&nbsp;</td></tr>
			    <tr>
				    <td width="30%"><div align="right"></div></td>
				    <td  width="34%" align="center">
				    	<div id="teclado" style=" visibility: hidden;">
							<div id="lower" style="display: none;" ></div>
							<div id="upper"></div>
							<div id="cls" align="bo"></div>		
						</div>&nbsp;&nbsp;
					</td>
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
					  <table><tr>
						<td><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
						<td><B><p class="bienvenida"><bean:message key="lbl.preg.secreta.observacion"/></p></B></td>
					  </tr></table>
					  </td>
					</tr>
					<tr>
					   <td colspan="2" class="bienvenida">
						  <OL>
							<li><bean:message key="lbl.autorizar.beneficiario.token.paso1" /><img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15"></li>
							<li><bean:message key="lbl.autorizar.beneficiario.token.paso2" /><img src="<html:rewrite page='/images/TokenPin.png'/>" height="15"></li>
							<li><bean:message key="lbl.autorizar.beneficiario.token.paso3" /></li>
							<li><bean:message key="lbl.autorizar.beneficiario.token.paso4" /></li>
							<li><bean:message key="lbl.autorizar.beneficiario.token.paso5" /></li>
							<li><bean:message key="lbl.autorizar.beneficiario.token.paso6" /></li>
						  </OL>
					   </td>
					</tr>
				</table>
				<%@ include file="../divFooter.jsp"%>
				</td>                               
			</tr>
		</table>
	</td>
  </tr>
</table>
<%@ include file="../footer.jsp" %>
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
<%@ page import="com.arango.common.util.StringUtilities"%>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
ArrayList t = (ArrayList) session.getAttribute("transferAprobacion");
session.setAttribute("autorizada",null);

String tieneToken = (String) session.getAttribute("tieneToken");
String aprobacion = response.encodeRedirectURL(request.getContextPath()+"/transferencias/aprobacion.jsp");
if(tieneToken != null && tieneToken.equals("S")){
	aprobacion = response.encodeRedirectURL(request.getContextPath()+"/transferencias/aprobacionMasiva.jsp");	
}
%>
<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>
<link rel="stylesheet" type="text/css" 	href="<html:rewrite page='/style/flujos.css'/>" />
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
	  /*var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizarForm'].elements;
	  for(var i = 0; i < elements.length; i++)
	  {
	  	 	if (elements[i].name == "indice")
	  	 	{
			   if (elements[i].checked)
			   {
			  	flag = true;
				index = elements[i].value;
			  	count++;
			   }
			}
	  }

	if (count > 0){
		return true;  
	}		
	else{
		alert("Debe seleccionar un registro para enviar a aprobación");
		return false;
	}*/return true; 
}
function set(target){
	if(validatePass())
    {
		var aprobacion = "<bean:message key="lbl.transf.confirma.autorizar.beneficiario.masivo"/>";
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

<html:form method="post" action="/autoriza">
<html:hidden styleId="tipos" property="tipo" />
<html:hidden styleId="tipos" property="indice" value="1" />
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		<!-- 	Fila de la pantalla -->
		<tr>
			<td colspan="2"><div class="fuente-titulo"><bean:message key="lbl.aprobacion.masiva.titulo"/></div></td>
		</tr>
		
		<tr> 
			<td td colspan="2">
				<br>
				<table border="1" bordercolor="#A4A4A4" width="98%" cellspacing="1" cellpadding="4" >
					<tr>
						<td class="infoMensaje">
							Alerta de Seguridad:<br>
							Va a aprobar nuevos beneficiarios: (Nombres, números de cuenta y bancos). Sí recibió esta 
							información a través de correo electrónico, por razones de seguridad favor reconfirmar con 
							los beneficiarios dicha información utilizando un medio de comunicación distinto al del 
							correo electrónico recibido.
							<br>
						</td>
					</tr>
				</table>
				<br>
			</td>
		</tr>
		
		<!-- 	Fila con las transferencias y los tips -->
		<tr>
			<td width="65%">
				<table width="100%">
					<tr class="fuente-obligatorio">
						<td><div><bean:message key="lbl.aprobacion.masiva.col1"/></div></td>
						<td><div><bean:message key="lbl.aprobacion.masiva.col2"/></div></td>
						<td><div><bean:message key="lbl.aprobacion.masiva.col3"/></div></td>
						<td><div><bean:message key="lbl.aprobacion.masiva.col4"/></div></td>
						<td><div><bean:message key="lbl.aprobacion.masiva.col5"/></div></td>
					</tr>
					<%
						com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
						for(int i=0;i<t.size();i++){
							TransferenciaInternacional obj = (TransferenciaInternacional) t.get(i);
					%>
						
					<tr class="fuente-principal">
						<td>
							<div>
								<%=StringUtilities.replace(f.formatCuenta(obj.getNumeroDocumento(), "A-S-C"), "-","")%>
							</div>
						</td>
						<td><div><%=obj.getNombreBeneficiario()%></div></td>
						<td><div><%=obj.getCuentaBeneficiario()%></div></td>
						<td><div><%=obj.getNombreBancoIntermediario()%></div></td>
						<td><div><%=f.formatMonto(obj.getMonto())%></div></td>
					</tr>
					
					<%
						}
					%>
				</table>
			</td>
			<td align="center">
				<!--  Cuadro de Tips -->
				<%@ include file="../divHeader.jsp"%>
			    	<table cellspacing="3" cellpading="3"  width="350">
	        			<tr valign="top">
	      	  				<td colspan="2">
	      	  					<table>
	      	  						<tr>
	      	  							<td><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
		      							<td><B><p class="bienvenida"><bean:message key="lbl.preg.secreta.observacion"/></p></B></td>
		      						</tr>
	      						</table>
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
		
		<!-- 	Fila en blanco -->
		<tr>
			<td colspan="2"></td>
		</tr>
		
		<!-- 	Fila para el campo de texto -->
		<tr>
			<td colspan="2">
				<div align="right" style="width:48%;float:left;" class="texto-acceso">
					<bean:message key="lbl.clave.token"/>
				</div>
				<div align="left" style="width:48%;float:right">
					<input type="text" name="clave" maxlength="8" class="botton-acceso"  id="clave" />
				</div>
			</td>
		</tr>
		
		<!-- 	Fila en blanco -->
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		
		<!-- 	Fila con los botones -->
		<tr>
			<td colspan="2">
				<div align="right" style="width:48%;float:left;" class="texto-acceso">
					<input type="button" class="botton" onclick="autorizar();" value="<bean:message key="lbl.transf.inter.autorizar"/>">
				</div>
				<div align="left" style="width:48%;float:right">
					<input type="button" class="botton" onclick="retroceder();" value="<bean:message key="lbl.retroceder"/>">
				</div>				
			</td>
		</tr>
		
		<!-- 	Fila en blanco -->
		<tr>
			<td colspan="2"></td>
		</tr>
	</table>
</html:form>	
<%@ include file="../footer.jsp" %>
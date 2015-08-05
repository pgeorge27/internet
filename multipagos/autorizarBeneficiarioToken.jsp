<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.arango.common.util.StringUtilities"%>
<%@ page import="com.arango.internet.services.interfaces.ITransferencia"  %>
<%@ page import="com.arango.common.beans.DetalleTransferencia"%>
<%@ page import="com.arango.internet.beans.TranferenciaProcesada"%>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
TranferenciaProcesada t = (TranferenciaProcesada)session.getAttribute("transferAprobacion");
session.setAttribute("autorizada",null);

String tieneToken = (String) session.getAttribute("tieneToken");
String aprobacion = response.encodeRedirectURL(request.getContextPath()+"/multipagos/aprobacion.jsp");
if(tieneToken != null && tieneToken.equals("S")){
	aprobacion = response.encodeRedirectURL(request.getContextPath()+"/multipagos/aprobacion.jsp");	
}

%>
<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>
<script type="text/javascript" src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script src="<html:rewrite page='/scripts/jquery.numeric.js'/>" type="text/javascript"></script>

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
	}*/
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
		}
		else if(document.getElementById("clave")){
			if(document.getElementById("clave").value.length<8){
				document.getElementById("clave").value=document.getElementById("clave").value+A;
				window.status="";
				focusContinueControl();
				return true
			}
		}
		else if(document.getElementById("segundaClave")){
			if(document.getElementById("segundaClave").value.length<4){
				document.getElementById("segundaClave").value=document.getElementById("segundaClave").value+A;
				window.status="";
				focusContinueControl();
				return true
			}
		}
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

<div class="container">
	<div class="row" style="padding-right: 3%; padding-left: 3%;">

		<logic:messagesPresent>
			<div class="col-md-4 col-md-offset-4">
				<div align="center" class="well">
					<p><img src="<html:rewrite page='/images/warning.gif'/>"></p>
					<p><b><bean:message key="errors.header"/></b></p>
					<html:messages id="error">
						<p class="bienvenida">- <bean:write name="error" /></p>
					</html:messages>
				</div>
			</div>
		</logic:messagesPresent>

		<div class="col-md-4 col-md-offset-1">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.preg.secreta.observacion"/>
					</strong>
				</div>

				<div class="panel-body">
					<ol>
						<li><bean:message key="lbl.autorizar.beneficiario.token.paso1" /><img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15"></li>
						<li><bean:message key="lbl.autorizar.beneficiario.token.paso2" /><img src="<html:rewrite page='/images/TokenPin.png'/>" height="15"></li>
						<li><bean:message key="lbl.autorizar.beneficiario.token.paso3" /></li>
						<li><bean:message key="lbl.autorizar.beneficiario.token.paso4" /></li>
						<li><bean:message key="lbl.autorizar.beneficiario.token.paso5" /></li>
						<li><bean:message key="lbl.autorizar.beneficiario.token.paso6" /></li>
					</ol>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="tit.title.autorizar.beneficiario.token"/>
					</strong>
				</div>
				<div class="panel-body">

					<html:form method="post" action="/multipago/autoriza"  >
						<html:hidden styleId="tipos" property="indice" value="1" />

						<bean:message key="lbl.detalle.beneficiario.token" />

						<p><b><font color="#e96b10"><bean:message key="lbl.nombre.beneficiario.token" /></font></b></p>
						<p><b><font color="#e96b10"><%=StringUtilities.getValue(t.getNombreBeneficiario())%></p>

						<p><b><font color="#e96b10"><bean:message key="lbl.cuenta.beneficiario.token" /></font></b></p>
						<p><b><font color="#e96b10"><%=StringUtilities.getValue(t.getCuentabancoBeneficiario())%></p>

						<p><b><font color="#e96b10"><bean:message key="lbl.nombre.banco.beneficiario.token" /></font></b></p>
						<p><b><font color="#e96b10"><%=StringUtilities.getValue(t.getNombreBancoIntermediario())%></p>

						<html:hidden property="tipo" />

						<div align="center">
							<p><bean:message key="lbl.clave.token"/></p>
							<p><input type="text" name="clave" maxlength="8" class="form-control"  id="clave" autocomplete="off"/></p>
						</div>

						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />

						<div align="center">
							<input type="button" class="btn btn-default" value="<bean:message key="lbl.transf.inter.autorizar"/>" onclick="autorizar();">
							<input type="button" class="btn btn-default" value="<bean:message key="lbl.transf.inter.rechazar"/>" onclick="__reject();">
							<input type="button" class="btn btn-default" value="<bean:message key="lbl.retroceder"/>" onclick="retroceder();" >
						</div>

						<div id="teclado" style="display:none visibility: hidden;">
							<div id="lower" style="display: none;" ></div>
							<div id="upper"></div>
							<div id="cls" align="bo"></div>
						</div>

					</html:form>

				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../footer.jsp" %>
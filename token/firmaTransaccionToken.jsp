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
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
TransferenciaInternacional t = (TransferenciaInternacional)session.getAttribute("transfer");
if(t.getCodigoMonedaIso() == null)
	t.setCodigoMonedaIso("999");
long dMonto = (long)(Math.round(t.getMonto() * 100));
String monto  = String.valueOf(dMonto);

session.setAttribute("autorizada",null);

String tieneToken = (String) session.getAttribute("tieneToken");
String aprobacion = response.encodeRedirectURL(request.getContextPath()+"/transferencias/aprobacion.jsp");
if(tieneToken != null && tieneToken.equals("S")){
	aprobacion = response.encodeRedirectURL(request.getContextPath()+"/transferencias/aprobacionMasiva.jsp");	
}
%>
<%@ include file="../head.jsp"%>
<script type="text/javascript" src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script src="<html:rewrite page='/scripts/jquery.numeric.js'/>" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" 	href="<html:rewrite page='/style/flujos.css'/>" />

<script type="text/javascript">

$(document).ready(function(){
	executeOnLoad(); 
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
    var aprobacion = "<bean:message key="lbl.transf.inter.confirma.autorizar"/>";
    var rechazo = "<bean:message key="lbl.transf.inter.confirma.rechazar"/>";
    var msg = "";
	    if (__aprobar()){
		    if (target == "<%=ITransferencia.APROBADA%>"){
		        msg = aprobacion;
		    }
		    else{
		    	msg = rechazo;
		    }
		    if (confirm(msg)){
		    	document.getElementById("btenviar").disabled = true; 
				document.forms[0].tipo.value=target;
				document.forms[0].submit();
				
			}
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

function modificarSession(id,valor)
{
	$.ajax({
		  type: "POST",
		  url: "<html:rewrite page='/token/modificarSessionToken.jsp'/>",
		  data: { id: id, valor: valor },
		  success: function(data){
		  	  if(valor=="S")
		  	  {
				  set('<%=ITransferencia.APROBADA%>');
				  //console.info(data);
			  }
		  }
		});
}

function autorizar()
{
	modificarSession("autorizada","S");
}

function retroceder()
{
	modificarSession("autorizada","null");
	document.location="<%=aprobacion%>";
}
</script>

<script type="text/javascript" src="<html:rewrite page='/scripts/optical-ocra-embed.js' />"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/encoding-ocra.js' />"></script>
<script type="text/javascript">
	var setChallengeCallback = setChallengeCallback;
	var getDataOrderCallback = getDataOrderCallback;
	
	var sCurrency;
	var sTransactionAmount;
	var sToAccountNumber;
	var sFolio;
	var startResize = 0;
	var CONST_X=300;
	var CONST_Y=420;
	
	function handleException(e){
	}
	
	function setChallengeCallback(){
	}
	
	function executeOnLoad() 
	{
		//sCurrency = document.forms[0].currency_id.value;
		sTransactionAmount = document.forms[0].amount_id.value.replace(".","").replace(",","");
		//sToAccountNumber = document.forms[0].to_account_id.value;
		//sFolio = document.forms[0].folio_id.value;
		//var e = document.getElementById('led-wrapper');
		try {
			getWindowSize();
			clearTransmissionArea();
			createTransmissionArea();
			//e.style.display = "block";
		} catch (e) {
			handleException(e)
		}
	}
	
	function formatUserData(){
	  var f = null;
	  f = document.getElementById('to_account_id');
	  if (f) {
		var v = f.value;
		if (v.length) {
		  if (v.length % 2) {
			f.value = "0" + v;
		  }
		}
	  }
	}
	
	function validatePass()
	{
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
</script>

<%@ include file="../body.jsp"%>

<div class="container"> 
	<div class="row">

		<logic:present name="msg">
		<div align="center" class="well col-md-4 col-md-offset-4">
			<p><img src="<html:rewrite page='/images/warning.gif'/>"></p>
			<p><b><bean:message key="errors.header"/></b></p>
			<p class="bienvenida">- <bean:write name="error" /></p>
		</div>
		<script type="text/javascript">
			CONST_Y += document.getElementById('msgError').clientHeight;
		</script>
	</logic:present>
	<%
	session.removeAttribute("msg");
	%>

	<div class="col-md-4 col-md-offset-1">
		<div class="panel panel-default" >
			<div class="panel-heading">
				<img src="<html:rewrite page='/images/logo_icon.png' />" />
				<strong>
					<bean:message key="lbl.firma.transaccion.token.pasos"/>
				</strong>
			</div>
			<div class="panel-body">
				<ol>
					<li><bean:message key="lbl.firma.transaccion.token.paso1" /><img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15"></li>
					<li><bean:message key="lbl.firma.transaccion.token.paso2" /><img src="<html:rewrite page='/images/TokenOptico.png'/>" height="15"></li>
					<li><bean:message key="lbl.firma.transaccion.token.paso3" /></li>
					<li><bean:message key="lbl.firma.transaccion.token.paso4" /></li>
					<li><bean:message key="lbl.firma.transaccion.token.paso5" /></li>
					<li><bean:message key="lbl.firma.transaccion.token.paso6" /></li>
					<li><bean:message key="lbl.firma.transaccion.token.paso7" /></li>
					<li><bean:message key="lbl.firma.transaccion.token.paso8" /></li>
					<li><bean:message key="lbl.firma.transaccion.token.paso9" /></li>
				</ol>
			</div>
		</div>
	</div>

	<div class="col-md-6">
		<div class="panel panel-default" >
			<div class="panel-heading">
				<img src="<html:rewrite page='/images/logo_icon.png' />" />
				<strong>
					<bean:message key="tit.title.firma.transaccion.token"/>
				</strong>
			</div>
			<div class="panel-body">

				<html:form method="post" action="/autoriza" enctype="multipart/form-data">
				<html:hidden styleId="tipos" property="indice" value="1" />
				<html:hidden styleId="tipos" property="pantalla" value="aprobar" />
				<p><bean:message key="lbl.monto.transferencia.firma.transaccion.token" /></p>
				<p><input name="amount" id="amount_id2" readonly="readonly" type="text" value="<%=f.formatMonto(t.getMonto())%>"></p>
				<html:hidden property="tipo" />

				<p><bean:message key="lbl.area.transmision.firma.transaccion.token" /></p>

				<div id="resize-buttons" >
					<a href="javascript:void(0);" onclick="divResizeUp();"><img src="<html:rewrite page='/images/zoom_in.png'/>" style="width:16px; border:0;"/></a>
					<a href="javascript:void(0);" onclick="divResizeDn();"><img src="<html:rewrite page='/images/zoom_out.png'/>" style="width:16px; border:0;"/></a>
				</div>
				<div name="captorsTransmissionZone" id="captorsTransmissionZone" style="position:relative;height: 60px;float:left;border:0px solid #C00"></div>


				<p><bean:message key="lbl.firma.transaccion.token.clave"/></p>

				<input type="text" name="clave" maxlength="8" class="botton-acceso"  id="clave"/>

				<div align="center">
					<input id="btenviar" type="button" class="btn btn-default" value='<bean:message key="lbl.firma.transaccion.token.validar"/>' onclick="autorizar();">
					<input class="btn btn-default" onclick="retroceder();" type="button" value='<bean:message key="lbl.firma.transaccion.token.cancelar"/>'>
					<input type="hidden" id="amount_id" value=<%=monto%>>
				</div>
				</html:form>
			</div>
		</div>
	</div>
</div>
</div>





<%@ include file="../footer.jsp" %>
<script type="text/javascript" src="<html:rewrite page='/scripts/ocra-init.js' />"></script>
<script type="text/javascript">
	//formatUserData();
	SAVE_DIMENSIONS_TO_COOKIE = true;
	var captorDimensions = getCaptorDimensions();
	captorWidth = captorDimensions[0];
	captorHeight = captorDimensions[1];
	saveCaptorDimensionsToCookie();
</script>
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
ArrayList t = (ArrayList) session.getAttribute("transfer");
String monto = "";
String strMonto = "";
Object objMonto = session.getAttribute("monto");

double dblMonto = 0;
if(objMonto != null){
	strMonto = objMonto.toString();
	dblMonto = Double.parseDouble(strMonto);
	monto = String.valueOf((long)(Math.round(dblMonto * 100)));
}
String strMoneda = "";
String strMonedaISO = "";
String strCantidad = "";
String strCuentas = "";

String moneda = (String)session.getAttribute("moneda");
String monedaISO = (String)session.getAttribute("monedaISO");
String cantidad = (String)session.getAttribute("cantidad");
String cuentas = (String)session.getAttribute("cuentas");

if(moneda != null)
	strMoneda = moneda;
	
if(monedaISO != null)
	strMonedaISO = monedaISO;

if(cantidad != null)
	strCantidad = cantidad;
	
if(cuentas != null)
	strCuentas = cuentas;

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
	}*/return true; 
}
function set(target){
	if(validatePass())
    {
    var aprobacion = "<bean:message key="lbl.transf.inter.confirma.autorizar.Masivo"/>";
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
	var sQuantity;
	var startResize = 0;
	var CONST_X=300;
	var CONST_Y=420;
	
	function handleException(e){
	}
	
	function setChallengeCallback(){
	}
	
	function executeOnLoad() 
	{
	  sCurrency = document.forms[0].currency_id.value;
	  sTransactionAmount = document.forms[0].amount_id.value.replace(".","").replace(",","");
	  //sToAccountNumber = document.forms[0].to_account_id.value;
	  sQuantity = document.forms[0].quantity_id.value;
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



<logic:messagesPresent>
		<div align="center" class="well col-md-4 col-md-offset-4">
			<p><img src="<html:rewrite page='/images/warning.gif'/>"></p>
			<p><b><bean:message key="errors.header"/></b></p>
			<p class="bienvenida">- <bean:write name="error" /></p>
			<html:messages id="error">
				<p class="bienvenida">- <bean:write name="error" /></p>
			</html:messages>
		</div>
		<script type="text/javascript">
			CONST_Y += document.getElementById('msgError').clientHeight;
		</script>
</logic:messagesPresent>

	<div class="col-md-4 col-md-offset-1 ">
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
				<!-- Tabla con Formulario -->
				<html:form method="post" action="/autoriza" enctype="multipart/form-data">
					<html:hidden styleId="tipos" property="indice" value="1" />
					<html:hidden styleId="tipos" property="pantalla" value="aprobar" />
					<%
						for(int i=0;i<t.size();i++){
							TransferenciaInternacional obj = (TransferenciaInternacional) t.get(i);
					%>
					<%	} %>
					<html:hidden property="tipo" />

					<bean:message key="lbl.area.transmision.firma.transaccion.token" />
					<div id="led-wrapper" style="float:right; position:relative">
						<div id="resize-buttons" style="width:32px;float:left;">
						<a href="javascript:void(0);" onclick="divResizeUp();"><img src="<html:rewrite page='/images/zoom_in.png'/>" style="width:16px; border:0;"/></a>
						<a href="javascript:void(0);" onclick="divResizeDn();"><img src="<html:rewrite page='/images/zoom_out.png'/>" style="width:16px; border:0;"/></a>
						</div>
						<div name="captorsTransmissionZone" id="captorsTransmissionZone" style="position:relative;height: 60px;float:left;border:0px solid #C00"></div>
					</div>


					<p class="bienvenida"><bean:message key="lbl.tipo.moneda.firma.transaccion.token.masivo" /></p>
					<p class="bienvenida"><input name="currency" class="form-control" id="currency_id" readonly="readonly" type="text" value="<%=strMonedaISO %>"><b><%=strMoneda%></b></p>

					<p class="bienvenida"><bean:message key="lbl.monto.firma.transaccion.token.masivo" /></p>
					<p class="bienvenida"><input name="amount" class="form-control" id="amount_id2" readonly="readonly" type="text" value="<%=f.formatMonto(dblMonto)%>"></p>

					<p class="bienvenida"><b><i><bean:message key="lbl.monto.firma.cantidad.token.masivo" />:</i></b></p>
					<p class="bienvenida"><input name="quantity" class="form-control" id="quantity_id" readonly="readonly" type="text" value="<%=strCantidad%>"></p>


					<p>
						<bean:message key="lbl.firma.transaccion.token.clave"/>
					</p>

					<p><input type="text" class="form-control" name="clave" maxlength="8" class="botton-acceso"  id="clave"/></p>

					<div align="center">
						<p><input id="btenviar" type="button" class="btn btn-default" value='<bean:message key="lbl.firma.transaccion.token.validar"/>' onclick="autorizar();"></p>
						<p><input class="btn btn-default" onclick="retroceder();" type="button" value='<bean:message key="lbl.firma.transaccion.token.cancelar"/>'></p>
					</div>

					<p><input type="hidden" id="amount_id" value=<%=monto%>></p>
                </html:form>

			</div>
		</div>
	</div>

</div>
</div>



<logic:messagesPresent>
<table cellpadding="1" cellspacing="1" width="750" class="tabla-acceso1" id="msgError">
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
<script type="text/javascript">
	CONST_Y += document.getElementById('msgError').clientHeight;
</script>
</logic:messagesPresent>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td height="40" valign="bottom">
		<div align="center"> 
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			  <tr> 
				<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
				<td><div align="left" class="login"><bean:message key="tit.title.firma.transaccion.token"/></div></td>
				<td width="8%"><div align="right">&nbsp;</div></td>
			  </tr>
			</table>
		</div>
		</td>
	</tr>
	<tr><td class="texto-acceso">&nbsp;</td></tr>
	<tr> 
		<td valign="top" align="center">
			<table>
			<tr valign="top">
			    <td width="200">
			    <!-- Tabla con Formulario -->
			    <html:form method="post" action="/autoriza" enctype="multipart/form-data">
			    <html:hidden styleId="tipos" property="indice" value="1" />
			    <html:hidden styleId="tipos" property="pantalla" value="aprobar" />
				<%
					for(int i=0;i<t.size();i++){
						TransferenciaInternacional obj = (TransferenciaInternacional) t.get(i);
				%>
				<%	} %>
			    <table width="400" cellspacing="0" cellpadding="0" >
			    	<tr>
			    		<td>
				    		<table width="400">
						    	<tr>
						    		<td class="bienvenida"><bean:message key="lbl.tipo.moneda.firma.transaccion.token.masivo" /></td>
						    		<td class="bienvenida"><input name="currency" id="currency_id" readonly="readonly" type="text" value="<%=strMonedaISO %>" size="4"><b><%=strMoneda%></b></td>
						    	</tr>
						    	<tr>
						    		<td class="bienvenida"><bean:message key="lbl.monto.firma.transaccion.token.masivo" /></td>
						    		<td class="bienvenida"><input name="amount" id="amount_id2" readonly="readonly" type="text" value="<%=f.formatMonto(dblMonto)%>"></td>
						    	</tr>
								<tr>
						    		<td class="bienvenida"><b><i><bean:message key="lbl.monto.firma.cantidad.token.masivo" />:</i></b></td>
						    		<td class="bienvenida"><input name="quantity" id="quantity_id" readonly="readonly" type="text" value="<%=strCantidad%>"></td>
						    	</tr>
						    </table>
			    		</td>
			    	</tr>
			    </table>
			    
			    <html:hidden property="tipo" />
			    
				<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">
				<tr>
					<td colspan="3" ><bean:message key="lbl.area.transmision.firma.transaccion.token" />
					  <div id="led-wrapper" style="float:right; width: 500px; position:relative">
						<div id="resize-buttons" style="width:32px;float:left;">
						  <a href="javascript:void(0);" onclick="divResizeUp();"><img src="<html:rewrite page='/images/zoom_in.png'/>" style="width:16px; border:0;"/></a>
						  <a href="javascript:void(0);" onclick="divResizeDn();"><img src="<html:rewrite page='/images/zoom_out.png'/>" style="width:16px; border:0;"/></a>
						</div>
						<div name="captorsTransmissionZone" id="captorsTransmissionZone" style="position:relative;height: 60px;float:left;border:0px solid #C00"></div>
					  </div>
					</td>
				</tr>
				<tr> 
					<td width="30%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.firma.transaccion.token.clave"/></div></td>
					<td width="34%" align="center" nowrap><input type="text" name="clave" maxlength="8" class="botton-acceso"  id="clave"/></td>
					<td width="35%"><div align="right"></div></td>
				</tr>
				<tr>
					<td width="30%"><div align="right"></div></td>
					<td  width="34%" align="center">&nbsp;&nbsp;&nbsp;&nbsp;
						<table>
							<tr valign="baseline">
								<td><input id="btenviar" type="button" class="botton" value='<bean:message key="lbl.firma.transaccion.token.validar"/>' onclick="autorizar();"></td>
								<td><input class="botton" onclick="retroceder();" type="button" value='<bean:message key="lbl.firma.transaccion.token.cancelar"/>'></td>
							</tr>
						</table>
					</td>
					<td width="35%"><div align="right"></div></td>
				</tr>
				</table>
				<input type="hidden" id="amount_id" value=<%=monto%>>
                </html:form>
			    </td>
			    <td>
			    <!--  Cuadro de Tips -->
			    <%@ include file="../divHeader.jsp"%>
			    <table cellspacing="3" cellpading="3"  width="350">
					<tr valign="top">
					  <td colspan="2">
						<table>
							<tr>
								<td><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
								<td><p class="bienvenida"><bean:message key="lbl.firma.transaccion.token.pasos"/></p></td>
							</tr>
						</table>
					  </td>
					</tr>
					<tr>
					   <td colspan="2" class="bienvenida">
						  <OL>
							<li><bean:message key="lbl.firma.transaccion.token.paso1" /><img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15"></li>
							<li><bean:message key="lbl.firma.transaccion.token.paso2" /><img src="<html:rewrite page='/images/TokenOptico.png'/>" height="15"></li>
							<li><bean:message key="lbl.firma.transaccion.token.paso3" /></li>
							<li><bean:message key="lbl.firma.transaccion.token.paso4" /></li>
							<li><bean:message key="lbl.firma.transaccion.token.paso5" /></li>
							<li><bean:message key="lbl.firma.transaccion.token.paso6" /></li>
							<li><bean:message key="lbl.firma.transaccion.token.paso7" /></li>
							<li><bean:message key="lbl.firma.transaccion.token.paso8" /></li>
							<li><bean:message key="lbl.firma.transaccion.token.paso9" /></li>
						  </OL>
					   </td>
					</tr>
					<tr>
						<td colspan="2" class="fuente-principal"><bean:message key="lbl.firma.transaccion.token.paso10" /></td>
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
<script type="text/javascript" src="<html:rewrite page='/scripts/ocra-init.js' />"></script>
<script type="text/javascript">
	formatUserData();
	SAVE_DIMENSIONS_TO_COOKIE = true;
	var captorDimensions = getCaptorDimensions();
	captorWidth = captorDimensions[0];
	captorHeight = captorDimensions[1];
	saveCaptorDimensionsToCookie();
</script>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales"%>
<%@ page import="com.arango.common.beans.PerfilXML"%>
<%@ page import="com.arango.common.beans.Cliente"%>
<%@ page import="com.arango.common.beans.ClaveEspecial"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.arango.common.sql.*"%>
<%@ page import="com.arango.internet.beans.*" %>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.arango.common.beans.Cuenta"%>
<%@ page import="com.arango.internet.banking.Vencimiento"%>
<%@page import="com.arango.common.beans.Parametro"%>
<%@page import="com.arango.common.delegate.Manager"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.arango.internet.banking.dian.Formulario"%>
<%!com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();%>
<%
	Parametro paran = new Parametro();
	paran = paran.getParametros();
%>

<%
	PerfilXML p2 = (PerfilXML) session.getAttribute("perfil.xml");
	if (p2 == null)
		pageContext.forward("/index.jsp");
	String nom = "";
	nom = p2.getNombre();

	ArrayList mensaje = new ArrayList();
	ArrayList javascript = new ArrayList();

	Calendar calendar = Calendar.getInstance();
	calendar.setTime(new Date(System.currentTimeMillis()));

	java.util.Date fechaHoy = calendar.getTime();
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
			"dd-MM-yyyy");
	String fecha = sdf.format(fechaHoy);
	if (session.getAttribute("codigo.role.compensacion") != null) {
		String roleCompensacion = (String) session
				.getAttribute("codigo.role.compensacion");

		String mensajeImportacion = "Documento de transporte No. <b>{1}</b>, correspondiente a la Importación No. <b>{2}</b> por valor de USD <b>{3}</b>.";
		String mensajeExportacion = "Documento de Exportación No. <b>{1}</b>, correspondiente a la Venta No. <b>{2}</b> por valor de USD  <b>{3}</b>.";
		String mensajeExportacionAnticipada = "Reintegro anticipado por valor de <b>{1}</b>, correspondiente a la Venta No. <b>{2}</b>.";

		if (!"".equals(roleCompensacion)) {
			IBCompensacion ibcomp = new IBCompensacion();
			ArrayList arreglo = null;

			ArrayList cta = (ArrayList) session
					.getAttribute("ctasCompensacion");
			Cuenta c = null;
			Vencimiento v = null;
			for (int i = 0; i < cta.size(); i++) {
				c = (Cuenta) cta.get(i);
				arreglo = ibcomp.VencimientoConsulta(fechaHoy,
						fechaHoy, fechaHoy, c.getCodigoBanco(), 1);
				if (!arreglo.isEmpty() && arreglo.get(0) != null) {
					v = (Vencimiento) arreglo.get(0);
					if (1 == v.getMensaje()) {
						mensaje.add(java.text.MessageFormat.format(
								mensajeImportacion,
								new Object[] { fecha,
										v.getDocTransporte(),
										v.getNumImportacion(),
										f.formatMonto(v.getValor()) }));
						javascript.add("__ok('" + fecha + "', "
								+ c.getCodigoCSIC() + ", " + 1 + ")");
					}
				}

				arreglo = ibcomp.VencimientoConsulta(fechaHoy,
						fechaHoy, fechaHoy, c.getCodigoBanco(), 2);
				if (!arreglo.isEmpty() && arreglo.get(0) != null) {
					v = (Vencimiento) arreglo.get(0);
					if (1 == v.getMensaje()) {
						mensaje.add(java.text.MessageFormat.format(
								mensajeExportacion,
								new Object[] { fecha,
										v.getNumExportacion(),
										v.getNumDex(),
										f.formatMonto(v.getValor()) }));
						javascript.add("__ok('" + fecha + "', "
								+ c.getCodigoCSIC() + ", " + 2 + ")");
					}
				}
				arreglo = ibcomp.VencimientoConsulta(fechaHoy,
						fechaHoy, fechaHoy, c.getCodigoBanco(), 3);
				if (!arreglo.isEmpty() && arreglo.get(0) != null) {
					v = (Vencimiento) arreglo.get(0);
					if (1 == v.getMensaje()) {
						mensaje.add(java.text.MessageFormat.format(
								mensajeExportacionAnticipada,
								new Object[] { fecha,
										f.formatMonto(v.getValor()),
										v.getNumeroDeclaracion() }));
						javascript.add("__ok('" + fecha + "', "
								+ c.getCodigoCSIC() + ", " + 3 + ")");
					}
				}
			}

		}
	}
%>
<%
	session.setAttribute("selected", "inicio");
%>
<%
	try {
%> <%@ include file="head.jsp"%> <%
 	} catch (Exception e) {
 		;
 	}
 %>


<style>

a.ln, a.ln:active,a.ln:link,a.ln:visited, a.ln:hover {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #004284;
	text-decoration: none;
}
a.ln:hover {
	text-decoration: underline;
}
.infoMensaje {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #d05454;
	font-weight:bold;
	text-align: justify;
	}

</style>

<STYLE type="text/css">
.okButton {
background-color: #D4D4D4;
font-color: #000000;
font-size: 9pt;
font-family: arial;
width: 70px;
height:	20px;  
}
.alertTitle {
background-color: #3C56FF;
font-family: arial;
font-size: 9pt;
color: #FFFFFF;
font-weight: bold;
}
.alertMessage {
font-family: arial;
font-size: 9pt;
color: #000000;
font-weight: normal;
}
.alertBoxStyle {
cursor: default;
filter: alpha(opacity=90);
background-color: #f9f9f9;
position: absolute;
top: 200px;
left: 200px;
width: 100px;
height: 50px;
visibility:hidden; z-index: 999;
border-style: groove;
border-width: 5px;
border-color: #FFFFFF;
text-align: center;
}
</STYLE>

<div id="alertLayer" class=alertBoxStyle></div>
<SCRIPT LANGUAGE="JavaScript">

function BrowserCheck() {

var b = navigator.appName;
if (b == "Netscape") this.b = "NS";
else if (b == "Microsoft Internet Explorer") this.b = "IE";
else this.b = b;
this.v = parseInt(navigator.appVersion);
this.NS = (this.b == "NS" && this.v>=4);
this.NS4 = (this.b == "NS" && this.v == 4);
this.NS5 = (this.b == "NS" && this.v == 5);
this.IE = (this.b == "IE" && this.v>=4);
this.IE4 = (navigator.userAgent.indexOf('MSIE 4')>0);
this.IE5 = (navigator.userAgent.indexOf('MSIE 5')>0);
if (this.IE5 || this.NS5) this.VER5 = true; else this.VER5 = false;
if (this.IE4 || this.NS4) this.VER4 = true; else this.VER4 = false;
this.OLD = (! this.VER5 && ! this.VER4) ? true : false;
this.min = (this.NS||this.IE);
}

function hideAlert(){
alertBox.visibility = "hidden";}

function makeAlert(aTitle,aMessage){

is = new BrowserCheck();
alertBox = (is.VER5) ? document.getElementById("alertLayer").style
: (is.NS) ? document.layers["alertLayer"]
:document.getElementById("alertLayer").style;


document.all.alertLayer.innerHTML = "<table border=0 width=100% height=100%>" +
"<tr><td width=3></td><td width=10 align=left></td><td align=left class=alertMessage>" + aMessage + "<BR></td><td width=5></td></tr>" + 
"<tr height=5><td width=5></td></tr>" +
"<tr><td width=3></td><td colspan=2 align=center><input type=button value='OK' onClick='hideAlert()' class=okButton><BR></td><td width=5></td></tr>" +
"<tr height=3><td width=5></td></tr></table>";



thisText = aMessage.length;
if (aTitle.length > aMessage.length){ thisText = aTitle.length; }

aWidth = (thisText * 5) + 80;
aHeight = 100;
if (aWidth < 150){ aWidth = 300; }
if (aWidth > 350){ aWidth = 590; }
if (thisText > 60){ aHeight = 210; }
if (thisText > 120){ aHeight = 230; }
if (thisText > 180){ aHeight = 250; }
if (thisText > 240){ aHeight = 270; }
if (thisText > 300){ aHeight = 290; }
if (thisText > 360){ aHeight = 310; }
if (thisText > 420){ aHeight = 330; }
if (thisText > 490){ aHeight = 350; }
if (thisText > 550){ aHeight = 370; }
if (thisText > 610){ aHeight = 290; }

var w=window.innerWidth
|| document.documentElement.clientWidth
|| document.body.clientWidth;

var h=window.innerHeight
|| document.documentElement.clientHeight
|| document.body.clientHeight;

alertBox.width = aWidth;
alertBox.height = aHeight;

alertBox.left = (w- aWidth)/2;
alertBox.top = (h - aHeight)/2;

alertBox.visibility = "visible";
}

</SCRIPT>
<script>
var 
message = '<table border="0" cellpadding="1" cellspacing="0" width="100%">'+
		'<tr valign="top"><td width="100%" class="bienvenida_3">'+
		'<br><br>'+
		'ALERTA !<br><br>'+
		'La Reserva Federal de los Estados Unidos ha emitido una alerta advirtiendo <br>'+
		' una infiltración fraudulenta en los correos electrónicos, particularmente <br> '+
		'con las operaciones de transferencia a países asiáticos como China y Japón. '+
		'<br><br>'+
		'Es de suma importancia revisar las direcciones de los correo electrónicos '+
		'provenientes de estos países para asegurarse que sean legítimos.<br>'+
		'Cuando un proveedor le indique el cambio en instrucciones de transferencias<br> '+
		'es recomendable comunicarse con el mismo para verificar la autenticidad<br>'+
		'del cambio.<br>'+
		'</td></tr>'+
		'</table>';
		
		
is = new BrowserCheck();	

///if(!is.VER5 && !is.NS){	
///window.onload = function(){ makeAlert(' ALERTA ',message);}		
/// }else{
/// makeAlert(' ALERTA ',message);
 }


</script>

</head>

<%
	try {
%> <%@ include file="body.jsp"%> <%
 	} catch (Exception e) {
 		;
 	}
 %>

<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
<tr valign="top"> 
<td width="500px" height="40">
	<table width="500px" border="0" cellpadding="0" cellspacing="0" class="titulo2" align="center">
	  <tr> 
		<td>
		<bean:message key="tit.bienvenida"/>  
			<strong>: <%=nom%></strong>
		</td>
	  </tr>
	  <tr valign="top"><td class="bottom-line">&nbsp;</td></tr> 
	</table>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	
	<%
			String var = session.getAttribute("validacion.dias") != null ? session
					.getAttribute("validacion.dias").toString() : "1";
			//Object leyenda = session.getAttribute("leyenda");
			String diasDian = session.getAttribute("validacion.dias.dian") != null ? session
					.getAttribute("validacion.dias.dian").toString() : "d";
			ArrayList rechazados = (ArrayList) session
					.getAttribute("rechazados");

			//Elimino la validacion de la leyenda ya que no es necesaria Edgar Sucre => 08/03/2012
			if (var != "1") {
		%>
	    <tr>
		   <td>
	    <div align="center">                     
                               
                   <table width="100%" border="0" cellspacing="2" cellpadding="2" class="tabla-acceso1">
                       <tr> 
                         <td width="100%" rowspan="2"><div align="center"> 
                             <table width="100%" border="0" cellspacing="2" cellpadding="2" aling="center">
                               <tr> 
                                 <td><div align="left"><img src="<html:rewrite page='/images/icon_info_lrg.gif'/>"></div></td>
                               </tr>
	                               <tr>	                                
	                                <td width="68%" class="bienvenida"><b> <bean:message key="lbl.compensacion.leyenda"/>: &nbsp;<%=var.substring(1, var.length() - 1)%></b> </td>		 
	                           </tr> 
                               </table>
						</td>                                
                     </tr>
			   </table>	   
			   </div>        							   
			</td></tr>
	  <%
	  	}
	  	if (diasDian != "d") {
	  %>
	  <tr><td>
	  <div align="center">     
	 	 <table width="100%" border="0" cellspacing="2" cellpadding="2" class="tabla-acceso1">
             <tr> 
               <td width="100%" rowspan="2"><div align="center"> 
                   <table width="100%" border="0" cellspacing="2" cellpadding="2" aling="center">                               
                      <tr> 
                        <td width="68%" class="bienvenida"><b><%=diasDian.substring(1, diasDian.length() - 1)%></b></td>	 
                 	 </tr> 
                   </table>
	        	</td></tr>
	      </table>
	  </div></td></tr>
	  <%
	  	}

	  	//genero los mensajes de formularios rechazados Edgar Sucre => 21/03/2012
		rechazados = null;	//Se elimina mensaje de rechazados Omar Rujano 18/11/2013
	  	if (rechazados != null && !rechazados.isEmpty()) {
	  		Iterator it = rechazados.iterator();	  		
	  		while(it.hasNext()){
	  			ArrayList temp = (ArrayList) it.next();
	  			Iterator st = temp.iterator();
	  		
	  %>
				<tr>
					<td>
						<div align="center">
							<table width="100%" border="0" cellspacing="2" cellpadding="2"
								class="tabla-acceso1">
								<tr>
									<td width="100%" rowspan="2"><div align="center">
										<table width="100%" border="0" cellspacing="2" cellpadding="2" aling="center">
											<% while (st.hasNext()){ 
												Formulario form = (Formulario) st.next();												
											%>
											<tr>
												<td width="68%" class="bienvenida"><b><bean:message key="lbl.fomulario.rechazado" 
												arg0="<%=Integer.toString(form.getCodigo()) %>" arg1="<%=form.getNumeroDeclaracion() %>" 
												arg2="<%=form.getFecha().toString() %>" />
												</b></td>
											</tr>
											<% } %>
										</table>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>

				<%
					}}
				%>
	 <tr><td>
	  <br>
	   <%
	   	if (!mensaje.isEmpty()) {
	   %>
	   <html:form method="post" action="/actualiza/control">
	<html:hidden property="cuenta"/>
	<html:hidden property="tipoVencimiento"/>
	<html:hidden property="desde"/>
	<html:hidden property="hasta"/>
</html:form>
	   <script language="javascript">
function __ok(__date, __acct, __type){
	document.forms["vencimientoForm"].tipoVencimiento.value=__type;
	document.forms["vencimientoForm"].cuenta.value=__acct;
	document.forms["vencimientoForm"].desde.value=__date;
	document.forms["vencimientoForm"].hasta.value=__date;
	document.forms["vencimientoForm"].submit();
}
</script>
	   <div align="center">     
		 <table width="100%" border="0" cellspacing="2" cellpadding="2" class="tabla-acceso1">
              <tr> 
                <td width="100%"> 
                    <table width="100%" border="0" cellspacing="2" cellpadding="2" align="left">
                      <tr> 
                        <td width="5%"><div align="left"><img src="<html:rewrite page='/images/icon_info_lrg.gif'/>"></div></td>
                        <td width="95%" class="bienvenida" align="left"><b>Estimado Cliente:</b> <br>
                        De acuerdo con su control de vencimientos nos permitimos informarle que hoy <b><%=fecha%></b> finaliza el plazo para:</td>	 
	                   </tr> 
	                 </table>
                 <tr><td colspan="2">    
                 <table width="100%" border="0" cellspacing="2" cellpadding="2" align="left">        
		 <%
        		 	for (int i = 0; i < mensaje.size(); i++) {
        		 %>   			 
			 <tr class="<%=i % 2 == 0 ? "celda-clave1" : ""%>">
			    <td width="90%" class="bienvenida"><%=mensaje.get(i)%></td>
			    <td width="10%" align="center" class="bienvenida"><input type="button" class="botton" value="OK" onclick="<%=javascript.get(i)%>"/></td>
			 </tr>  
		<%
  			} //cierra for
  		%>
	   </table></td></tr></table>
  </div>
	  <%
	  	}
	  %> 
	</td></tr>
<tr><td><br><br></td></tr>

<csic:clave-especial/>
<%
	if ("true".equals(session
			.getAttribute("mostrar.mensaje.clave.especial"))
			&& session.getAttribute("clave.secundaria") != null) {
		ClaveEspecial clave = (ClaveEspecial) session
				.getAttribute("clave.secundaria");

		if (ConstantesGlobales.PRIMER_LOGIN == clave.getFlag()) {
%>
<tr>
  <td class="bienvenida_3" colspan="2"><bean:message key="lbl.clave.especial.cambiar"/>
	<a href="<html:rewrite page='/ib/cambioClaveEspecial.jsp'/>">
	<bean:message key="lbl.clave.especial.click.aqui"/></a></td></tr>
<%
	} else if (ConstantesGlobales.CLAVE_BLOQUEADA.equals(clave
				.getEstado())) {
%>
 <tr>
  <td class="bienvenida" colspan="2">
	 
	 <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="bienvenida"><bean:message key="lbl.clave.especial.bloqueada"/><br>
	 <bean:message key="lbl.clave.especial.mensaje"/>
								   </td></tr>
			 </table></td></tr>
		  </table></td></tr>
	 
	 <%
	 	 	} else if (ConstantesGlobales.CLAVE_EXPIRADA.equals(clave
	 	 				.getEstado())) {
	 	 %>
  <tr>
  <td class="bienvenida" colspan="2">
  <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="bienvenida"><bean:message key="lbl.clave.especial.expirada"/><br>
	 <bean:message key="lbl.clave.especial.mensaje"/>
								   </td></tr>
			 </table></td></tr>
		  </table>
	 </td></tr>
	 <%
	 	}
	 	}
	 %>

<logic:present name="mensajes.compensacion">
<%
	String fechaInicioStart = null;
		String fechaFinalStart = null;
		SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
		Calendar cal = Calendar.getInstance();
		fechaFinalStart = df.format(cal.getTime());
		cal.set(Calendar.DATE, 1);
		fechaInicioStart = df.format(cal.getTime());
%>
<html:form method="post" action="/consulta/estado">
	<html:hidden property="cuenta"/>
	<html:hidden property="estado" value="P"/>
	<html:hidden property="desde" value="<%=fechaInicioStart%>"/>
	<html:hidden property="hasta" value="<%=fechaFinalStart%>"/>
</html:form>
<script>
function _start_consulta(cta){
	document.forms["consultaEstadoForm"].cuenta.value=cta;
	document.forms["consultaEstadoForm"].submit();
}
</script>

<%
	Hashtable msg = (Hashtable) session
				.getAttribute("mensajes.compensacion");
		String key = null;
		Enumeration keys = msg.keys();
		for (; keys.hasMoreElements();) {
			key = keys.nextElement().toString();
%>
<tr>
  <td class="bienvenida" colspan="2">
  <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="bienvenida"><%=msg.get(key)%><br>
	 Si desea consultar los movimientos pendientes haga CLICK <a href="javascript:_start_consulta(<%=key%>);">Aquí</a>
								   </td></tr>
			 </table></td></tr>
		  </table>
 </td></tr>
 <%
 	}
 %>
 </logic:present>
 
 <tr>
  <td class="bienvenida" colspan="2">
  <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
		  <tr><td>
			<table border="0" cellpadding="1" cellspacing="0" width="100%">
		<tr valign="top"><td width="100%" class="infoMensaje">
		<br><br>
		ALERTA !<br><br>
		La Reserva Federal de los Estados Unidos ha emitido una alerta advirtiendo 
		 una infiltración fraudulenta en los correos electrónicos, particularmente  
		con las operaciones de transferencia a países asiáticos como China y Japón. 
		<br><br>
		Es de suma importancia revisar las direcciones de los correo electrónicos 
		provenientes de estos países para asegurarse que sean legítimos.<br>
		Cuando un proveedor le indique el cambio en instrucciones de transferencias 
		es recomendable comunicarse con el mismo para verificar la autenticidad
		del cambio.<br><br><br>
		</td></tr>
		</table>
			
			</td></tr>
		  </table>
 </td></tr>
 
 
<tr> 
<td height="30" class="texto-acceso"><br><br></td>
</tr>
<tr height="60%"><td>&nbsp;</td></tr>
</table>
</td>
<td>
	<table width="100%" cellpadding="0" cellspacing="0">
	  <tr><td align="center" width="90%">
     <div id="z_se_v2" z.type="zul.wnd2.Wnd2" z.autoz="true"
          class="z-window-embedded" style="width:250px;height:302px;"
          z.zcls="z-window-embedded" z.minheight="100" z.minwidth="200"
          z.conshow="setTimeout(showMessage(), 30000);">
		  <div id="z_se_v2!cave" class=" z-window-embedded-cnt">
             <div id="z_se_03" class="z-separator-hor" style="height:85px;" z.zcls="z-separator-hor">&nbsp;
             </div>

             <div id="z_se_13" z.conshow="anima.slideUp( $e('z_se_13'), 200);" z.conhide="anima.fade( $e('z_se_13'));">
                 <span id="z_se_23" class="helm-label-news z-label" z.zcls="z-label" class="z-label">
			<%=paran.getmensage_postit() != null ? paran
					.getmensage_postit() : ""%>
			    </span>
             </div>
         </div>
     </div>
	 </td><td width="10%">&nbsp;</td>
	 </tr>
	 </table>
</td>
</tr>
</table>

	
<br>
<%@ include file="footer.jsp" %>
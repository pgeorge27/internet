<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.common.beans.PerfilXML"%>
<%@ page import="com.arango.common.beans.Cliente"%>
<%@ page import="com.arango.internet.beans.IBTransferencias"%>
<%@ page import="com.arango.common.beans.UserInfo"%>
<%@ page import="com.arango.internet.controller.SecurityImageUser"%>


<%
PerfilXML p = (PerfilXML)session.getAttribute("perfil.xml");
if (p == null)
	pageContext.forward("/index.jsp");
ArrayList cltes = p.getClientes();
String nombreCliente = "";
if (cltes.size() > 0){
    nombreCliente = ((Cliente)cltes.get(0)).getNombreCompleto();
}
IBTransferencias tmgr = new IBTransferencias();
//Crea el objeto UserInfo
UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext()); 
String roleCompensacion = (String)session.getAttribute("codigo.role.compensacion");
String tineHelConexion = (String)session.getAttribute("helm.conexion");
String tieneMultipago = (String)session.getAttribute("tiene.multipago");
String width="115";
if (!"".equals(roleCompensacion)){
	width = "145";
}

String permiteDescarga1= "0";
try{
	permiteDescarga1 = (String)session.getAttribute("permite.descarga");
	if ("S" == permiteDescarga1){
		permiteDescarga1 = "1";
		}
	}
	catch(Exception ex){permiteDescarga1 = "0";}

%>


<script language="javascript">
timegap=500
followspeed=5
followrate=40
suboffset_top=10;
suboffset_left=10;

effect = ""


function openwin(url)
{
	nwin=window.open(url, "nwin",config="scrollbars=yes,resizable=yes,toolbar=yes,location=yes,status=yes,menubar=yes,");
	nwin.focus();
}

</script>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/all.css'/>">

<script type="text/javascript" src="<html:rewrite page='/scripts/jquery-latest.min.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/bootstrap.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/DV.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/script.js'/>"></script>

<script type="text/javascript">
//Define your images using arbitrary variables, to be passed in as arguments later down the page:
var usersecurity = 	'<img src="<html:rewrite page='/do.GetImage'/>" width="270px" height="270px" border="0" alt="">'
</script>

<script type="text/javascript"  src="<html:rewrite page='/scripts/statusbar.js'/>"></script>
<script type="text/javascript"  src="<html:rewrite page='/scripts/mmenu.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/tecladoUpdate.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>
<script src="<html:rewrite page='/scripts/vertmenu.js'/>" language="javascript"></script>

<style type="text/css">
.menu {
 position:relative;
 background-color:#EFEFEF;
 border:1px solid #EFEFEF;
 width:200;
 font-size:10px;
 font-family:Verdana, Arial, Helvetica, sans-serif;
 font-weight:bold;
 color:#EF6910;
 position:absolute;
 cursor:hand;
}
 
.item_panel {
  font-weight:bold;
  width:200;
  border-left:1px solid #EFEFEF;
  border-right:1px solid #EFEFEF;
  clip:rect(0,200,0,0);
  cursor:hand;
  position:absolute;
}
 
.item_panel a {
 text-decoration:none;
 font-weight:bold;
 color:#EF6910;
 cursor:hand;
}
 
.item {
 background-color:#EFEFEF;
 width:200;
 font-size:10px;
 font-family:Verdana, Arial, Helvetica, sans-serif;
 font-weight:bold;
}
</style>



</head>

<body>

<div class="flex">
	<div><img class="img-responsive" onclick="dv.showDV(usersecurity); return false" src='<html:rewrite page="/do.GetImage?img=ch"/>'  style=" width : 90px; height : 90px;" ></div>
    <div><img class="img-responsive" border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></div>
	<div>
		<div><h6><strong><bean:message key="lbl.IP_Actual"/> :</strong><%=session.getAttribute("IP.adress")%></h6></div>
    	<div><h6><strong><bean:message key="lbl.Ultima_Transferencia"/> : </strong><common:UltimaTransaccion></common:UltimaTransaccion></h6></div>
     	<div><h6><strong><bean:message key="lbl.ultimo.acceso"/></strong> <common:fecha-acceso/></h6></div>
  	</div>
</div>

<%if ("50".equals(userInfo.getRole())
        ||"60".equals(userInfo.getRole())
		||"65".equals(userInfo.getRole())
        ||"70".equals(userInfo.getRole())){%> 

<nav class="navbar navbar-default">
	<div id='cssmenu' style="z-index:99; " >
		<ul style="">
			<li class='has-sub top'><a href='#' ><span>Consultas</span></a>
				<ul>
					<li class=''><a href='/internet/servicios/seleccion.jsp?prod=CC'><span>Saldo</span></a></li>
					<li class=''><a href='/internet/servicios/movimiento.jsp?prod=CC'><span>Movimientos</span></a></li>
					<li class=''><a href='/internet/servicios/estadocta.jsp?prod=CC'><span>Estado de Cuenta</span></a></li>

	<%if("S".equals(tineHelConexion)) { %> 
       <li class=''><a href='/internet/multicash.do'><span>Helm Conexi&#243n</span></a></li>
	<% } %>

				</ul>

			</li>
			<li class='has-sub top'><a href='#'><span>Inversiones</span></a>
				<ul>
					<li class=''><a href='/internet/servicios/seleccionso.jsp?prod=DP'><span>Dep&#243sitos a Plazo Fijo</span></a></li>
				</ul>
			</li>
			<li class='has-sub top'><a href='#'><span>Helm Transfer</span></a>
				<ul>

	<% if ("60".equals(userInfo.getRole())
		||"65".equals(userInfo.getRole())
		||"70".equals(userInfo.getRole())){%>

					<li class=''><a href='/internet/transfer.do?mode=create'><span>Preparaci&#243n</span></a></li>
					<li><a href='/internet/servicios/modificacion.jsp'><span>Modificaci&#243n</span></a></li>

	<%}%>

					<li class=''><a href='/internet/servicios/transferencias.jsp'><span>Consulta</span></a></li>

	<% if ("50".equals(userInfo.getRole())
		||"70".equals(userInfo.getRole())){
		session.setAttribute("mostrar.mensaje.clave.especial", "true");
	%>

					<li class=''><a href='/internet/transferencias/clave.jsp'><span>Autorizaci&#243n / Cancelaci&#243n</span></a></li>

	<%}%>
	<% if ("60".equals(userInfo.getRole())
		||"65".equals(userInfo.getRole())
		||"70".equals(userInfo.getRole())){%>

	<%if (!"".equals(roleCompensacion)){%>
					<li class='has-sub top bottom last'><a href='#'><span>Plantilla</span></a>
						<ul>
							<li><a href='/internet/transferencias/crearPlantilla.jsp'><span>Elaborar</span></a></li>
							<li class='last'><a href='/internet/mant/plantilla.do'><span>Edici&#243n / Eliminaci&#243n</span></a></li>
						</ul>
					</li>
	<%}%>

					<li class=''><a href='/internet/mant/beneficiarios.do'><span>Gesti&#243n de Beneficiarios</span></a></li>
					<li class=''><a href='/internet/consultaAprovados.do'><span>Beneficiarios Aprobados</span></a></li>
					<li class=''><a href='/internet/trans/activity/seleccion.do'><span>Actividad de Transferencias</span></a></li>
	<%}%>
				</ul>

			<li class='has-sub top'><a href='#'><span>Helm Compensaci&#243n</span></a>
				<ul>
					<li class='has-sub'><a href='#'><span>Declaraci&#243n de Cambio</span></a>
						<ul>

	<% if ("60".equals(roleCompensacion)
		||"65".equals(roleCompensacion)
		||"70".equals(roleCompensacion)){%>
							<li class='has-sub bottom'><a href='#'><span>Elaborar</span></a>
								<ul>
									<li><a href="/internet/mant/cuenta.do"><span>Movimientos</span></a></li>
									<li><a href="/internet/mant/cuenta1.do"><span>Sin Movimientos</span></a></li>
								</ul>
							</li>
							<li><a href="/internet/mant/modificar.do"><span>Modificar Guardado Temporal / Pendiente de Aprobar</span></a></li>
	<%}%>

							<li><a href="/internet/seleccion/estado.do"><span>Consultar</span></a></li>
	<% if ("50".equals(roleCompensacion)
			||"70".equals(roleCompensacion)){%>
							<li><a href="/internet/compensacion/aceptacion.do"><span>Aprobar</span></a></li>
							<li><a href="/internet/consulta/busqueda/documentos/formularios.do"><span>Consulta Documento Importanci&#243n/Exportaci&#243n</span></a></li>
	<%}%>
						</ul>
					</li>

	<% if ("60".equals(roleCompensacion)
			||"65".equals(roleCompensacion)
			||"70".equals(roleCompensacion)){%>

					<li class='has-sub top'><a href='#'><span>Formulario 10 Relaci&#243n de Operaciones</span></a>
						<ul>
							<li><a href="/internet/formulario10/mant/cuenta.do"><span>Elaborar</span></a></li>
							<li><a href="/internet/formulario10/mant/modificar.do"><span>Modificar - Guardados Temporal</span></a></li>
							<li><a href="/internet/formulario10/seleccion/estado.do"><span>Consultar</span></a></li>

		<% if ("60".equals(roleCompensacion)
			||"65".equals(roleCompensacion)){%>
						</ul>
					</li>
		<%}%>
	<%}%>
	<% if ("50".equals(roleCompensacion)
		||"70".equals(roleCompensacion)){%>

	<% if ("50".equals(roleCompensacion)){%>
					<li class='has-sub top'><a href='#'><span>Formulario 10 Relaci&#243n de Operaciones</span></a>
						<ul>
	<%}%>
							<li><a href="/internet/formulario10/compensacion/aceptacion.do"><span>Aprobar</span></a></li>
							<li><a href="/internet/formulario10/mant/reproceso.do"><span>Reprocesar</span></a></li>
							<li><a href="/internet/formulario10/generar/xml/consulta.do"><span>Generar XML Ban. Rep.</span></a></li>
						</ul>
					</li>
	<%}%>
					<li class='has-sub top'><a href='#'><span>Reporte DIAN</span></a>
						<ul>
	<%if ("60".equals(roleCompensacion)
		||"65".equals(roleCompensacion)
		||"70".equals(roleCompensacion)){%>
							<li><a href="/internet/dian/elaborar/seleccion.do"><span>Preparar DIAN</span></a></li>
	<%}%>
							<li><a href="/internet/dian/consultar/seleccion.do"><span>Consultar</span></a></li>
	<%if ("50".equals(roleCompensacion)
		||"65".equals(roleCompensacion)
		||"70".equals(roleCompensacion)
		||"60".equals(roleCompensacion)){%>
							<li><a href="/internet/dian/generar/seleccion.do"><span>Generar XML</span></a></li>
	<%}%>
	<% if ("50".equals(roleCompensacion)
		||"65".equals(roleCompensacion)
		||"70".equals(roleCompensacion)
		||"60".equals(roleCompensacion)){%>
							<li><a href="/internet/dian/reproceso/seleccion.do"><span>Reproceso de XML</span></a></li>
	<% 	} if ("S".equals(permiteDescarga1)){ %>
							<li><a href="/internet/dian/exportar/seleccion.do"><span>Exportar Exccel</span></a></li>
	<%}%>
							<li><a href="/internet/dian/cambioFecha/seleccion.do"><span>Cambio de Fecha Legalizaci&#243n</span></a></li>
						</ul>
					</li>
					<li class='has-sub top'><a href='#'><span>Reprocesos de Informes Anteriores</span></a>
						<ul>
							<li><a href="/internet/mant/reprocesar.do"><span>Modificar- Formularios Aprobados</span></a></li>
							<li><a href="/internet/selec/legalizaciones.do"><span>Legalizaci&#243n de operaciones</span></a></li>
							<li><a href="/internet/selec/Modlegalizaciones.do"><span>Modificar Legalizaci&#243n</span></a></li>
							<li><a href="/internet/mant/reprocesar1.do"><span>Consultar</span></a></li>
						</ul>
					</li>

					<li class='has-sub top bottom'><a href='#'><span>Consultas</span></a>
						<ul>
							<li><a target="_blank" href="https://quimbaya.banrep.gov.co/secinternet/operaciones.jsp?opcion=codigos"><span>CIIUs</span></a></li>
							<li><a target="_blank" href="https://quimbaya.banrep.gov.co/secinternet/operaciones.jsp?opcion=ciudades"><span>Ciudades</span></a></li>
							<li><a target="_blank" href="https://quimbaya.banrep.gov.co/secinternet/operaciones.jsp?opcion=paises"><span>Paises</span></a></li>
							<li><a target="_blank" href="https://quimbaya.banrep.gov.co/secinternet/operaciones.jsp?opcion=numerales"><span>Numerales Cambiarios</span></a></li>
							<li><a target="_blank" href="http://www.banrep.gov.co/es/buscador-reglamentacion/4025%2B4027%2B4026"><span>Reglamentaciones</span></a></li>
						</ul>
					</li>

					<li class=''><a href='/internet/mant/parametro.do'><span>Par&#225metros de la Cuenta</span></a>
					</li>

					<li class=''><a href='/internet/mant/representante.do'><span>Datos del Representante Legal</span></a>
					</li>

					<li class='has-sub top bottom'><a href='#'><span>Reporte</span></a>
						<ul>
							<li><a href="/internet/est/seleccion.do"><span>Estadistico por Formulario y Numeral</span></a></li>
							<li><a href="/internet/est/seleccion/control.do"><span>Reportes de Control</span></a></li>
						</ul>
					</li>
				</ul>
			</li>

			<li class='has-sub top'><a href='#'><span>Multipagos</span></a>
				<ul>
					<li class="visible-lg"><a href="/internet/multipagos/CargaArchivo.jsp"><span>Carga de Archivo</span></a></li>
	<% if ("50".equals(userInfo.getRole()) || "70".equals(userInfo.getRole())){%>
					<li><a href="/internet/multipagos/consultaAutCan.jsp"><span>Aprobar MultiPagos</span></a></li>
	<%}%>
					<li><a href="/internet/multipagos/pconsultaMultipagos.jsp"><span>Consultar MultiPagos</span></a></li>
				</ul>
			</li>

			<li class='has-sub top'><a href='#'><span>Ayuda</span></a>
				<ul>
					<li><a target="_blank" href="http://get.adobe.com/es/reader/"><span>Descargar Adobe Reader</span></a></li>
					<li><a target="_blank" href="/internet/ayuda/descargar_carga_masiva.jsp?titul=VD"><span>Instalador Carga Masiva</span></a></li>
					<li><a target="_blank" href="/internet/ayuda/acuerdos_formularios.jsp?titul=AF"><span>Acuerdos y Formularios</span></a></li>
					<li><a target="_blank" href="https://www.grupohelm.com/personal/negocios-internacionales/reglamentacion-cambiaria"><span>Estatuto Cambiario</span></a></li>
					<li><a target="_blank" href="/internet/ayuda/consseguridad.jsp"><span>Consejos de Seguridad</span></a></li>
					<li><a target="_blank" href="/internet/ayuda/video_demo.jsp?titul=VD"><span>Video Demo</span></a></li>
				</ul>
			</li>
			<li class='has-sub top'><a href='#'><span>Administraci&#243n</span></a>
				<ul>
					<li><a href="/internet/ib/cambioClave.jsp"><span>Cambio clave de acceso</span></a></li>
	<%if ("50".equals(userInfo.getRole()) ||"70".equals(userInfo.getRole())){
		String keyCambioPin ="";
	if(session.getAttribute("tieneToken").toString().equals("S")){%>	
					<li><a href="/internet/mant/AdminIMG.jsp"><span>Cambio imagen personalizada</span></a></li>
					<li><a href="/internet/token/sincronizarToken.jsp"><span>Sincronizar su Dispositivo</span></a></li>
					<li><a href="/internet/token/cambioPIN.jsp"><span>Cambio del PIN de su Dispositivo</span></a></li>
	<% } else if(session.getAttribute("tieneToken").toString().equals("N")) { %>
					<li><a href="/internet/ib/cambioClaveEspecial.jsp"><span>Cambio de Firma</span></a></li>
	<% } %>
					<li><a href="/internet/preguntas.jsp?admpregsec=true"><span>Cambio preguntas de seguridad</span></a></li>
					<li><a href="/internet/mant/users.jsp"><span>Administraci&#243n de usuarios</span></a></li>
	<%}%>
					<li class='last'><a href="/internet/cargaInformacion.do?pantalla=carga"><span>Actualizaci&#243n de la Informaci&#243n del Cliente</span></a></li>
				</ul>
			</li>
			<li class='last'><a href='/internet/logout.jsp'><span>Salir</span></a></li>
		</ul>
	</div>
</nav>

 <%}   else {%>
  <div>no debe ser ejecutado</div>
 <%} %>

<script language="JavaScript">
      urlBase= "<html:rewrite page='/logout.jsp'/>";
      ar[0] = 'User ID: <%=session.getAttribute("user.id")%>      Cliente: <%=nombreCliente%>     ip=<%=session.getAttribute("IP.adress")%>';
      showBanner();
</script>

<div id="__objPleaseWait" style="overflow:visible;display:none;position:absolute;top:0px;left:0px;background-color:white;border-style:solid;border-width:1px;border-color:black;filter:progid:DXImageTransform.Microsoft.dropshadow(OffX=10, OffY=10, Color=Gray, Positive=true)"
		onclick="__CloseWait();">

<table cellpadding="0" cellspacing="0" border="0">
	<tr>
	<td colspan="2" height="8px" style="Padding-Top:2px;Padding-Bottom:2px;Padding-Left:10px;cursor:default;white-space:nowrap;font-size:11px;font-family:Arial;background-color:gray;color:White;font-weight:bold;">
			<bean:message key="tit.title.banco"/>
	</td></tr>
	<tr>
	<td style="Padding:12px;cursor:default;Font-Size:11px;white-space:nowrap;font-family:Arial;font-size:11px;"> </td> 
		<td style="Padding:12px;cursor:default;Font-Size:11px;white-space:nowrap;font-family:Arial;font-size:11px;">
		<table border="0" cellpadding="3" cellspacing="1" width="100%">
		  <tr><td width="5%" valign="top"><img src="<html:rewrite page='/images/session.gif'/>"></td>
			  <td width="95%" class="bienvenida">
				  <bean:message key="lbl.alerta.fin.sesion"/> <a href="javascript:__CloseWait();"><bean:message key="lbl.clave.especial.click.aqui"/></a>.
			  </td></tr>
		</table>
	</td></tr> 
</table>
</div>
</body>
</html>
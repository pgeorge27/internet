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


propini=[					// prop1 is an array of properties you can have as many property arrays as you need
"#E96B10",					// Off Font Color
"#EFEFEF",					// Off Back Color
"#E96B10",					// On Font Color
"#E9C29D",					// On Back Color
"#EFEFEF", 			    	        // Border Color
11,						// Font Size
"normal",					// Font Style
"bold",   					// Font Weight
"Verdana",					// Font
4,						// Padding
"<html:rewrite page='/images/arrow.jpg'/>",	// Sub Menu Image
,						// 3D Border & Separator
,				                // 3D High Color
,		    	                        // 3D Low Color
,  						// Referer item Font Color (leave this blank to disable)
,			 			// Referer item Back Color (leave this blank to disable)
]


prop1=[						// prop1 is an array of properties you can have as many property arrays as you need
"#E96B10",					// Off Font Color
"#EFEFEF",					// Off Back Color
"#4D4F53",					// On Font Color
"#E9C29D",					// On Back Color
"#DBDBDB",					// Border Color
11,						// Font Size
"normal",					// Font Style 
"bold",   				        // Font Weight
"Verdana",			     	        // Font
6,						// Padding
"<html:rewrite page='/images/arrow.jpg'/>",	// Sub Menu Image
,						// 3D Border & Separator
,					        // 3D High Color
,					        // 3D Low Color
,						// Referer item Font Color (leave this blank to disable)
,						// Referer item Back Color (leave this blank to disable)
]
























menu2=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="mnu.consulta.saldos"/>","<html:rewrite page='/servicios/seleccion.jsp?prod=CC'/>",,"<bean:message key="mnu.consulta.saldos"/>",1, 
"<bean:message key="mnu.consulta.movimiento"/>","<html:rewrite page='/servicios/movimiento.jsp?prod=CC'/>",,"<bean:message key="mnu.consulta.movimiento"/>",1,
"<bean:message key="mnu.estado.cuenta"/>","<html:rewrite page='/servicios/estadocta.jsp?prod=CC'/>",,"<bean:message key="mnu.estado.cuenta"/>",1
<%if("S".equals(tineHelConexion)) { %> 
,"Helm Conexión","<html:rewrite page='/multicash.do'/>",,"Helm Conexión",1
<% } %>		
]

menu3=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="mnu.deposito.plazo"/>","<html:rewrite page='/servicios/seleccionso.jsp?prod=DP'/>",,"<bean:message key="mnu.deposito.plazo"/>",1
]

menu4=[,,270,1,"",prop1,,"left",effect,,,,,,,
<%
if ("60".equals(userInfo.getRole())
	  ||"65".equals(userInfo.getRole())
	  ||"70".equals(userInfo.getRole())){%>
	"<bean:message key="mnu.preparacion"/>","<html:rewrite page='/transfer.do?mode=create'/>",,"<bean:message key="mnu.preparacion"/>",1,
	"<bean:message key="mnu.modificacion"/>","<html:rewrite page='/servicios/modificacion.jsp'/>",,"<bean:message key="mnu.modificacion"/>",1,
<%}%>
"<bean:message key="mnu.consulta.transferencia"/>","<html:rewrite page='/servicios/transferencias.jsp'/>",,"<bean:message key="mnu.consulta.transferencia"/>",1
<% if ("50".equals(userInfo.getRole())
	||"70".equals(userInfo.getRole())){
    session.setAttribute("mostrar.mensaje.clave.especial", "true");
%>
,"<bean:message key="mnu.aprobacion"/>","<html:rewrite page='/transferencias/clave.jsp'/>",,"<bean:message key="mnu.aprobacion"/>",1
<%}%>
<%
if ("60".equals(userInfo.getRole())
	  ||"65".equals(userInfo.getRole())
	  ||"70".equals(userInfo.getRole())){%>
	  
<%if (!"".equals(roleCompensacion)){%>
,"<bean:message key="lbl.transf.inter.plantilla.menu"/>","show-menu18",,"<bean:message key="lbl.transf.inter.plantilla.menu"/>",1
<%}else{%>
,"<bean:message key="lbl.transf.inter.plantilla.menu"/>","show-menu7",,"<bean:message key="lbl.transf.inter.plantilla.menu"/>",1
<%}%>

<%}%>

<% 
String tieneTok = (String) session.getAttribute("tieneToken");
if(tieneTok.equals("S")){ %>
// ,"<bean:message key="lbl.beneficiarios.aprobados.menu"/>","<html:rewrite page='/consultaAprovados.do'/>",,"<bean:message key="lbl.beneficiarios.aprobados.menu"/>",1
//,"<bean:message key="lbl.beneficiarios.general.mnu"/>","show-menu16",,"<bean:message key="lbl.beneficiarios.general.mnu"/>",1

,"<bean:message key="lbl.manenimiento.beneficiarios.mnu"/>","<html:rewrite page='/mant/beneficiarios.do'/>",,"<bean:message key="lbl.manenimiento.beneficiarios.mnu"/>",1,
"<bean:message key="lbl.beneficiarios.aprobados.menu"/>","<html:rewrite page='/consultaAprovados.do'/>",,"<bean:message key="lbl.beneficiarios.aprobados.menu"/>",1
<% }%>
,"Actividad De Transferencias","<html:rewrite page='/trans/activity/seleccion.do'/>","Actividad De Transferencias",1
]

menu16=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.manenimiento.beneficiarios.mnu"/>","<html:rewrite page='/mant/beneficiarios.do'/>",,"<bean:message key="lbl.manenimiento.beneficiarios.mnu"/>",1,
"<bean:message key="lbl.beneficiarios.aprobados.menu"/>","<html:rewrite page='/consultaAprovados.do'/>",,"<bean:message key="lbl.beneficiarios.aprobados.menu"/>",1
]

menu5=[,,215,1,"",prop1,,"left",effect,,,,,,,
"Descargar Adobe Reader","http://get.adobe.com/es/reader/ target=\"NEW\"",,"Descargar Adobe Reader",1,
"Instalador Carga Masiva","<html:rewrite page='/ayuda/descargar_carga_masiva.jsp?titul=VD'/>",,"Instalador Carga Masiva",1,
"<bean:message key="mnu.acuerdos.formularios"/>","<html:rewrite page='/ayuda/acuerdos_formularios.jsp?titul=AF'/>",,"<bean:message key="mnu.acuerdos.formularios"/>",1,
"<bean:message key="lbl.estatuto.cambiario"/>","https://www.grupohelm.com/personal/negocios-internacionales/reglamentacion-cambiaria target=\"NEW\"",,"<bean:message key="lbl.estatuto.cambiario"/>",1,
"<bean:message key="lbl.mnu.consejos.seguridad"/>","<html:rewrite page='/ayuda/consseguridad.jsp'/> ",,"<bean:message key="lbl.mnu.consejos.seguridad"/>",1,
"<bean:message key="mnu.video.demo"/>","<html:rewrite page='/ayuda/video_demo.jsp?titul=VD'/>",,"<bean:message key="mnu.video.demo"/>",1
]
<%if (!"".equals(roleCompensacion)){%>
menu6=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.compensacion.menu.declaracion.cambio"/>","show-menu7",,"<bean:message key="lbl.compensacion.menu.declaracion.cambio"/>",1,
"<bean:message key="lbl.compensacion.menu.formulario.10"/>","show-menu8",,"<bean:message key="lbl.compensacion.menu.formulario.10"/>",1,
"<bean:message key="lbl.compensacion.menu.reporte.dian"/>","show-menu9",,"<bean:message key="lbl.compensacion.menu.reporte.dian"/>",1,
"<bean:message key="lbl.compensacion.menu.reprocesos"/>","show-menu12",,"<bean:message key="lbl.compensacion.menu.reprocesos"/>",1,
"<bean:message key="lbl.compensacion.menu.consultas"/>","show-menu10",,"<bean:message key="lbl.compensacion.menu.consultas"/>",1,
"<bean:message key="lbl.compensacion.parametro.titulo"/>","<html:rewrite page='/mant/parametro.do'/>",,"<bean:message key="lbl.compensacion.parametro.titulo"/>",1,
"<bean:message key="lbl.compensacion.parametro.titulo.2"/>","<html:rewrite page='/mant/representante.do'/>",,"<bean:message key="lbl.compensacion.parametro.titulo.2"/>",1,
//"Control de Vencimiento de Importación y Exportación","show-menu14",,"Control de Vencimiento de Importación y Exportación",1,
"<bean:message key="lbl.compensacion.parametro.reporte"/>","show-menu13",,"<bean:message key="lbl.compensacion.parametro.reporte"/>",1
]
menu7=[,,215,1,"",prop1,,"left",effect,,,,,,,
<%
if ("60".equals(roleCompensacion)
	  ||"65".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)){%>
"<bean:message key="lbl.compensacion.menu.elaborar"/>","show-menu11",,"<bean:message key="lbl.compensacion.menu.elaborar"/>",1,
"<bean:message key="lbl.compensacion.menu.modificar2"/>","<html:rewrite page='/mant/modificar.do'/>",,"<bean:message key="lbl.compensacion.menu.modificar2"/>",1,
<%}%>
"<bean:message key="lbl.compensacion.menu.consultar"/>","<html:rewrite page='/seleccion/estado.do'/>",,"<bean:message key="lbl.compensacion.menu.consultar"/>",1
<%
if ("50".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)){%>
,"<bean:message key="lbl.compensacion.menu.aprobar"/>","<html:rewrite page='/compensacion/aceptacion.do'/>",,"<bean:message key="lbl.compensacion.menu.aprobar"/>",1
//,"Eliminar Declaración","<html:rewrite page='/seleccion/estado/formularios/eliminacion.do'/>",,"Eliminar Declaración",1
<%}%>
,"Consulta Documento Importacion/Exportacion","<html:rewrite page='/consulta/busqueda/documentos/formularios.do'/>",,"Consulta Documento Importacion/Exportacion",1

]
menu8=[,,215,1,"",prop1,,"left",effect,,,,,,,
 <%
 if ("60".equals(roleCompensacion)
 	  ||"65".equals(roleCompensacion)
 	  ||"70".equals(roleCompensacion)){%>
 "<bean:message key="lbl.compensacion.menu.elaborar"/>","<html:rewrite page='/formulario10/mant/cuenta.do'/>",,"<bean:message key="lbl.compensacion.menu.elaborar"/>",1
 ,"<bean:message key="lbl.compensacion.menu.modificar"/>","<html:rewrite page='/formulario10/mant/modificar.do'/>",,"<bean:message key="lbl.compensacion.menu.modificar"/>",1,
 <%}%>
 "<bean:message key="lbl.compensacion.menu.consultar"/>","<html:rewrite page='/formulario10/seleccion/estado.do'/>",,"<bean:message key="lbl.compensacion.menu.consultar"/>",1
 <%
 if ("50".equals(roleCompensacion)
 	  ||"70".equals(roleCompensacion)){%>
 ,"<bean:message key="lbl.compensacion.menu.aprobar"/>","<html:rewrite page='/formulario10/compensacion/aceptacion.do'/>",,"<bean:message key="lbl.compensacion.menu.aprobar"/>",1
 ,"Reprocesar","<html:rewrite page='/formulario10/mant/reproceso.do'/>",,"Reprocesar",1
 <%}%>
 //moviendo el menu generar xml.ban al menu de compensacion Edgar Sucre => 08/03/2012
 ,"<bean:message key="lbl.compensacion.menu.generar.xml.ban.rep"/>","<html:rewrite page='/formulario10/generar/xml/consulta.do'/>",,"<bean:message key="lbl.compensacion.menu.generar.xml.ban.rep"/>",1
]
menu9=[,,215,1,"",prop1,,"left",effect,,,,,,,
<%
if ("60".equals(roleCompensacion)
	  ||"65".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)){%>
"<bean:message key="lbl.compensacion.dian.elaborar"/>","<html:rewrite page='/dian/elaborar/seleccion.do'/>",,"<bean:message key="lbl.compensacion.dia.elaborar"/>",1,

<%}%>
"<bean:message key="lbl.compensacion.menu.consultar"/>","<html:rewrite page='/dian/consultar/seleccion.do'/>",,"<bean:message key="lbl.compensacion.menu.consultar"/>",1

<%if ("50".equals(roleCompensacion)
	  ||"65".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)
	  ||"60".equals(roleCompensacion)){%>
,"<bean:message key="lbl.compensacion.generar.xml"/>","<html:rewrite page='/dian/generar/seleccion.do'/>",,"<bean:message key="lbl.compensacion.generar.xml"/>",1
<%}%>
<%
if ("50".equals(roleCompensacion)
	  ||"65".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)
	  ||"60".equals(roleCompensacion)){%>
,"Reproceso de XML","<html:rewrite page='/dian/reproceso/seleccion.do'/>",,"Reproceso de XML",1
<%
}
if ("S".equals(permiteDescarga1)){ %>
 ,"Exportar Excel","<html:rewrite page='/dian/exportar/seleccion.do'/>",,"Exportar Excel",1
 <%}%>
 ,"Cambio de Fecha Legalización","<html:rewrite page='/dian/cambioFecha/seleccion.do'/>",,"Cambio de Fecha Legalización",1
]
menu10=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.compensacion.menu.ciiu"/>","https://quimbaya.banrep.gov.co/secinternet/operaciones.jsp?opcion=codigos target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.ciiu"/>",1,
"<bean:message key="lbl.compensacion.menu.ciudades"/>","https://quimbaya.banrep.gov.co/secinternet/operaciones.jsp?opcion=ciudades target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.ciudades"/>",1,
"<bean:message key="lbl.compensacion.menu.paises"/>","https://quimbaya.banrep.gov.co/secinternet/operaciones.jsp?opcion=paises target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.paises"/>",1,
"<bean:message key="lbl.compensacion.menu.numeral.cambiario"/>","https://quimbaya.banrep.gov.co/secinternet/operaciones.jsp?opcion=numerales target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.numeral.cambiario"/>",1,
"<bean:message key="lbl.compensacion.menu.reglamentaciones"/>","http://www.banrep.gov.co/es/buscador-reglamentacion/4025%2B4027%2B4026 target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.reglamentaciones"/>",1
]

menu11=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.compensacion.menu.movimientos.asociados"/>","<html:rewrite page='/mant/cuenta.do'/>",,"<bean:message key="lbl.compensacion.menu.movimientos.asociados"/>",1,
"<bean:message key="lbl.compensacion.menu.movimientos.no.asociados"/>","<html:rewrite page='/mant/cuenta1.do'/>",,"<bean:message key="lbl.compensacion.menu.movimientos.no.asociados"/>",1
]

menu12=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.compensacion.menu.reprocesar"/>","<html:rewrite page='/mant/reprocesar.do'/>",,"<bean:message key="lbl.compensacion.menu.reprocesar"/>",1,
"Legalización de Operaciones","<html:rewrite page='/selec/legalizaciones.do'/>",,"Legalización de Operaciones",1,
"Modificar Legalización","<html:rewrite page='/selec/Modlegalizaciones.do'/>",,"Modificar Legalización",1,
"<bean:message key="lbl.compensacion.menu.consultar"/>","<html:rewrite page='/mant/reprocesar1.do'/>",,"<bean:message key="lbl.compensacion.menu.consultar"/>",1

]
menu13=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.compensacion.movimiento.titulo.estadistica"/>","<html:rewrite page='/est/seleccion.do'/>",,"<bean:message key="lbl.compensacion.movimiento.titulo.estadistica"/>",1,
"Reportes de Control","<html:rewrite page='/est/seleccion/control.do'/>",,"Reportes de Control",1
//"<bean:message key="lbl.compensacion.menu.generar.xml.ban.rep"/>","<html:rewrite page='/formulario10/generar/xml/consulta.do'/>",,"<bean:message key="lbl.compensacion.menu.generar.xml.ban.rep"/>",1

]

menu14=[,,215,1,"",prop1,,"left",effect,,,,,,,
"Información de Importación","<html:rewrite page='/vencimiento/insercion/importacion.do'/>",,"Información de Importación",1,
"Información de Exportación Ordinaria","<html:rewrite page='/vencimiento/insercion/exportacion/ordinaria.do'/>",,"Información de Exportación Ordinaria",1,
"Información de Exportación Anticipada","<html:rewrite page='/vencimiento/insercion/exportacion/anticipada.do'/>",,"Información de Exportación Anticipada",1, 
"Consultas","<html:rewrite page='/vencimiento/seleccion.do'/>",,"Consultas",1,
"Modificación","<html:rewrite page='/vencimiento/modificacion/seleccion.do'/>",,"Modificación",1

]

menu15=[,,215,1,"",prop1,,"left",effect,,,,,,,
        "<bean:message key="mnu.salir"/>","<html:rewrite page='/logout.jsp'/>",,"Salir",1
        ]
<%}%>
<%if (!"".equals(roleCompensacion)){%>
menu17=[,,215,1,"",prop1,,"left",effect,,,,,,,
		"Carga de Archivo ","<html:rewrite page='/multipagos/CargaArchivo.jsp'/>",,"Carga De Archivo",1,   
        <% if ("50".equals(userInfo.getRole()) || "70".equals(userInfo.getRole())){%>
		"Aprobar MultiPagos","<html:rewrite page='/multipagos/consultaAutCan.jsp'/>",,"Carga De Archivo",1,   
		<%}%>
        "Consultar MultiPagos","<html:rewrite page='/multipagos/pconsultaMultipagos.jsp'/>",,"Carga De Archivo",1  
		]
menu18=[,,215,1,"",prop1,,"left",effect,,,,,,,		
"<bean:message key="lbl.compensacion.menu.elaborar"/>","<html:rewrite page='/transferencias/crearPlantilla.jsp'/>",,"<bean:message key="lbl.transf.inter.plantilla.menu"/>",1
,"Edición / Eliminación","<html:rewrite page='/mant/plantilla.do'/>",,"<bean:message key="lbl.transf.inter.plantilla.menu"/>",1
]
<%}else{%>
menu6=[,,215,1,"",prop1,,"left",effect,,,,,,,
		"Carga de Archivo ","<html:rewrite page='/multipagos/CargaArchivo.jsp'/>",,"Carga De Archivo",1,   
        <% if ("50".equals(userInfo.getRole()) || "70".equals(userInfo.getRole())){%>
		"Aprobar MultiPagos","<html:rewrite page='/multipagos/consultaAutCan.jsp'/>",,"Carga De Archivo",1,   
		<%}%>
        "Consultar MultiPagos","<html:rewrite page='/multipagos/pconsultaMultipagos.jsp'/>",,"Carga De Archivo",1  
		]
menu7=[,,215,1,"",prop1,,"left",effect,,,,,,,		
        "<bean:message key="lbl.compensacion.menu.elaborar"/>","<html:rewrite page='/transferencias/crearPlantilla.jsp'/>",,"<bean:message key="lbl.transf.inter.plantilla.menu"/>",1
        ,"Edición e Eliminación","<html:rewrite page='/mant/plantilla.do'/>",,"<bean:message key="lbl.transf.inter.plantilla.menu"/>",1
        ]
	<%}%>
</script>
<!--script language="javascript">
function __pageLoad2(){
	if (__init){
		__init();
	}
}
</script-->


<!DOCTYPE html>
<html>
<HEAD>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<script type="text/javascript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>

<script type="text/javascript" src="<html:rewrite page='/scripts/bootstrap.js'/>"></script>






<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>



<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/bootstrap.min.css'/>">


<script src="<html:rewrite page='/scripts/DV.js'/>" type="text/javascript"></script>

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




   <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

   
   
   
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/styles.css'/>">
<script type="text/javascript"  src="<html:rewrite page='/scripts/script.js'/>"></script>


</HEAD>


<body>






    <div class="row" style="width: 90%; padding-right: 2px;">
        
       <table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="160" align="center" style="padding-left: 5%;" > 
						<img onclick="dv.showDV(usersecurity); return false" src='<html:rewrite page="/do.GetImage?img=ch"/>'  style=" width : 90px; height : 90px;" >
				</td>
				<td width="1%"></td>
			<td width="100%" height="100" style="padding-left: 5%;" >
				<table width="100%" style="text-align: left" >
					<tr><td><a class="mnu"><h6><strong><bean:message key="lbl.IP_Actual"/> :</strong><%=session.getAttribute("IP.adress")%></h6></a></td></tr>
					<tr><td><a class="mnu"><h6><strong><bean:message key="lbl.Ultima_Transferencia"/> :</strong>  <common:UltimaTransaccion></common:UltimaTransaccion></h6></a></td></tr>
					<tr><td><a class="mnu"><h6><strong><bean:message key="lbl.ultimo.acceso"/></strong> <common:fecha-acceso/></h6></a></td></tr>
				</table> 

			</td>  

		<td style="padding-left: 2%"> 
				<img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/>
			</td>

			</tr>
		</table>

		</div>

	<br>
	
<%if ("50".equals(userInfo.getRole())
        ||"60".equals(userInfo.getRole())
		||"65".equals(userInfo.getRole())
        ||"70".equals(userInfo.getRole())){%> 

<nav class="navbar navbar-default" style="width: 99.8%; margin-left: 0.2em;">
	<div id='cssmenu' style="z-index:99; " >
		<ul style="">
			<li class='has-sub'><a href='#' ><span>Consultas</span></a>
				<ul>
					<li class=''><a href='/internet/servicios/seleccion.jsp?prod=CC'><span>Saldo</span></a></li>
					<li class=''><a href='/internet/servicios/movimiento.jsp?prod=CC'><span>Movimientos</span></a></li>
					<li class=''><a href='/internet/servicios/estadocta.jsp?prod=CC'><span>Estado de Cuenta</span></a></li>

	<%if("S".equals(tineHelConexion)) { %> 
       <li class=''><a href='/multicash.do'><span>Helm Conexi&#243n</span></a></li>
	<% } %>

				</ul>

			</li>
			<li class='has-sub'><a href='#'><span>Inversiones</span></a>
				<ul>
					<li class=''><a href='/internet/servicios/seleccionso.jsp?prod=DP'><span>Dep&#243sitos a Plazo Fijo</span></a></li>
				</ul>
			</li>
			<li class='has-sub'><a href='#'><span>Helm Transfer</span></a>
				<ul>

	<% if ("60".equals(userInfo.getRole())
		||"65".equals(userInfo.getRole())
		||"70".equals(userInfo.getRole())){%>

					<li class=''><a href='/transfer.do?mode=create'><span>Preparaci&#243n</span></a></li>
					<li class='/internet/servicios/modificacion.jsp'><a href='#'><span>Modificaci&#243n</span></a></li>

	<%}%>

					<li class=''><a href='/internet/servicios/transferencias.jsp'><span>Consulta</span></a></li>

	<% if ("50".equals(userInfo.getRole())
		||"70".equals(userInfo.getRole())){
		session.setAttribute("mostrar.mensaje.clave.especial", "true");
	%>

					<li class=''><a href='/transferencias/clave.jsp'><span>Autorizaci&#243n / Cancelaci&#243n</span></a></li>

	<%}%>
	<% if ("60".equals(userInfo.getRole())
		||"65".equals(userInfo.getRole())
		||"70".equals(userInfo.getRole())){%>

	<%if (!"".equals(roleCompensacion)){%>

					<li class='has-sub'><a href='#'><span>Plantilla</span></a>
						<ul>
							<li><a href='/transferencias/crearPlantilla.jsp'><span>Elaborar</span></a></li>
							<li class='last'><a href='/mant/plantilla.do'><span>Edici&#243n / Eliminaci&#243n</span></a></li>
						</ul>
					</li>

	<%}%>

					<li class='/mant/beneficiarios.do'><a href='#'><span>Gesti&#243n de Beneficiarios</span></a></li>
					<li class=''><a href='/consultaAprovados.do'><span>Beneficiarios Aprobados</span></a></li>
					<li class=''><a href='/trans/activity/seleccion.do'><span>Actividad de Transferencias</span></a></li>

				</ul>

			<li class='has-sub'><a href='#'><span>Helm Compensaci&#243n</span></a>
				<ul>
					<li class='has-sub'><a href='/internet/servicios/seleccionso.jsp?prod=DP'><span>Declaraci&#243n de Cambio</span></a>
						<ul>

	<% if ("60".equals(roleCompensacion)
		||"65".equals(roleCompensacion)
		||"70".equals(roleCompensacion)){%>
							<li class='has-sub'><a href='#'><span>Elaborar</span></a>
								<ul>
									<li><a href="/mant/cuenta.do"><span>Movimientos</span></a></li>
									<li><a href="/mant/cuenta1.do"><span>Sin Movimientos</span></a></li>
								</ul>
							</li>
							<li><a href="/mant/modificar.do"><span>Modificar Guardado Temporal / Pendiente de Aprobar</span></a></li>
	<%}%>
	<%}%>
							<li><a href="/seleccion/estado.do"><span>Consultar</span></a></li>
	<% if ("50".equals(roleCompensacion)
			||"70".equals(roleCompensacion)){%>
							<li><a href="/compensacion/aceptacion.do"><span>Aprobar</span></a></li>
							<li><a href="/consulta/busqueda/documentos/formularios.do"><span>Consulta Documento Importanci&#243n/Exportaci&#243n</span></a></li>
	<%}%>
						</ul>
					</li>

	<% if ("60".equals(roleCompensacion)
	 	  ||"65".equals(roleCompensacion)
	 	  ||"70".equals(roleCompensacion)){%>

					<li class='has-sub'><a href='#'><span>Formulario 10 Relaci&#243n de Operaciones</span></a>
						<ul>
							<li><a href="/formulario10/mant/cuenta.do"><span>Elaborar</span></a></li>
							<li><a href="/formulario10/mant/modificar.do"><span>Modificar - Guardados Temporal</span></a></li>
							<li><a href="/formulario10/seleccion/estado.do"><span>Consultar</span></a></li>

		<% if ("60".equals(roleCompensacion)
			||"65".equals(roleCompensacion)){%>
						</ul>
					</li>
		<%}%>
	<%}%>
	<% if ("50".equals(roleCompensacion)
		||"70".equals(roleCompensacion)){%>

	<% if ("50".equals(roleCompensacion)){%>
					<li class='has-sub'><a href='#'><span>Formulario 10 Relaci&#243n de Operaciones</span></a>
						<ul>
	<%}%>
							<li><a href="/formulario10/compensacion/aceptacion.do"><span>Aprobar</span></a></li>
							<li><a href="/formulario10/mant/reproceso.do"><span>Reprocesar</span></a></li>
							<li><a href="/formulario10/generar/xml/consulta.do"><span>Generar XML Ban. Rep.</span></a></li>
						</ul>
					</li>
	<%}%>
					<li class='has-sub'><a href='#'><span>Reporte DIAN</span></a>
						<ul>
							<li><a href="#"><span>Preparar DIAN</span></a></li>
							<li><a href="#"><span>Consultar</span></a></li>
							<li><a href="#"><span>Generar XML</span></a></li>
							<li><a href="#"><span>Reproceso de XML</span></a></li>
							<li><a href="#"><span>Exportar Exccel</span></a></li>
							<li><a href="#"><span>Cambio de Fecha Legalizaci&#243n</span></a></li>
						</ul>
					</li>
					<li class='has-sub'><a href='/internet/servicios/seleccionso.jsp?prod=DP'><span>Reprocesos de Informes Anteriores</span></a>
						<ul>
							<li><a href="#"><span>Modificar- Formularios Aprobados</span></a></li>
							<li><a href="#"><span>Legalizaci&#243n de operaciones</span></a></li>
							<li><a href="#"><span>Modificar Legalizaci&#243</span></a></li>
							<li><a href="#"><span>Consultar</span></a></li>
						</ul>
					</li>

					<li class='has-sub'><a href='/internet/servicios/seleccionso.jsp?prod=DP'><span>Consultas</span></a>
						<ul>
							<li><a href="#"><span>CIIUs</span></a></li>
							<li><a href="#"><span>Ciudades</span></a></li>
							<li><a href="#"><span>Paises</span></a></li>
							<li><a href="#"><span>Nimerales Cambiarios</span></a></li>
							<li><a href="#"><span>Reglamentaciones</span></a></li>
						</ul>
					</li>

					<li class=''><a href='/internet/servicios/seleccionso.jsp?prod=DP'><span>Par&#225metros de la Cuenta</span></a>
					</li>

					<li class=''><a href='/internet/servicios/seleccionso.jsp?prod=DP'><span>Datos del Representante Legal</span></a>
					</li>

					<li class='has-sub'><a href='/internet/servicios/seleccionso.jsp?prod=DP'><span>Reporte</span></a>
						<ul>
							<li><a href="#"><span>Estadistico por Formulario y Numeral</span></a></li>
							<li><a href="#"><span>Reportes de Control</span></a></li>
						</ul>
					</li>
				</ul>
			</li>

			<li class='has-sub'><a href='#'><span>Multipagos</span></a>
				<ul>
					<li><a href="#"><span>Carga de Archivo</span></a></li>
					<li><a href="#"><span>Aprobar MultiPagos</span></a></li>
					<li><a href="#"><span>Consultar MultiPagos</span></a></li>
				</ul>
			</li>

			<li class='has-sub'><a href='#'><span>Ayuda</span></a>
				<ul>
					<li><a href="http://get.adobe.com/es/reader/"><span>Descargar Adobe Reader</span></a></li>
					<li><a href="/ayuda/descargar_carga_masiva.jsp?titul=VD"><span>Instalador Carga Masiva</span></a></li>
					<li><a href="/ayuda/acuerdos_formularios.jsp?titul=AF"><span>Acuerdos y Formularios</span></a></li>
					<li><a href="https://www.grupohelm.com/personal/negocios-internacionales/reglamentacion-cambiaria"><span>Estatuto Cambiario</span></a></li>
					<li><a href="/ayuda/consseguridad.jsp"><span>Consejos de Seguridad</span></a></li>
					<li><a href="/ayuda/video_demo.jsp?titul=VD"><span>Video Demo</span></a></li>
				</ul>
			</li>
			<li class='last'><a href='#'><span>Administraci&#243n</span></a></li>
			<li class='last'><a href='#'><span>Salir</span></a></li>
		</ul>
	</div>
</nav>

 <%}   else {%>
  <div>no debe ser ejecutado</div>
 <%} %>

			<br>

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














<div id="printHeader1" style="display:visible;">
<table id="Table_01" width="100%" border="0" cellpadding="0" cellspacing="0">

  

 
 <tr valign="top">
		<td colspan="2" width="100%" align="right" height="6">
		<table cellpadding="2" cellspacing="2">
			<tr valign="top">
		<!-- td width="130" valign="top">
	<table width="100%" height="14" bgcolor="#EFEFEF" cellpadding="0" cellspacing="0" style="cursor:pointer">
  		<tr valign="top"><td align="left"> 
  			<script src="<html:rewrite page='/scripts/mensajeriaMenu.js'/>"></script></td></tr></table>
	</td-->
  		<td><span class="mnuSeparador">&nbsp;</span></td>
  		<td width="190" align="center">
  <table width="100%" height="18" bgcolor="#EFEFEF" cellpadding="0" cellspacing="0" style="cursor:pointer">
  <tr>
  <td>
  

  <script>
  function openwin(url)
  {
  	nwin=window.open(url, "nwin",config="width=500,height=375,scrollbars=yes,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no,");
  	nwin.focus();
  }

  if(typeof(loc)=="undefined"||loc==""){var loc="";if(document.body&&document.body.innerHTML){var tt=document.body.innerHTML;var ml=tt.match(/["']([^'"]*)reporte.js["']/i);if(ml && ml.length > 1) loc=ml[1];}}
  										
  var bd=0
  document.write("<style type=\"text/css\">");
  document.write("\n<!--\n");
  document.write(".Administracion_menu {z-index:999;border-color:#EFEFEF;border-style:solid;border-width:"+bd+"px 0px "+bd+"px 0px;background-color:#ffffff;position:absolute;left:0px;top:0px;visibility:hidden;}");
  document.write(".reporte_plain, a.reporte_plain:link, a.reporte_plain:visited{text-align:left;background-color:#EFEFEF;color:#E96B10;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:2px 0px 2px 0px;cursor:hand;display:block;font-size:8pt;font-family:Arial, Helvetica, sans-serif;}");
  document.write("a.reporte_plain:hover, a.reporte_plain:active{background-color:#E9C29D;color:#000000;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:2px 0px 2px 0px;cursor:hand;display:block;font-size:8pt;font-family:Arial, Helvetica, sans-serif;}");
  document.write("a.reporte_l:link, a.reporte_l:visited{text-align:left;background:#ffffff url(<html:rewrite page='/images/reporte_l.gif'/>) no-repeat right;color:#E96B10;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:2px 0px 2px 0px;cursor:hand;display:block;font-size:8pt;font-family:Arial, Helvetica, sans-serif;}");
  document.write("a.reporte_l:hover, a.reporte_l:active{background:#c3c3c3 url(<html:rewrite page='/images/reporte_l2.gif'/>) no-repeat right;color: #000000;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:2px 0px 2px 0px;cursor:hand;display:block;font-size:8pt;font-family:Arial, Helvetica, sans-serif;}");
  document.write("\n-->\n");
  document.write("</style>");

  var fc=0x000000;
  var bc=0xc3c3c3;
  if(typeof(frames)=="undefined"){var frames=0;}
  			
  startMainMenu("",0,0,2,0,0)
  mainMenuItem("sub2","<bean:message key='lbl.administration'/>",18,180,"javascript:;","","Mensajeria Interna ",2,2,"reporte_plain");
  endMainMenu("",0,0);

  startSubmenu("sub2","Administracion_menu",220);
  submenuItem("<bean:message key='lbl.mnu.cambio.clave'/>","<html:rewrite page='/ib/cambioClave.jsp'/>","","reporte_plain");
  submenuItem("<bean:message key='lbl.mnu.cambio.imagen'/>","<html:rewrite page='/mant/AdminIMG.jsp'/>","","reporte_plain");
 
  <%if ("50".equals(userInfo.getRole()) ||"70".equals(userInfo.getRole())){
		String keyCambioPin ="";
			 
		if(session.getAttribute("tieneToken").toString().equals("S"))		 
		 {
		%>	
			submenuItem("<bean:message key='lbl.mnu.sincronizar.token'/>","<html:rewrite page='/token/sincronizarToken.jsp'/>","","reporte_plain");
			submenuItem("<bean:message key='lbl.mnu.cambio.pin'/>","<html:rewrite page='/token/cambioPIN.jsp'/>","","reporte_plain");
		<%		
		 }
		else if(session.getAttribute("tieneToken").toString().equals("N"))
		{
			%>
			submenuItem("<bean:message key='lbl.mnu.cambio.firma'/>","<html:rewrite page='/ib/cambioClaveEspecial.jsp'/>","","reporte_plain");
			<%
		}
	%>
		 
		 submenuItem("<bean:message key='lbl.mnu.preguntas.seguridad'/>","<html:rewrite page='/preguntas.jsp?admpregsec=true'/>","","reporte_plain");
         //submenuItem("<bean:message key='lbl.mnu.preguntas.seguridad'/>","<html:rewrite page='/mant/pregsecretas.jsp'/>","","reporte_plain");
         submenuItem("<bean:message key='lbl.mnu.admin.usuarios'/>","<html:rewrite page='/mant/users.jsp'/>","","reporte_plain");
 		   <%}%>
  submenuItem("<bean:message key='lb.menu.administracion.datos.usuario'/>","<html:rewrite page='/cargaInformacion.do'/>?pantalla=carga","","reporte_plain");		   
  endSubmenu("sub2");

  </script>
  </td>
  </tr>
  </table>
     </td>
     <td width="50">
     <span class="mnuSeparador">&nbsp;</span><span class="mnuItem">&nbsp;<a class="mnu" href="<html:rewrite page='/logout.jsp'/>"><bean:message key="mnu.salir"/></a>&nbsp;</span>&nbsp;
     </td>
   </tr>
   </table></td>
   </tr>
   <tr>
    <td height="16" colspan="2" align="right" ><div class="bienvenida"></div></td>
 </tr>
  </table>
</div>


                   </body>
                
                </html>

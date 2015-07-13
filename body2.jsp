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
String width="115";
if (!"".equals(roleCompensacion)){
	width = "145";
}

String permiteDescarga1 = (String)session.getAttribute("permite.descarga");
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

menu1=[				// This is the array that contains your menu properties and details
140,				// Top
2,				// left
<%=width%>,			    	// Width
1,				// Border Width
"left", 			// Screen Position - here you can use "center;middle;right"
propini,			// Properties Array - this is set higher up, as above
1,				// Always Visible - allows the menu item to be visible at all time
"center",		        // Alignment - sets the menu elements alignment, HTML values are valid here for example: left, right or center
effect,				// Filter - Text variable for setting transitional effects on menu activation
,				// Follow Scrolling - Tells the menu item to follow the user down the screen
1, 				// Horizontal Menu - Tells the menu to be horizontal instead of top to bottom style
,				// Keep Alive - Keeps the menu visible until the user moves over another menu or clicks elsewhere on the page
,				// Position of sub image left:center:right:middle:top:bottom
1,				// Show an image on top menu bars indicating a sub menu exists below
,				// Reserved for future use
// "Description Text", "URL", "Alternate URL", "Status", "Separator Bar"
"<bean:message key="mnu.cuentas"/>", "show-menu2",,"<bean:message key="mnu.cuentas"/>", 1,
"<bean:message key="mnu.inversiones"/>", "show-menu3",,"<bean:message key="mnu.inversiones"/>", 1,

<%if ("50".equals(userInfo.getRole())
        ||"60".equals(userInfo.getRole())
		||"65".equals(userInfo.getRole())
        ||"70".equals(userInfo.getRole())){%>	
"<bean:message key="mnu.transferencias"/>", "show-menu4",,"<bean:message key="mnu.transferencias"/>", 1
<%if (!"".equals(roleCompensacion)){%>
	,"<bean:message key="lbl.compensacion.menu.helm.compensacion"/>","show-menu6",,"<bean:message key="lbl.compensacion.menu.helm.compensacion"/>",1
<%}%>

<%}else{%>
"<bean:message key="mnu.transferencias"/>", "<html:rewrite page='/ib/construction.jsp'/>",,"<bean:message key="mnu.transferencias"/>", 1
<%if (!"".equals(roleCompensacion)){%>
	,"<bean:message key="lbl.compensacion.menu.helm.compensacion"/>","show-menu6",,"<bean:message key="lbl.compensacion.menu.helm.compensacion"/>",1
	
<%}%><%}%>
,"<bean:message key="mnu.ayuda"/>","show-menu5",,"<bean:message key="mnu.ayuda"/>",1
]


menu2=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="mnu.consulta.saldos"/>","<html:rewrite page='/servicios/seleccion.jsp?prod=CC'/>",,"<bean:message key="mnu.consulta.saldos"/>",1, 
"<bean:message key="mnu.consulta.movimiento"/>","<html:rewrite page='/servicios/movimiento.jsp?prod=CC'/>",,"<bean:message key="mnu.consulta.movimiento"/>",1,
"<bean:message key="mnu.estado.cuenta"/>","<html:rewrite page='/servicios/estadocta.jsp?prod=CC'/>",,"<bean:message key="mnu.estado.cuenta"/>",1,
"Mensajes SWIFT","<html:rewrite page='/mensaje/swift.do'/>",,"Mensajes SWIFT",1
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
,"<bean:message key="lbl.transf.inter.plantilla"/>","<html:rewrite page='/mant/plantilla.do'/>",,"<bean:message key="lbl.transf.inter.plantilla"/>",1

<%}%>
]
menu5=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="mnu.video.demo"/>","<html:rewrite page='/ayuda/video_demo.jsp?titul=VD'/>",,"<bean:message key="mnu.video.demo"/>",1,
"Descargar Adobe Reader 8.1.2","<html:rewrite page='/ayuda/descargar_adobe.jsp?titul=VD'/>",,"Descargar Adobe Reader 8.1.2",1,
"<bean:message key="lbl.estatuto.cambiario"/>","https://www.grupohelm.com/personal/negocios-internacionales/reglamentacion-cambiaria",,"<bean:message key="lbl.estatuto.cambiario"/>",1
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
"Control de Vencimiento de Importación y Exportación","show-menu14",,"Control de Vencimiento de Importación y Exportación",1,
"<bean:message key="lbl.compensacion.parametro.reporte"/>","show-menu13",,"<bean:message key="lbl.compensacion.parametro.reporte"/>",1
]
menu7=[,,215,1,"",prop1,,"left",effect,,,,,,,
<%
if ("60".equals(roleCompensacion)
	  ||"65".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)){%>
"<bean:message key="lbl.compensacion.menu.elaborar"/>","show-menu11",,"<bean:message key="lbl.compensacion.menu.elaborar"/>",1,
"<bean:message key="lbl.compensacion.menu.modificar"/>","<html:rewrite page='/mant/modificar.do'/>",,"<bean:message key="lbl.compensacion.menu.modificar"/>",1,
<%}%>
"<bean:message key="lbl.compensacion.menu.consultar"/>","<html:rewrite page='/seleccion/estado.do'/>",,"<bean:message key="lbl.compensacion.menu.consultar"/>",1
<%
if ("50".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)){%>
,"<bean:message key="lbl.compensacion.menu.aprobar"/>","<html:rewrite page='/compensacion/aceptacion.do'/>",,"<bean:message key="lbl.compensacion.menu.aprobar"/>",1
<%}%>

]
menu8=[,,215,1,"",prop1,,"left",effect,,,,,,,
<%
if ("60".equals(roleCompensacion)
	  ||"65".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)){%>
"<bean:message key="lbl.compensacion.menu.elaborar"/>","<html:rewrite page='/formulario10/mant/cuenta.do'/>",,"<bean:message key="lbl.compensacion.menu.elaborar"/>",1,
"<bean:message key="lbl.compensacion.menu.modificar"/>","<html:rewrite page='/formulario10/mant/modificar.do'/>",,"<bean:message key="lbl.compensacion.menu.modificar"/>",1,
<%}%>
"<bean:message key="lbl.compensacion.menu.consultar"/>","<html:rewrite page='/formulario10/seleccion/estado.do'/>",,"<bean:message key="lbl.compensacion.menu.consultar"/>",1
<%
if ("50".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)){%>
,"<bean:message key="lbl.compensacion.menu.aprobar"/>","<html:rewrite page='/formulario10/compensacion/aceptacion.do'/>",,"<bean:message key="lbl.compensacion.menu.aprobar"/>",1
,"Reprocesar","<html:rewrite page='/formulario10/mant/reproceso.do'/>",,"Reprocesar",1
<%}%>

]
menu9=[,,215,1,"",prop1,,"left",effect,,,,,,,
<%
if ("60".equals(roleCompensacion)
	  ||"65".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)){%>
"<bean:message key="lbl.compensacion.menu.elaborar"/>","<html:rewrite page='/dian/elaborar/seleccion.do'/>",,"<bean:message key="lbl.compensacion.menu.elaborar"/>",1,

<%}%>
"<bean:message key="lbl.compensacion.menu.consultar"/>","<html:rewrite page='/dian/consultar/seleccion.do'/>",,"<bean:message key="lbl.compensacion.menu.consultar"/>",1
<%
if ("50".equals(roleCompensacion)
	  ||"70".equals(roleCompensacion)
	  ||"60".equals(roleCompensacion)){%>
,"<bean:message key="lbl.compensacion.menu.aprobar"/>","<html:rewrite page='/dian/aprobar/aceptacion.do'/>",,"<bean:message key="lbl.compensacion.menu.aprobar"/>",1
<%}%>
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
]
menu10=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.compensacion.menu.ciiu"/>","http://www.bancodecredito.com.co/generador/hfsnuevo/html/cambios/codigos.htm target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.ciiu"/>",1,
"<bean:message key="lbl.compensacion.menu.ciudades"/>","http://www.bancodecredito.com.co/generador/hfsnuevo/html/cambios/ciudades.htm target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.ciudades"/>",1,
"<bean:message key="lbl.compensacion.menu.paises"/>","http://www.bancodecredito.com.co/generador/hfsnuevo/html/cambios/paises.htm target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.paises"/>",1,
"<bean:message key="lbl.compensacion.menu.numeral.cambiario"/>","http://www.bancodecredito.com.co/generador/hfsnuevo/herramientas/hts_cambios_int.jsp target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.numeral.cambiario"/>",1,
"<bean:message key="lbl.compensacion.menu.reglamentaciones"/>","http://www.bancodecredito.com.co/generador/hfsnuevo/herramientas/hts_cambios_int.jsp target=\"NEW\"",,"<bean:message key="lbl.compensacion.menu.reglamentaciones"/>",1
]

menu11=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.compensacion.menu.movimientos.asociados"/>","<html:rewrite page='/mant/cuenta.do'/>",,"<bean:message key="lbl.compensacion.menu.movimientos.asociados"/>",1,
"<bean:message key="lbl.compensacion.menu.movimientos.no.asociados"/>","<html:rewrite page='/mant/cuenta1.do'/>",,"<bean:message key="lbl.compensacion.menu.movimientos.no.asociados"/>",1
]

menu12=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.compensacion.menu.reprocesar"/>","<html:rewrite page='/mant/reprocesar.do'/>",,"<bean:message key="lbl.compensacion.menu.reprocesar"/>",1,
"Legalización de Operaciones","<html:rewrite page='/selec/legalizaciones.do'/>",,"Legalización de Operaciones",1,
"<bean:message key="lbl.compensacion.menu.consultar"/>","<html:rewrite page='/mant/reprocesar1.do'/>",,"<bean:message key="lbl.compensacion.menu.consultar"/>",1

]
menu13=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="lbl.compensacion.movimiento.titulo.estadistica"/>","<html:rewrite page='/est/seleccion.do'/>",,"<bean:message key="lbl.compensacion.movimiento.titulo.estadistica"/>",1,
"Reportes de Control","<html:rewrite page='/est/seleccion/control.do'/>",,"Reportes de Control",1 

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


</script>
<!--script language="javascript">
function __pageLoad2(){
	if (__init){
		__init();
	}
}
</script-->
<% 
String ipAddress = request.getHeader("X-FORWARDED-FOR"); 
if ( ipAddress == null  )
{  ipAddress =  request.getRemoteAddr(); }

%>

<script src="<html:rewrite page='/scripts/DV.js'/>" type="text/javascript"></script>

<script type="text/javascript">
//Define your images using arbitrary variables, to be passed in as arguments later down the page:
var usersecurity = 	'<img src="<html:rewrite page='/do.GetImage'/>" width="270px" height="270px" border="0" alt="">'
</script>



<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/teclado.css'/>">
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

</HEAD>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="reset(); ">

<script language="JavaScript">
      urlBase= "<html:rewrite page='/logout.jsp'/>";
      ar[0] = "User ID: <%=session.getAttribute("user.id")%>      Cliente: <%=nombreCliente%>     ip=<%=ipAddress%>";
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
	<td style="Padding:12px;cursor:default;Font-Size:11px;white-space:nowrap;font-family:Arial;font-size:11px;"> 
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
  <tr height="10"> 
    <td width="100%" height="10" ><br>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="160" align="center" > 
						<img onclick="dv.showDV(usersecurity); return false" src='<html:rewrite page="/do.GetImage"/>'  style=" width : 90px; height : 90px;" >
				</td>
				<td width="1%"></td>
			<td width="98%" height="100">
				<table width="100%" >
					<tr><td><a class="mnu"><bean:message key="lbl.IP_Actual"/> :<%=session.getAttribute("IP.adress")%></a><br/></td></tr>
					<tr><td><a class="mnu"><bean:message key="lbl.Ultima_Transferencia"/> :  <common:UltimaTransaccion></common:UltimaTransaccion></a><br/></td></tr>
					<tr><td><a class="mnu"><bean:message key="lbl.ultimo.acceso"/> <common:fecha-acceso/></a><br/></td></tr>
				</table> 
			</td>  
			<td> 
				<img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/>
			</td></tr>
		</table>
			<br></td>
    <td>&nbsp;</td>
    
  </tr>
  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="width:254;height:26;background-color:#EFEFEF;"><div  class="bienvenida"></div></td>
  </tr>
  <tr valign="top">
		<td colspan="2" width="100%" align="right" height="6">
		<table cellpadding="2" cellspacing="2">
		<tr valign="top">
	<!-- <td>		
	    <span class="mnuSeparador">&nbsp;</span><span class="mnuItem" style="margin-top:2px;">&nbsp;<a class="mnu" style="margin-top:2px;" href="<html:rewrite page='/ib/calculo.jsp'/>"><bean:message key="lbl.general.simule.su.credito"/></a>&nbsp;</span>		
  		</td>
  		-->
  		<td><span class="mnuSeparador">&nbsp;</span></td>
  		<td width="202" valign="top">
  <table width="100%" height="18" bgcolor="#EFEFEF" cellpadding="0" cellspacing="0" style="cursor:pointer">
  		<tr valign="top"><td>
  <script language="JavaScript">
      //Link[nr] = "position [0 is menu/1 is item],Link name,url,target (blank|top|frame_name)"
  var Link = new Array();
  Link[0] = "0|"+ '<bean:message key="lbl.administration"/>';
  Link[1] = "1|"+ '<bean:message key="lbl.mnu.cambio.clave"/>'+"|<html:rewrite page='/ib/cambioClave.jsp'/>|";
  Link[2] = "1|"+ '<bean:message key="lbl.mnu.cambio.firma"/>'+"|<html:rewrite page='/ib/cambioClaveEspecial.jsp'/>|";
  Link[3] = "1|"+ '<bean:message key="lbl.mnu.cambio.imagen"/>'+"|<html:rewrite page='/mant/users.jsp'/>|";
  Link[4] = "1|"+ '<bean:message key="lbl.mnu.preguntas.seguridad"/>'+"|<html:rewrite page='/mant/pregsecretas.jsp'/>|";
  Link[5] = "1|"+ '<bean:message key="lbl.mnu.consejos.seguridad"/>||';    
  startup(4);
  </script></td></tr></table>
     </td>
     <td>
     <span class="mnuSeparador">&nbsp;</span><span class="mnuItem">&nbsp;<a class="mnu" href="<html:rewrite page='/logout.jsp'/>"><bean:message key="mnu.salir"/></a>&nbsp;</span>&nbsp;
     </td>
   </tr>
   </table></td>
   <tr>
    <td height="16" colspan="2" align="right" ><div class="bienvenida"></div></td>
 </tr>
  </table>

  
</div>
  
<table id="Table_01" border="0"  width="100%" border="0" cellpadding="0" cellspacing="0">
<tr valign="top"> 
    <td colspan="4" align="left">
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr valign="top"> 
          <td height="300" align="center">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr valign="top"> 
                <td align="center">
                

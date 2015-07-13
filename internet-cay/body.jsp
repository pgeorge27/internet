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
<%@ page import="com.arango.common.services.ManagerBean"%>
<%@ page import="com.arango.common.services.GrupoCSICBean"%>

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
ManagerBean mb 		  = new ManagerBean();
//Crea el objeto UserInfo
UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext()); 
boolean aprobador = "70".equals(userInfo.getRole())||"50".equals(userInfo.getRole());
boolean custodiaNuevo = false; 

ArrayList usuarios = (new GrupoCSICBean().getUsuarioByGrupo(userInfo.getEmpresa(),userInfo.getClienteCSIC()));

   for(int i = 0; i < usuarios.size(); i++)
   {
	   com.arango.common.beans.Usuario usuario = (com.arango.common.beans.Usuario)usuarios.get(i);
 		  if (userInfo.getUserId().equals(usuario.getUsuarioGrupo().getUserId())){
 			 custodiaNuevo = usuario.getUsuarioGrupo().isCustodia();
 			 break;
 		  }
   }

/*
boolean custodiaNuevo = false;	
if(userInfo.getUserId().equals("202928"))
{
	custodiaNuevo = true;
}
else
{
	custodiaNuevo = false;
}
*/
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
115,			    	// Width
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
        ||"65".equals(userInfo.getRole())
        ||"60".equals(userInfo.getRole())
        ||"70".equals(userInfo.getRole())){%>	
"<bean:message key="mnu.transferencias"/>", "show-menu4",,"<bean:message key="mnu.transferencias"/>", 1,
<%}else{%>
"<bean:message key="mnu.transferencias"/>", "<html:rewrite page='/ib/construction.jsp'/>",,"<bean:message key="mnu.transferencias"/>", 1,
<%}%>
<%if (custodiaNuevo == true){%>	
"Helm Custodia","show-menu6",,"Helm Custodia",1,
<%}%>
"<bean:message key="mnu.ayuda"/>","show-menu5",,"<bean:message key="mnu.ayuda"/>",1
]


menu2=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="mnu.consulta.saldos"/>","<html:rewrite page='/servicios/seleccion.jsp?prod=CC'/>",,"<bean:message key="mnu.consulta.saldos"/>",1, 
"<bean:message key="mnu.consulta.movimiento"/>","<html:rewrite page='/servicios/movimiento.jsp?prod=CC'/>",,"<bean:message key="mnu.consulta.movimiento"/>",1,
"<bean:message key="mnu.estado.cuenta"/>","<html:rewrite page='/servicios/estadocta.jsp?prod=CC'/>",,"<bean:message key="mnu.estado.cuenta"/>",1
]

menu3=[,,215,1,"",prop1,,"left",effect,,,,,,,
       "<bean:message key="mnu.deposito.plazo"/>","<html:rewrite page='/servicios/seleccionso.jsp?prod=DP'/>",,"<bean:message key="mnu.deposito.plazo"/>",1
	   <%if (custodiaNuevo == false){%>	
       ,"Helm Custodia","<html:rewrite page='/custodia/seleccion.do'/>",,"Helm Custodia",1
	   <%}%>
       ]

menu4=[,,270,1,"",prop1,,"left",effect,,,,,,,
<%if ("60".equals(userInfo.getRole())
        ||"65".equals(userInfo.getRole())
	  ||"70".equals(userInfo.getRole())){%>
	"<bean:message key="mnu.preparacion"/>","<html:rewrite page='/transfer.do?mode=create'/>",,"<bean:message key="mnu.preparacion"/>",1,
	"<bean:message key="mnu.modificacion"/>","<html:rewrite page='/servicios/modificacion.jsp'/>",,"<bean:message key="mnu.modificacion"/>",1,
<%}%>
"<bean:message key="mnu.consulta.transferencia"/>","<html:rewrite page='/servicios/transferencias.jsp'/>",,"<bean:message key="mnu.consulta.transferencia"/>",1
<% if (aprobador){
    session.setAttribute("mostrar.mensaje.clave.especial", "true");
%>
,"<bean:message key="mnu.aprobacion"/>","<html:rewrite page='/transferencias/clave.jsp'/>",,"<bean:message key="mnu.aprobacion"/>",1
<%}%>
<%if ("60".equals(userInfo.getRole())
	  ||"65".equals(userInfo.getRole())
	  ||"70".equals(userInfo.getRole())){%>
,"<bean:message key="lbl.transf.inter.plantilla"/>","<html:rewrite page='/mant/plantilla.do'/>",,"<bean:message key="lbl.transf.inter.plantilla"/>",1

<%}%>

<% 
String tieneTok = (String) session.getAttribute("tieneToken");
if(tieneTok.equals("S")){ %>
,"<bean:message key="lbl.beneficiarios.aprobados.menu"/>","<html:rewrite page='/consultaAprovados.do'/>",,"<bean:message key="lbl.beneficiarios.aprobados.menu"/>",1
<% }%>
]

menu5=[,,215,1,"",prop1,,"left",effect,,,,,,,
"<bean:message key="mnu.acuerdos.formularios"/>","<html:rewrite page='/ayuda/acuerdo_formulario.jsp?titul=AF'/>",,"<bean:message key="mnu.acuerdos.formularios"/>",1
]


menu6=[,,215,1,"",prop1,,"left",effect,,,,,,,
//        "<bean:message key="mnu.custodia.resumen"/>","<html:rewrite page='/custodia/ResumenProducto.jsp'/>",,"<bean:message key="mnu.custodia.resumen"/>",1,
//        "<bean:message key="mnu.custodia.actividad"/>","<html:rewrite page='/custodia/ActividadCuenta.jsp'/>",,"<bean:message key="mnu.custodia.actividad"/>",1,
//        "<bean:message key="mnu.custodia.extracto"/>","<html:rewrite page='/custodia/Extracto.jsp'/>",,"<bean:message key="mnu.custodia.extracto"/>",1
       
       "<bean:message key="mnu.custodia.resumen"/>","<html:rewrite page='/custodia/seleccion.do?page=resumen'/>",,"<bean:message key="mnu.custodia.resumen"/>",1,
       "<bean:message key="mnu.custodia.actividad"/>","<html:rewrite page='/custodia/seleccion.do?page=actividad'/>",,"<bean:message key="mnu.custodia.actividad"/>",1,
       "<bean:message key="mnu.custodia.extracto"/>","<html:rewrite page='/custodia/seleccion.do?page=extracto'/>",,"<bean:message key="mnu.custodia.extracto"/>",1,
       "<bean:message key="mnu.custodia.novedades"/>","<html:rewrite page='/custodia/Novedades.jsp'/>",,"<bean:message key="mnu.custodia.novedades"/>",1

]

</script>
<script language="javascript">
function __pageLoad2(){
	if (__init){
		__init();
	}
}
</script>

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
	<td style="Padding:12px;cursor:default;Font-Size:11px;white-space:nowrap;font-family:Arial;font-size:11px;"></td> 
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
		<td>
	<table width="100%" height="18" bgcolor="#EFEFEF" cellpadding="0" cellspacing="0" style="cursor:pointer">
  		<tr valign="top"><td>
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

  </script></td></tr></table>
     </td>
     <td>
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
  
<table id="Table_02" border="0"  width="100%" border="0" cellpadding="0" cellspacing="0">
<tr valign="top"> 
    <td colspan="4" align="left">
		<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr valign="top"> 
          <td height="300" align="center">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr valign="top"> 
                <td align="center">
                

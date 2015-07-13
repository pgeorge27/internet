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
document.write(".reporte_menu {z-index:999;border-color:#000000;border-style:solid;border-width:"+bd+"px 0px "+bd+"px 0px;background-color:#ffffff;position:absolute;left:0px;top:0px;visibility:hidden;}");
document.write(".reporte_plain, a.reporte_plain:link, a.reporte_plain:visited{text-align:left;background-color:#ffffff;color:#E96B10;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:2px 0px 2px 0px;cursor:hand;display:block;font-size:8pt;font-family:Arial, Helvetica, sans-serif;}");
document.write("a.reporte_plain:hover, a.reporte_plain:active{background-color:#c3c3c3;color:#000000;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:2px 0px 2px 0px;cursor:hand;display:block;font-size:8pt;font-family:Arial, Helvetica, sans-serif;}");
document.write("a.reporte_l:link, a.reporte_l:visited{text-align:left;background:#ffffff url(<html:rewrite page='/images/reporte_l.gif'/>) no-repeat right;color:#E96B10;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:2px 0px 2px 0px;cursor:hand;display:block;font-size:8pt;font-family:Arial, Helvetica, sans-serif;}");
document.write("a.reporte_l:hover, a.reporte_l:active{background:#c3c3c3 url(<html:rewrite page='/images/reporte_l2.gif'/>) no-repeat right;color: #000000;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:2px 0px 2px 0px;cursor:hand;display:block;font-size:8pt;font-family:Arial, Helvetica, sans-serif;}");
document.write("\n-->\n");
document.write("</style>");

var fc=0x000000;
var bc=0xc3c3c3;
										if(typeof(frames)=="undefined"){var frames=0;}
<%
	if (selected.equals("consultas"))
	{
%>
										startMainMenu("",0,0,2,0,0)
										mainMenuItem("","Consultas",18,80,"<html:rewrite page='/servicios/seleccion.jsp?prod=CC'/>","","Consultas",2,2,"reporte_plain");
										mainMenuItem("","Movimientos",18,85,"<html:rewrite page='/servicios/movimiento.jsp?prod=CC'/>","","Movimientos",2,2,"reporte_plain");
										mainMenuItem("","Estados de Cuenta",18,120,"<html:rewrite page='/servicios/estadocta.jsp?prod=CC'/>","","Estados de Cuenta",2,2,"reporte_plain");
										endMainMenu("",0,0);
<%
	}
	if (selected.equals("transfer"))
	{	
%>
startMainMenu("",0,0,2,0,0)
mainMenuItem("","Preparaci&oacute;n",18,80,"<html:rewrite page='/transfer.do?mode=create'/>","","Consultas",2,2,"reporte_plain");
mainMenuItem("","Modificaci&oacute;n",18,85,"<html:rewrite page='/servicios/modificacion.jsp'/>","","Movimientos",2,2,"reporte_plain");
mainMenuItem("","Consulta",18,70,"<html:rewrite page='/servicios/transferencias.jsp'/>","","Consulta",2,2,"reporte_plain");
mainMenuItem("","Autorizaci&oacute;n/Modificaci&oacute;n/Cancelaci&oacute;n",18,225,"<html:rewrite page='/transferencias/clave.jsp'/>","","Estados de Cuenta",2,2,"reporte_plain");
mainMenuItem("","Plantillas",18,60,"<html:rewrite page='/mant/plantilla.do'/>","","Plantillas",2,2,"reporte_plain");
endMainMenu("",0,0);

<%
	}
	if (selected.equals("compensacion"))
	{	
%>
startMainMenu("",0,0,2,1,0)
mainMenuItem("sub1","Declaración de Cambio",18,140,"javascript:;","","Declaración de Cambio",2,0,"reporte_plain");
mainMenuItem("sub2","Formulario 10",18,90,"javascript:;","","Formulario 10",2,2,"reporte_plain");
mainMenuItem("sub3","Reporte DIAN",18,90,"javascript:;","","Reporte DIAN",2,2,"reporte_plain");
mainMenuItem("sub4","Reprocesos",18,90,"javascript:;","","Reprocesos",2,2,"reporte_plain");
mainMenuItem("sub5","Consultas",18,70,"javascript:;","","Consultas",2,2,"reporte_plain");
mainMenuItem("","Parámetros",18,79,"<html:rewrite page='/mant/parametro.do'/>","","Parámetros",2,2,"reporte_plain");
mainMenuItem("","Datos del Rep.",18,100,"<html:rewrite page='/mant/representante.do'/>","","Datos del Representante",2,2,"reporte_plain");
mainMenuItem("sub6","Control de Venc.",18,115,"javascript:;","","Control de Vencimiento",2,2,"reporte_plain");
mainMenuItem("","Reporte",18,79,"<html:rewrite page='/est/seleccion/control.do'/>","","Reporte",2,2,"reporte_plain");
endMainMenu("",0,0);


startSubmenu("sub1","reporte_menu",140);
mainMenuItem("sub1_1","Elaborar",0,0,"javascript:;","","",1,1,"reporte_l");
submenuItem("Modificar","<html:rewrite page='/mant/modificar.do'/>","","reporte_plain");
submenuItem("Consultar","<html:rewrite page='/seleccion/estado.do'/>","","reporte_plain");
submenuItem("Aprobar","<html:rewrite page='/compensacion/aceptacion.do'/>","","reporte_plain");
endSubmenu("sub1");

startSubmenu("sub1_1","reporte_menu",120);
submenuItem("Movimientos","<html:rewrite page='/mant/cuenta.do'/>","","reporte_plain");
submenuItem("Sin Movimientos","<html:rewrite page='/mant/cuenta1.do'/>","","reporte_plain");
endSubmenu("sub1_1");

startSubmenu("sub2","reporte_menu",73);
submenuItem("Elaborar","<html:rewrite page='/formulario10/mant/cuenta.do'/>","","reporte_plain");
submenuItem("Modificar","<html:rewrite page='/formulario10/mant/modificar.do'/>","","reporte_plain");
submenuItem("Consultar","<html:rewrite page='/formulario10/seleccion/estado.do'/>","","reporte_plain");
submenuItem("Aprobar","<html:rewrite page='/formulario10/compensacion/aceptacion.do'/>","","reporte_plain");
submenuItem("Reprocesar","<html:rewrite page='/formulario10/mant/reproceso.do'/>","","reporte_plain");
endSubmenu("sub2");

startSubmenu("sub3","reporte_menu",120);
submenuItem("Elaborar","<html:rewrite page='/dian/elaborar/seleccion.do'/>","","reporte_plain");
submenuItem("Consultar","<html:rewrite page='/dian/consultar/seleccion.do'/>","","reporte_plain");
submenuItem("Aprobar","<html:rewrite page='/dian/aprobar/aceptacion.do'/>","","reporte_plain");
submenuItem("Generar XML","<html:rewrite page='/dian/generar/seleccion.do'/>","","reporte_plain");
submenuItem("Reproceso de XML","<html:rewrite page='/dian/reproceso/seleccion.do'/>","","reporte_plain");
submenuItem("Exportar Excel","<html:rewrite page='/dian/exportar/seleccion.do'/>","","reporte_plain");
endSubmenu("sub3");

startSubmenu("sub4","reporte_menu",170);
submenuItem("Reprocesar","<html:rewrite page='/mant/reprocesar.do'/>","","reporte_plain");
submenuItem("Legalización de Operaciones","<html:rewrite page='/selec/legalizaciones.do'/>","","reporte_plain");
submenuItem("Consultar","<html:rewrite page='/mant/reprocesar1.do'/>","","reporte_plain");
endSubmenu("sub4");

startSubmenu("sub5","reporte_menu",150);
submenuItem("CIIU","javascript:openwin('https://www.bancodecredito.com/generador/hfsnuevo/html/cambios/codigos.htm');","","reporte_plain");
submenuItem("Ciudades","javascript:openwin('http://www.bancodecredito.com.co/generador/hfsnuevo/html/cambios/ciudades.htm');","","reporte_plain");
submenuItem("Países","javascript:openwin('http://www.bancodecredito.com.co/generador/hfsnuevo/html/cambios/paises.htm');","","reporte_plain");
submenuItem("Numerales Cambiarios","javascript:openwin('http://www.bancodecredito.com.co/generador/hfsnuevo/herramientas/hts_cambios_int.jsp');","","reporte_plain");
submenuItem("Reglamentaciones","javascript:openwin('http://www.bancodecredito.com.co/generador/hfsnuevo/herramientas/hts_cambios_int.jsp');","","reporte_plain");
endSubmenu("sub5");

startSubmenu("sub6","reporte_menu",220);
submenuItem("Información de Importación","<html:rewrite page='/vencimiento/insercion/importacion.do'/>","","reporte_plain");
submenuItem("Información de Exportación Ordinaria","<html:rewrite page='/vencimiento/insercion/exportacion/ordinaria.do'/>","","reporte_plain");
submenuItem("Información de Exportación Anticipada","<html:rewrite page='/vencimiento/insercion/exportacion/anticipada.do'/>","","reporte_plain");
submenuItem("Consultas","<html:rewrite page='/vencimiento/seleccion.do'/>","","reporte_plain");
submenuItem("Modificación","<html:rewrite page='/vencimiento/modificacion/seleccion.do'/>","","reporte_plain");
endSubmenu("sub6");


<%
	}
	if (selected.equals("administracion"))
	{	
%>
										startMainMenu("",0,0,2,0,0)
										mainMenuItem("","Cambiar Contrase&ntilde;a",18,125,"<html:rewrite page='/ib/cambioClave.jsp'/>","","Movimientos",2,2,"reporte_plain");
										mainMenuItem("","Cambiar Imagen",18,100,"<html:rewrite page='/mant/AdminIMG.jsp'/>","","Estados de Cuenta",2,2,"reporte_plain");
										mainMenuItem("","Administraci&oacute;n de Correos",18,160,"<html:rewrite page='/ib/adminEmail.jsp'/>","","Estados de Cuenta",2,2,"reporte_plain");	
										mainMenuItem("","Cambiar Clave Correo",18,130,"<html:rewrite page='/ib/cambioClaveCorreos.jsp'/>","","Estados de Cuenta",2,2,"reporte_plain");												
										<%
		                             	if (role.equals(ConstantesGlobales.ROLE_OPERADOR_AUTORIZADOR) || role.equals(ConstantesGlobales.ROLE_AUTORIZADOR))
		                             	{
		                             	%>
		                             	mainMenuItem("","Admin Usuarios",18,115,"<html:rewrite page='/mant/users.jsp'/>","","Movimientos",2,2,"reporte_plain");
										mainMenuItem("","Cambiar Firma Digital",18,130,"<html:rewrite page='/ib/cambioClaveEspecial.jsp'/>","","Estados de Cuenta",2,2,"reporte_plain");
										mainMenuItem("","Cambiar Preguntas",18,120,"<html:rewrite page='/mant/pregsecretas.jsp'/>","","Estados de Cuenta",2,2,"reporte_plain");
										<%
		                             	}
										%>
										
										endMainMenu("",0,0);

<%
	}
%>
<%

if (selected.equals("ayuda"))
{	
%>
									startMainMenu("",0,0,2,0,0)
									mainMenuItem("","Video Demo",18,115,"<html:rewrite page='/ayuda/video_demo.jsp?titul=VD'/>","","Video Demo",2,2,"reporte_plain");
									mainMenuItem("","Descargar Adobe Reader",18,165,"<html:rewrite page='/ayuda/descargar_adobe.jsp?titul=VD'/>","","Movimientos",2,2,"reporte_plain");
									mainMenuItem("","Estatuto Cambiario",18,130,"javascript:openwin('https://www.grupohelm.com/personal/negocios-internacionales/reglamentacion-cambiaria');","","Estados de Cuenta",2,2,"reporte_plain");
									mainMenuItem("","Consejos de seguridad",18,185,"<html:rewrite page='/ayuda/consseguridad.jsp'/>","","Movimientos",2,2,"reporte_plain");
									endMainMenu("",0,0);
<%
}
%>
<%

if (selected.equals("mensajes"))
{	
%>
									startMainMenu("",0,0,2,0,0)
									mainMenuItem("","Redactar",18,80,"<html:rewrite page='/mensajes/enviarMensaje.jsp'/>","","",2,2,"reporte_plain");
									mainMenuItem("","Bandeja de Entrada",18,135,"<html:rewrite page='/mensajes/bandeja.jsp'/>","","",2,2,"reporte_plain");
									mainMenuItem("","Mensajes Enviados",18,135,"<html:rewrite page='/do.mensajesbanco?tipo=CS&cantidad=2'/>","","",2,2,"reporte_plain");
									endMainMenu("",0,0);
<%
}
%>
loc="";
</script>
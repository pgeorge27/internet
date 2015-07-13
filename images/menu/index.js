 function openwin(url)
{
	nwin=window.open(url, "nwin",config="width=500,height=375,scrollbars=yes,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no,");
	nwin.focus();
}

if(typeof(loc)=="undefined"||loc==""){var loc="";if(document.body&&document.body.innerHTML){var tt=document.body.innerHTML;var ml=tt.match(/["']([^'"]*)index.js["']/i);if(ml && ml.length > 1) loc=ml[1];}}

var bd=0
document.write("<style type=\"text/css\">");
document.write("\n<!--\n");
document.write(".index_menu {z-index:999;border-color:#000000;border-style:solid;border-width:"+bd+"px 0px "+bd+"px 0px;background-color:#b8b2b2;position:absolute;left:0px;top:0px;visibility:hidden;}");
document.write(".index_plain, a.index_plain:link, a.index_plain:visited{text-align:left;background-color:#b8b2b2;color:#ffffff;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:3px 0px 3px 0px;cursor:hand;display:block;font-size:7pt;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold;}");
document.write("a.index_plain:hover, a.index_plain:active{background-color:#b8b2b2;color:#000000;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:3px 0px 3px 0px;cursor:hand;display:block;font-size:7pt;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold;}");
document.write("a.index_l:link, a.index_l:visited{text-align:left;background:#b8b2b2 url("+loc+"index_l.gif) no-repeat right;color:#ffffff;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:3px 0px 3px 0px;cursor:hand;display:block;font-size:7pt;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold;}");
document.write("a.index_l:hover, a.index_l:active{background:#b8b2b2 url("+loc+"index_l2.gif) no-repeat right;color: #000000;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:3px 0px 3px 0px;cursor:hand;display:block;font-size:7pt;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold;}");
document.write("\n-->\n");
document.write("</style>");

var fc=0x000000;
var bc=0xb8b2b2;
if(typeof(frames)=="undefined"){var frames=0;}

startMainMenu("index_left.png",29,23,2,0,0)
mainMenuItem("index_b1",".png",29,133,"javascript:;","","Consultas",2,2,"index_plain");
mainMenuItem("index_b2",".png",29,133,"javascript:;","","Inversiones",2,2,"index_plain");
if (50 == MENUR
        ||60 == MENUR
		||65 == MENUR
        ||70 == MENUR){
mainMenuItem("index_b3",".png",29,133,"javascript:;","","Helm Transfer",2,2,"index_plain");
}
if ("nop" != MENUCOMPE){
mainMenuItem("index_b4",".png",29,133,"javascript:;","","Helm Compensación",2,2,"index_plain");
}
mainMenuItem("index_b5",".png",29,133,"javascript:;","","Ayuda",2,2,"index_plain");
endMainMenu("index_right.png",29,23)

startSubmenu("index_b5","index_menu",134);
submenuItem("Video Demo",loc+"../../"+"ayuda/video_demo.jsp?titul=VD","","index_plain");
submenuItem("Descargar Adobe Reader",loc+"../../"+"ayuda/descargar_adobe.jsp?titul=VD","","index_plain");
submenuItem("Estatuto Cambiario","javascript:openwin('https://www.grupohelm.com/personal/negocios-internacionales/reglamentacion-cambiaria');","","index_plain");
endSubmenu("index_b5");

startSubmenu("index_b4_8","index_menu",207);
submenuItem("Información de Importación",loc+"../../"+"vencimiento/insercion/importacion.do","","index_plain");
submenuItem("Información de Exportación Ordinaria",loc+"../../"+"vencimiento/insercion/exportacion/ordinaria.do","","index_plain");
submenuItem("Información de Exportación Anticipada",loc+"../../"+"vencimiento/insercion/exportacion/anticipada.do","","index_plain");
submenuItem("Consultas",loc+"../../"+"vencimiento/seleccion.do","","index_plain");
submenuItem("Modificación",loc+"../../"+"vencimiento/modificacion/seleccion.do","","index_plain");
endSubmenu("index_b4_8");

startSubmenu("index_b4_5","index_menu",121);
submenuItem("CIIU","https://www.bancodecredito.com/generador/hfsnuevo/html/cambios/codigos.htm","","index_plain");
submenuItem("Ciudades","http://www.bancodecredito.com.co/generador/hfsnuevo/html/cambios/ciudades.htm","","index_plain");
submenuItem("Países","http://www.bancodecredito.com.co/generador/hfsnuevo/html/cambios/paises.htm","","index_plain");
submenuItem("Numerales Cambiarios","http://www.bancodecredito.com.co/generador/hfsnuevo/herramientas/hts_cambios_int.jsp","","index_plain");
submenuItem("Reglamentaciones","http://www.bancodecredito.com.co/generador/hfsnuevo/herramientas/hts_cambios_int.jsp","","index_plain");
endSubmenu("index_b4_5");

startSubmenu("index_b4_4","index_menu",152);
submenuItem("Reprocesar",loc+"../../"+"mant/reprocesar.do","","index_plain");
submenuItem("Legalización de Operaciones",loc+"../../"+"selec/legalizaciones.do","","index_plain");
submenuItem("Consultar",loc+"../../"+"mant/reprocesar1.do","","index_plain");
endSubmenu("index_b4_4");

startSubmenu("index_b4_3","index_menu",102);
if (60 == MENUCOMPE
		  ||65 == MENUCOMPE
		  ||70 == MENUCOMPE ){
submenuItem("Elaborar",loc+"../../"+"dian/elaborar/seleccion.do","","index_plain");
}
submenuItem("Consultar",loc+"../../"+"dian/consultar/seleccion.do","","index_plain");
if (50 == MENUCOMPE
		  ||70 == MENUCOMPE
		  ||60 == MENUCOMPE){
submenuItem("Aprobar",loc+"../../"+"dian/aprobar/aceptacion.do","","index_plain");
}
if (50 == MENUCOMPE
		  ||65 == MENUCOMPE
		  ||70 == MENUCOMPE
		  ||60 == MENUCOMPE){
submenuItem("Generar XML",loc+"../../"+"dian/generar/seleccion.do","","index_plain");
submenuItem("Reproceso de XML",loc+"../../"+"dian/reproceso/seleccion.do","","index_plain");
}
if (1 == MENUD){
submenuItem("Exportar Excel",loc+"../../"+"dian/exportar/seleccion.do","","index_plain");
}
endSubmenu("index_b4_3");

startSubmenu("index_b4_2","index_menu",73);
if (60 == MENUCOMPE
		  ||65 == MENUCOMPE
		  ||70 == MENUCOMPE){
submenuItem("Elaborar",loc+"../../"+"formulario10/mant/cuenta.do","","index_plain");
submenuItem("Modificar",loc+"../../"+"formulario10/mant/modificar.do","","index_plain");
}
submenuItem("Consultar",loc+"../../"+"formulario10/seleccion/estado.do","","index_plain");
if (50 == MENUCOMPE
		  ||70 == MENUCOMPE){
submenuItem("Aprobar",loc+"../../"+"formulario10/compensacion/aceptacion.do","","index_plain");
submenuItem("Reprocesar",loc+"../../"+"formulario10/mant/reproceso.do","","index_plain");
}
endSubmenu("index_b4_2");

startSubmenu("index_b4_1_2","index_menu",100);
submenuItem("Movimientos ",loc+"../../"+"mant/cuenta.do","","index_plain");
submenuItem("Sin Movimientos",loc+"../../"+"mant/cuenta1.do","","index_plain");
endSubmenu("index_b4_1_2");


startSubmenu("index_b4_1","index_menu",65);
if (60 == MENUCOMPE
		  ||65 == MENUCOMPE
		  ||70 == MENUCOMPE){
mainMenuItem("index_b4_1_2","Elaborar",0,0,"javascript:;","","",1,1,"index_l");
submenuItem("Modificar",loc+"../../"+"mant/modificar.do","","index_plain");
}
submenuItem("Consultar",loc+"../../"+"seleccion/estado.do","","index_plain");
if (50 == MENUCOMPE
		  ||70 == MENUCOMPE){
submenuItem("Aprobar",loc+"../../"+"compensacion/aceptacion.do","","index_plain");
}
endSubmenu("index_b4_1");

startSubmenu("index_b4","index_menu",218);
mainMenuItem("","Declaración de Cambio",0,0,"javascript:;","","",1,1,"index_l");
mainMenuItem("index_b4_2","Formulario 10 Relación de Operaciones",0,0,"javascript:;","","",1,1,"index_l");
mainMenuItem("index_b4_3","Reporte DIAN",0,0,"javascript:;","","",1,1,"index_l");
mainMenuItem("index_b4_4","Reprocesos de Informes Anteriores",0,0,"javascript:;","","",1,1,"index_l");
mainMenuItem("index_b4_5","Consultas",0,0,"javascript:;","","",1,1,"index_l");
submenuItem("Parámetros de la Cuenta",loc+"../../"+"mant/parametro.do","","index_plain");
submenuItem("Datos del Representante Legal",loc+"../../"+"mant/representante.do","","index_plain");
mainMenuItem("index_b4_8","Control de Vencimiento de Importación y Exportación",0,0,"javascript:;","","",1,1,"index_l");
submenuItem("Reporte",loc+"../../"+"est/seleccion/control.do","","index_plain");
endSubmenu("index_b4");

startSubmenu("index_b3","index_menu",207);
submenuItem("Preparación",loc+"../../"+"transfer.do?mode=create","","index_plain");
submenuItem("Modificación",loc+"../../"+"servicios/modificacion.jsp","","index_plain");
submenuItem("Consulta",loc+"../../"+"servicios/transferencias.jsp","","index_plain");
submenuItem("Autorización/Modificación/Cancelación",loc+"../../"+"transferencias/clave.jsp","","index_plain");
submenuItem("Plantillas",loc+"../../"+"compensacion/plantilla.do","","index_plain");
endSubmenu("index_b3");

startSubmenu("index_b2","index_menu",133);
submenuItem("Depósitos a Plazo",loc+"../../"+"servicios/seleccionso.jsp?prod=DP","","index_plain");
if(MENUEP == 2)
	submenuItem("Helm Custodia",loc+"../../"+"custodia/seleccion.do","","index_plain");
endSubmenu("index_b2");

startSubmenu("index_b1","index_menu",133);
submenuItem("Saldos",loc+"../../"+"servicios/seleccion.jsp?prod=CC","","index_plain");
submenuItem("Movimientos",loc+"../../"+"servicios/movimiento.jsp?prod=CC","","index_plain");
submenuItem("Estado de Cuenta",loc+"../../"+"servicios/estadocta.jsp?prod=CC","","index_plain");
//submenuItem("Mensajes SWIFT",loc+"../../"+"mensaje/swift.do","","index_plain");
endSubmenu("index_b1");

loc="";

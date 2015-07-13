
 function openwin(url)
{
	nwin=window.open(url, "nwin",config="width=500,height=375,scrollbars=yes,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no,");
	nwin.focus();
}

if(typeof(loc)=="undefined"||loc==""){var loc="";if(document.body&&document.body.innerHTML){var tt=document.body.innerHTML;var ml=tt.match(/["']([^'"]*)reporte.js["']/i);if(ml && ml.length > 1) loc=ml[1];}}
										
var bd=0
document.write("<style type=\"text/css\">");
document.write("\n<!--\n");
document.write(".Mensajeria_menu {z-index:999;border-color:#EFEFEF;border-style:solid;border-width:"+bd+"px 0px "+bd+"px 0px;background-color:#ffffff;position:absolute;left:0px;top:0px;visibility:hidden;}");
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
mainMenuItem("MENU1","Mensajeria Interna ",18,150,"javascript:;","","Mensajeria Interna ",2,2,"reporte_plain");
endMainMenu("",0,0);

startSubmenu("MENU1","Mensajeria_menu",140);
submenuItem("Redactar",loc+"do.mensajesbanco?tipo=RM","","reporte_plain");
submenuItem("Bandeja de Entrada",loc+"do.mensajesbanco?tipo=CE&cantidad=5","","reporte_plain");
submenuItem("Mensajes Enviados",loc+"do.mensajesbanco?tipo=CS&cantidad=5","","reporte_plain");
endSubmenu("sub1");

loc="";

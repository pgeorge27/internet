//©Xara Ltd
if(typeof(loc)=="undefined"||loc==""){var loc="";if(document.body&&document.body.innerHTML){var tt=document.body.innerHTML;var ml=tt.match(/["']([^'"]*)salir.js["']/i);if(ml && ml.length > 1) loc=ml[1];}}

var bd=0
document.write("<style type=\"text/css\">");
document.write("\n<!--\n");
document.write(".salir_menu {z-index:999;border-color:#000000;border-style:solid;border-width:"+bd+"px 0px "+bd+"px 0px;background-color:#efefef;position:absolute;left:0px;top:0px;visibility:hidden;}");
document.write(".salir_plain, a.salir_plain:link, a.salir_plain:visited{text-align:left;background-color:#efefef;color:#ef6910;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:3px 0px 3px 0px;cursor:hand;display:block;font-size:7pt;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold;}");
document.write("a.salir_plain:hover, a.salir_plain:active{background-color:#b5aead;color:#ef6910;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:3px 0px 3px 0px;cursor:hand;display:block;font-size:7pt;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold;}");
document.write("a.salir_l:link, a.salir_l:visited{text-align:left;background:#efefef url("+loc+"salir_l.gif) no-repeat right;color:#ef6910;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:3px 0px 3px 0px;cursor:hand;display:block;font-size:7pt;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold;}");
document.write("a.salir_l:hover, a.salir_l:active{background:#b5aead url("+loc+"salir_l.gif) no-repeat right;color: #ef6910;text-decoration:none;border-color:#000000;border-style:solid;border-width:0px "+bd+"px 0px "+bd+"px;padding:3px 0px 3px 0px;cursor:hand;display:block;font-size:7pt;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:bold;}");
document.write("\n-->\n");
document.write("</style>");

var fc=0xef6910;
var bc=0xb5aead;
if(typeof(frames)=="undefined"){var frames=0;}

startMainMenu("",0,0,2,0,0)
mainMenuItem("salir_b2",".png",23,149,"javascript:;","","Administración",2,2,"salir_plain");
mainMenuItem("salir_b3",".png",23,149,loc+"../../"+"logout.jsp","","Salir",2,2,"salir_plain");
endMainMenu("",0,0);

startSubmenu("salir_b2_1","salir_menu",173);
submenuItem("Administración de usuarios",loc+"../../"+"mant/users.jsp","","salir_plain");
submenuItem("Cambiar contraseña de ingreso",loc+"../../"+"ib/cambioClave.jsp","","salir_plain");
submenuItem("Cambiar firma digital",loc+"../../"+"ib/cambioClaveEspecial.jsp","","salir_plain");
submenuItem("Cambiar imagen personalizada",loc+"../../"+"mant/AdminIMG.jsp","","salir_plain");
submenuItem("Cambiar preguntas de validación",loc+"../../"+"mant/pregsecretas.jsp","","salir_plain");
submenuItem("Administracion Correos",loc+"../../"+"ib/adminEmail.jsp","","salir_plain");
submenuItem("Cambiar clave Correos Adjuntos",loc+"../../"+"ib/cambioClaveCorreos.jsp","","salir_plain");
submenuItem("Consejos de seguridad",loc+"../../"+"ayuda/consseguridad.jsp","","salir_plain");
endSubmenu("salir_b2_1");

startSubmenu("salir_b2","salir_menu",149);
mainMenuItem("salir_b2_1","Seguridad",0,0,"javascript:;","","",1,1,"salir_l");
endSubmenu("salir_b2");

loc="";

<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import = "com.arango.common.beans.UserInfo"%>
<%@ page import = "com.arango.common.services.ManagerBean"%>
<%@ page import = "com.arango.common.beans.PreguntaUsuario"%>
<%@ page import = "java.util.ArrayList"%>

<!-- esto es lo que venia de head.jsp -->

<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
java.util.Calendar cal2 =  java.util.Calendar.getInstance();

%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--
var da = (document.all) ? 1 : 0;
var pr = (window.print) ? 1 : 0;
var mac = (navigator.userAgent.indexOf("Mac") != -1);

function printPage2() {  
  if (pr){ // NS4, IE5    
	window.print();
  }	
  else if (da && !mac){ // IE4 (Windows)    
    vbPrintPage();
  }
}

function hideElement(){    
    if (document.getElementById){
    	var obj = document.getElementById("bankdiv"); 
    	var bdj = document.getElementById("bk2");
		if (obj)
			obj.style.display = 'none';
		if (bdj)
			bdj.style.display = 'none';
    }
    else{
        name.style.display = 'none';
    }

}
function showElement(){
    if (document.getElementById){    
    	var obj = document.getElementById("bankdiv");
    	var bdj = document.getElementById("bk2"); 
		if (obj)
			obj.style.display = '';
		if (bdj)
			bdj.style.display = '';
    }
    else{
        name.style.display = '';
    }
}

function printPage3() {
  var obj;
  if (document.getById){
	obj = document.getElementById("printHeader1");
  }    
  else{
    obj = printHeader1;
  }
  
  if (obj){
	obj.style.display ="none";
  }
  hideMenu();
	showElement();
  if (pr){ // NS4, IE5    
	window.print();
  }	
  else if (da && !mac){ // IE4 (Windows)    
    vbPrintPage();
  }
  if (obj){
    obj.style.display = "";
  }
  showMenu();
	hideElement();
}

if (da && !pr && !mac) with (document) {
  writeln('<OBJECT ID="WB" WIDTH="0" HEIGHT="0" CLASSID="clsid:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>');
  writeln('<' + 'SCRIPT LANGUAGE="VBScript">');
  writeln('Sub window_onunload');
  writeln('  On Error Resume Next');
  writeln('  Set WB = nothing');
  writeln('End Sub');
  writeln('Sub vbPrintPage');
  writeln('  OLECMDID_PRINT = 6');
  writeln('  OLECMDEXECOPT_DONTPROMPTUSER = 1');
  writeln('  OLECMDEXECOPT_PROMPTUSER = 2');
  writeln('  On Error Resume Next');
  writeln('  WB.ExecWB OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER');
  writeln('End Sub');
  writeln('<' + '/SCRIPT>');
}

// -->
</SCRIPT>

<SCRIPT language="Javascript">
var mensaje = "<bean:message key='msg.derechos.reservados' arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>";
function noViewSource(btnClick)
{
	if (navigator.appName == "Netscape" && btnClick.which == 3)
	{   alert(mensaje);
		return false;
	}
	else if (navigator.appName =="Microsoft Internet Explorer" && event.button == 2)
	{	alert(mensaje);
		return false;
	}
}
document.onmousedown = noViewSource;
if (navigator.appName =="Microsoft Internet Explorer")
   document.oncontextmenu = noViewSource;
</SCRIPT>

<SCRIPT language="JavaScript">
function protect(evt){
 if (navigator.appName != "Microsoft Internet Explorer"){
 if (evt.which != 3)
 return true;
};
return false;
}

function trap(){
 if(document.images){
 if(navigator.appName != "Microsoft Internet Explorer"){
 document.onmousedown = protect;}
 else{
document.oncontextmenu = protect;}}}
</SCRIPT>
<script language="JavaScript">

function ventanaAyuda(texto)
{
     link=texto+".htm";
     win1=open(link,'AYUDA', 'toolbar=no menubar=no personalbar=no locationbar=no resizable statusbar=no scrollbars=yes width=240 height=480');
     if (!win1.closed)
       {
         win1.focus();
       }
}
function regresar(){
	window.history.back(1);
}
</script>


<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/estilo.css'/>">
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/newlf.css '/>">
<script src="<html:rewrite page='/scripts/xaramenu.js' />"></script>


<!-- termina lo de head -->

<%
	session.setAttribute("no.aplicar.regla.password", "true"); 
	UserInfo userInfo = com.arango.common.servlet.helper.SessionReader.getUserInfo(session, pageContext.getServletContext());
%>


<script language="javascript" src="../../scripts/campos.js"></script>
<script language="javascript">
function send(){
    if(validateQuestion())/* && validatePreg(document.forma.respuesta1)
    		&& validatePreg(document.forma.respuesta2) && validatePreg(document.forma.respuesta3) && validatePreg(document.forma.pregunta3))*/
    {
  		document.forma.submit();
    }  
}

function validateQuestion(){
	var tem1;
	var tem2;
	/*if (document.forma.pregunta1.value == "-1")
	{
		alert("Debe seleccionar la pregunta 1");
		return false;
	}*/
  	if (document.forma.respuesta1.value == "")
  	{
     	 alert("El campo de respuesta 1 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirma1.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 1 no puede estar vacio");
     	 return false;
  	}  	
  	tem1 =document.forma.respuesta1.value;
  	tem2 =document.forma.confirma1.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
		 alert("La respuesta a la pregunta 1 no coincide con la confirmación");
		 return false;
	}
	/*if (document.forma.pregunta2.value == "-1")
	{
		alert("Debe seleccionar la pregunta 1");
		return false;
	}*/
  	if (document.forma.respuesta2.value == "")
  	{
     	 alert("El campo de respuesta 2 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirma2.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 2 no puede estar vacio");
     	 return false;
  	}
  	
  	tem1 =document.forma.respuesta2.value;
  	tem2 =document.forma.confirma2.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
		 alert("La respuesta a la pregunta 2 no coincide con la confirmación");
		 return false;
  	}
  	if (document.forma.pregunta3.value == "")
  	{
     	 alert("El campo de pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	if (document.forma.confirmapreg3.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	
  	tem1 =document.forma.confirmapreg3.value;
  	tem2 =document.forma.pregunta3.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
     	 alert("La pregunta 3 y su confirmación no contienen los mismos valores, verifique.");
     	 return false;
  	}
  	if (document.forma.respuesta3.value == "")
  	{
     	 alert("El campo de respuesta 3 no puede estar vacio");
     	 return false;
  	}
  	
  	if (document.forma.confirma3.value == "")
  	{
     	 alert("El campo de confirmación a la pregunta 3 no puede estar vacio");
     	 return false;
  	}
  	tem1 =document.forma.respuesta3.value;
  	tem2 =document.forma.confirma3.value;
  	if (tem1.toUpperCase() != tem2.toUpperCase())
  	{
		 alert("La respuesta a la pregunta 3 no coincide con la confirmación");
		 return false;
  	}
	 	
  	return true;    				 
}
</script>

</head>

<body style="margin: 0px;">

<logic:present name="msg">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabla-acceso">
		<tr> 
			<td valign="top" width="10%"><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>" border="0" hspace="8"></td>
			<td valign="top">
				<table>
					<tr><td class="bienvenida"><b><bean:message key="errors.header"/></b></td></tr>
					<tr><td class="bienvenida">
					<%
					String errors[] = session.getAttribute("msg").toString().split(";");
					for(int i=0; i<errors.length; i++){
					%>
					- <bean:message key="<%=errors[i] %>"/>

					<% out.println("<BR>"); }	%>	
					</td></tr>
				</table>
			</td>
		</tr>
	</table>   
</logic:present>

<%
   session.removeAttribute("msg");
   ManagerBean mb = new ManagerBean();
%>



<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr> 
		<td>
			<table width="100%" border="0" cellpadding="10" cellspacing="0">
				<tr><td align="right" ><img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/></td></tr>
			</table>			
		</td>
		<td>&nbsp;</td>	 
	</tr>
	
	<tr> 
		<td height="26" width="100%" colspan="2" align="right" style="height:26;background-color:#EFEFEF;"><div class="fuente-principal"><bean:message key="tit.title.atenticacion.paso6"/></div></td>
	</tr>
  
	<tr valign="top"> 
		<td colspan="4">
			<div align="center"> 
				<form name="forma" action="<html:rewrite page='/do.preguntastoken'/>" method="post">

					<%
						if (session.getAttribute("pregOK") != null)
						{
					%>

							<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="580">
								<TR>
									<TD class="bienvenida">
									<h4><font color="#CC6600"></font></h4>
									</TD>
								</TR>
							</TABLE>

					<%
							session.removeAttribute("pregOK");
						}
					%>
				
					<table width="800" align="center">
						<tr>
							<td width="1000" align="left">
								<table width="1000" border="0" align="left" cellpadding="0" cellspacing="0">
									
									<tr> 
										<td height="20" valign="bottom">
											<div align="left"> 
												<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
													<tr> 
														<!--td width="60%"><div align="left" class="login"><bean:message key="lbl.preg.secreta.titulo1a"/></div></td>
														<td width="40%"><div align="right"></div></td-->
														<td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>
														<td width="100%"><div align="left" class="fuente-titulo"><bean:message key="lbl.preg.secreta.titulo1b"/></div></td>
														<td width="8%"><div align="right"></div></td>
													</tr>
												</table>
											</div>
										</td>
									</tr>
  
									<tr><td>&nbsp;</td></tr> 
									<tr><td>&nbsp;</td></tr>
  
									<tr> 
										<td valign="top" align="left">
											<table>
												<tr valign="top">
												
													<td>
														<!--  Tabla con Preguntas -->
														<table width="400" border="0" cellpadding="0" cellspacing="2">
															<tr>
																<td class="fuente-principal">1. <bean:message key="lbl.preg.secreta1"/></td>
															</tr>
															
															<tr><td>&nbsp;</td></tr>

															<tr> 
																<td align="center">
																	<select name="pregunta1">
																		<option value="-1"><bean:message key="lbl.seleccion.pregunta"/></option>
																			<%
																				ArrayList lista = mb.getPreguntasCuestionario(userInfo);
																				PreguntaUsuario pregunta = null;
																				int preg1 = Integer.parseInt((request.getParameter("pregunta1")==null || request.getParameter("pregunta1").equals(""))?"0":request.getParameter("pregunta1"));
																				int preg2 = Integer.parseInt((request.getParameter("pregunta2")==null || request.getParameter("pregunta2").equals(""))?"0":request.getParameter("pregunta2"));
																				String preg3 = (request.getParameter("pregunta3")!=null)?request.getParameter("pregunta3"):"";
																				String respuesta1 = (request.getParameter("respuesta1")!=null)?request.getParameter("respuesta1"):"";
																				String respuesta2 = (request.getParameter("respuesta2")!=null)?request.getParameter("respuesta2"):"";
																				String respuesta3 = (request.getParameter("respuesta3")!=null)?request.getParameter("respuesta3"):"";
																			
																				
																				for (int i=0; i<10; i++)
																				{
																					pregunta = (PreguntaUsuario)lista.get(i);
																					String selected = (preg1==pregunta.getCodigoPregunta()) ? " selected " : "";
																					out.println("<option value=\"" + pregunta.getCodigoPregunta() + "\""+ selected + ">");
																					if (pregunta.getNombreEtiqueta() != null){
																			%>	
																						<bean:message key="<%=pregunta.getNombreEtiqueta() %>"/>
																					<%
																					}else
																						out.print(pregunta.getDescripcionPregunta());
																					out.print("</option>");
																				}
																					%>
																	</select>
																</td>
															</tr>
															
															<tr> 
																<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.resp.secreta1"/></td>
															</tr>
															<tr>
																<td align="center"><input name="respuesta1" type="text" class="caja-acceso" size="20" maxlength="50" value="<%=respuesta1 %>" ></td>
															</tr>
															<tr> 
																<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.preg.secreta.conf.resp"/></td>
															</tr>
															<tr>
																<td align="center"><input name="confirma1" type="text" class="caja-acceso" size="20" maxlength="50" value="<%=respuesta1 %>" ></td>
															</tr>
															<tr>
																<td class="texto-acceso" align="center"><bean:message key="lbl.preg.secreta.rango"/></td>
															</tr>
															
															<tr><td>&nbsp;</td></tr>
		  
															<tr>
																<td class="fuente-principal">2. <bean:message key="lbl.preg.secreta2"/></td>
															</tr>
		  
															<tr><td>&nbsp;</td></tr>
															
															<tr>
															<td align="center">			
															   <select name="pregunta2">
																  <option value="-1"><bean:message key="lbl.seleccion.pregunta"/></option>
																 <%
																	for (int i=0; i<10; i++)
																	{
																		pregunta = (PreguntaUsuario)lista.get(i+10);
																		String selected = (preg2==pregunta.getCodigoPregunta()) ? " selected " : "";
																		out.println("<option value=\"" + pregunta.getCodigoPregunta() + "\""+ selected + ">");
																		if (pregunta.getNombreEtiqueta() != null){
																		%>	
																			<bean:message key="<%=pregunta.getNombreEtiqueta() %>"/>
																		<%
																		}else
																			out.println(pregunta.getDescripcionPregunta());
																		out.print("</option>");
																	}
																%>
																</select>
															</td>
															</tr>
		 
															<tr> 
																<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.resp.secreta2"/></td>
															</tr>
	     
															<tr>
																<td align="center"><input name="respuesta2" type="text" class="caja-acceso" size="20" maxlength="50" value="<%=respuesta2 %>"></td>
															</tr>
		  
															<tr> 
																<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.preg.secreta.conf.resp"/></td>
															</tr>
															
															<tr>
																<td align="center"><input name="confirma2" type="text" class="caja-acceso" size="20" maxlength="50" value="<%=respuesta2 %>"></td>
															</tr>
		 
															<tr>
																<td class="texto-acceso" align="center"><bean:message key="lbl.preg.secreta.rango"/></td>
															</tr>
		
															<tr><td>&nbsp;</td></tr>
															
															<tr>
																<td class="fuente-principal">3. <bean:message key="lbl.preg.secreta3"/>&nbsp;
																<span class="texto-acceso"><bean:message key="lbl.preg.secreta.rango"/></span></td>
															</tr>
															
															<tr><td>&nbsp;</td></tr>
		  
															<tr>
																<td class="bienvenidaBold" align="left">&nbsp;&nbsp;<bean:message key="lbl.preg.secreta3.texto"/></td>
															</tr>
		  
															<tr> 
																<td class="bienvenidaBold" align="left">&nbsp;&nbsp;<input name="pregunta3" type="text" class="caja-acceso" size="40" maxlength="50" value="<%=preg3 %>"></td>
															</tr>
															
															<tr> 
																<td class="bienvenidaBold" align="left">&nbsp;&nbsp;<bean:message key="lbl.preg.secreta3.confirm"/></td>
															</tr>

															<tr> 
																<td class="bienvenidaBold" align="left">&nbsp;&nbsp;<input name="confirmapreg3" type="text" class="caja-acceso" size="40" maxlength="50" value="<%=preg3 %>"></td>
															</tr>
															
															<tr> 
																<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.resp.secreta3"/></td>
															</tr>
															
															<tr>
																<td align="center"><input name="respuesta3" type="text" class="caja-acceso" size="20" value="<%=respuesta3 %>"></td>
															</tr>
 		
															<tr> 
																<td height="20" class="bienvenidaBold" align="center"><bean:message key="lbl.preg.secreta.conf.resp"/></td>
															</tr>
		 
															<tr>
																<td align="center"><input name="confirma3" type="text" class="caja-acceso" size="20" value="<%=respuesta3 %>"></td>
															</tr>
		  
															<tr><td>&nbsp;</td></tr>
		  
															<tr> 
																<td align="center"><input name="button" onclick="send();" type="button" class="botton" value="<bean:message key="btn.enviar"/>"> &nbsp;&nbsp;<input name="Submit2" type="reset" class="botton" value="<bean:message key="btn.limpiar"/>"></td>
															</tr>
														</table>
														<!--  FIn de Tabla con Preguntas -->
		
													</td>
		
													<td>
														<!--  Tabla con Tips -->
														<%@ include file="../../divHeader.jsp"%>
														
														<table cellspacing="0" cellpading="0" >
															<tr><td colspan="2">&nbsp;</td></tr>
															
															<tr>
																<td width="5%"><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
																<td><p class="fuente-recuadro-titulo"><B><bean:message key="lbl.pregunta.tips.titulo"/></B></p></td>
															</tr>
															
															<tr>
																<td class="fuente-principal" colspan="2">
																	<UL>
																	<li><bean:message key="lbl.preg.secreta.obs1"/></li>
																	<li><bean:message key="lbl.preg.secreta.obs2"/></li>
																	<li><bean:message key="lbl.preg.secreta.obs3"/></li>
																	<li><bean:message key="lbl.preg.secreta.obs6"/></li>
																	<li><bean:message key="lbl.preg.secreta.obs7"/></li>	
																	</UL>
																</td>
															</tr>
														</table>
														
														<%@ include file="../../divFooter.jsp"%>
														<!--  Fin de Tabla con Tips -->
													</td>
													
												</tr>
											</table>
											
										</td>
									</tr>
								</table> 
							</td>
						</tr>
					</table>
					
					<br>

				</form> 
			</div>

			<!-- Empieza lo de footer.jsp -->

			<%
			   java.util.Calendar cal4 =  java.util.Calendar.getInstance();
			   String  serv = session.getAttribute("codigo.servicio").toString(); 
			   System.out.println("Codigo Servicio: " + serv);
			%>		

		</td>
	</tr>
</table>
<!--
</td></tr>
   </table></td></tr> -->
<table width="100%">   
 <tr>
<%if (serv.equals("1")) {%> 
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">
        <bean:message key="msg.derechos.reservados" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
     </div></td>
 <%}   else {%>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">
        <bean:message key="msg.derechos.reservados2" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
     </div></td>
 <%} %>
 
  </tr>
</table>

</body>
</html>
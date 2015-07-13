<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.common.beans.PerfilXML"%>
<%@ page import="com.arango.common.beans.Cliente"%>
<%@ page import="com.arango.internet.beans.IBTransferencias"%>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales"%>
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
String role = userInfo.getRole();

if (roleCompensacion != null || !roleCompensacion.trim().equals("")){
	width = "145";
}else
{roleCompensacion = "false";}

String permiteDescarga1 = (String)session.getAttribute("permite.descarga");
if ("S" == permiteDescarga1){
	permiteDescarga1 = "1";
}else
{ permiteDescarga1 = "0";}

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


function __pageLoad2(){
	if (__init){
		__init();
	}
}
<%
if(permiteDescarga1.equalsIgnoreCase("N")){
	permiteDescarga1 = "0";
}
try{ 
	Integer.parseInt(roleCompensacion);
}catch(Exception ES){roleCompensacion = "false";}

%>

</script>
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
<script type="text/javascript" src="<html:rewrite page='/scripts/tecladoUpdate.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/scriptmenu.js'/>"></script>


<%
	String selected = session.getAttribute("selected").toString();
%>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="reset(); ">

<script language="JavaScript">
      urlBase= "<html:rewrite page='/logout.jsp'/>";
      ar[0] = "User ID: <%=session.getAttribute("user.id")%>      Cliente: <%=nombreCliente%>     ip=<%=ipAddress%>";
      showBanner();
</script>

<br /><br />
<table cellpadding="0" cellspacing="0" width="950px">
	<tr>
    	<td width="50px"></td>
        <!-- Encabezado -->
        <td width="900px">
        	<table cellpadding="0" cellspacing="0" width="900px">
            	<tr>
                	<td>
<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="100"> 
						<img onclick="dv.showDV(usersecurity); return false" src='<html:rewrite page="/do.GetImage?img=ch"/>'  style=" width : 90px; height : 90px;" >
				</td>
			<td height="100">
				<table cellpadding="0" cellspacing="0">
					<tr><td><a class="mnuimg"><bean:message key="lbl.IP_Actual"/>: <%=ipAddress%></a><br/></td></tr>
					<tr><td><a class="mnuimg"><bean:message key="lbl.Ultima_Transferencia"/>:  <common:UltimaTransaccion></common:UltimaTransaccion></a><br/></td></tr>
					<tr><td><a class="mnuimg"><bean:message key="lbl.ultimo.acceso"/><common:fecha-acceso/></a><br/></td></tr>
				</table> 
			</td>  
			</tr>
		</table>
       				 </td>
                     <td align="right">
                        <table>
                        	<tr>
                            	<td align="center">
                                	<img src="<html:rewrite page='/images/logo.jpg' />" />
                                </td>
                            </tr>
                            <tr>
                            	<td align="center">
                                	<a href="<html:rewrite page='/start.jsp'/>"><img src="<html:rewrite page='/images/home.gif' />" border="0" title="Inicio"/></a>
                                	<a href="<html:rewrite page='/do.mensajesbanco?tipo=CE&cantidad=2'/>"><img src="<html:rewrite page='/images/mail.gif' />" border="0" title="Enviar Mensajes al Banco"/></a>
                                	<a href="<html:rewrite page='/ayuda/video_demo.jsp?titul=VD'/>"><img src="<html:rewrite page='/images/help.gif' />" border="0" title="Ayuda"/></a>
                                    <a href="<html:rewrite page='/logout.jsp' />"><img src="<html:rewrite page='/images/close.gif' />" border="0" title="Cerrar"/></a>
                                </td>
                            </tr>
                         </table>
                     </td>
    			</tr>
             </table>
         </td>
     </tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr>
        <td width="50px"></td>
        <td width="900px">
            <table cellpadding="0" cellspacing="0" width="900px" align="center">
                <tr>
                    <td width="900px">
                        <table cellpadding="0" cellspacing="0" width="900px">
                        <tr>
                             <td align="center" 
							 <%
								if (selected.equals("inicio"))
								{
							%>
							 background="<html:rewrite page='/images/index_over.png' />"
							 <%
							 }
							 else
							 {
							 %>
							 background="<html:rewrite page='/images/index.png' />"
							 <% } %> width="133px" height="29px"><a href="<html:rewrite page='/start.jsp' />">Inicio</a></td>
                             <td align="center" 
							 <%
								if (selected.equals("consultas"))
								{
							%>
							 background="<html:rewrite page='/images/index_over.png' />"
							 <%
							 }
							 else
							 {
							 %>
							 background="<html:rewrite page='/images/index.png' />"
							 <% } %>
 width="133px" height="29px"><a href="<html:rewrite page='/servicios/seleccion.jsp?prod=CC' />">Consultas</a></td>
                             <td align="center" <%
								if (selected.equals("depositos"))
								{
							%>
							 background="<html:rewrite page='/images/index_over.png' />"
							 <%
							 }
							 else
							 {
							 %>
							 background="<html:rewrite page='/images/index.png' />"
							 <% } %> width="133px" height="29px"><a href="<html:rewrite page='/servicios/seleccionso.jsp?prod=DP' />">Dep&oacute;sitos</a></td>
                             <td align="center" <%
								if (selected.equals("transfer"))
								{
							%>
							 background="<html:rewrite page='/images/index_over.png' />"
							 <%
							 }
							 else
							 {
							 %>
							 background="<html:rewrite page='/images/index.png' />"
							 <% } %> width="133px" height="29px"><a href="<html:rewrite page='/transfer.do?mode=create'/>">Helm Transfer</a></td>
                             <%
                             	if (role.equals(ConstantesGlobales.ROLE_OPERADOR_AUTORIZADOR) || role.equals(ConstantesGlobales.ROLE_AUTORIZADOR))
                             	{
                             %>
                             <td align="center" <%
								if (selected.equals("compensacion"))
								{
							%>
							 background="<html:rewrite page='/images/index2_over.png' />"
							 <%
							 }
							 else
							 {
							 %>
							 background="<html:rewrite page='/images/index2.png' />"
							 <% } %> width="150px" height="29px"><a href="<html:rewrite page='/compensacion.jsp' />">Helm Compensaci&oacute;n</a></td>
							 <% } %>
                             <td align="center" <%
								if (selected.equals("administracion"))
								{
							%>
							 background="<html:rewrite page='/images/index_over.png' />"
							 <%
							 }
							 else
							 {
							 %>
							 background="<html:rewrite page='/images/index.png' />"
							 <% } %> width="133px" height="29px"><a href="<html:rewrite page='/ib/adminEmail.jsp'/>">Administraci&oacute;n</a></td>
                             <td background="<html:rewrite page='/images/superior_centro.png' />" 
                             <%
                             	if (role.equals(ConstantesGlobales.ROLE_OPERADOR_AUTORIZADOR) || role.equals(ConstantesGlobales.ROLE_AUTORIZADOR))
                             	{
                             %>
                             width="85px" height="29px"></td>
                             <%
                             	}
                             	else
                             	{
                             %>
                             width="235px" height="29px"></td>
                             <%
                             }%>
                         </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" width="900px">
                                <tr>
                                    <td background="<html:rewrite page='/images/linea_2.png' />"></td>
                                    <td>&nbsp;</td>
                                    </td>
                                    <td background="<html:rewrite page='/images/linea_3.png' />"></td>
                                </tr>
                                <tr>
                                    <td background="<html:rewrite page='/images/linea_2.png' />"></td>
                                    <td>
                                    <!-- SUBMENU -->
									<%@ include file="menu.jsp"%>
									</td>
                                    <td background="<html:rewrite page='/images/linea_3.png' />"></td>
                                </tr>
                                <tr>
                                    <td background="<html:rewrite page='/images/linea_2.png' />"></td>
                                    <td>
									<br/><br/>
                                    <!-- CONTENIDO -->
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

if (roleCompensacion != null || !roleCompensacion.trim().equals("")){
	width = "145";
}else
{roleCompensacion = "false";}

String permiteDescarga1 = (String)session.getAttribute("permite.descarga");
try{
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

var MENUCOMPE = "<%=roleCompensacion%>";
var MENUR = <%=userInfo.getRole()%>;
var MENUD = <%=permiteDescarga1%>;
var MENUEP = <%=userInfo.getEmpresa()%>;

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
						<img onclick="dv.showDV(usersecurity); return false" src='<html:rewrite page="/do.GetImage?img=ch"/>'  style=" width : 90px; height : 90px;" >
				</td>
				<td width="1%"></td>
			<td width="75%" height="100">
				<table width="100%" >
					<tr><td><a class="mnuimg"><bean:message key="lbl.IP_Actual"/>: <%=ipAddress%></a><br/></td></tr>
					<tr><td><a class="mnuimg"><bean:message key="lbl.Ultima_Transferencia"/>:  <common:UltimaTransaccion></common:UltimaTransaccion></a><br/></td></tr>
					<tr><td><a class="mnuimg"><bean:message key="lbl.ultimo.acceso"/><common:fecha-acceso/></a><br/></td></tr>
				</table> 
			</td>  
			<td> 
				<img border="0" src="<html:rewrite page='/images/logo.jpg'/>"/>
			</td>
			<td width="100%"> 
								
			</td>
			
			</tr>
		</table>
			<br></td>
    <td>&nbsp;</td>
    
  </tr>
  <tr>
    <td colspan="2" background="<html:rewrite page='/images/menu/index_medium.png'/>">
		<script src="<html:rewrite page='/images/menu/index.js'/>"></script>
    </td>
  </tr>
  <tr>
     <td colspan="2" align="right">
     	<table width="100%"><tr><td width="60%">&nbsp;</td><td align="center">
		<script src="<html:rewrite page='/images/menu2/salir.js'/>"></script></td></tr></table>
     </td>
  </tr>
  <tr valign="top">
		<td colspan="2" width="100%" align="right" height="6">
		</td>
   <tr>
    <td height="16" colspan="2" align="right" ><div class="bienvenida"></div></td>
 </tr>
  </table>

  
</div>
  
<table id="Table_01" border="0"  width="100%" border="0" cellpadding="0" cellspacing="0">
<tr valign="top"> 
    <td colspan="4" align="left">
		<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center" >
        <tr valign="top"> 
          <td height="300" align="center">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr valign="top"> 
                <td align="center">
                

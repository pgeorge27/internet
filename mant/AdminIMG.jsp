<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="com.arango.internet.beans.IBAfiliacion" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ page import="com.arango.common.beans.Usuario" %>
<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>
<%@ page import="java.util.ArrayList" %>
<%! 
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
private String getStatus(String status){
	String descestado = "";
	if (ConstantesGlobales.USUARIO_ACTIVO.equals(status))
	  descestado = "lbl.administration.user.active";
	else if (ConstantesGlobales.USUARIO_INACTIVO.equals(status))
	  descestado = "lbl.administration.user.inactive";
	else if (ConstantesGlobales.USUARIO_BLOQUEADO.equals(status))
	  descestado = "lbl.administration.user.lock";
	else
	    descestado = "lbl.administration.user.active";
	return descestado;  
}

%>
<% 
String descripcion = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "lbl.mant.imagen.obs3" :  "lbl.mant.imagen.obs4";
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
%>
<%@ include file="../head.jsp"  %>
<style type="text/css">
#derechos{
	width: 100%;	 
	background-color:#4D4F53;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #FFFFFF;
	position: fixed; 
	bottom:0;	
	vertical-align: middle;
	padding-bottom: 8px;
	padding-top: 8px;
	text-align: center;
}
</style>
<script language="javascript">
function __submit(usr, opt){
	document.forms[0].username.value=usr;
	document.forms[0].action.value=opt;
	if ("I" == opt){
		if (confirm('<bean:message key="lbl.administration.msg.inactivar" arg0=" '+usr+' "/>')){
			document.forms[0].submit();
		}
	}
	else if("D" == opt) {
		if (confirm('<bean:message key="lbl.administration.msg.desbloquear" arg0=" '+usr+' "/>')){
			document.forms[0].submit();
		}
	 }	
	else if("Y" == opt){
		if (confirm('<bean:message key="lbl.administration.msg.IP.inactivar" arg0=" '+usr+' "/>')){
			document.forms[0].submit();
		}
	}
	else if("N" == opt){
		if (confirm('<bean:message key="lbl.administration.msg.IP.activar" arg0=" '+usr+' "/>')){
			document.forms[0].submit();
		}
    }		
	else if("E" == opt){
			if (confirm('<bean:message key="lbl.administracion.IP.confirma.eliminar" arg0=" '+usr+' " />')){
				document.forms[0].submit();
			}	
	}
}


function send()
{
	document.forma.submit();
}

function refreshImage(categoria){
	//location.reload(true);
	//console.info(categoria);
	var target = document.getElementById("imageRefresh").value;
	document.forma.action = target;
	document.getElementById("categoria").value = categoria;
	document.forma.submit();
}

</script>
<link rel="stylesheet" type="text/css" 	href="<html:rewrite page='/style/flujos.css'/>" />
<style>
.texto-acceso2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: normal;
	color:#E96B10;
}
</style>
<script type="text/javascript" src="imageGallery.js"></script>

<jsp:useBean id="marcas" class="com.arango.internet.beans.MarcasIdentidad" scope="page"/>
<%
int emp = Integer.parseInt(session.getAttribute("codigo.empresa").toString());
//marcas.setEmpresa(Integer.parseInt(session.getAttribute("codigo.empresa").toString()));
String pais = "";
String categoria = "";
String sessCat = (String)session.getAttribute("categoria");
if(emp == 1){
	   pais = "Panam&aacute;";
	   categoria = "pa";
}
else{
	   pais = "Cayman";
	   categoria = "cay";
}

//verificamos si existe categoria en la session
if(sessCat == null || sessCat.equals("")){
	   session.setAttribute("categoria", categoria);
	   marcas.setCategoria(categoria);	   
}
else{
		session.setAttribute("categoria", null);
	   marcas.setCategoria(sessCat);
}   

marcas.carga();
%>
<%@ include file="../body.jsp"  %>



<table width="100%" border="0"  cellpadding="0" cellspacing="0">
  
  <tr align="center"> 
  
	<td valign="top" colspan="2" width="100%">
	<table width="100%" align="center"><tr><td>
	<form method="post" action="<html:rewrite page='/UploadpageAdm.jsp'/>" name="forma">
      	<input type="hidden" name="categoria" id="categoria" value="" />
      	<input type="hidden" name="imageRefresh" id="imageRefresh" value="<html:rewrite page='/cambioImagenAdm.do'/>" />
      	<input type="hidden" name="pantalla" value="cambioImagenSeleccionAdm" />
      	
      	<%@ include file="../divHeader.jsp"%>
	 <table cellspacing="3" cellpading="3" align="center" width="100%">
       <tr valign="top">
      	  <td colspan="2">
      	  <table ><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><B><p class="fuente-recuadro-titulo"><bean:message key="lbl.imagen.tips.titulo"/></p></B></td>
	      </tr></table>
	      </td>
	    </tr>
      <tr>
	    <td class="fuente-principal">
	    <UL>
	       <li><bean:message key="lbl.mant.imagen.obs1" /></li>
	       <!--  <li><bean:message key="lbl.mant.imagen.obs2" /></li>-->
	       <li><bean:message key="<%=descripcion %>" /></li>
	    </UL>
	    </td>
	  </tr>
	  </table>
	  <%@ include file="../divFooter.jsp"%>
	
	<!-- Inicio del Div -->
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
	<td width="11px" height="9px" background="<html:rewrite page='/images/div/top-left.gif'/>"></td>
	<td height="9px" background="<html:rewrite page='/images/div/top-meddium.gif'/>"></td>
	<td width="8px" height="9px" background="<html:rewrite page='/images/div/top-right.gif'/>"></td>
  </tr>
  <tr>
	<td width="11px" height="9px" background="<html:rewrite page='/images/div/left-center.gif'/>"></td>
	<td>
	<!-- Colocar Contenido Aqui -->	
	
	  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	   <tr>
	   	<td valign="top" width="19%">
	   		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	   			<tr>
	   				<td colspan="2">&nbsp;</td>
	   			</tr>
	   			<tr>
	   				<td width="10%">&nbsp;</td>
	   				<td width="90%">
	   					<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('<%=categoria %>');">
				   						<div class="texto-acceso2" align="left"><%=pais %></div>
			   						</a>
			   					</td>
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('ani');">
				   						<div class="texto-acceso2" align="left">Animales</div>
				   					</a>	
		   						</td>			   					
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('arq');">
				   						<div class="texto-acceso2" align="left">Arquitectura</div>
			   						</a>
			   					</td>
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('dep');">
				   						<div class="texto-acceso2" align="left">Deportes</div>
			   						</a>
			   					</td>
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="refreshImage('nat');">
				   						<div class="texto-acceso2" align="left">Naturaleza</div>
			   						</a>
			   					</td>
				   			</tr>
				   			<tr><td>&nbsp;</td></tr>
				   			<tr>
				   				<td>
				   					<a href="#" onclick="send();">
				   						<div align="left" class="texto-acceso2">Personalizar</div>
			   						</a>
<%-- 			   					<input name="Personaliza"  type="button" class="botton" value="<bean:message key="btn.seleccion.marca.identidad.personal"/>"  onclick="submit();"> --%>
			   					</td>
				   			</tr>
	   					</table>
	   				</td>
	   			</tr>	   			
	   		</table>
	   		
	   	</td>
	   	<td width="1%" background="<html:rewrite page='/images/div/left-center.gif'/>">&nbsp;</td>	   
	    <td width="80%" colspan="2">
		    <table width="100%" border="0" cellpadding="0">
			  <tr align="center">
					<c:forEach var="imagen" items="${marcas.imagenes}" varStatus="rowCounter">
						<c:if test="${rowCounter.count % 4 == 1 && rowCounter.count>1}">			    
							</tr>
							<c:if test="${rowCounter.count <= marcas.total}">
							   <tr align="center">
							</c:if>
						</c:if>
						<td width="20">
						  <a href="do.SetImage?id=<c:out value='${imagen}'/>">
						   <img src="do.GetImage?id=<c:out value="${imagen}"/>&img=ch" width="100" height="100" border="0" />
						   </a>
						</td>
					</c:forEach>
		   </tr>
		   </table>
		</td>
	   </tr>
<!-- 	   <tr> -->
			
<!-- 			<td  align="center" style=" width : 350px;"> -->
<%-- 			<input name="Personaliza"  type="button" class="botton" value="<bean:message key="btn.seleccion.marca.identidad.personal"/>"  onclick="submit();"> --%>
<!-- 			</td>  -->
			   
<!--   </tr> -->
		</table>
		
		
		<%@ include file="../divFooter.jsp"%>
		
	  </form></td></tr>
	  </table>  
	  </td>
  </tr>
  <tr>
	<td height="20" valign="middle" class="texto-acceso"></td>
  </tr>
</table></div>
</td></tr></table>

</td></tr>
	</table></td></tr>
   </table></td></tr></table>
   	
   	<!-- Div que contiene el cintillo de los derechos reservados -->
	<div id="derechos">
		<bean:message key="<%=copyrigth %>"
			arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>' />
	</div>
	
</body>
</html>  
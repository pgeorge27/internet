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


%>
<% 
String descripcion = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "lbl.mant.imagen.obs3" :  "lbl.mant.imagen.obs4";
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";
%>
<%@ include file="head.jsp"  %>
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
<link href="<html:rewrite page='/style/estilo.css'/>" rel="stylesheet" type="text/css">
<script language="javascript" src="./scripts/campos.js"></script>
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
window.statusbar=' ';

var imgRe = /^.+\.(jpg|jpeg|gif|png)$/i;
function previewImage(pathField, previewName)
{       
    var path = pathField.value;
    if (path.search(imgRe) != -1)
    {   
        document[previewName].src = 'file://'+path;
    }       
    else    
    {   
        alert("JPG, PNG, and GIFs only!");
    }   
}

var imgRe = /^.+\.(jpg|jpeg|gif|png)$/i;
function previewImage(pathField, previewName)
{       
    var path = pathField.value;
    if (path.search(imgRe) != -1)
    {   
        document[previewName].src = 'file://'+path;
    }       
    else    
    {   
        alert("JPG, PNG, and GIFs only!");
    }   
}

function makeSubmit(){
	
	var campo = document.getElementById('mark');
	if(campo.value ==  ""){
		alert("Debe darle un nombre a la imagen");
	}
	else{
		 document.getElementById('marca').value = campo.value; 
		 document.forms[0].submit();
	}
	
}


function userElection()
{


}
var login = <%=Integer.parseInt(session.getAttribute("flag").toString())%>
function cancelar(){

	window.location.href = "<html:rewrite page='/mant/AdminIMG.jsp'/>";
}
</script>
<link rel="stylesheet" type="text/css" 	href="<html:rewrite page='/style/flujos.css'/>" />



<%@ include file="body.jsp"  %>

<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td height="300" valign="middle"><table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center"> 
                    
                      <table width="100%" height="200" border="0" cellpadding="0" cellspacing="0" >
                        <tr> 
                          <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                              <tr> 
                                <td width="46%" rowspan="2"><div align="center"> 
                                    <table width="70%" border="0" cellspacing="2" cellpadding="2">
                                      <tr>
                                      	<td>
                                      	
                                      	<%@ include file="divHeader.jsp"%>
                                      		<table>
                                      			<tr valign="baseline">
                                      				<td><img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
                                      				<td class="fuente-titulo"><bean:message key="lbl.confirmar.imagen.indicacion"/></td>
                                      			</tr>	
                                      		</table>
                                      	<%@ include file="divFooter.jsp"%>
                                      	
                                      	</td> 
                                      </tr>	
                                      <tr> 
                                        <td><div align="right" ><img align="right" src="<html:rewrite page='/do.GetImage'/>"  style=" width : 325px; height : 325px;"></div></td>
                                      </tr>
                                      <tr> 
                                        <td align="right" >
                                        <table width="100%">
                                        <tr>
                                        	<td width="60%"><div class="fuente-principal"><bean:message key="lbl.token.cambio.imagen.nombreImagen" /></div></td>
                                        	<td><div align="right"><input size="35" id="mark" type="text" maxlength="12" style="text-transform: uppercase"></div></td>
                                       	</tr>
                                        <tr><td>
                                        <form name="formConfirma" action="<html:rewrite page='/saveImg.jsp'/>" >
                                        	<input type="hidden" name="marca"  id="marca" value=""/>
                                        	<div align="right"><input name="baceptar"  onclick="makeSubmit();" type="button" class="botton" value="<bean:message key="btn.confirmar"/>"></div> 
			  							</form >
										</td><td>
			  							<form name="cancelacion" action="<html:rewrite page='/do.cancelImage'/>">
										<input name="btCancelar" onclick="submit();" type="button" class="botton" value="<bean:message key="btn.cancelar"/>"  > 
										</form>
										</td></tr>
										</table>
                                        </td>
                                      </tr>
                                    </table>
                                  </div></td>                                
                              </tr>
                            </table></td>
                        </tr>
                      </table>
                  </div></td>
              </tr>
              <tr> 
                <td></td>
              </tr>
            </table></td>
        </tr>
      </table>

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
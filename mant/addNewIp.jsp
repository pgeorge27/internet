<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ page import="com.arango.internet.beans.IBAfiliacion" %>
<%@ page import="com.arango.common.beans.UserInfo" %>
<%@ page import="com.arango.common.beans.Usuario" %>
<%@ page import="com.arango.internet.tag.TagUtil" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.arango.internet.beans.IBdireccionesIp"%>
<%@ page import="com.arango.common.beans.IPbeansAdress"%>
<%@ include file="../head.jsp"  %>
<script>
function validar(ip) {
    partes=ip.split('.');
    if (partes.length!=4) {
           return true;
    }
    for (i=0;i<4;i++) {
        num=partes[i];
        if (num>255 || num<0 || num.length==0 || isNaN(num)){
        	return true;
        	}
        }
    return false;
} 
</script>

<script language="javascript">

function _send(registroIPF){
	
	if (registroIPF.newIP.value == "" ){
		alert("<bean:message key='lbl.administration.msg.IP.direccion'/>");
			return false}
	else if(validar(registroIPF.newIP.value)){
		alert('<bean:message key="lbl.administration.msg.IP.invalido"/>');
 			return false}
	else{	  	
		return true }
	}
	
	
	function cancelar(){
		window.location.href = "<html:rewrite page='/mant/users.jsp'/>";
	}
	
</script> 
<%@ include file="../body.jsp"  %>


  <tr height="0" valign="top"> 
    <td colspan="4">
	<table width="100%" border="0" cellspacing="2" cellpadding="2" >
        <tr> 
          <td height="300" valign="middle">
			<table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td>
			<table width="50%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			  <tr> 
				<td width="50%"><div align="left" class="login"><bean:message key="tit.administration.IP.matricula"/></div></td>
				<td width="8%"><div align="right"></div></td>
			  </tr>
			</table>			
                      <table width="400" height="200" border="0" cellpadding="0" cellspacing="0" class="linea-botton" >
                        <tr> 
                          <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                              <tr> 
                              </tr>
                              <tr>
                                <td width="100%" rowspan="2">
                                    <form method="POST" action="<html:rewrite page='/do.setNewIP'/>"  onSubmit="return _send(this);"  id="registroIP"  >
                                   <%@ include file="../divHeader.jsp"%>
									<table width="100%" border="0" cellspacing="2" cellpadding="2">
                                 		
                                 		<tr>
                                 			<td width="40%" height="30" class="texto-acceso"><bean:message key="lbl.administracion.IP.nuevo.registro"/> <span>(<font color="#FF0000">*</font>)</span> </td>
                                 		    <td width="60%" class="texto-acceso"> <input width="100%" type="text" name="newIP" id="newIP" style=" width : 202px;" maxlength="15" /> </td>
                                 		</tr>
                                   		<tr>
                                   			<td> <input type="radio" name="estado" id="estado" value="Y" CHECKED /><bean:message key="lbl.administration.IP.estado.true"/> </td> 
                                 			<td> <input type="radio" name="estado" id="estado" value="N" /><bean:message key="lbl.administration.IP.estado.false"/></td> 
                                 		</tr>
                                   		<tr>
                                   			<td align="center"><input type="submit" class="botton" onclick="submit;"  value="<bean:message key='btl.administration.IP.aceptar'/>" /></td>
                                 			<td align="center"><input type="button" class="botton" onclick="cancelar();" value="<bean:message key='btn.cancelar'/>"></td>
                                 		</tr>
                                    </table>
                                    <%@ include file="../divFooter.jsp"%>
                                    </form>
								</td>                                
                              </tr>
					  </table></td>
	<td height="20" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
  </tr>
       </table></table></table>
<%@ include file="../footer.jsp"  %>
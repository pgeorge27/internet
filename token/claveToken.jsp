<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>

<link rel="stylesheet" type="text/css" href="<html:rewrite page='/style/flujos.css'/>" />
<script type="text/javascript" src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script src="<html:rewrite page='/scripts/jquery.numeric.js'/>" type="text/javascript"></script>
<script type="text/javascript">
function escribir(A){
	if(A.charCodeAt(0)!=160){
      if(document.getElementById("Foco")){
    	  if(document.getElementById(document.getElementById("Foco").value).value.length<8){
    			 document.getElementById(document.getElementById("Foco").value).value=document.getElementById(document.getElementById("Foco").value).value+A;
    			 window.status="";
    			 focusContinueControl();
    			return true
    			}
    	  
      }else if(document.getElementById("claveToken")){
    	  if(document.getElementById("claveToken").value.length<8){
		 document.getElementById("claveToken").value=document.getElementById("claveToken").value+A;
		 window.status="";
		 focusContinueControl();
		return true
		}}
      else if(document.getElementById("segundaClave")){
    	  if(document.getElementById("segundaClave").value.length<4){
		 document.getElementById("segundaClave").value=document.getElementById("segundaClave").value+A;
		 window.status="";
		 focusContinueControl();
		return true
		}}
      else
    	  {
 			 document.getElementById(Foco).value=document.getElementById(Foco).value+A;
 			 window.status="";
 			 focusContinueControl();
 			return true
 			}
    	  
	}
}

function send(){
    if(validatePass())
    {
		document.forms[0].submit();
	}  
}


function validatePass(){
	if(document.getElementById('claveToken').value=="")
	{
		alert("<bean:message key="lbl.actualiza.campos.requeridos"/>");
		return false;
	}
	else if(document.getElementById('claveToken').value.length<8)
	{	
		alert("<bean:message key="error.token.activarToken.largo"/>");
		return false;
	}
	else
	{
		return true;
	}

}
$(document).ready(function(){
	$("#claveToken").numeric({ decimal: false, negative: false }, function() { alert("Positive integers only"); this.value = ""; this.focus(); });
	
	$("form").submit(function(){
		send();
		return false;
	});
	
});


</script>


<logic:messagesPresent>
  <table cellpadding="1" cellspacing="1" width="750" class="tabla-acceso1">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span><br>
	<span class="bienvenida">
		<table width="80%">
		<html:messages id="error">					
			<tr><td class="bienvenida">- <bean:write name="error" /></td></tr>
		</html:messages>
		</table>
	</span><br>
								   </td></tr>
			 </table></td></tr>
		  </table>
</logic:messagesPresent>


<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom">
	<div align="center"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
		    <td width="50px"><img src="<html:rewrite page='/images/gancho.gif' />"/></td>	
			<td><div align="left" class="login"><bean:message key="tit.title.ingreso.clave.token"/></div>
			</td>
		  <td width="8%"><div align="right">&nbsp;</div></td>
		  </tr>
		</table>
	  </div>
	 </td>
  </tr>
  <tr> 
	<td class="texto-acceso">&nbsp;</td>
  </tr>
  <tr> 
	<td valign="top" align="center">
			<table>
			 <tr valign="top">
			    <td width="200">
			    <!-- Tabla con Formulario -->
			    <html:form method="post" action="/claveToken.do">
			<table width="70%" border="0" align="center" cellpadding="5" cellspacing="5">
		  <tr> 
			<td width="30%" height="20" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.clave.token"/></td>
		 	<td width="34%" align="center" nowrap><html:text property="claveToken" styleClass="botton-acceso"  maxlength="8"  styleId="claveToken"/></td>
			<td width="35%"><div align="right"></div></td>
		  </tr>
										  
			<tr>
				<td colspan="3"  align="center"class="texto-acceso">
						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
				</td>
			</tr>
				<tr><td width="30%"><div align="right"></div></td>
			    	<td colspan="3"align="center">
				    	<div >
							<div ></div>
<!-- 							<div id="upper"></div> -->
							<div id="cls" align="bottom"><input name="button" onclick="send();" type="button" class="botton" value='<bean:message key="btn.enviar"/>'></div>		
						</div>
					</td>
			     </tr>
			     <tr><td colspan="3">&nbsp;
						<div id="teclado" style=" visibility: hidden;">
							<div id="lower" style="display: none;" ></div>
							<div id="upper"></div>
							<div id="cls" align="bo"></div>		
						</div>
			     </td></tr>
			     <tr>
				    <td width="30%"><div align="right"></div></td>
				    <td  width="34%" align="center">
				   		
				    </td>
				    <td width="35%"><div align="right"></div></td>
		         </tr>
		</table>
                    </html:form>
			    </td>
			    <td>
			    <!--  Cuadro de Tips -->
			    <%@ include file="../divHeader.jsp"%>
			    <table cellspacing="3" cellpading="3"  width="350">
        <tr valign="top">
      	  <td colspan="2">
      	  <table><tr><td>
      	  <img src="<html:rewrite page='/images/gancho.gif'/>" border="0"></td>
	      <td><B><p class="bienvenida"><bean:message key="lbl.preg.secreta.observacion"/></p></B></td>
	      </tr></table>
	      </td>
	    </tr>
	    <tr>
	       <td colspan="2" class="bienvenida">
				
	          <OL>
	          	<li><bean:message key="lbl.transferencia.clave.token.paso1" /><img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15"></li>
	          	<li><bean:message key="lbl.transferencia.clave.token.paso2" /><img src="<html:rewrite page='/images/TokenPin.png'/>" height="15"></li>
	          	<li><bean:message key="lbl.transferencia.clave.token.paso3" /></li>
	          	<li><bean:message key="lbl.transferencia.clave.token.paso4" /></li>
	          	<li><bean:message key="lbl.transferencia.clave.token.paso5" /></li>
	          	<li><bean:message key="lbl.transferencia.clave.token.paso6" /></li>
	          </OL>
	       </td>
	    </tr>
	  </table>	
	  <%@ include file="../divFooter.jsp"%>	                   
      </td>                                
  </tr>
 </table>
 </td></tr></table>
<%@ include file="../footer.jsp" %>
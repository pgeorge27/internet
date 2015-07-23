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

<div class="container">
	<div class="row">

		<logic:messagesPresent>
		<div class="well col-md-4 col-md-offset-4">
			<p><img src="<html:rewrite page='/images/warning.gif'/>"></p>
			<p><span class="bienvenida"><b><bean:message key="errors.header"/></p>
			<html:messages id="error">
				<p class="bienvenida"> - <bean:write name="error" /></p>
			</html:messages>
			</div>
		</logic:messagesPresent>

		<div class="col-md-4 col-md-offset-1">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.preg.secreta.observacion"/>
					</strong>
				</div>

				<div class="panel-body">
					<p><bean:message key="lbl.transferencia.clave.token.paso1" />
					<img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15"></p>
		          	<p><bean:message key="lbl.transferencia.clave.token.paso2" />
		          	<img src="<html:rewrite page='/images/TokenPin.png'/>" height="15"></p>
		          	<p><bean:message key="lbl.transferencia.clave.token.paso3" /></p>
		          	<p><bean:message key="lbl.transferencia.clave.token.paso4" /></p>
		          	<p><bean:message key="lbl.transferencia.clave.token.paso5" /></p>
		          	<p><bean:message key="lbl.transferencia.clave.token.paso6" /></p>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="tit.title.ingreso.clave.token"/>
					</strong>
				</div>
				<div class="panel-body">
					<html:form method="post" action="/claveToken.do">
						<p><bean:message key="lbl.clave.token"/></p>
						<p><html:text property="claveToken" styleClass="botton-acceso form-control"  maxlength="8" styleId="claveToken"/></p>
						<div align="center">
						<p><input name="button" onclick="send();" type="button" class="btn btn-default" value='<bean:message key="btn.enviar"/>'></p>
						<p>
							<div id="teclado" style=" visibility: hidden;">
								<div id="lower" style="display: none;" ></div>
								<div id="upper"></div>
								<div id="cls" align="bo"></div>		
							</div>
						</p>
						</div>
						<p></p>
                    </html:form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../footer.jsp" %>
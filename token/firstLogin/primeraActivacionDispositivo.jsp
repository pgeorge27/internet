<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../../head.jsp"%>
<%@ include file="../../ib/jsScripts.jsp"%>

<script type="text/javascript" src="<html:rewrite page='/scripts/campos.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ValidaFirmaDigital.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/jquery.min.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/jquery.blockUI.js'/>"></script>


<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/estilo.css'/>">
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/newlf.css '/>">
<script type="text/javascript" src="<html:rewrite page='/scripts/tecladoUpdate.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/transferencia.js'/>"></script>
<LINK REL="stylesheet" TYPE="text/css" HREF="<html:rewrite page='/style/teclado.css'/>">

<script language="javascript">
function campoChange(campo){
if(1 == campo){
document.forma.Foco.value = "claveold"
}else if(2 == campo){
document.forma.Foco.value = "clavenew"
}else if(3 == campo){
document.forma.Foco.value = "claveconf"
}
}
function send(){
    //if(validatePass())
    //{
    	$.blockUI({ message: $('#esperar'), css: { width: '400px' } });
            setTimeout(function() {
                $.unblockUI({
                    onUnblock: function(){
                        $.blockUI({ message: $('#finEspera'), css: { width: '400px' } })
                        setTimeout($.unblockUI, 3000);
                        document.forma.submit();
                    }
                });
            }, 30000);
	//}  
}
/*function validatePass(){
  	if ((document.forma.newPassw.value.length < 7) || (document.forma.newPassw.value.length > 7))
  	{
     	 alert("<bean:message key="lbl.cambio.pin.observacion1"/>");
     	 return false;
  	}else if(!checkVal(document.forma.newPassw.value)){
  		 alert("<bean:message key="lbl.cambio.clave.especial.observacion3"/>");
    	 return false;
  	}
  	return true;    				 
}*/
var option = "0"; // Solamente teclado numerico   
</script>
<body  onLoad="reset();">

<div class="container"> 
    <div class="row">

      <div align="right">
        <img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
      </div>
      <br>
      <br>
      <div height="26" width="100%" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
        <div  class="fuente-principal">

        </div>
      </div>
      <br>
      <br>

      <logic:present name="msg">
      <div align="center" class="well col-md-4 col-md-offset-4">
        <p><img src="<html:rewrite page='/images/icon_warning_lrg.gif'/>"></p>
        <p><b><bean:message key="errors.header"/></b></p>
        <p class="fuente-principal">
          <%String error = session.getAttribute("msg").toString();%>
          <bean:message key="<%=error%>"/></p>
        </div>
      </logic:present>
		<%
			session.removeAttribute("msg");
			if (session.getAttribute("sync")!=null){	
				%>
				<script language="javascript">
					$.blockUI({ message: $('#msgExito'), css: { width: '350px' } });
				</script> 
				<%
				session.removeAttribute("sync");
			}
		%>

		<div class="col-md-4 col-md-offset-4">
			<div class="panel panel-default" >
				<div class="panel-heading">
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="tit.title.sincronizar.token"/>
					</strong>
				</div>
				<div class="panel-body">

					<p>
						<bean:message key="lbl.title.sincronizar.token.opt1"/>
					</p>
					<p>
						<bean:message key="lbl.title.sincronizar.token.pasos" />
					</p>
					<p>
						<bean:message key="lbl.pasos.sincronizar.token.paso1" />
						<img src="<html:rewrite page='/images/TokenON.jpg'/>" height="15">
					</p>
					<p>
						<bean:message key="lbl.pasos.sincronizar.token.paso2" />
						<img src="<html:rewrite page='/images/TokenClave.png'/>" height="15">
					</p>
					<p>
						<bean:message key="lbl.pasos.sincronizar.token.paso3" />
					</p>
					<p>
						<bean:message key="lbl.sincronizar.token.clave.generada" />
						<span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
					</p>
					<p>
						<html:password property="otp1" styleClass="inputf form-control" redisplay="false" onclick="campoChange(1);" styleId="claveold" onkeypress="javascript: return false;" onkeydown="javascript: return false;"/>
					</p>
					<p>
						<input type="checkbox" id="changeLetters" checked="false" onclick="changeStyle();" style="display: none;" />
					</p>
					<div id="teclado" style=" visibility: hidden; display: none;">
						<div id="lower" style="display: none;" ></div>
						<div id="upper"></div>
						<div id="cls" align="bottom"></div>
					</div>

					<div align="center">
						<input name="button" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.enviar"/>">
						<input name="Submit2" type="reset" class="btn btn-default" value="<bean:message key="btn.limpiar"/>">
						<p><bean:message key="lbl.mensaje.campo.requerido"/></p>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>



<%@ include file="../../footer.jsp" %>

</body>
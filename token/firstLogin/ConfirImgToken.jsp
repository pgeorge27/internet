<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados" : "msg.derechos.reservados2";
%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<script language="JavaScript" src="<html:rewrite page='/scripts/bootstrap.min.js'/>"></script>
<link href="<html:rewrite page='/style/bootstrap.min.css'/>" rel="stylesheet" type="text/css">

<link rel="stylesheet" type="text/css" 	href="<html:rewrite page='/style/flujos.css'/>" />
<SCRIPT language="Javascript">
var mensaje = "<bean:message key='<%=copyrigth %>' arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>";
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

function close(){
	window.close();
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

/*
function evaluar()
{       
	var radioButtons = document.getElementsByName("selection");

	for (var i=0; i < radioButtons.length; i++)
	   {           
	   if (radioButtons[i].checked)
	      {
		   document.forms[0].action = radioButtons[i].value;
		   document.getElementById("pantalla").value = radioButtons[i].id

	      }
	   }	   
}  */
	


</SCRIPT>
<% String  service = session.getAttribute("codigo.servicio").toString(); %>
<%if (service.equals("1")) {%> 
    <title><bean:message key="tit.title.banco"/></title>
 <%}   else {%>
    <title><bean:message key="tit.title.banco2"/></title>
 <%} %>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<LINK REL="stylesheet" TYPE="text/css" HREF="../../style/estilo.css">
<script type="text/javascript">
<!--
if (typeof window.event != 'undefined') // IE
document.onkeydown = function() // IE
 {
 var t=event.srcElement.type;
 var kc=event.keyCode;
 return ((kc != 8 ) || ( t == 'text'  ) ||
          (t == 'textarea') || ( t == 'submit' ) || (t =='password')) 
 }
else
document.onkeypress = function(e)  // FireFox/Others 
 {
 var t=e.target.type;
 var kc=e.keyCode;
 if ((kc != 8 ) || ( t == 'text'  ) ||
     (t == 'textarea') || ( t == 'submit' ) || (t =='password'))
     return true
 else {
     return false
 }
}
//-->
</script>

</head>
<body>

  <div class="container"> 
    <div class="row" style="padding-right: 3%; padding-left: 3%;">

      <div align="right">
        <img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
      </div>
      <br>
      <br>
      <div height="26" width="100%" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
        <div  class="fuente-principal">
          <bean:message key="tit.title.first.login.paso2"/>
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
      %>

      <div class="col-md-4 col-md-offset-4">
        <div class="panel panel-default" >
          <div class="panel-heading">
            <img src="<html:rewrite page='/images/logo_icon.png' />" />
            <strong>
              <bean:message key="lbl.confirmar.imagen.indicacion"/>
            </strong>
          </div>
          <div class="panel-body">
            <div class="row" align="center">
              <img class="img-responsive" align="right" src="<html:rewrite page='/do.GetImage'/>">
            </div>
            <p>
              <bean:message key="lbl.token.cambio.imagen.nombreImagen" />
            </p>
            <p>
              <input class="form-control" id="mark" type="text" maxlength="12" style="text-transform: uppercase;">
            </p>
            <div align="center">
              <div class="col-md-4 col-md-offset-2">
                <html:form method="post" action="/cambioImagenToken.do">
                  <input type="hidden" name="pantalla" value="cambioImagenSuccess">
                  <html:hidden property="marca"  styleId="marca" value=""/>
                  <input name="baceptar"  onclick="makeSubmit();" type="button" class="btn btn-default" value="<bean:message key="btn.confirmar.imagen"/>">
                </html:form>
              </div>
              <div class="col-md-4">
                <form method="post" name="cancelacion" action="<html:rewrite page='/cambioImagenToken.do'/>">
                  <input type="hidden" name="pantalla" value="cambioImagenSeleccion">
                  <input name="btCancelar" onclick="submit();" type="button" class="btn btn-default" value="<bean:message key="btn.cancelar"/>"  >
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>


</body>

</html>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../../head.jsp"%>
<%
String  copyrigth = (session.getAttribute("codigo.servicio").toString().equals("1")) ? "msg.derechos.reservados"  : "msg.derechos.reservados2";

%>
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

<%

session.setAttribute("flag","12");
	try{
		if (session.getAttribute("codigos.Banco.formularios") != null){
			ArrayList codigosBanco = (ArrayList)session.getAttribute("codigos.Banco.formularios") ;
			codigosBanco.remove(0);
			session.setAttribute("codigos.Banco.formularios",codigosBanco);
		}
	}catch(Exception ex){
		
	}
%>

<div class="container"> 
    <div class="row">

      <div align="right">
        <img border="0" src="<html:rewrite page='/images/logo.jpg'/>" />
      </div>
      <br>
      <br>
      <div height="26" width="100%" align="right" style="height:26;background-color:#EFEFEF; padding-right: 15px">
        <div  class="fuente-principal">
          <div  class="bienvenida"></div>
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
				 <bean:message key="lbl.actualiza.mensaje.resultado"/>
            </strong>
          </div>
          <div class="panel-body">

	         <p><bean:write name="resultado_secuencia"/></p>
	         <p><bean:write name="resultado_fecha"/></p>

			<div align="center">
				<html:form action="/preguntaSeguridad.do">
					<input name="baceptar"  onclick="submit();" type="button" class="btn btn-default" value="<bean:message key="btn.confirmar"/>">
				</html:form >
			</div>

          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- empieza cinta con derechos reservados -->
  <div align="center" class="derechos" style="width:100%;height:31;background-color:#4D4F53;">
    <bean:message key="<%=copyrigth %>" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
  </div>



</body>
<%@page import="java.util.ArrayList"%>
</html>



<%
response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

String usuario = "";
String cliente = "";
String servicio = "";
Throwable throwable = (Throwable)
request.getAttribute("javax.servlet.error.exception");
if (throwable != null){
	com.arango.common.util.Actividad.writeLog(new Exception(throwable), usuario, cliente, servicio);
}
else{
    com.arango.common.util.Actividad.writeLog("compile error", "");
}
%>

<html>
<head>
<title>HELM BANK CAYMAN</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/internet-cay/style/estilo.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="254" height="68" background="/internet-cay/images/template_02.jpg"> <div align="left"><img src="/internet-cay/images/template_01.jpg" width="254" height="68" alt=""></div></td>
    <td background="/internet-cay/images/template_02.jpg"> <div align="right"><img src="/internet-cay/images/template_04.jpg" width="242" height="68" alt=""></div></td>
  </tr>

  <tr> 
    <td height="26" width="100%" colspan="2" align="right" style="width:254;height:26;background-color:#E96B10;"><div  class="bienvenida">&nbsp;</div> </td>
  </tr>
  <tr height="0" valign="top"> 
    <td colspan="4">
	<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td height="300" valign="middle">
			<table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center">                     
                      <table width="400" height="200" border="0" cellpadding="0" cellspacing="0" class="tabla-acceso">
                        <tr> 
                          <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                              <tr> 
                                <td width="46%" rowspan="2"><div align="center"> 
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                      <tr> 
                                        <td><div align="center"><img src="/internet-cay/images/error.gif"></div></td>
                                      </tr>
                                      <tr> 
                                        <td class="bienvenida">Para terminar satisfactoriamente el proceso de su solicitud,<br>
                                        					   favor contactar nuestra área de Servicio al Cliente.
                                        </td>
                                      </tr>
									 
                                    </table>
								</td>                                
                              </tr>
							</td>                           
                        </tr>
					  </table></td></tr></div></td>
              </tr>
              <tr> 
                <td></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos"> 
        Derechos Reservados &copy;. HELM BANK CAYMAN.</div></td>
  </tr>
</table>
</body>
</html>

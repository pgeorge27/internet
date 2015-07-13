<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%
SimpleDateFormat df = new SimpleDateFormat("yyyy");
Date pDate = new java.util.Date(System.currentTimeMillis());
String pYear = df.format(pDate);

df.applyPattern("MM");
String pMonth = df.format(pDate);

df.applyPattern("dd");
String pDay = df.format(pDate);

df.applyPattern("dd-MM-yyyy");

String fecha = df.format(pDate);

%>
<%
String prod = "ALL";
if (request.getParameterValues("prod") != null)
{
  prod = request.getParameterValues("prod")[0];
}
String cuenta = "-1";
String tipo = "1";
if (request.getParameter("cuenta") != null && request.getParameter("cuenta").length() > 0)
{
 cuenta = request.getParameter("cuenta");
}
if (request.getParameterValues("tipo") != null)
{
  tipo = request.getParameterValues("tipo")[0];
}
String backPage = "seleccion";
if (request.getParameter("back") != null){
        backPage="consulta";	
}

%>
<%@ include file="/head.jsp"  %>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>
<style type="text/css">
    .lstbox {
        font-family: Arial, Helvetica, sans-serif;
        font-size: 10px;
        width: 400px;
        border: 1px solid #999999;
    }
</style>
<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
        locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
        session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
String anio2 =""+ java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
String anio1 =""+( java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)-1);
String anio3 =""+( java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)-2);
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar.js'/>"></script>
<script type="text/javascript" language='javascript'>
    var t;
    function send(){
        if (document.forms['movimientoFormXML'].cuenta.value == "")
        {
            alert("<bean:message key="+msg.seleccionar.cuenta+"/>");
            document.forms['movimientoFormXML'].cuenta.focus();
            return;
        }	
	
        document.forms['movimientoFormXML'].submit();
    }
    function setValue(_value){
        t = _value;
    }
    function retornar(){
        history.back();
    }
    function cambiaAction(_value){
        var text = _value.toUpperCase();
        var form = document.forms['movimientoFormXML'];
        if (text == 'TODAS LAS CUENTAS'){
            form.action='/internet/dian/reprocesarConsolidado.do';
		
            if (form.elements['formulario'].options[form.elements['formulario'].length-1].text.toUpperCase() == 'TODOS'){
                form.elements['formulario'].options[form.elements['formulario'].length-1] = null;	
            }
		
		
        }else{
            var a = new Option("Todos","0");
            form.action='/internet/dian/reproceso.do';
		
            if (form.elements['formulario'].options[form.elements['formulario'].length-1].text.toUpperCase() != 'TODOS'){
                form.elements['formulario'].options[form.elements['formulario'].length] = a;	
            }
        }
    }
</script>

<script type="text/javascript" language="javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" language="javascript" src="<html:rewrite page='/scripts/objetoFecha.js'/>"></script>

<%@ include file="/body.jsp"%>
<logic:messagesPresent>
    <table cellpadding="1" align="center" cellspacing="1" width="80%" class="tabla-acceso">
        <tr>
            <td>
                <table border="0" cellpadding="1" cellspacing="0" width="100%">
                    <tr valign="top">
                        <td width="5%">
                            <img alt="Warning" src="<html:rewrite page='/images/warning.gif'/>">
                        </td>
                        <td width="95%" class="msg">
                            <span class="bienvenida">
                                <b>
                                    <bean:message key="errors.header"/>
                                </b>
                            </span><br>
                            <span class="bienvenida">
                                <table width="80%">
                                    <html:messages id="error">					
                                        <tr>
                                            <td class="bienvenida">- 
                                        <bean:write name="error" />
                                        </td>
                                        </tr>
                                    </html:messages>
                                </table>
                            </span><br>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</logic:messagesPresent>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
    <tr> 
        <td height="40" valign="bottom">
            <div align="left"> 
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                    <tr>
                        <td width="50px">
                            <img alt="Check" src="<html:rewrite page='/images/gancho.gif' />"/>
                        </td> 
                        <td>
                            <div align="left" class="login">Reproceso de Generación de XML</div>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr> 
        <td valign="top" align="center">
    <html:form method="post" action="/dian/reproceso"> 
        <html:hidden property="estado" value="5"/>
        <html:hidden property="unico" value="xml"/>
        <%@ include file="../../divHeader.jsp"%>
        <table width="90%" border="0" align="center" cellpadding="5" cellspacing="5">
            <tr> 
                <td colspan="3">
                    <div align="center" class="subtitulos">
                        <bean:message key="lbl.movimiento.tipos"/>
                    </div>
                </td>
            </tr>
            <tr> 
                <td colspan="3">
                    <table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">

                    </table>
                </td>
            </tr>
            <tr> 
                <td width="30%" class="celda-clave1">
                    <div align="right" class="texto-acceso">
                        <bean:message key="lbl.cuentas"/>
                    </div>
                </td>
                <td width="70%">
            <html:select property="cuenta" styleClass="lstbox" onchange="cambiaAction(this[selectedIndex].text);">
                <logic:notEmpty name="cuentasCompensacion">
                    <html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
					<html:option value="-1" >Todas las cuentas</html:option>
                    <bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
                    <html:options collection="cp" property="codigoCSIC" labelProperty="tag"/>

                </logic:notEmpty>
                <logic:empty name="cuentasCompensacion">
                    <html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
                </logic:empty>	</html:select>
                </td>
                <td>
                    <span class="texto-acceso">(<font color="#FF0000">*</font>)</span>
                </td>
            </tr>
            <tr>
                <td  class="celda-clave1" nowrap>
                    <div align="right" class="texto-acceso">Tipo de Formato</div>
                </td>
                <td>
                <html:select property="formulario" styleClass="lstbox">
                    <html:option value="1059">1059 - Informe de datos de declaración de cambio por importación de bienes - formulario no 1</html:option>
                    <html:option value="1060">1060 - Informe de datos de declaración de cambio por exportación de bienes - formulario no 2</html:option>
                    <html:option value="1061">1061 - Informe de datos de declaración de cambio por endeudamiento externo - formulario no 3</html:option>
                    <html:option value="1062">1062 - Informe de datos de declaración de cambio por servicios, transferencias y otros conceptos - formulario no 5	</html:option>										
                    <html:option value="1066">1066 - Informe de aclaraciones de datos para fines estadísticos - declaraciones de cambio 1 2 3 y 5</html:option>
                    <html:option value="1067"><bean:message key="1067"/></html:option>
                    <html:option value="0">Todos</html:option>
                </html:select>
                </td> 
            </tr>
            <tr> 
                <td class="celda-clave1">
                    <div align="right" class="texto-acceso">Trimestre</div>
                </td>
                <td class="bienvenida">
                    <html:select property="trimestre" styleClass="lstbox">										
                        <html:option value="1">Trimestre - 1</html:option>
                        <html:option value="2">Trimestre - 2</html:option>
                        <html:option value="3">Trimestre - 3</html:option>
                        <html:option value="4">Trimestre - 4</html:option>										
                    </html:select>
                </td>
            </tr>
            <tr> 
                <td class="celda-clave1"><div align="right" class="texto-acceso">Año</div></td>
                <td class="bienvenida">
                    <html:select property="anio" styleClass="lstbox">	
                   	    <html:option value="<%=anio3%>"><%=anio3%></html:option>																			 	
                        <html:option value="<%=anio1%>"><%=anio1%></html:option>
                        <html:option value="<%=anio2%>"><%=anio2%></html:option>	
                       </html:select>
                </td>
            </tr>
            <tr>
                <td>&nbsp;<br><br></td>
                <td>
                    <input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
                    <input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()">
                </td>
            </tr>
        </table>
        <%@ include file="../../divFooter.jsp"%>
        </html:form>
        </td>
    </tr>
    <tr>
        <td height="25" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
    </tr>
</table>

<%@ include file="/footer.jsp"  %>
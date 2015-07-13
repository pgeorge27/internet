<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>

<%@ include file="/head.jsp"  %>

<%
SimpleDateFormat df = new SimpleDateFormat("yyyy");
SimpleDateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
Date pDate = new java.util.Date(System.currentTimeMillis());
String pYear = df.format(pDate);

Date hoy = pDate;
Date desde = (Date)session.getAttribute("fecha.desde");
Date hasta = (Date)session.getAttribute("fecha.hasta");
Integer formulario = (Integer)session.getAttribute("formulario");

%>
<script language=javascript>
    function __retornar(){
        history.back();
    }
</script>
<%@ include file="/body.jsp"%>
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
    <tr> 
        <td height="40" valign="bottom"><div align="center"> 
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                    <tr> 
                        <td><div align="left" class="login">Generar XML</div></td>
                        <td width="8%"><div align="right">&nbsp;
                                <INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
                    </tr>
                </table>
            </div></td>
    </tr>
    <tr> 
        <td height="40" class="texto-acceso">&nbsp;</td>
    </tr>
</table>         
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">               
    <tr> 
        <td valign="top">


            <table cellpadding="1" style="overflow:scroll;width:50%">
                <html:form   action="/dian/genexml">
                    <tr align="center">
                        <td ><b>Datos del Encabezado</b></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr> 
                        <td class="celda-clave1">Año de Envio</td>
                        <td class="bienvenida"><input type="text" name="anio" size="20" maxlength="4" value="<%=pYear %>" /></td>                      
                    </tr>

                    <tr>
                        <td class="celda-clave1">Codigo del Formato</td>	                      
                        <td class="bienvenida"><b><input type="text" size="20" name="formulario" disabled  value="<%=formulario%>"  /></b></td>                      
                    </tr>
                    <tr>
                        <td class="celda-clave1">Version del Formato</td>
                        <td class="bienvenida"><b><input type="text" size="20" disabled maxlength="4" value="6" /></b></td>                      
                    </tr>
                    <tr>
                        <td class="celda-clave1">Fecha Envio</td>
                        <td class="bienvenida"><input type="text" size="20" name="hasta" onchange maxlength="10" value="<%=dd.format(hoy)%> " />&nbsp;[<b>yyyy-mm-dd</b>]</td>
                    </tr>
                    <tr>
                        <td class="celda-clave1">Fecha Inicial</td>	                      
                        <td class="bienvenida"><input type="text" name="desde" size="20" onchange maxlength="10" value="<%=dd.format(desde)%>" />&nbsp;[<b>yyyy-mm-dd</b>]</td>                      
                    </tr>
                    <tr>
                        <td class="celda-clave1">Fecha Final</td>                       
                        <td class="bienvenida"><input type="text" size="20" name="hasta" onchange maxlength="10" value="<%=dd.format(hasta)%> " />&nbsp;[<b>yyyy-mm-dd</b>]</td>
                    </tr>
                    <tr>
                        <td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
                                <input type="button" class="botton" onclick="submit()" value="Descargar"/>"/>
                            </div></td>
                    </tr>
            </table>

            </html:form>
        </td></tr></table>
<table width="80%" border="0" cellpadding="0" cellspacing="2">

    <tr> 
        <td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>


                <INPUT class="botton" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>
<%@ include file="/footer.jsp"  %>
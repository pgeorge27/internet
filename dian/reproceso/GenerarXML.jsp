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
String strFechaDesde = "";
String strFechaHasta = "";
df.applyPattern("dd-MM-yyyy");
if (desde != null){
    strFechaDesde = df.format(desde);
}
if (hasta != null){
    strFechaHasta = df.format(hasta);
}
%>
<script language=javascript>
function __retornar(){
	document.forms["movimientoFormXML"].submit();
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
               <html:form method="post" action="/dian/reproceso"> 
						<html:hidden property="estado" value="5"/>
						<html:hidden property="est" value='<%=(String)session.getAttribute("est")%>'/>
						<html:hidden property="tipo" value="3"/>
						<html:hidden property="cuenta" value='<%=session.getAttribute("cuenta.csic").toString()%>'/>
						<html:hidden property="formulario" value="<%=formulario.toString()%>"/>
						<html:hidden property="desde" value="<%=strFechaDesde%>"/>
						<html:hidden property="hasta" value="<%=strFechaHasta%>"/>
						<html:hidden property="unico" value="xml"/>
						<html:hidden property="trimestre" value='<%=(String)session.getAttribute("trimestre")%>'/>
						<html:hidden property="anio" value='<%=(String)session.getAttribute("anio")%>'/>
					</html:form>
				
                    <table cellpadding="1" style="overflow:scroll;width:50%">
                     <html:form   action="/dian/recibo">
                     	<html:hidden property="codigoFormato"/>
                     <tr align="center">
                        <td class="subtitulos"><b>Datos del Encabezado</b></td>
                        <td>&nbsp;</td>                        
                     </tr>
                     <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                     </tr>
                     <tr> 
                        <td class="celda-clave1">Año de Envío</td>
                        <td class="bienvenida"><html:text property="anio" size="20" maxlength="4" /></td>                      
                     </tr>
                     
                     <tr> 
                        <td class="celda-clave1">Concepto</td>
                        <td class="bienvenida"><html:select property="concepto">
                        	<html:option value="1">Inserción/Nuevo</html:option>
                        	<html:option value="2">Reemplazo</html:option>
                        </html:select></td>                      
                     </tr>
                     <tr>
	                      <td class="celda-clave1">Código del Formato</td>	                                           
	                      <td class="bienvenida"><b><html:text property="formulario" size="20" maxlength="4" value='<%=session.getAttribute("formulario").toString()%>' disabled="true"/></b></td>
                     </tr>
                     <tr>
	                      <td class="celda-clave1">Versión del Formato</td>
	                      <td class="bienvenida"><b>
	                      <%
	                      String form = session.getAttribute("formulario").toString();
	                      String version = "6";
	                      if ("1059".equals(form)){
	                      	version = "7";
	                      }
	                      else if ("1063".equals(form)){
	                      	version =  "7";
	                      }
	                      else if ("1064".equals(form)){
	                      	version =  "7";
	                      }
	                      else if ("1066".equals(form)){
	                      	version =  "7";
	                      }
	                      else if ("1067".equals(form)){
	                      	version =  "7";
	                      } %>
	                      <input type="text" name="version" size="20" value="<%=version %>" disabled/></b></td>  
						  <html:hidden property="versionFormato" value="<%=version %>"/>                    
                     </tr>
                     
                     <tr>
	                      <td class="celda-clave1">Número de Envío</td>
	                      <td class="bienvenida"><html:text property="numeroEnvio" size="20" maxlength="4"/></td>                      
                     </tr>
                     <tr>
                        <td class="celda-clave1">Fecha Envío</td>
                        <td class="bienvenida"><html:text property="fechaEnvio" size="20" maxlength="20"/>&nbsp;[<b>yyyy-mm-dd</b>]</td>
                     </tr>
                     <tr>
	                      <td class="celda-clave1">Fecha Inicial</td>	                      
	                      <td class="bienvenida"><html:text property="desde" size="20" maxlength="10"/>&nbsp;[<b>yyyy-mm-dd</b>]</td>                      
                     </tr>
                     <tr>
                        <td class="celda-clave1">Fecha Final</td>                       
                        <td class="bienvenida"><html:text property="hasta" size="20" maxlength="10"/>&nbsp;[<b>yyyy-mm-dd</b>]</td>
                     </tr>
                    <tr>
	    <td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>

	       <input type="button" class="botton" onclick="submit()" value="Generar XML"/>

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
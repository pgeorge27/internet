<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://ajaxtags.org/tags/ajax" prefix="ajax" %>

<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="../head.jsp"%>
<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script type="text/javascript" src="<html:rewrite page='/scripts/utilidades.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/prototype.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/ajaxtags-1.1.js'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/calendar/calendar.js'/>"></script>

<%
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null){
	locale = com.arango.common.util.i18n.ASIResourceBundle.getDefaultLocale();
	session.setAttribute(org.apache.struts.Globals.LOCALE_KEY, locale);
}
String calendar = "/calendar/calendar-"+locale.getLanguage()+".js";
%>
<script type="text/javascript" src="<html:rewrite page='<%=calendar%>'/>"></script>
<script type="text/javascript" src="<html:rewrite page='/scripts/calendar-trx.js'/>"></script>
<%@ include file="../body.jsp" %>

<div class="container">
  <div class="row" style="padding-right: 3%; padding-left: 3%;">

    <logic:messagesPresent>
    <div align="center" class="well col-md-4 col-md-offset-4">
      <p><img src="<html:rewrite page='/images/warning.gif'/>"></p>
      <p><b><bean:message key="errors.header"/></b></p>
      <html:messages id="error">
      <p class="bienvenida"> - <bean:write name="error" /></p>
      </html:messages>
    </div>
  </logic:messagesPresent>

  <div class="col-md-6 col-md-offset-3">
    <div class="panel panel-default" >
      <div class="panel-heading" >
        <img src="<html:rewrite page='/images/logo_icon.png' />" />
        <strong>
          <bean:message key="lbl.compensacion.parametro.titulo.2" />
        </strong>
      </div>

      <div class="panel-body">

        <p><INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/mant/representante.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></p>

        <% String doubleCuote = (String)session.getAttribute("representante.accion.nuevo"); %>
        <html:form method="post" action="/grabar/representante">
        <html:hidden styleId="nuevo" property="nuevo" value="<%= doubleCuote%>"/>
        <html:hidden styleId="numero" property="numero" />
        <!-- Agrego campo oculto ciu Edgar Sucre => 06/03/2012 -->
        <html:hidden styleId="numero" property="ciu" />

        <p><bean:message key="lbl.mensaje.campo.requerido" /></p>


        <div class="col-md-4">
          <p>
            <bean:message key="lbl.compensacion.parametro.cuenta" /><span class="texto-acceso"> (<font color="#FF0000">*</font>)</span>
          </p>
        </div>

        <div class="col-md-8">
          <p>
            <html:select property="cuenta" styleClass="form-control">
            <bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
            <html:options collection="cp" property="codigoCSIC" labelProperty="codigoBanco"/>
            </html:select>
          </p>
        </div>

        <p><bean:message key="lbl.compensacion.parametro.nombre" /></p>
        <p><html:text property="nombre" size="50" maxlength="150"/></p>

        <p><bean:message key="lbl.compensacion.parametro.identificacion" />(<font color="#FF0000">*</font>)</p>
        <p>
          <html:select styleId="tipoIdentificacion" property="tipoIdentificacion" styleClass="form-control">
          <bean:define id="cp2" scope="session" name="tipos" type="java.util.ArrayList"/>
          <html:options collection="cp2" property="codigo" labelProperty="descripcion"/>
          </html:select>
        </p>

        <p>
          <html:text property="identificacion" styleClass="form-control" size="25" maxlength="20" />
        </p>
        
        <p>
          <bean:message key="lbl.compensacion.parametro.direccion" />(<font color="#FF0000">*</font>)
        </p>
        <p>
          <html:text property="direccion" styleClass="form-control" size="50" maxlength="200"/>
        </p>

        <p>
          <bean:message key="lbl.compensacion.parametro.ciudad" />(<font color="#FF0000">*</font>)
        </p>
        <p> 
          <html:select property="ciudad" styleClass="form-control">
          <bean:define id="cp3" scope="session" name="ciudades" type="java.util.ArrayList"/>
          <html:options collection="cp3" property="codigo" labelProperty="descripcion"/>
          </html:select>
        </p>

        <p>
          <bean:message key="lbl.compensacion.parametro.telefono" />(<font color="#FF0000">*</font>)
        </p>
        <p>
         <html:text property="telefono" styleClass="form-control" size="30" maxlength="30"/>
       </p>

       <p>
        <bean:message key="lbl.compensacion.parametro.email" />(<font color="#FF0000">*</font>)
      </p>
      <p>
        <html:text property="email" styleClass="form-control" size="30" maxlength="60"/>
      </p>

      <div align="center">
        <html:submit styleClass="btn btn-default">Aceptar</html:submit> 

        <INPUT class="btn btn-default" onclick="document.location='<html:rewrite page='/mant/representante.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
      </div>

      </html:form>

    </div>
  </div>
</div>
</div>
</div>

<logic:messagesPresent>
  <table cellpadding="1" align="center" cellspacing="1" width="80%" class="tabla-acceso">
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

<div align="center"> 
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td	height="40"	valign="bottom">
		<div align="center">
		<table width="100%"	border="0" cellpadding="0" cellspacing="0" class="linea-botton">
			<tr>
				<td>
				<div align="left" class="login"><bean:message key="lbl.compensacion.parametro.titulo.2" /></div>
				</td>
				<td width="8%"><div align="right">&nbsp;
				<INPUT class="botton" onclick="document.location='<html:rewrite page='/mant/representante.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td class="texto-acceso">&nbsp;</td>
	</tr>
	<tr>
		<% String doubleCuote = (String)session.getAttribute("representante.accion.nuevo"); %>		
		<td valign="top"><html:form
			method="post"
			action="/grabar/representante">
			<html:hidden styleId="nuevo" property="nuevo" value="<%= doubleCuote%>"/>
			<html:hidden styleId="numero" property="numero" />
			<!-- Agrego campo oculto ciu Edgar Sucre => 06/03/2012 -->
			<html:hidden styleId="numero" property="ciu" />			
			
			<table
				width="100%"
				border="0"
				cellpadding="5"
				cellspacing="1">
				<tr>
					<td height="20" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido" /></td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.cuenta" />(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida"><html:select property="cuenta" styleClass="lstbox">
											<bean:define id="cp" scope="session" name="cuentasCompensacion" type="java.util.ArrayList"/>
				                            <html:options collection="cp" property="codigoCSIC" labelProperty="codigoBanco"/>
										   </html:select></td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.nombre" /></td>
					<td class="bienvenida"><div class="txtTexto"><html:text property="nombre" size="50" maxlength="150"/></div></td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.identificacion" />(<font color="#FF0000">*</font>)</td>
					<td><table>
						   <tr valign="middle">
						     <td class="bienvenida">
								<html:select styleId="tipoIdentificacion" property="tipoIdentificacion" styleClass="botton-acceso">
									<bean:define id="cp2" scope="session" name="tipos" type="java.util.ArrayList"/>
					                <html:options collection="cp2" property="codigo" labelProperty="descripcion"/>
								 </html:select>
							</td>
							<td class="bienvenida" align="right">

								<div class="txtTexto"><html:text  property="identificacion" size="25" maxlength="20"  /></div>

								

							</td>
						  </tr>
						</table></td>

										   
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.direccion" />(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida"><div class="txtTexto"><html:text property="direccion" size="50" maxlength="200"/></div></td>
				</tr>
				<!-- Comento el campo CIU Edgar Sucre => 06/03/2012
				<tr valign="middle">
					<td class="bienvenida">CIIU(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida"><html:select property="ciu" styleClass="lstbox">
											<bean:define id="cp4" scope="session" name="actividades.parametro" type="java.util.ArrayList"/>
				                            <html:options collection="cp4" property="codigo" labelProperty="descripcion"/>
										   </html:select></td>
				</tr>
				 -->
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.ciudad" />(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida"><html:select property="ciudad" styleClass="lstbox">
											<bean:define id="cp3" scope="session" name="ciudades" type="java.util.ArrayList"/>
				                            <html:options collection="cp3" property="codigo" labelProperty="descripcion"/>
										   </html:select></td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.telefono" />(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida"><div class="txtTexto"><html:text property="telefono" size="30" maxlength="30"/></div></td>
				</tr>
				<tr valign="middle">
					<td class="bienvenida"><bean:message key="lbl.compensacion.parametro.email" />(<font color="#FF0000">*</font>)</td>
					<td class="bienvenida"><div class="txtTexto"><html:text property="email" size="30" maxlength="60"/></div></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><html:submit styleClass="botton">Aceptar</html:submit> &nbsp;&nbsp;<INPUT class="botton" onclick="document.location='<html:rewrite page='/mant/representante.do'/>'" type="button" value="<bean:message key="lbl.retroceder"/>">
				</tr>
				</table>
		</html:form></td>
	</tr>
</table></div>
<%@ include file="../footer.jsp"  %>	
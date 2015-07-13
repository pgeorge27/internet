<% session.setAttribute("selected", "custodia"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@page import="com.arango.common.banking.Productos"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.common.beans.PerfilXML"%>
<%@ page import="com.arango.internet.banking.Custodia"%>
<%@page import="com.arango.common.delegate.cliente.drivers.arango.DrvNroCuenta"%>
<%@page import="com.arango.common.beans.Cuenta"%>

<%
ArrayList cuentas = new ArrayList();

if (session.getAttribute("ctaCustodia") == null || ((ArrayList)session.getAttribute("ctaCustodia")).isEmpty()){
	PerfilXML p3 = (PerfilXML)session.getAttribute("perfil.xml");
	if (p3 == null)
		pageContext.forward("/index.jsp");
		
	cuentas = p3.getCuentasPorProducto(new String[]{"12"}, null);
	if (cuentas != null && !cuentas.isEmpty()){
		Custodia cus = null;
		ArrayList custodias = new ArrayList();
		DrvNroCuenta	  nroCta = null;
		Cuenta c = null;
		for(int i = 0; i < cuentas.size(); i++){
			c = (Cuenta)cuentas.get(i);
			cus = new Custodia();
			
			nroCta = new DrvNroCuenta(c.getCodigoBanco());
			cus.setNroCuenta((int)nroCta.getNroCuenta());
			cus.setCodigo((int)nroCta.getNroCuenta());
			cus.setCodigoEmisor(Integer.parseInt(c.getTitular()));
			custodias.add(cus);
		}
		session.setAttribute("ctaCustodia", custodias);
	}
}
String backPage = "seleccion";

%>
<%@ include file="../head.jsp"  %>

<link rel="stylesheet" type="text/css" media="all" href="<html:rewrite page='/calendar/calendar-win2k-1.css'/>" title="win2k-1">

<script language='javascript'>
var t;
function send(){
    if (document.forms['movimientoForm'].cuenta.value == "")
	{
	   alert("<bean:message key="msg.seleccionar.cuenta"/>");
	   document.forms['movimientoForm'].cuenta.focus();
	   return;
	}
	
	
	document.forms['movimientoForm'].submit();
}
function setValue(_value){
	t = _value;
}
function retornar(){
	history.back();
}
</script>

<%@ include file="../body.jsp"%>
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="center"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login">Reportes</div></td>
                        <td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
                      </tr>
                    </table>
                  </div></td>
              </tr>
              <tr> 
                <td height="40" class="texto-acceso">&nbsp;</td>
              </tr>
              <tr> 
                <td valign="top">
				<html:form method="post" action="/custodia/reportes" target="_NEW">
                    <table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
                      
                      <tr> 
                        <td width="41%" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.cuentas"/></div></td>
                        <td width="59%">
                            <html:select property="cuenta" styleClass="lstbox">
									<logic:notEmpty name="ctaCustodia">
											<html:option value=""><bean:message key="lbl.seleccione.una.cuenta"/></html:option>
											<bean:define id="cp" scope="session" name="ctaCustodia" type="java.util.ArrayList"/>
				                            <html:options collection="cp" property="codigo" labelProperty="nroCuenta"/>
										   
									</logic:notEmpty>
									<logic:empty name="ctaCustodia">
										<html:option value=""><bean:message key="lbl.seleccione.no.hay.cuentas"/></html:option>
									</logic:empty>
							   	 </html:select>	 <span class="texto-acceso">(<font color="#FF0000">*</font>)</span></td>
                      </tr>
                     
                      <tr>
                        <td>&nbsp;<br><br></td>
                        <td><input name="botonEnviar" onclick="send();" type="button" class="botton" value="<bean:message key="btn.consultar"/>">&nbsp;&nbsp;&nbsp;&nbsp; 
							<input TYPE="BUTTON" class="botton" VALUE="<bean:message key="lbl.retroceder"/>" onclick="retornar()"></td>
                      </tr>
                    </table>
                  </html:form></td>
              </tr>
              <tr>
                <td height="25" align="center" valign="middle" class="texto-acceso"><bean:message key="lbl.mensaje.campo.requerido"/></td>
              </tr>
            </table>

<%@ include file="../footer.jsp"  %>
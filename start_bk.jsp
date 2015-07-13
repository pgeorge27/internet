<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="/tags/asi-common" prefix="common" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales"%>
<%@ page import="com.arango.common.beans.PerfilXML"%>
<%@ page import="com.arango.common.beans.Cliente"%>
<%@ page import="com.arango.common.beans.ClaveEspecial"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.arango.common.sql.*"%>
<%@ page import="com.arango.internet.beans.*" %>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.arango.common.beans.Cuenta"%>
<%@ page import="com.arango.internet.banking.Vencimiento"%>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>
<%!
 private String isPermiteDescarga(String usuario) throws SQLException {
    String sql = "select PERMITE_DESCARGA from  CSIC_USUARIO_X_CLIENTES"+
               " WHERE user_id = ?";
    Connection conn = null;
    ResultSet rs =  null;
	PreparedStatement p = null;
    try {
        conn = ConnectionFactory.getConnectionCSIC();
        p = conn.prepareStatement(sql);
      
        
        p.setString(1, usuario);
        
        rs = p.executeQuery();
		if(rs.next()){
			return rs.getString(1);
			
		}
		return "N";
       
    } finally {
        if (rs != null) {
            rs.close(); 			
        }
		if (p != null) {
            p.close();
        }
		if (conn != null) {
            conn.close();
        }
    }
 }
%>
<%

PerfilXML p2 = (PerfilXML)session.getAttribute("perfil.xml");
if (p2 == null)
	pageContext.forward("/index.jsp");
String nom = "";
nom = p2.getNombre();
String permiteDescarga = (String)session.getAttribute("permite.descarga");
if (permiteDescarga == null){
	String userId = (String)session.getAttribute("user.id");
	permiteDescarga = isPermiteDescarga(userId);
	session.setAttribute("permite.descarga",permiteDescarga);
}
ArrayList mensaje = new ArrayList();
ArrayList javascript = new ArrayList();

Calendar calendar = Calendar.getInstance();
calendar
        .setTime(new Date(System.currentTimeMillis()));

java.util.Date fechaHoy =  calendar.getTime();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy");
String fecha = sdf.format(fechaHoy);
if(session.getAttribute("codigo.role.compensacion") != null){
String roleCompensacion = (String)session.getAttribute("codigo.role.compensacion");

String mensajeImportacion="Documento de transporte No. <b>{1}</b>, correspondiente a la Importación No. <b>{2}</b> por valor de USD <b>{3}</b>.";
String mensajeExportacion="Documento de Exportación No. <b>{1}</b>, correspondiente a la Venta No. <b>{2}</b> por valor de USD  <b>{3}</b>.";
String mensajeExportacionAnticipada="Reintegro anticipado por valor de <b>{1}</b>, correspondiente a la Venta No. <b>{2}</b>.";

if (!"".equals(roleCompensacion)){
	IBCompensacion ibcomp = new IBCompensacion();
	ArrayList arreglo = null;   
	
	ArrayList cta = (ArrayList)session.getAttribute("ctasCompensacion");
	Cuenta c = null;
	Vencimiento v = null;
	for(int i =0; i < cta.size(); i++){
		c = (Cuenta)cta.get(i);
		arreglo = ibcomp.VencimientoConsulta(fechaHoy, fechaHoy, fechaHoy, c.getCodigoBanco(),1);
		if(!arreglo.isEmpty() && arreglo.get(0)!= null){
			v = (Vencimiento)arreglo.get(0);
			if (1 == v.getMensaje()){
				mensaje.add(java.text.MessageFormat.format(mensajeImportacion, new Object[]{fecha, v.getDocTransporte(), v.getNumImportacion(), f.formatMonto(v.getValor())}));
				javascript.add("__ok('"+fecha+"', "+c.getCodigoCSIC()+", "+1+")");
			}
		}
		
		arreglo = ibcomp.VencimientoConsulta(fechaHoy, fechaHoy, fechaHoy, c.getCodigoBanco(),2);
		if(!arreglo.isEmpty() && arreglo.get(0)!= null){
			v = (Vencimiento)arreglo.get(0);
			if (1 == v.getMensaje()){
				mensaje.add(java.text.MessageFormat.format(mensajeExportacion, new Object[]{fecha, v.getNumExportacion(), v.getNumDex(), f.formatMonto(v.getValor())}));
				javascript.add("__ok('"+fecha+"', "+c.getCodigoCSIC()+", "+2+")");
			}
		}
		arreglo = ibcomp.VencimientoConsulta(fechaHoy, fechaHoy, fechaHoy, c.getCodigoBanco(),3);
		if(!arreglo.isEmpty() && arreglo.get(0)!= null){
			v = (Vencimiento)arreglo.get(0);
			if (1 == v.getMensaje()){
				mensaje.add(java.text.MessageFormat.format(mensajeExportacionAnticipada, new Object[]{fecha, f.formatMonto(v.getValor()), v.getNumeroDeclaracion()}));
				javascript.add("__ok('"+fecha+"', "+c.getCodigoCSIC()+", "+3+")");
			}
		}
	}
	
	
}
}
%>

<%try{%> <%@ include file="head.jsp"%> <%}catch(Exception e){;}%>

<style>

a.ln, a.ln:active,a.ln:link,a.ln:visited, a.ln:hover {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #004284;
	text-decoration: none;
}
a.ln:hover {
	text-decoration: underline;
}
</style>
</head>

<%try{%> <%@ include file="body.jsp"%> <%}catch(Exception e){;}%>

<table width="750" border="0" align="left" cellpadding="0" cellspacing="0">
<tr valign="top"> 
<td height="40" valign="bottom"><div align="left"> 
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
	 
	  <tr> 
		<td width="32%" class="tabla-acceso"><div align="center" class="bienvenida"><bean:message key="tit.bienvenida"/>  
			<strong><%=nom%></strong></div></td>
		<td width="68%">&nbsp;</td>		
		
	  </tr>	  
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	
	<% 
	
	String var = session.getAttribute("validacion.dias")!=null? session.getAttribute("validacion.dias").toString():"1";
	Object leyenda = session.getAttribute("leyenda");
	String diasDian = session.getAttribute("validacion.dias.dian")!= null?session.getAttribute("validacion.dias.dian").toString():"d";
   
    if(var != "1" && leyenda != null ){
	%>
	    <tr>
		   <td>
	    <div align="center">                     
                               
                   <table width="100%" border="0" cellspacing="2" cellpadding="2" class="tabla-acceso1">
                       <tr> 
                         <td width="100%" rowspan="2"><div align="center"> 
                             <table width="100%" border="0" cellspacing="2" cellpadding="2" aling="center">
                               <tr> 
                                 <td><div align="left"><img src="<html:rewrite page='/images/icon_info_lrg.gif'/>"></div></td>
                               </tr>
	                               <tr> 
	                                <td width="68%" class="bienvenida"><b> <%= leyenda %>: &nbsp;<%=var.substring(1, var.length()-1)%></b> </td>		 
	                           </tr> 
                               </table>
						</td>                                
                     </tr>
			   </table>	   
			   </div>        							   
			</td></tr>
	  <% } 
	  if(diasDian != "d"){		  
	  %>
	  <tr><td>
	  <div align="center">     
	 	 <table width="100%" border="0" cellspacing="2" cellpadding="2" class="tabla-acceso1">
             <tr> 
               <td width="100%" rowspan="2"><div align="center"> 
                   <table width="100%" border="0" cellspacing="2" cellpadding="2" aling="center">                               
                      <tr> 
                        <td width="68%" class="bienvenida"><b><%=diasDian.substring(1, diasDian.length()-1) %></b></td>	 
                 	 </tr> 
                   </table>
	        	</td></tr>
	      </table>
	  </div></td></tr>
	  <%}%>
	 <tr><td>
	  <br>
	   <%if(!mensaje.isEmpty()){ %>
	   <html:form method="post" action="/actualiza/control">
	<html:hidden property="cuenta"/>
	<html:hidden property="tipoVencimiento"/>
	<html:hidden property="desde"/>
	<html:hidden property="hasta"/>
</html:form>
	   <script language="javascript">
function __ok(__date, __acct, __type){
	document.forms["vencimientoForm"].tipoVencimiento.value=__type;
	document.forms["vencimientoForm"].cuenta.value=__acct;
	document.forms["vencimientoForm"].desde.value=__date;
	document.forms["vencimientoForm"].hasta.value=__date;
	document.forms["vencimientoForm"].submit();
}
</script>
	   <div align="center">     
		 <table width="100%" border="0" cellspacing="2" cellpadding="2" class="tabla-acceso1">
              <tr> 
                <td width="100%"> 
                    <table width="100%" border="0" cellspacing="2" cellpadding="2" align="left">
                      <tr> 
                        <td width="5%"><div align="left"><img src="<html:rewrite page='/images/icon_info_lrg.gif'/>"></div></td>
                        <td width="95%" class="bienvenida" align="left"><b>Estimado Cliente:</b> <br>
                        De acuerdo con su control de vencimientos nos permitimos informarle que hoy <b><%=fecha %></b> finaliza el plazo para:</td>	 
	                   </tr> 
	                 </table>
                 <tr><td colspan="2">    
                 <table width="100%" border="0" cellspacing="2" cellpadding="2" align="left">        
		 <% 
		   for(int i=0; i< mensaje.size(); i++){
			%>   			 
			 <tr class="<%=i%2==0?"celda-clave1":"" %>">
			    <td width="90%" class="bienvenida"><%=mensaje.get(i) %></td>
			    <td width="10%" align="center" class="bienvenida"><input type="button" class="botton" value="OK" onclick="<%=javascript.get(i) %>"/></td>
			 </tr>  
		<%  }		//cierra for%>
	   </table></td></tr></table>
  </div>
	  <%} %> 
	</td></tr>
<tr><td><br><br></td></tr>

<csic:clave-especial/>
<% 
if ("true".equals(session.getAttribute("mostrar.mensaje.clave.especial")) 
		&& session.getAttribute("clave.secundaria") != null ){
ClaveEspecial clave = (ClaveEspecial)session.getAttribute("clave.secundaria");

 if ( ConstantesGlobales.PRIMER_LOGIN == clave.getFlag()){ %>
<tr>
  <td class="bienvenida2" colspan="2"><bean:message key="lbl.clave.especial.cambiar"/>
	<a href="<html:rewrite page='/ib/cambioClaveEspecial.jsp'/>">
	<bean:message key="lbl.clave.especial.click.aqui"/></a></td></tr>
<% }
 else if(ConstantesGlobales.CLAVE_BLOQUEADA.equals(clave.getEstado())){
	 %>
 <tr>
  <td class="bienvenida" colspan="2">
	 
	 <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="bienvenida"><bean:message key="lbl.clave.especial.bloqueada"/><br>
	 <bean:message key="lbl.clave.especial.mensaje"/>
								   </td></tr>
			 </table></td></tr>
		  </table></td></tr>
	 
	 <%
 }
 else if(ConstantesGlobales.CLAVE_EXPIRADA.equals(clave.getEstado())){
	 %>
  <tr>
  <td class="bienvenida" colspan="2">
  <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="bienvenida"><bean:message key="lbl.clave.especial.expirada"/><br>
	 <bean:message key="lbl.clave.especial.mensaje"/>
								   </td></tr>
			 </table></td></tr>
		  </table>
	 </td></tr>
	 <%
 }
}%>

<logic:present name="mensajes.compensacion">
<%
String fechaInicioStart=null;
String fechaFinalStart=null;
SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
Calendar cal = Calendar.getInstance();
fechaFinalStart=df.format(cal.getTime());
cal.set(Calendar.DATE, 1); 
fechaInicioStart=df.format(cal.getTime());
%>
<html:form method="post" action="/consulta/estado">
	<html:hidden property="cuenta"/>
	<html:hidden property="estado" value="P"/>
	<html:hidden property="desde" value="<%=fechaInicioStart%>"/>
	<html:hidden property="hasta" value="<%=fechaFinalStart%>"/>
</html:form>
<script>
function _start_consulta(cta){
	document.forms["consultaEstadoForm"].cuenta.value=cta;
	document.forms["consultaEstadoForm"].submit();
}
</script>

<%
Hashtable msg = (Hashtable)session.getAttribute("mensajes.compensacion");
String key = null;
Enumeration keys = msg.keys();
for (;keys.hasMoreElements();){
    key = keys.nextElement().toString();
%>
<tr>
  <td class="bienvenida" colspan="2">
  <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>"></td>
								   <td width="95%" class="bienvenida"><%=msg.get(key) %><br>
	 Si desea consultar los movimientos pendientes haga CLICK <a href="javascript:_start_consulta(<%=key %>);">Aquí</a>
								   </td></tr>
			 </table></td></tr>
		  </table>
 </td></tr>
 <%} %>
 </logic:present>
 <tr>
  <td class="bienvenida" colspan="2">
  <table cellpadding="1" cellspacing="1" width="100%" class="tabla-acceso">
		  <tr><td>
			 <table border="0" cellpadding="1" cellspacing="0" width="100%">
				  <tr valign="top"><td width="100%" class="bienvenida">
	 Ya puede descargar sus transferencias en Formato Swift.
								   </td></tr>
								   <tr><td><a href="<html:rewrite page='/guia-swift.pdf'/>" class="ln" target="_NEW">Instructivo On Line</a></td></tr>
			 </table></td></tr>
		  </table>
 </td></tr>
<tr> 
<td height="30" class="texto-acceso"><br><br></td>
</tr>
<tr height="60%"><td>&nbsp;</td></tr>
</table>
<%@ include file="footer.jsp" %>
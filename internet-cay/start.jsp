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
<%
Parametro paran = new Parametro();
  paran = paran.getParametros();

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
<% session.setAttribute("selected", "inicio"); %>
<%try{%> <%@ include file="head.jsp"%> <%}catch(Exception e){;}%>


<%@page import="com.arango.common.beans.Parametro"%><style>

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

<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
<tr valign="top"> 
<td width="300px" height="40">
	<table width="300px" border="0" cellpadding="0" cellspacing="0" class="titulo2" align="center">
	  <tr> 
		<td>
		<bean:message key="tit.bienvenida"/>  
			<strong>:<%=nom%></strong>
		</td>
	  </tr>
	  <tr valign="top"><td class="bottom-line">&nbsp;</td></tr> 
	</table>
</td>
<td>
	<table width="100%" cellpadding="0" cellspacing="0">
	  <tr><td align="right" width="90%">
     <div id="z_se_v2" z.type="zul.wnd2.Wnd2" z.autoz="true"
          class="z-window-embedded" style="width:250px;height:302px;"
          z.zcls="z-window-embedded" z.minheight="100" z.minwidth="200"
          z.conshow="setTimeout(showMessage(), 30000);">
		  <div id="z_se_v2!cave" class=" z-window-embedded-cnt">
             <div id="z_se_03" class="z-separator-hor" style="height:85px;" z.zcls="z-separator-hor">&nbsp;
             </div>

             <div id="z_se_13" z.conshow="anima.slideUp( $e('z_se_13'), 200);" z.conhide="anima.fade( $e('z_se_13'));">
                 <span id="z_se_23" class="helm-label-news z-label" z.zcls="z-label" class="z-label">
			<%=paran.getmensage_postit()!= null ? paran.getmensage_postit() : ""%>
			    </span>
             </div>
         </div>
     </div>
	 </td><td width="10%">&nbsp;</td>
	 </tr>
	 </table>
</td>
</tr>
</table>
	
<br>
<%@ include file="footer.jsp" %>
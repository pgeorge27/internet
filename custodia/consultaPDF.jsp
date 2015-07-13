<% session.setAttribute("selected", "custodia"); %>
<%@ taglib uri="/tags/asi-pdf" prefix="csic" %>

<%@ page import="java.util.Locale" %>
<%@ page import="com.arango.common.util.Format"%>
<%@ page import="com.arango.internet.banking.Custodia"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!

Format f = Format.getFormat();
private String formatDocument(String doc){
      String year = doc.substring(doc.length() - 2, doc.length());
      String num = doc.substring(2, doc.length()- 2);
      return num+"-"+year;  
    }

%>
<%
Locale locale = null;
java.util.ArrayList mov = null;

java.util.Date fechaCustodia = null;
StringBuffer nombreFile = null; 
SimpleDateFormat dateFormater = null;

float wm[] = null;
int ALIGN_RIGHT=0;
int ALIGN_CENTER=0;
int ALIGN_LEFT=0;

%>
<%try{
 locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
 mov = (java.util.ArrayList)session.getAttribute("custodia");

 fechaCustodia = (java.util.Date)session.getAttribute("fecha.consulta.custodia");
 nombreFile = new StringBuffer("attachment; filename=statement");   
 dateFormater = new SimpleDateFormat("ddMMyyyy");

dateFormater.applyPattern("ddMMyyyy");
nombreFile.append(dateFormater.format(new java.util.Date(System.currentTimeMillis())));
nombreFile.append(".pdf");

response.addHeader("Content-disposition", nombreFile.toString() );

 wm = new float[]{.07f,.07f,.10f,.10f,.10f,.10f,.10f,.10f,.10f,.07f,.10f};
 ALIGN_RIGHT=com.lowagie.text.Cell.ALIGN_RIGHT;
 ALIGN_CENTER=com.lowagie.text.Cell.ALIGN_CENTER;
 ALIGN_LEFT=com.lowagie.text.Cell.ALIGN_LEFT;
}catch(Exception ex){ex.printStackTrace();}
%>  
<%try{ %>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%><csic:doc height="612" width="792" author="tit.title.banco" title="tit.title.consulta.estado.cuenta.ca">
<csic:table width="10.0f" rows="1" cols="1">
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>	
</csic:table>
<csic:table width="10.0f" rows="1" cols="1">
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>	
</csic:table>
<csic:table width="100.0f" rows="1" cols="1">
	<csic:head key="" label="Consulta de Inversiones" align="<%=ALIGN_CENTER%>" bold="true" fontSize="12"/>
</csic:table>	  

<csic:table width="50.0f" rows="3" cols="2">
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
	<csic:head label=" " key=" " bold="true" fontSize="10"/>
</csic:table>

<csic:table width="70.0f" rows="3" cols="2">   
	<csic:head label="Nro. Custodia" key="" bold="true" fontSize="8" background="true" align="<%=ALIGN_RIGHT%>"/>	
	<csic:cell label="<%=(String)session.getAttribute("ctaCustodia") %>"/>
	<csic:head label="Cliente" key="" bold="true" fontSize="8" background="true" align="<%=ALIGN_RIGHT%>"/>	
	<csic:cell label="<%=(String)session.getAttribute("nombre.cliente.custodia") %>"/>
			<csic:head label="Fecha" key="" bold="true" fontSize="8" background="true" align="<%=ALIGN_RIGHT%>"/>	
	<csic:cell label="<%=f.formatFecha(fechaCustodia, locale)%>"/>
</csic:table>


<csic:table width="100.0f" rows="1" cols="1">
	<csic:head label=" " key="" bold="true" fontSize="10"/>
</csic:table>

<csic:table width="100.0f" rows="1" cols="11" >
	<csic:head label="Fecha Compra" key="" bold="true" fontSize="7" background="true"/>
	<csic:head label="Fecha Vencimiento" key="" bold="true" fontSize="7" background="true"/>
	<csic:head label="Emisor" bold="true" key="" fontSize="7" background="true"/>
	<csic:head label="Producto" key="" bold="true" fontSize="7" background="true"/>
	<csic:head label="Valor Nominal" key="" bold="true" fontSize="7" background="true"/>
	<csic:head label="Cupon" key="" bold="true" fontSize="7" background="true"/>
	<csic:head label="Precio Compra" key="" bold="true" fontSize="7" background="true"/>
	<csic:head label="T.I.R" key="" bold="true" fontSize="7" background="true"/>
	<csic:head label="Valor Giro" key="" bold="true" fontSize="7" background="true"/>
	<csic:head label="Prox. Pago Int." key="" bold="true" fontSize="7" background="true"/>
	<csic:head label="Detalle"  key="" bold="true" fontSize="7" background="true"/>
</csic:table>
<%

Custodia m = null;
String document = null;
String moneda = "";
double total = 0;
boolean registro = true;
for (int i = 0; i < mov.size(); i++){
 m = (Custodia)mov.get(i);

 
 
 if( moneda.equals(m.getMonedaNominal())){
		
 }	else {	
	
	moneda = m.getMonedaNominal();
	
	if(!registro) {
%>

   <csic:table width="100.0f" rows="1" cols="5" >
 	   <csic:head label="Total Moneda" key="" bold="true" fontSize="7" background="true"/>
       <csic:head label="" key="" bold="true" fontSize="7" background="true"/>       
       <csic:head label="<%=f.formatMonto(total)%>" key="" bold="true" fontSize="7" background="true"/>
    </csic:table>


  <% } %>
  <csic:table width="100.0f" rows="1" cols="1">
	<csic:head label=" " key="" bold="true" fontSize="7"/>
</csic:table>
     <csic:table width="100.0f" rows="1" cols="1">
		<csic:head key="" bold="true" fontSize="7" label="<%=m.getMonedaNominal() %>"/>
   </csic:table>
	<csic:table width="100.0f" rows="1" cols="1">
	<csic:head label=" " key="" bold="true" fontSize="7"/>
</csic:table>	
		
		
       
<%
registro = false;
total= 0;
 }		//cierra el else %>
   
 
   <csic:table width="100.0f" rows="1" cols="11" headerWidths="<%=wm%>">
 		<csic:head label="<%=f.formatFecha(m.getFechaCompra(), locale)%>"  key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=f.formatFecha(m.getFechaVencimiento(), locale)%>"  key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=m.getNombreEmisor() %>" key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=m.getNombreProducto() %>" key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=f.formatMonto(m.getValorNominal()) %>" align="<%=ALIGN_CENTER%>" key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=f.formatMonto(m.getCupon()) %>" align="<%=ALIGN_CENTER%>" key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=f.formatMonto(m.getPrecioCompra()) %>" align="<%=ALIGN_CENTER%>" key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=f.formatMonto(m.getTir()) %>" align="<%=ALIGN_CENTER%>" key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=f.formatMonto(m.getValorGiro()) %>" align="<%=ALIGN_CENTER%>" key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=f.formatFecha(m.getFechaprox(), locale) %>" key="" bold="false" fontSize="7" background="false"/>
		<csic:head label="<%=m.getDetalle() ==null?"":m.getDetalle()%>" key="" bold="false" fontSize="7" background="false"/>
   </csic:table>
  
 <% 
 total +=  m.getValorNominal(); 
}		//cierra el for
 %> 
 <csic:table width="100.0f" rows="1" cols="5" >
 	   <csic:head label="Total Moneda" key="" bold="true" fontSize="7" background="true"/>
       <csic:head label="" key=""   bold="true" fontSize="7" background="true"/>       
       <csic:head label="<%=f.formatMonto(total)%>" key="" bold="true" fontSize="7" background="true"/>
    </csic:table>
<csic:table width="50.0f" rows="1" cols="1"><!--DWLayoutTable-->
	<csic:head key="msg.sin.movimentos" align="<%=ALIGN_LEFT%>"/>
</csic:table>
<csic:table width="10.0f" rows="1" cols="1">
	<csic:head label=" " key=" " bold="true" fontSize="7"/>
</csic:table>

</csic:doc>

<% }catch(Exception e ){e.printStackTrace();} %>

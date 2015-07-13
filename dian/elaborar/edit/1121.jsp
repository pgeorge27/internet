<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="include/jspfunciones.inc.jsp" %>
<%@ include file="/head.jsp"  %>
<%  
  
   //Conectando a la base de datos
   try{
   //Cragano los datos de DTPAIS
   session.setAttribute("{codigoPais}", GetList(application, "DTPAIS"));	
   
   //Cragano los datos de DTABLA7
   session.setAttribute("{codigoMoneda}", GetList(application, "DTABLA7"));	
   
   //Cragano los datos de DMUNICIPIO
   java.util.ArrayList data = GetList(application, "DMUNICIPIO");
   session.setAttribute("{codigoMunicipioBeneficiario}", data);		
   session.setAttribute("{codigoMunicipio}", data);	
   
   //Cragano los datos de DTPAGO
   session.setAttribute("{formaPago}", GetList(application, "DTPAGO"));	
   session.setAttribute("{codigoClaseCompraVenta}", GetList(application, "DTPAGO"));	
   
   //Cragano los datos de DTABLA1
   session.setAttribute("{tipoNegociacion}", GetList(application, "DTABLA1"));	
   session.setAttribute("{codigoConceptoOperacion}", GetList(application, "DTABLA16"));
   
   //Cragano los datos de DTABLA8
   data = GetList(application, "DTABLA8");
   session.setAttribute("{tipoDocumentoCliente}", data);	
   session.setAttribute("{tipoDocumentoBeneficiario}", data);   
   
   
   }catch (Exception e) { }	
   %>

   <%@ include file="/body.jsp"%>	
   <%@ include file="./templates/1121.jsp"  %>
   <%@ include file="/footer.jsp"  %>


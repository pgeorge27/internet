<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="include/jspfunciones.inc.jsp" %>
<%@ include file="/head.jsp"  %>
<%  
   
   //Conectando a la base de datos
   try{
       session.setAttribute("{codigoMoneda}", GetList(application, "DTABLA7"));	
   
   //Cragano los datos de DMUNICIPIO
   java.util.ArrayList data = GetList(application, "DMUNICIPIO");
   session.setAttribute("{codigoMunicipioBeneficiario}", data);		
   session.setAttribute("{codigoMunicipio}", data);	
   
   
   //Cragano los datos de DTPAGO
   session.setAttribute("{formaPago}", GetList(application, "DTPAGO"));		
   //Cragano los datos de DTABLA1
   session.setAttribute("{tipoNegociacion}", GetList(application, "DTABLA1"));		
   
   //Cragano los datos de DTABLA8
   data = GetList(application, "DTABLA8");
   session.setAttribute("{tipoDocumentoCliente}", data);	
   session.setAttribute("{tipoDocumentoBeneficiario}", data);   
   
   }catch (Exception e) { }	
   %>

   <%@ include file="/body.jsp"%>	
   <%@ include file="./templates/1100.jsp"  %>
   <%@ include file="/footer.jsp"  %>


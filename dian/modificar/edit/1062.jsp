<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%@ include file="include/jspfunciones.inc.jsp" %>
<%@ include file="/head.jsp"  %>
<%  
   //Lectura de la Plantilla

   //Conectando a la base de datos
   try{
   session.setAttribute("{tipoIdentificacionImportador}", GetList(application, "DTABLA8"));
      
   //Cragano los datos de DMUNICIPIO
   session.setAttribute("{codigoCiudad}", GetList(application, "DMUNICIPIO"));
  
    //Cragano los datos de DTABLA7
   session.setAttribute("{codigoMoneda}", GetList(application, "DTABLA7"));

   }catch (Exception e) { }	

   
   %>

   <%@ include file="/body.jsp"%>	
   <%@ include file="./templates/1062.jsp"  %>
   <%@ include file="/footer.jsp"  %>

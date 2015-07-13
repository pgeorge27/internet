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
   
      
   }catch (Exception e) { }	
   
   
%>

<%@ include file="/body.jsp"%>	
<%@ include file="./templates/1059.jsp"  %>
<%@ include file="/footer.jsp"  %>

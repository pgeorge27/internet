<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="include/jspfunciones.inc.jsp" %>
<%@ include file="/head.jsp"  %>
<%  
  //Lectura de la Plantilla

   //Conectando a la base de datos
   try{
   //Cragano los datos de DTABLA8
   session.setAttribute("{tipoIdentificacion}", GetList(application, "DTABLA8"));			
   
   //Cragano los datos de DTABLA12
   session.setAttribute("{procesamientoDeclaracion}", GetList(application, "DTABLA12"));	
   }catch (Exception e) { }	

   
   %>

   <%@ include file="/body.jsp"%>	
   <%@ include file="./templates/1067.jsp"  %>
   <%@ include file="/footer.jsp"  %>


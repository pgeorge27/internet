<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


<%@ include file="include/jspfunciones.inc.jsp" %>
<%@ include file="/head.jsp"  %>
<%  
   //Lectura de la Plantilla

   //Conectando a la base de datos
   try{
   java.util.ArrayList data =  GetList(application, "DTABLA7");
   session.setAttribute("{codigoMonedaNegociacion}",data);
   session.setAttribute("{codigoMoneda}",data);
   session.setAttribute("{codigoMonedaNegociacion}",data);
   
   //Cragano los datos de DTABLA8
   session.setAttribute("{tipoIdentificacion}", GetList(application, "DTABLA8"));	
   
   //Cragano los datos de DMUNICIPIO
   session.setAttribute("{codigoCiudad}", GetList(application, "DMUNICIPIO"));
   
   //Cragano los datos de DTABLA10
   session.setAttribute("{codigoPropositoPrestamo}", GetList(application, "DTABLA10"));
   }catch (Exception e) { }	

   
   %>

   <%@ include file="/body.jsp"%>	
   <%@ include file="./templates/1064.jsp"  %>
   <%@ include file="/footer.jsp"  %>

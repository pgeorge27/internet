
<%@ page language="java" 

contentType="text/html;charset=iso-8859-1" 

import="java.util.*, java.io.*,
 
 java.text.DateFormat,
 java.text.SimpleDateFormat,
 java.util.Calendar,
 com.arango.internet.banking.dian.*,
 java.util.Date" %>
 <%@ page import="com.arango.common.util.StringUtilities"%>

<%
String name = (String)session.getAttribute("frm.dian.nombre.documento");
response.addHeader("Content-disposition", name);
DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
SimpleDateFormat df =  new SimpleDateFormat("yyyy-MM-dd");
try
{
String xmlStr ="";
//header for use in parser
String xmlStrForParse = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";
String headerXml = 

"<mas xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"1059.xsd\"> " +
"<Cab>"+
"<Ano>" + StringUtilities.getValidXML(session.getAttribute("frm.dian.year")) + "</Ano> " +
"<CodCpt>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.concepto")) + "</CodCpt>" +
"<Formato>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.formato")) + "</Formato>" +
"<Version>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.version")) + "</Version>" +
"<NumEnvio>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.numero.envio")) + "</NumEnvio>" +
"<FecEnvio>" + StringUtilities.getValidXML(session.getAttribute("frm.dian.fecha.envio")) + "</FecEnvio>" +
"<FecInicial>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.fecha.inicial")) + "</FecInicial>" +
"<FecFinal>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.fecha.final")) + "</FecFinal>" +
"<ValorTotal>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.valor.total")) + " </ValorTotal>" +
"<CantReg>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.cant.registro"))+ "</CantReg>" +
"</Cab> ";

xmlStr += headerXml;		

ArrayList cImports = (ArrayList) session.getAttribute("frm.dia.registros");
		
    //for(Formulario form1059 : cImports)
	for(int i = 0; i < cImports.size(); i++)
	{
	   Formulario form1059 = (Formulario) cImports.get(i);
	   String xmlCont =

"<cimportacion "+
"ccom=\"" +  StringUtilities.getValidXML(form1059.getCodigoCuentaCompensacion()) + "\" " + 
"tinf=\"" +  StringUtilities.getValidXML(form1059.getTipoInformante()) + "\" " + 
"top=\"" +  StringUtilities.getValidXML(form1059.getTipoOperacion()) + "\" " + 
"fdec=\"" +  StringUtilities.getValidXML(form1059.getFechaDeclaracionCambio(), "yyyy-MM-dd") + "\" " + 
"fdeca=\"" +  StringUtilities.getValidXML(form1059.getFechaDeclaracionCambioAnterior(), "yyyy-MM-dd") + "\" " + 
"dv=\"" +  StringUtilities.getValidXML(form1059.getDigitoVerificador()) + "\" " +
"ndec=\"" +  StringUtilities.getValidXML(form1059.getNumeroDeclaracionCambio()) + "\" " + 
"ndeca=\"" +  StringUtilities.getValidXML(form1059.getNumeroDeclaracionCambioAnterior()) + "\" " + 
"tdoc=\"" +  StringUtilities.getValidXML(form1059.getTipoIdentificacionImportador()) + "\" " + 
"nid=\"" +  StringUtilities.getValidXML(form1059.getNumeroIdentificacionImportador())+ "\" " + 
"apl1=\"" +  StringUtilities.getValidXML(form1059.getPrimerApellidoImportador()) + "\" " + 
"apl2=\"" +  StringUtilities.getValidXML(form1059.getSegundoApellidoImpotador()) + "\" " + 
"nom1=\"" + StringUtilities.getValidXML(form1059.getNombreImportador()) + "\" " + 
"nom2=\"" +  StringUtilities.getValidXML(form1059.getOtroNombreImportador())  + "\" " + 
"cpag=\"" +  StringUtilities.getValidXML(form1059.getCondicionesPago()) + "\" " + 
"cdes=\"" +  StringUtilities.getValidXML(form1059.getCondicionesDespachoMercancia()) + "\" " + 
"raz=\"" +  StringUtilities.getValidXML(form1059.getRazonSocialImportador()) + "\" " + 
"obs=\"" + StringUtilities.getValidXML(form1059.getObservaciones()) + "\" " +
"></cimportacion>";

xmlStr += xmlCont;
//end loop
}
xmlStr += "</mas>";
xmlStrForParse += xmlStr;

	out.println(xmlStr);



}
catch(Exception ex)
{
    ex.printStackTrace();
  out.println("There were errors on the form " + ex.toString() );
}


%>





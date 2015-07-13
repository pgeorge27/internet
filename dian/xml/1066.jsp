
<%@ page language="java" 

contentType="text/xml;charset=iso-8859-1" 

import="java.util.*, 
 java.text.DateFormat,
 java.text.SimpleDateFormat,
 com.arango.internet.banking.dian.*,
 java.util.Date" %>

 <%@ page import="com.arango.common.util.StringUtilities"%>
<%
String name = (String)session.getAttribute("frm.dian.nombre.documento");
response.addHeader("Content-disposition", name);
		//Formulario form1060 = (Formulario) session.getAttribute("formulario");
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		try
{
String xmlStr ="";
//header for use in parser
String xmlStrForParse = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>";
String headerXml = 

"<mas xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"1066.xsd\"> " +
"<Cab>"+
"<Ano>" + session.getAttribute("frm.dian.year") + "</Ano> " +
"<CodCpt>" +  session.getAttribute("frm.dian.concepto") + "</CodCpt>" +
"<Formato>" +  session.getAttribute("frm.dian.formato") + "</Formato>" +
"<Version>" +  session.getAttribute("frm.dian.version") + "</Version>" +
"<NumEnvio>" +  session.getAttribute("frm.dian.numero.envio") + "</NumEnvio>" +
"<FecEnvio>" + (Date) session.getAttribute("frm.dian.fecha.envio") + "</FecEnvio>" +
"<FecInicial>" +  session.getAttribute("frm.dian.fecha.inicial") + "</FecInicial>" +
"<FecFinal>" +  session.getAttribute("frm.dian.fecha.final") + "</FecFinal>" +
"<ValorTotal>" +  session.getAttribute("frm.dian.valor.total") + " </ValorTotal>" +
"<CantReg>" +  session.getAttribute("frm.dian.cant.registro")+ "</CantReg>" +
"</Cab> ";

xmlStr += headerXml;

ArrayList Aclaraciones = (ArrayList) session.getAttribute("frm.dia.registros");


		
    //for(Formulario form1060 : Aclaraciones)
	for(int i = 0; i < Aclaraciones.size(); i++)
	{
	
	   Formulario form1060 = (Formulario) Aclaraciones.get(i);
	   String xmlCont =
	

"<aclaraciones "+
"tinf=\"" +  StringUtilities.getValidXML(form1060.getTipoInformante()) + "\" " + 
"pdec=\"" +  StringUtilities.getValidXML(form1060.getProcesamientoDeclaracion()) + "\" " + 
"fdeca=\"" +  StringUtilities.getValidXML(form1060.getFechaDeclaracionAclarada()) + "\" " +
"ndeca=\"" +  StringUtilities.getValidXML(form1060.getNumeroDeclaracionCambioAclarada()) + "\" " + 
 
"dv=\"" +  StringUtilities.getValidXML(form1060.getDigitoVerificador()) + "\" " +
"fcom=\"" +  StringUtilities.getValidXML(form1060.getFecha(), "yyyy-MM-dd") + "\" " + 

"tdoc=\"" +  StringUtilities.getValidXML(form1060.getTipoIdentificacion()) + "\" " + 
"nid=\"" +  StringUtilities.getValidXML(form1060.getNumeroIdentificacion())+ "\" " + 

"apl1=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellido()) + "\" " + 
"apl2=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellido()) + "\" " + 
"nom1=\"" + StringUtilities.getValidXML(form1060.getNombre()) + "\" " + 
"nom2=\"" +  StringUtilities.getValidXML(form1060.getOtroNombre()) + "\" " + 
"raz=\"" +  StringUtilities.getValidXML(form1060.getRazonSocial()) + "\" " +
"></aclaraciones>";

xmlStr += xmlCont;
//end loop
}

xmlStr += "</mas>";
out.println(xmlStr);



}
catch(Exception ex)
{
ex.printStackTrace();
out.println("There were errors on the form " + ex.toString() );
}
%>
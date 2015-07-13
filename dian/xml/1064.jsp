<%@ page language="java" 

contentType="text/xml;charset=iso-8859-1" 

import="java.util.*, 
 java.text.DateFormat,
 java.text.SimpleDateFormat,
 com.arango.internet.banking.dian.*" %>
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

"<mas xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"1064.xsd\"> " +
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
"<CantReg>" + StringUtilities.getValidXML( session.getAttribute("frm.dian.cant.registro"))+ "</CantReg>" +
"</Cab> ";

xmlStr += headerXml;

ArrayList EndNoresidentes = (ArrayList) session.getAttribute("frm.dia.registros");


		
    //for(Formulario form1060 : EndNoresidentes)
	for(int i = 0; i < EndNoresidentes.size(); i++)
	{
	   Formulario form1060 = (Formulario) EndNoresidentes.get(i);
	   String xmlCont =
	

"<endnoresidentes " +
"top=\"" +  StringUtilities.getValidXML(form1060.getTipoOperacion()) + "\" " + 
"dv=\"" +  StringUtilities.getValidXML(form1060.getDigitoVerificador()) + "\" " +
"ndec=\"" +  StringUtilities.getValidXML(form1060.getNumeroDeclaracion()) + "\" " + 

"fec=\"" +  StringUtilities.getValidXML(form1060.getFecha(), "yyyy-MM-dd") + "\" " + 
"num=\"" +  StringUtilities.getValidXML(form1060.getNumeral()) + "\" " + 
 
"tdoc=\"" +  StringUtilities.getValidXML(form1060.getTipoIdentificacion()) + "\" " + 
"nid=\"" +  StringUtilities.getValidXML(form1060.getNumeroIdentificacion()) + "\" " + 

"apl1=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellidoPrestamista()) + "\" " + 
"apl2=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellidoPrestamista()) + "\" " + 
"nom1=\"" + StringUtilities.getValidXML(form1060.getNombrePrestamista()) + "\" " + 
"nom2=\"" +  StringUtilities.getValidXML(form1060.getOtroNombrePrestamista()) + "\" " + 
"raz=\"" +  StringUtilities.getValidXML(form1060.getRazonSocialPrestamista()) + "\" " + 

"cmonn=\"" +  StringUtilities.getValidXML(form1060.getCodigoMonedaNegociacion()) + "\" " + 
"vtmon=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorTotal())) + "\" " + 
"vusd=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorUSD()))+ "\" " +

"cmon=\"" +  StringUtilities.getValidXML(form1060.getCodigoMoneda()) + "\" " + 

//apellidos del acrededor o deudor pasivo
"apl1a=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellidoPrestatario()) + "\" " + 
"apl2a=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellidoPrestatario()) + "\" " + 
"nom1a=\"" + StringUtilities.getValidXML(form1060.getNombrePrestatario()) + "\" " + 
"nom2a=\"" +  StringUtilities.getValidXML(form1060.getOtroNombrePrestatario()) + "\" " + 
"raza=\"" +  StringUtilities.getValidXML(form1060.getRazonSocialPrestatario()) + "\" " + 

"dir=\"" +  StringUtilities.getValidXML(form1060.getDireccion()) + "\" " +
"mun=\"" +  StringUtilities.getValidXML(form1060.getCodigoCiudad()) + "\" " + 



"npres=\"" +  StringUtilities.getValidXML(form1060.getNumeroPrestamo()) + "\" " +
"cpre=\"" +  StringUtilities.getValidXML(form1060.getCodigoPropositoPrestamo()) + "\" " + 

"monc=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getMontoContratado())) + "\" " + 

"ndece=\"" +  StringUtilities.getValidXML(form1060.getNumeroDeclaracionExportacion()) + "\" " + 
"fdece=\"" +  StringUtilities.getValidXML(form1060.getFechaDeclaracionExportacion(), "yyyy-MM-dd") + "\" " + 
"></endnoresidentes> ";

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
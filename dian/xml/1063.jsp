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

"<mas xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"1063.xsd\"> " +
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

ArrayList Endresidentes = (ArrayList) session.getAttribute("frm.dia.registros");


		
    //for(Formulario form1060 : Endresidentes)
	for(int i = 0; i < Endresidentes.size(); i++)
	{
	   Formulario form1060 = (Formulario) Endresidentes.get(i);
	
	   String xmlCont = 

"<endresidentes " +
"top=\"" +  StringUtilities.getValidXML(form1060.getTipoOperacion()) + "\" " + 

"dv=\"" +  StringUtilities.getValidXML(form1060.getDigitoVerificador()) + "\" " +
"ndec1=\"" +  StringUtilities.getValidXML(form1060.getNumeroDeclaracion()) + "\" " + 

"fec=\"" +  StringUtilities.getValidXML(form1060.getFecha(), "yyyy-MM-dd") + "\" " + 
"num=\"" +  StringUtilities.getValidXML(form1060.getNumeral()) + "\" " + 
 
"tdoc=\"" +  StringUtilities.getValidXML(form1060.getTipoIdentificacion()) + "\" " + 
"nid=\"" +  StringUtilities.getValidXML(form1060.getNumeroIdentificacionPrestatario()) + "\" " + 

"apl1=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellidoPrestatario()) + "\" " + 
"apl2=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellidoPrestatario()) + "\" " + 
"nom1=\"" + StringUtilities.getValidXML(form1060.getNombrePrestatario()) + "\" " + 
"nom2=\"" +  StringUtilities.getValidXML(form1060.getOtroNombrePrestatario()) + "\" " + 
"raz=\"" +  StringUtilities.getValidXML(form1060.getRazonSocialPrestatario()) + "\" " + 

"cmon1=\"" +  StringUtilities.getValidXML(form1060.getCodigoMonedaNegociacion()) + "\" " + 
"vtmonn=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorTotal())) + "\" " + 
"vusd1=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorUSD()))+ "\" " +

"cmon2=\"" +  StringUtilities.getValidXML(form1060.getCodigoMoneda()) + "\" " + 

"cmon3=\"" +  StringUtilities.getValidXML(form1060.getCodigoMonedaNegociacion()) + "\" " + 

//apellidos del acrededor o deudor pasivo

"apl1p=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellidoPrestamista()) + "\" " + 
"apl2p=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellidoPrestamista()) + "\" " + 
"nom1p=\"" + StringUtilities.getValidXML(form1060.getNombrePrestamista()) + "\" " + 
"nom2p=\"" +  StringUtilities.getValidXML(form1060.getOtroNombrePrestamista()) + "\" " + 
"razp=\"" +  StringUtilities.getValidXML(form1060.getRazonSocialPrestamista()) + "\" " + 
"dir=\"" +  StringUtilities.getValidXML(form1060.getDireccion()) + "\" " +
"mun=\"" +  StringUtilities.getValidXML(form1060.getCodigoCiudad()) + "\" " + 

"npres=\"" +  StringUtilities.getValidXML(form1060.getNumeroPrestamo()) + "\" " +
"cpres=\"" +  StringUtilities.getValidXML(form1060.getCodigoPropositoPrestamo()) + "\" " + 

"monto=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getMontoContratado())) + "\" " + 

"nexp=\"" +  StringUtilities.getValidXML(form1060.getNumeroExpedicionDeposito()) + "\" " + 
"val=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorDeposito())) + "\" " + 

"csus=\"" +  StringUtilities.getValidXML(form1060.getCodigoSustitucionCreditos()) + "\" " + 
"vsus=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorSustituir())) + "\" " + 
"ncrea=\"" +  StringUtilities.getValidXML(form1060.getNumeroIdentificacionCreditoAnterior()) + "\" " +
"> </endresidentes> ";

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

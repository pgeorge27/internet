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

"<mas xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"1062.xsd\"> " +
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
 
ArrayList cServicios = (ArrayList) session.getAttribute("frm.dia.registros");


		
    //for(Formulario form1060 : cServicios)
	for(int i = 0; i < cServicios.size(); i++)
	{
	   Formulario form1060 = (Formulario) cServicios.get(i);
	   
	   String xmlCont =
	

"<cservicios " +
"ccom=\"" +  StringUtilities.getValidXML(form1060.getCodigoCuentaCompensacion()) + "\" " +
"tinf=\"" +  StringUtilities.getValidXML(form1060.getTipoInformante()) + "\" " + 
"top=\"" +  StringUtilities.getValidXML(form1060.getTipoOperacion()) + "\" " + 
"fdec=\"" +  StringUtilities.getValidXML(form1060.getFechaDeclaracionCambio(), "yyyy-MM-dd") + "\" " + 
"fdeca=\"" +  StringUtilities.getValidXML(form1060.getFechaDeclaracionCambioAnterior(), "yyyy-MM-dd") + "\" " + 
"dv=\"" +  StringUtilities.getValidXML(form1060.getDigitoVerificador()) + "\" " +
"ndec=\"" +  StringUtilities.getValidXML(form1060.getNumeroDeclaracionCambio()) + "\" " + 
"ndeca=\"" +  StringUtilities.getValidXML(form1060.getNumeroDeclaracionCambioAnterior()) + "\" " + 
"tdoc=\"" +  StringUtilities.getValidXML(form1060.getTipoIdentificacionImportador()) + "\" " + 
"nid=\"" +  StringUtilities.getValidXML(form1060.getNumeroIdentificacionImportador())+ "\" " + 

"apl1=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellidoAcreedor()) + "\" " + 
"apl2=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellidoComprador()) + "\" " + 
"nom1=\"" + StringUtilities.getValidXML(form1060.getNombreComprador()) + "\" " + 
"nom2=\"" +  StringUtilities.getValidXML(form1060.getOtroNombreComprador()) + "\" " + 
"raz=\"" +  StringUtilities.getValidXML(form1060.getRazonSocial()) + "\" " + 
"cmon=\"" +  StringUtilities.getValidXML(form1060.getCodigoMoneda()) + "\" " + 
"vmon=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorMonedaReintegro())) + "\" " + 
"vtusd=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorUSD())) + "\" " + 

//info ciudad

"dir=\"" +  StringUtilities.getValidXML(form1060.getDireccion()) + "\" " +
"mun=\"" +  StringUtilities.getValidXML(form1060.getCodigoCiudad()) + "\" " + 
"ciud=\"" +  StringUtilities.getValidXML(form1060.getNombreCiudadExterior()) + "\" " + 
 
"></cservicios>";

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

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

String headerXml = 

"<mas xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"1061.xsd\"> " +
"<Cab>"+
"<Ano>" + StringUtilities.getValidXML(session.getAttribute("frm.dian.year"))+" </Ano> " +
"<CodCpt>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.concepto")) + "</CodCpt>" +
"<Formato>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.formato")) + "</Formato>" +
"<Version>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.version")) + "</Version>" +
"<NumEnvio>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.numero.envio")) + "</NumEnvio>" +
"<FecEnvio>" + StringUtilities.getValidXML( session.getAttribute("frm.dian.fecha.envio")) + "</FecEnvio>" +
"<FecInicial>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.fecha.inicial")) + "</FecInicial>" +
"<FecFinal>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.fecha.final")) + "</FecFinal>" +
"<ValorTotal>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.valor.total")) + " </ValorTotal>" +
"<CantReg>" +  StringUtilities.getValidXML(session.getAttribute("frm.dian.cant.registro"))+ "</CantReg>" +
"</Cab> ";
%>

xmlStr += headerXml;


<% 
ArrayList cEndeudamiento = (ArrayList) session.getAttribute("frm.dia.registros");


		
    //for(Formulario form1060 : cEndeudamiento)
	for(int i = 0; i < cEndeudamiento.size(); i++)
	{
		   Formulario form1060 = (Formulario) cEndeudamiento.get(i);
	   String xmlCont = 
	

"<cendeudamiento tinf=\"" +  StringUtilities.getValidXML(form1060.getTipoInformante()) + "\" " + 
"top=\"" +  StringUtilities.getValidXML(form1060.getTipoOperacion()) + "\" " + 
"fdec=\"" +  StringUtilities.getValidXML(form1060.getFechaDeclaracionCambio(), "yyyy-MM-dd") + "\" " + 
"fdeca=\"" +  StringUtilities.getValidXML(form1060.getFechaDeclaracionCambioAnterior(), "yyyy-MM-dd") + "\" " + 
"dv=\"" +  StringUtilities.getValidXML(form1060.getDigitoVerificador()) + "\" " +
"ndec=\"" +  StringUtilities.getValidXML(form1060.getNumeroDeclaracionCambio()) + "\" " + 
"ndeca=\"" +  StringUtilities.getValidXML(form1060.getNumeroDeclaracionCambioAnterior()) + "\" " + 
"tdoc=\"" +  StringUtilities.getValidXML(form1060.getTipoIdentificacion()) + "\" " + 
"nid=\"" +  StringUtilities.getValidXML(form1060.getNumeroIdentificacion())+ "\" " + 

"apl1=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellido()) + "\" " + 
"apl2=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellido()) + "\" " + 
"nom1=\"" + StringUtilities.getValidXML(form1060.getNombre()) + "\" " + 
"nom2=\"" +  StringUtilities.getValidXML(form1060.getOtroNombre()) + "\" " + 
"raz=\"" +  StringUtilities.getValidXML(form1060.getRazonSocial()) + "\" " + 
"mon=\"" +  StringUtilities.getValidXML(form1060.getCodigoMonedaContratada()) + "\" " + 
"vmon=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorMonedaContratada())) + "\" " + 

"monn=\"" +  StringUtilities.getValidXML(form1060.getCodigoMonedaNegociacion()) + "\" " + 
"vtmonn=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorTotal())) + "\" " + 
"tmonn=\"" +  StringUtilities.getValidXML(form1060.getTipoCambioNegociacion()) + "\" " + 
"vtusd=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorUSD()))+ "\" " + 

"apl1a=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellidoAcreedor()) + "\" " + 
"apl2a=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellidoAcreedor()) + "\" " + 
"nom1a=\"" + StringUtilities.getValidXML(form1060.getNombreAcreedor()) + "\" " + 
"nom2a=\"" +  StringUtilities.getValidXML(form1060.getOtroNombreAcreedor()) + "\" " + 
"raza=\"" +  StringUtilities.getValidXML(form1060.getRazonSocialAcreedor()) + "\" " + 

"npres=\"" +  StringUtilities.getValidXML(form1060.getNumeroPrestamo()) + "\" " +

"fob=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getTotalFOB())) + "\" " + 
"tgas=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getTotalGastosNumeral1510())) + "\" " + 
"ded=\"" +  StringUtilities.getValidXML(form1060.getDeduccionesNumeral2016()) + "\" " +  
">" +
"</cendeudamiento>";


//end loop
}

}
catch(Exception ex)
{
  out.println("There were errors on the form " + ex.toString() );
}

%>

</mas>
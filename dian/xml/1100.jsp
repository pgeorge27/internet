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

"<mas xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"1100.xsd\"> " +
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
ArrayList Faltantes = (ArrayList) session.getAttribute("frm.dia.registros");


		
    //for(Formulario form1060 : Faltantes)
	for(int i = 0; i < Faltantes.size(); i++)
	{
	   Formulario form1060 = (Formulario) Faltantes.get(i);

	   String xmlCont =
	

"<vdivisas "+
"tneg=\"" +  StringUtilities.getValidXML(form1060.getTipoNegociacion()) + "\" " +
"nfac=\"" +  StringUtilities.getValidXML(form1060.getNumeroFactura()) + "\" " +
"tdoc=\"" +  StringUtilities.getValidXML(form1060.getTipoDocumentoVendedor()) + "\" " +
"nid=\"" +  StringUtilities.getValidXML(form1060.getNumeroIdentificacion()) + "\" " +
"dv=\"" +  StringUtilities.getValidXML(form1060.getDigitoVerificador()) + "\" " +

"apl1=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellido()) + "\" " + 
"apl2=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellido()) + "\" " + 
"nom1=\"" + StringUtilities.getValidXML(form1060.getNombre()) + "\" " + 
"nom2=\"" +  StringUtilities.getValidXML(form1060.getOtroNombre()) + "\" " + 

"dirde=\"" +  StringUtilities.getValidXML(form1060.getDireccion())+ "\" " +
"mun=\"" +  StringUtilities.getValidXML(form1060.getCodigoMunicipio()) + "\" " + 
 
"telde=\"" +  StringUtilities.getValidXML(form1060.getTelefonoComprador()) + "\" " + 
"actde=\"" +  StringUtilities.getValidXML(form1060.getOcupacionComprador()) + "\" " + 

"tdocb=\"" +  StringUtilities.getValidXML(form1060.getTipoDocumentoBeneficiario()) + "\" " +
"nidb=\"" +  StringUtilities.getValidXML(form1060.getNumeroIdentificacionBeneficiario()) + "\" " +
"dvb=\"" +  StringUtilities.getValidXML(form1060.getDigitoVerificadorBeneficiario()) + "\" " +

"apl1b=\"" +  StringUtilities.getValidXML(form1060.getPrimerApellidoBeneficiario()) + "\" " + 
"apl2b=\"" +  StringUtilities.getValidXML(form1060.getSegundoApellidoBeneficiario()) + "\" " + 
"nom1b=\"" +  StringUtilities.getValidXML(form1060.getNombreBeneficiario()) + "\" " + 
"nom2b=\"" +  StringUtilities.getValidXML(form1060.getNombreBeneficiario()) + "\" " + 
"razb=\"" +  StringUtilities.getValidXML(form1060.getRazonSocialBeneficiario()) + "\" " +
"dirb=\"" +  StringUtilities.getValidXML(form1060.getDireccionBeneficiario()) + "\" " +


"munb=\"" +  StringUtilities.getValidXML(form1060.getCodigoMunicipioBeneficiario()) + "\" " +
"telb=\"" +  StringUtilities.getValidXML(form1060.getTelefonoBeneficiario()) + "\" " +
"actb=\"" +  StringUtilities.getValidXML(form1060.getOcupacionBeneficiario()) + "\" " +

"cmon=\"" +  StringUtilities.getValidXML(form1060.getCodigoMoneda()) + "\" " +

"monto=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getMontoNegociado())) + "\" " +

"tasav=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getTasaVenta())) + "\" " +
"prom=\"" +  StringUtilities.getValidXML(form1060.getPromedioCompra()) + "\" " +
"difta=\"" +  StringUtilities.getValidXML(form1060.getDiferenciaTasa()) + "\" " +
"basliq=\"" +  StringUtilities.getValidXML(form1060.getBaseLiquidacion()) + "\" " +

"valpe=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorPesos())) + "\" " +
"valiva=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorIVA())) + "\" " +
"retiva=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getReteIVA())) + "\" " +
"retfte=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getReteFte())) + "\" " +
"retica=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getReteICA())) + "\" " +
"grav=\"" +  StringUtilities.getValidXML(form1060.getGravamen()) + "\" " +
"valne=\"" +  StringUtilities.getValidXML(String.valueOf(form1060.getValorNeto())) + "\" " +
"fpag=\"" +  StringUtilities.getValidXML(form1060.getFormaPago()) + "\" " +
"codba=\"" +  StringUtilities.getValidXML(form1060.getCodigoBanco()) + "\" " +
"nunch=\"" +  StringUtilities.getValidXML(form1060.getNumeroCheque()) + "\" " +
"numdec=\"" +  StringUtilities.getValidXML(form1060.getNumeroDeclaracionCambio()) + "\" " +
"fecdec=\"" +  StringUtilities.getValidXML(form1060.getFechaDeclaracionCambio(), "yyyy-MM-dd") + "\" " +

"></vdivisas>";
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
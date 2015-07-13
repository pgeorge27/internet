<%@page contentType="application/pdf" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@page import="com.arango.common.util.Format"%>
<%@page import="com.arango.internet.banking.Titular"%>
<%@page import="com.arango.internet.banking.EstadoCuenta"%>
<%@page import="com.arango.internet.banking.Movimiento"%>
<%@page import="com.lowagie.text.*"%>
<%@page import="com.lowagie.text.pdf.*"%>
<%@page import="com.arango.internet.tag.TagUtil"%>
<%@page import="java.util.*" %>
<%@page import="java.io.*"%>
<%@ page import="com.arango.common.util.i18n.ASIResourceBundle" %>
<%! Format f = Format.getFormat();

private void printCell(Table t, String label)throws BadElementException{
	printCell (t, label, false, Cell.ALIGN_LEFT);
}
private void printCell(Table t, String label, boolean nowrap, int align)throws BadElementException{
  Paragraph p = new Paragraph(label, FontFactory.getFont("ARIAL", 8, Font.NORMAL, java.awt.Color.black));
  p.setAlignment(align);
  Cell cell = new Cell(p);
  cell.setHorizontalAlignment(align);
  cell.setVerticalAlignment(Cell.ALIGN_MIDDLE);
  cell.setNoWrap(nowrap);
  cell.setBorder(0);
    
  t.setSpaceInsideCell(1.0f);
  t.setPadding(2.0f);
  t.addCell(cell);
}

private void printHeader(Table t, String label)throws BadElementException{
   printHeader(t, label, -1, Cell.ALIGN_CENTER,8, true, true, -1);
}

private void printHeader(Table t, String label, int colspan, int align)throws BadElementException{
	printHeader(t, label, colspan, Cell.ALIGN_LEFT, 8, true, true, -1);
}

private void printHeader(Table t, String label, int colspan, int align, int fontSize, boolean bold, boolean background)throws BadElementException{
	printHeader(t, label, colspan, Cell.ALIGN_LEFT, fontSize, bold, background, -1);
}

private void printHeader(Table t, String label, int colspan, int align, int fontSize, boolean bold, boolean background,int rowspan)throws BadElementException{
  Paragraph p = null;
  if (bold)
	p = new Paragraph(label, FontFactory.getFont("ARIAL", fontSize, Font.BOLD, java.awt.Color.black));
  else	
    p = new Paragraph(label, FontFactory.getFont("ARIAL", fontSize, Font.NORMAL, java.awt.Color.black));

  Cell cell = new Cell(p);
  cell.setHorizontalAlignment(align);

  cell.setVerticalAlignment(Cell.ALIGN_TOP);

  if (background)
	cell.setBackgroundColor(new java.awt.Color(244, 242, 242));
  cell.setBorder(0);

  if (colspan > 0)
    cell.setColspan(colspan);
  if (rowspan > 0)
    cell.setRowspan(rowspan);  

  t.setSpaceInsideCell(1.0f);
  t.setPadding(2.0f);
  t.addCell(cell);
}
%>
<%	
EstadoCuenta ec = (EstadoCuenta)session.getAttribute("estado.cta");
Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
if (locale == null) {
   // algunos browser no detectan el idioma de forma adecuada con version java 1.4
   // por defecto toma el idioma espanol
   locale = ASIResourceBundle.getDefaultLocale();
}
if (ec == null){   
	session.setAttribute("csic.exception", new Exception("Api de consulta retorna Cuenta = NULL"));
	pageContext.forward("/ib/systemError2.jsp");   
}
java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("MMyyyy", locale);
response.setContentType("application/pdf");
StringBuffer buffer = new StringBuffer();
buffer.append("attachment; filename=estadocta");
buffer.append(f.formatCuenta(ec.getNumeroCuenta(), "C"));
buffer.append("_");
buffer.append(df.format((java.util.Date)ec.getFechaInicio()));
buffer.append(".pdf");
response.addHeader("Content-disposition", buffer.toString());
	
ArrayList clientes = ec.Titulares;
ArrayList Movimientos = ec.Movimientos;
String titulares="";
String codigoCliente = "";
if (clientes.size() > 0){
  titulares=((Titular)clientes.get(0)).getNombre();
  codigoCliente=((Titular)clientes.get(0)).getCodigoCliente();
}  

/* Variables para manejo de PDF*/
Document document = new Document();
ByteArrayOutputStream ba = new ByteArrayOutputStream();
PdfWriter writer = null;

/* Logo del banco */
Image jpg = Image.getInstance(pageContext.getServletContext().getRealPath("/WEB-INF/resources/logo.jpg"));
/* Logo del banco */                  
		 
writer = PdfWriter.getInstance(document, ba);
document.addTitle(TagUtil.getString(pageContext,"tit.title.consulta.estado.cuenta"));
document.addSubject(TagUtil.getString(pageContext,"tit.title.consulta.estado.cuenta"));
document.addCreationDate();
document.addAuthor(TagUtil.getString(pageContext,"tit.title.banco"));
document.addCreator(TagUtil.getString(pageContext,"tit.title.banco"));
document.setPageSize(PageSize.LETTER);
document.setMargins(30f, 30f, 30f, 30f);

Phrase phrase = new Phrase(TagUtil.getString(pageContext,"msg.derechos.reservados"),FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLDITALIC));

//HeaderFooter footer = new HeaderFooter(phrase, false);
//footer.setAlignment(HeaderFooter.ALIGN_RIGHT);
//footer.setBorder(1);

//document.setFooter(footer);
document.open();
document.newPage();
writer.open();

jpg.setAbsolutePosition(0, 0);
PdfContentByte cb = writer.getDirectContent();
         PdfTemplate tpl = cb.createTemplate(260, 68);
         tpl.addImage(jpg);
         cb.addTemplate(tpl,0,
                        PageSize.LETTER.height() - 70 );
         Phrase frPhraseImg = new Phrase(cb + "",
FontFactory.getFont(FontFactory.TIMES_ROMAN, 7, Font.NORMAL));
HeaderFooter footer = new HeaderFooter(frPhraseImg, phrase);
document.setHeader(footer);
		 
Table aTable = null;

aTable = new Table(1,1);
aTable.setBorder(0);
aTable.setWidth(100.0f);
printCell(aTable, " ");
printCell(aTable, " ");
printCell(aTable, " ");
document.add(aTable);

aTable = new Table(1,1);
aTable.setBorder(0);
aTable.setWidth(100.0f);
printCell(aTable, " ");
printCell(aTable, " ");
printHeader(aTable, TagUtil.getString(pageContext,"tit.title.consulta.estado.cuenta.cc"), 1, Cell.ALIGN_CENTER, 10, true, false,1);
printCell(aTable, " ");
document.add(aTable);

aTable = new Table(1,1);
aTable.setBorder(1);
aTable.setWidth(100.0f);
aTable.setAlignment(Table.ALIGN_CENTER);
printCell(aTable, " ");
document.add(aTable);

aTable = new Table(4,1);
aTable.setBorder(0);
aTable.setWidth(40.0f);
aTable.setAlignment(Table.ALIGN_CENTER);

printHeader(aTable, TagUtil.getString(pageContext,"lbl.desde"), 1, Cell.ALIGN_LEFT, 8, true, false,1);
printHeader(aTable, f.formatFecha((java.util.Date)ec.getFechaInicio(), locale), 1, Cell.ALIGN_LEFT, 8, false, false);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.hasta"), 1, Cell.ALIGN_LEFT, 8, true, false);
printHeader(aTable, f.formatFecha((java.util.Date)ec.getFechaFin(), locale), 1, Cell.ALIGN_LEFT, 8, false, false);
document.add(aTable);


aTable = new Table(4,1);
aTable.setBorder(0);
aTable.setWidth(70.0f);

printHeader(aTable, TagUtil.getString(pageContext,"lbl.cuenta.corriente"), 2, Cell.ALIGN_RIGHT, 8, true, false,1);
printHeader(aTable, f.formatCuenta(ec.getNumeroCuenta(), "C"), 2, Cell.ALIGN_RIGHT, 8, false, false,1);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.titular"), 2, Cell.ALIGN_RIGHT, 8, true, false,1);
printHeader(aTable, ((Titular)ec.Titulares.get(0)).getNombre(), 2, Cell.ALIGN_RIGHT, 8, false, false,1);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.moneda"), 2, Cell.ALIGN_RIGHT, 8, true, false,1);
printHeader(aTable, ec.getMoneda(), 2, Cell.ALIGN_RIGHT, 8, false, false,1);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.saldo.inicio.mes"), 2, Cell.ALIGN_RIGHT, 8, true, false,1);
printHeader(aTable, f.formatMonto(ec.getSaldoAnterior()), 2, Cell.ALIGN_RIGHT, 8, false, false,1);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.total.cheques.otros.debitos", new Object[]{String.valueOf(ec.getCantidadDebitos())}), 2, Cell.ALIGN_RIGHT, 8, true, false,1);
printHeader(aTable, f.formatMonto(ec.getTotalDebitos()), 2, Cell.ALIGN_RIGHT, 8, false, false,1);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.total.depositos.otros.creditos", new Object[]{String.valueOf(ec.getCantidadDepositos())}), 2, Cell.ALIGN_RIGHT, 8, true, false,1);
printHeader(aTable, f.formatMonto(ec.getTotalDepositos()), 2, Cell.ALIGN_RIGHT, 8, false, false,1);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.cc.saldo.fecha"), 2, Cell.ALIGN_RIGHT, 8, true, false,1);
printHeader(aTable, f.formatMonto(ec.getSaldoTotal()), 2, Cell.ALIGN_RIGHT, 8, false, false,1);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.cc.saldo.reserva"), 2, Cell.ALIGN_RIGHT, 8, true, false,1);
printHeader(aTable, f.formatMonto(ec.getSaldoTransito()), 2, Cell.ALIGN_RIGHT, 8, false, false,1);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.cc.saldo.disponible"), 2, Cell.ALIGN_RIGHT, 8, true, false,1);
printHeader(aTable, f.formatMonto(ec.getSaldoDisponible()), 2, Cell.ALIGN_RIGHT, 8, false, false,1);

document.add(aTable);
document.add(new Phrase(" "));
document.add(new Phrase(" "));
aTable = new Table(5,1);
aTable.setBorder(0);
aTable.setWidth(100.0f);
float widths[] = new float[]{0.10f, 0.40f, 0.10f,0.20f,0.20f};
aTable.setWidths(widths);

printHeader(aTable, TagUtil.getString(pageContext,"lbl.fecha"),1, Cell.ALIGN_LEFT);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.descripcion"),1, Cell.ALIGN_LEFT);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.referencia"),1, Cell.ALIGN_LEFT);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.est.cta.monto"),1, Cell.ALIGN_LEFT);
printHeader(aTable, TagUtil.getString(pageContext,"lbl.est.cta.detalle.saldo"),1, Cell.ALIGN_LEFT);
  

String styleClass = "";
ArrayList mov = Movimientos;
Movimiento m = null;
double monto =  0;
for (int i = 0; i < mov.size(); i++){
	m = (Movimiento)mov.get(i);
	if ("D".equals(m.getTipoTransaccion()))
		monto = m.getMonto() * -1;
	else{
		monto = m.getMonto();
	}	
	printCell(aTable, f.formatFecha(m.getFechaValida(),locale), false, Cell.ALIGN_LEFT);
	printCell(aTable, m.getDescripcion(), false, Cell.ALIGN_LEFT);
	printCell(aTable, m.getNumeroDocumento()==null?"":m.getNumeroDocumento(), false, Cell.ALIGN_CENTER);
	printCell(aTable, f.formatMonto(monto), false, Cell.ALIGN_RIGHT);
	printCell(aTable, f.formatMonto(m.getSaldo()), false, Cell.ALIGN_RIGHT);

}
document.add(aTable);

writer.flush();
document.close();

ba.flush();
pageContext.getResponse().setContentLength(ba.size()+32);
ba.writeTo(pageContext.getResponse().getOutputStream());
//ba.flush();
ba.close();
%>
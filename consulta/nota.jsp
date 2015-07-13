<%@ taglib uri="/tags/asi-pdf" prefix="p" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>


<%
response.setContentType("application/pdf");
float widths[] = new float[]{0.35f, 0.65f};
float w[] = new float[]{0.20f, 0.20f, 0.30f, 0.30f};
float w2[] = new float[]{0.30f, 0.70f};
float wm[] = new float[]{.10f,.30f,.10f,.15f,.15f,.20f};
int ALIGN_RIGHT=com.lowagie.text.Cell.ALIGN_RIGHT;
int ALIGN_CENTER=com.lowagie.text.Cell.ALIGN_CENTER;

String nombreCuenta = "XXXXX";
String numeroCuenta = "XXXX";
String fecha= "XXXXXXX";
String moneda = "XXXXXX";
String importe="XXXXXXX";
String concepto = "XXXXXX";
String nombreUsuario = "XXXXXXXX";
%>

<p:doc height="0" width="0" author="tit.title.banco" title="lbl.aviso.debito.titulo">

<p:table width="10.0f" rows="1" cols="1">
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>	
</p:table>

<p:table width="80.0f" rows="1" cols="1">
	<p:head key="lbl.aviso.debito.titulo" bold="true" align="<%=ALIGN_CENTER%>" fontSize="12"/>
</p:table>
	
<p:table width="80.0f" rows="1" cols="1">
	<p:head key="lbl.aviso.debito.cuenta.corriente" align="<%=ALIGN_CENTER%>" bold="true" fontSize="12"/>
</p:table>

<p:table width="100.0f" rows="1" cols="4" headerWidths="<%=w%>">
	<p:head key="lbl.aviso.db.cr.cuenta.corriente.linea.1" bold="true" fontSize="10"/>
	<p:cell label="<%=nombreCuenta%>"/>
	<p:cell label=" "/>
	<p:cell label=" "/>

	<p:head key="lbl.aviso.db.cr.cuenta.corriente.linea.2" bold="true" fontSize="10"/>
	<p:cell label="<%=numeroCuenta%>"/>
	<p:cell label=" "/>
	<p:cell label=" "/>

	<p:head key="lbl.aviso.db.cr.cuenta.corriente.linea.3" bold="true" fontSize="10"/>
	<p:cell label="<%=fecha%>"/>
	<p:cell label=" "/>
	<p:cell label=" "/>

	<p:head key="lbl.aviso.db.cr.cuenta.corriente.linea.4" bold="true" fontSize="10"/>
	<p:cell label="<%=moneda%>"/>
	<p:head key="lbl.aviso.db.cr.cuenta.corriente.linea.5"  bold="true" fontSize="10"/>
	<p:cell label="<%=importe%>"/>     

	<p:head key="lbl.aviso.db.cr.cuenta.corriente.linea.6" bold="true" fontSize="10"/>
	<p:cell label="<%=concepto%>"/>
	<p:cell label=" "/>
	<p:cell label=" "/>

	<p:head key="lbl.aviso.db.cr.cuenta.corriente.linea.7" bold="true" fontSize="10"/>
	<p:cell label="<%=nombreUsuario%>"/>
	<p:cell label=" "/>
	<p:cell label=" "/>
  
</p:table>

<p:table width="10.0f" rows="1" cols="1">
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>
	<p:head label=" " key=" " bold="true" fontSize="10"/>
</p:table>
<p:table width="100.0f" rows="1" cols="1">
	<p:head label="_______________________________________________________________________" key=" " bold="true" fontSize="10"/>
</p:table>
<p:table width="100.0f" rows="1" cols="1">
	<p:head label=" " key="msg.derechos.reservados" bold="true" fontSize="8"/>
</p:table>	
</p:doc>
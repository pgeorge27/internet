<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.arango.internet.banking.SWIFTLink"%>
<%@ page import="com.arango.common.util.Format" %>
<%@ page import="java.util.Locale" %>

<%! Format f = Format.getFormat();%>
<%!
private String getHTML(String tipoMensaje, Hashtable links){
	ArrayList datos = (ArrayList)links.get(tipoMensaje);
	StringBuffer buffer= new StringBuffer();
	if (datos != null && !datos.isEmpty()){
		SWIFTLink link = null;
		String styleClass = "";
		
		for (int i = 0; i < datos.size(); i++){
			link = (SWIFTLink)datos.get(i);
			if (i % 2 == 0)
				styleClass = "";
			else
				styleClass = " class=\"celda-clave1\"";
			buffer.append("<tr");
			buffer.append(styleClass);
			buffer.append(">");
			buffer.append("<td class=\"bienvenida\">");
			buffer.append(link.getTipoMensaje());
			buffer.append("</td>");
			buffer.append("<td class=\"bienvenida\">");
			
			buffer.append("<a href=\"/internet/descarga/swift?tipoMensaje=");
			buffer.append(link.getTipoMensaje());
			buffer.append("&secuencia=");
			buffer.append(i);
			buffer.append("\" target=\"_NEW\">");
			buffer.append(link.getDescripcion());
			buffer.append("</a>");
			buffer.append("</td></tr>");
			
		
		}
	}
	return buffer.toString();
	
}%>
<%

Locale locale = (Locale) session.getAttribute(org.apache.struts.Globals.LOCALE_KEY);
Hashtable links = (Hashtable)session.getAttribute("consulta.swift");
ArrayList datos = null;
%>
<%@ include file="../head.jsp"  %>
<script>
	function retornar(){
		document.location="<html:rewrite page='/mensaje/swift.do'/>";
	}
	function __download(__tipo, __sec){
		document.forms['forma'].tipoMensaje.value=__tipo;
		document.forms['forma'].secuencia.value=__sec;
		document.forms['forma'].submit();
	}
</script>
<%@ include file="../body.jsp"%>
<table width="80%" border="0" align="center" cellpadding="5" cellspacing="5">
   <tr> 
     <td height="40" valign="bottom"><div align="center"> 
         <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
           <tr> 
             <td><div align="left" class="login">Consulta de Mensajes SWIFT</div></td>
             <td width="8%"><div align="right">&nbsp;
	<INPUT class="botton" onclick="retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
           </tr>
         </table>
       </div></td>
   </tr>
   <tr> 
     <td height="40" class="texto-acceso">&nbsp;</td>
   </tr>
   <tr> 
     <td valign="top">
<table width="40%" border="0" cellpadding="0" cellspacing="2" align="center">
		<tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.desde"/></div></td>
          <td height="15" class="bienvenida" align="right"><%=f.formatFecha((java.util.Date)session.getAttribute("fecha.desde"), locale)%></td>
          <td height="15" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.hasta"/></div></td>
          <td height="15" class="bienvenida" align="right"><%=f.formatFecha((java.util.Date)session.getAttribute("fecha.hasta"), locale)%></td>
       </tr>
</table>
</td></tr><tr> 
     <td valign="top">
<table width="40%" border="0" cellpadding="0" cellspacing="2" align="center">
		<tr> 
		  <td height="15" class="celda-clave1" nowrap><div align="right" class="texto-acceso"><bean:message key="lbl.numero.cuenta"/></div></td>
          <td align="right" height="15" class="bienvenida"><%=f.formatCuenta((String)session.getAttribute("cuenta.banco"))%></td>
       </tr>
		<tr> 
		  <td height="15" class="celda-clave1"><div align="right" class="texto-acceso">Mensaje</div></td>
          <td height="15" align="right" class="bienvenida"><%=(String)session.getAttribute("tipo.mensaje.swift")%></td>
       </tr>
</table>	
</td></tr><tr> 
     <td valign="top">
     <table width="100%" border="0" cellpadding="0" cellspacing="2">

		<tr class="tabla-acceso">
			<td class="texto-acceso" width="10%">Tipo de Mensaje</td>
		    <td class="texto-acceso" width="39%">Documentos</td>
		</tr>
		<%=getHTML("101", links)%>
		<%=getHTML("900", links)%>
		<%=getHTML("940", links)%>
		<%=getHTML("942", links)%>
		
		
</table>    
     </td></tr>
</table>
<form name="forma" target="__new" method="post" action="<html:rewrite page='/descarga/swift'/>">
	<input type="hidden" name="secuencia"/>
	<input type="hidden" name="tipoMensaje"/>
</form>
<%@ include file="../footer.jsp"  %>
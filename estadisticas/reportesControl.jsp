<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ page import="java.text.SimpleDateFormat"%>

<%@ page import="com.arango.internet.banking.dian.Formulario" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Locale"%>
<%!
com.arango.common.util.Format f = com.arango.common.util.Format.getFormat();
%>

<% 
	String size1 = (String) session.getAttribute("size1");
	String size2 = (String) session.getAttribute("size2");
	String size3 = (String) session.getAttribute("size3");
	String size4 = (String) session.getAttribute("size4");
	String size5 = (String) session.getAttribute("size5");
	String size6 = (String) session.getAttribute("size6");
	
	session.setAttribute("size1", null);
	session.setAttribute("size2", null);
	session.setAttribute("size3", null);
	session.setAttribute("size4", null);
	session.setAttribute("size5", null);
	session.setAttribute("size6", null);
	
%>
<%@ include file="/head.jsp"  %>
<script language=javascript>

function __retornar(){
	document.location="<html:rewrite page='/est/seleccion/control.do'/>";
}
function __edit(formulario){
	document.forms["formulario-dian"].indice.value = formulario;
	document.forms["formulario-dian"].submit();
}
var index = -1;
function __set(num){
	index = num;
}

function __rechazar(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizacionMultipleForm'].elements;
	  for(var i = 0; i < elements.length; i++)
	  {
	  	 	if (elements[i].name == "indice")
	  	 	{
			   if (elements[i].checked)
			   {
			  	flag = true;
				index = elements[i].value;
			  	count++;
			   }
			}
	  }

	if (count >= 1){
		document.forms['autorizacionMultipleForm'].action="<html:rewrite page='/dian/definir/motivo.do'/>";
		document.forms['autorizacionMultipleForm'].submit();  
	}		
	else{
		alert("Debe seleccionar un registro para rechazar");
	}
}
function __aprobar(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizacionMultipleForm'].elements;
	  for(var i = 0; i < elements.length; i++)
	  {
	  	 	if (elements[i].name == "indice")
	  	 	{
			   if (elements[i].checked)
			   {
			  	flag = true;
				index = elements[i].value;
			  	count++;
			   }
			}
	  }

	if (count >= 1){
		document.forms['autorizacionMultipleForm'].submit();  
	}		
	else{
		alert("Debe seleccionar un registro para aprobación");
	}
}
function __editItem(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizacionMultipleForm'].elements;
	  for(var i = 0; i < elements.length; i++)
	  {
	  	 	if (elements[i].name == "indice")
	  	 	{
			   if (elements[i].checked)
			   {
			  	flag = true;
				index = elements[i].value;
			  	count++;
			   }
			}
	  }

	if (count == 1){
		__edit(index);
	}
	else if (count == 0){
		alert("Debe seleccionar un registro");
	}
	else{
		alert("Debe seleccionar un sólo registro");
	}	
}
function __checkAll(element)
{
	var elements = document.forms['autorizacionMultipleForm'].elements;
  	for(var i = 0; i < elements.length; i++)
 	{
  	 	if (elements[i].name == "indice")
  	 	   elements[i].checked = element.checked;
    }
}
function __submit(){
	  var flag = false;
	  var index = 0;
	  var count = 0;
	  var elements = document.forms['autorizacionMultipleForm'].elements;
	  for(var i = 0; i < elements.length; i++)
	  {
	  	 	if (elements[i].name == "indice")
	  	 	{
			   if (elements[i].checked)
			   {
			  	flag = true;
				index = elements[i].value;
			  	count++;
			   }
			}
	  }

	if (count > 0){
		document.forms['autorizacionMultipleForm'].submit();  
	}		
	else{
		alert("Debe seleccionar al menos un registro para aprobación");
	}
}

function _submit(indice){

            openwin("<html:rewrite page='/dian/formulario4.jsp'/>?indice="+indice);

}

function openwin(url)


{

            nwin=window.open(url, "nwin",config="scrollbars=no,resizable=yes,toolbar=no,location=yes,status=yes,menubar=no");

            nwin.focus();

}
</script>
<%@ include file="/body.jsp"%>
<html:form action="/dian/elaborar/editar">
	<html:hidden property="indice"/>
</html:form>

<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">
              <tr> 
                <td height="40" valign="bottom"><div align="left"> 
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
                      <tr> 
                        <td><div align="left" class="login">Reporte de Control</div></td>
                        <td width="8%"><div align="right">&nbsp;
							<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td>
                      </tr>
                    </table>
                  </div></td>
              </tr>
            
		</table>         
			<table width="100%" border="0" align="center" cellpadding="5" cellspacing="5">     
              <tr> 
                <td valign="top">               


				<logic:notEmpty name="infoDecImportacion">
				
				<table width="100%" border="0" cellpadding="1" cellspacing="2" align="center">
					<tr>
						<td colspan="4">
							<div align="center" class="texto-acceso">INFORMACIÓN POR DECLARACIÓN DE IMPORTACIÓN</div>
						</td>
						<td><a  href="<html:rewrite page='/do.declaimportacion'/>"><img src="../images/icono_acrobat.gif" border=0><bean:message key="lbl.pdf.download"/></a></td>				
					</tr>
	                 <tr class="tabla-acceso">
                        <td class="texto-acceso" width="20%" align="center">Fecha Formulario</td>
                        <td class="texto-acceso" width="20%" align="center">No. Consecutivo</td>
                        <td class="texto-acceso" width="20%" align="center">No. Declaración de Importación</td>
                        <td class="texto-acceso" width="20%" align="center">Año Declaración</td>
                        <td class="texto-acceso" width="20%" align="center">Valor USD</td>
                        
					 </tr>
					 
                     <logic:present name="infoDecImportacion">
                     <logic:iterate name="infoDecImportacion" id="row"
                     type="com.arango.internet.banking.ReportesControlBean" indexId="resultNo">
                     <bean:define id="remainder0" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder0" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder0" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo1" format="dd/mm/yyyy"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo2"/></td>
                        <td class="bienvenida" align="left">&nbsp;<bean:write name="row" property="campo3"/></td>
						<td class="bienvenida" align="center"><bean:write name="row" property="campo4" format="dd/mm/yyyy"/></td>
                        <td class="bienvenida" align="right"><bean:write name="row" property="campo5" format="##,###,###,##0.00"/></td>						
                    </tr>
					    
                     </logic:iterate>
					<tr>
					     
					    <td colspan="4" class="texto-acceso" width="20%" align="right">Cantidad  de Registros:</td>
<%-- 					   <td class="bienvenida" align="right"><b><bean:write name="row" property="cantidad" /></b></td> --%>
						<td class="bienvenida" align="right"><b><%=size1 %></b></td>	
					 </tr>
                     </logic:present>
				</table>

			</logic:notEmpty>
			<tr> 
                <td valign="top">               
			
			<logic:notEmpty name="infoDocTransporte">
				
				<table width="100%" border="0" cellpadding="1" cellspacing="2" align="center">
					<tr>
						<td colspan="4">
							<div align="center" class="texto-acceso">INFORMACIÓN POR DOCUMENTO DE TRANSPORTE</div>
						</td>
						<td><a  href="<html:rewrite page='/do.docutransporte'/>"><img src="../images/icono_acrobat.gif" border=0><bean:message key="lbl.pdf.download"/></a></td>				
					</tr>
	                 <tr class="tabla-acceso">
                        <td class="texto-acceso" width="20%" align="center">Fecha Formulario</td>
                        <td class="texto-acceso" width="20%" align="center">No. Consecutivo</td>
                        <td class="texto-acceso" width="20%" align="center">Documento de Trasporte NO.</td>
                        <td class="texto-acceso" width="20%" align="center">Fecha documento</td>
                        <td class="texto-acceso" width="20%" align="center">Valor USD</td>                                                                        
                     </tr>
                     <logic:present name="infoDocTransporte">
                     <logic:iterate name="infoDocTransporte" id="row"
                     type="com.arango.internet.banking.ReportesControlBean" indexId="resultNo">
                     <bean:define id="remainder1" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder1" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder1" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo2" format="dd/mm/yyyy"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo3"/></td>
                        <td class="bienvenida" align="left">&nbsp;<bean:write name="row" property="campo1"/></td>
						<td class="bienvenida" align="center"><bean:write name="row" property="campo4" format="dd/mm/yyyy"/></td>
                        <td class="bienvenida" align="right"><bean:write name="row" property="campo5" format="##,###,###,##0.00"/></td>
                    </tr>
                     </logic:iterate>
                     <tr>					     
					    <td colspan="4" class="texto-acceso" width="20%" align="right">Cantidad  de Registros:</td>
					   <td class="bienvenida" align="right"><b><%=size2 %></b></td>
					 </tr>
                     </logic:present>
				</table>

			</logic:notEmpty>
			<tr> 
                <td valign="top">               
			
			<logic:notEmpty name="infoDecExportacion">
				
				<table width="100%" border="0" cellpadding="1" cellspacing="2" align="center">
					<tr>
						<td colspan="5">
							<div align="center" class="texto-acceso">INFORMACIÓN POR DECLARACIÓN DE EXPORTACIÓN</div>
						</td>
						<td><a  href="<html:rewrite page='/do.declaexportacion'/>"><img src="../images/icono_acrobat.gif" border=0><bean:message key="lbl.pdf.download"/></a></td>				
					</tr>
	                 <tr class="tabla-acceso">
                        <td class="texto-acceso" width="16%" align="center">Fecha Formulario</td>
                        <td class="texto-acceso" width="17%" align="center">No. Consecutivo</td>
                        <td class="texto-acceso" width="16%" align="center">No. Declaración de Exportación</td>
                        <td class="texto-acceso" width="17%" align="center">Fecha de Exportación</td>
                        <td class="texto-acceso" width="16%" align="center">Numeral</td>    
                        <td class="texto-acceso" width="17%" align="center">Valor Reintegrado</td>                                             
                     </tr>
                     <logic:present name="infoDecExportacion">
                     <logic:iterate name="infoDecExportacion" id="row"
                     type="com.arango.internet.banking.ReportesControlBean" indexId="resultNo">
                     <bean:define id="remainder2" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder2" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder2" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo1" format="dd/mm/yyyy"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo2"/></td>
                        <td class="bienvenida" align="left">&nbsp;<bean:write name="row" property="campo3"/></td>
						<td class="bienvenida" align="center"><bean:write name="row" property="campo4" format="dd/mm/yyyy"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo5" /></td>
                        <td class="bienvenida" align="right"><bean:write name="row" property="campo6" format="##,###,###,##0.00" /></td>
                    </tr>
                     </logic:iterate>
                     <tr>					     
					    <td colspan="5" class="texto-acceso" width="20%" align="right">Cantidad  de Registros:</td>
					   <td class="bienvenida" align="right"><b><%=size3 %></b></td>
					 </tr>
                     </logic:present>                     
				</table>
			
			</logic:notEmpty>
			<tr> 
                <td valign="top">               
			
			<logic:notEmpty name="infoEndeudamiento">
				
				<table width="100%" border="0" cellpadding="1" cellspacing="2" align="center">
					<tr>
						<td colspan="5">
							<div align="center" class="texto-acceso">INFORMACIÓN DE ENDEUDAMIENTO</div>
						</td>
						<td><a  href="<html:rewrite page='/do.infoendeudamiento'/>"><img src="../images/icono_acrobat.gif" border=0><bean:message key="lbl.pdf.download"/></a></td>				
					</tr>
	                 <tr class="tabla-acceso">
                        <td class="texto-acceso" width="17%" align="center">Fecha Formulario</td>
                        <td class="texto-acceso" width="16%" align="center">No. Consecutivo</td>
                        <td class="texto-acceso" width="17%" align="center">No. de Prestamo</td>
                        <td class="texto-acceso" width="18%" align="center">Nombre del Deudor o Acreedor</td>
                        <td class="texto-acceso" width="16%" align="center">Numeral</td>    
                        <td class="texto-acceso" width="17%" align="center">Valor USD</td>                                             
                     </tr>
                     <logic:present name="infoEndeudamiento">
                     <logic:iterate name="infoEndeudamiento" id="row"
                     type="com.arango.internet.banking.ReportesControlBean" indexId="resultNo">
                     <bean:define id="remainder3" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder3" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder3" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo1" format="dd/mm/yyyy"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo2"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo3"/></td>
						<td class="bienvenida" align="left"><bean:write name="row" property="campo4" /></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo5" /></td>
                        <td class="bienvenida" align="right"><bean:write name="row" property="campo6" format="##,###,###,##0.00"/></td>
                    </tr>
                     </logic:iterate>
                     <tr>					     
					    <td colspan="5" class="texto-acceso" width="20%" align="right">Cantidad  de Registros:</td>
					   <td class="bienvenida" align="right"><b><%=size4 %></b></td>
					 </tr>
                     </logic:present>
                </table>

			</logic:notEmpty>
			<tr> 
                <td valign="top">               
			
			<logic:notEmpty name="infoDatosFaltantes1059">
				
				<table width="100%" border="0" cellpadding="1" cellspacing="2" align="center">
					<tr>
						<td colspan="4">
							<div align="right" class="texto-acceso">INFORMACIÓN DE DATOS FALTANTES DEL FORMATO 1</div>
						</td>
						<td><div align="center"><a  href="<html:rewrite page='/do.datosuno'/>"><img src="../images/icono_acrobat.gif" border=0><bean:message key="lbl.pdf.download"/></a></div></td>				
					</tr>
	                 <tr class="tabla-acceso">
                        <td class="texto-acceso" width="20%" align="center">Fecha Formulario</td>
                        <td class="texto-acceso" width="10%" align="center">No. Consecutivo</td>
                        <td class="texto-acceso" width="10%" align="center">Numeral</td>
                        <td class="texto-acceso" width="20%" align="center">Valor USD</td>
						<td class="texto-acceso" width="30%" align="center">Observaciones</td>
                     </tr>
                     <logic:present name="infoDatosFaltantes1059">
                     <logic:iterate name="infoDatosFaltantes1059" id="row"
                     type="com.arango.internet.banking.ReportesControlBean" indexId="resultNo">
                     <bean:define id="remainder4" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder4" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder4" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo1" format="dd/mm/yyyy"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo2"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo3"/></td>
						<td class="bienvenida" align="right"><bean:write name="row" property="campo4" format="##,###,###,##0.00"/></td>
						<td class="bienvenida" align="left"><bean:write name="row" property="campo7"/></td>
                    </tr>
                     </logic:iterate>
                     <tr>					     
					    <td colspan="4" class="texto-acceso" width="20%" align="right">Cantidad  de Registros:</td>
					   <td class="bienvenida" align="right"><b><%=size5 %></b></td>
					 </tr>
                     </logic:present>
				</table>
	
			</logic:notEmpty>
			<tr> 
                <td valign="top">               
			
			<logic:notEmpty name="infoDatosFaltantes1060">
				
				<table width="100%" border="0" cellpadding="1" cellspacing="2" align="center">
					<tr>
						<td colspan="4">
							<div align="right" class="texto-acceso">INFORMACIÓN DE DATOS FALTANTES DEL FORMATO 2</div>
						</td>
						<td><div align="center"><a  href="<html:rewrite page='/do.datosdos'/>"><img src="../images/icono_acrobat.gif" border=0><bean:message key="lbl.pdf.download"/></a></div></td>				
					</tr>
	                 <tr class="tabla-acceso">
                        <td class="texto-acceso" width="20%" align="center">Fecha Formulario</td>
                        <td class="texto-acceso" width="10%" align="center">No. Consecutivo</td>
                        <td class="texto-acceso" width="10%" align="center">Numeral</td>
                        <td class="texto-acceso" width="20%" align="center">Valor USD</td>
						<td class="texto-acceso" width="30%" align="center">Observaciones</td>
                     </tr>
            <logic:present name="infoDatosFaltantes1060">
            	<logic:iterate name="infoDatosFaltantes1060" id="row"
                     type="com.arango.internet.banking.ReportesControlBean" indexId="resultNo">
                     <bean:define id="remainder5" value="<%=Integer.toString(resultNo.intValue() % 2) %>"/>			
					     <logic:equal name="remainder5" value="0">
					       <tr>
					    </logic:equal>
					    <logic:notEqual name="remainder5" value="0">
					       <tr class="celda-clave1">
					    </logic:notEqual>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo1" format="dd/mm/yyyy"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo2"/></td>
                        <td class="bienvenida" align="center"><bean:write name="row" property="campo3"/></td>
						<td class="bienvenida" align="right"><bean:write name="row" property="campo4" format="##,###,###,##0.00"/></td>
						<td class="bienvenida" align="left"><bean:write name="row" property="campo7"/></td>
						
                    </tr>
					
                     </logic:iterate>
					 <tr>					     
					    <td colspan="4" class="texto-acceso" width="20%" align="right">Cantidad  de Registros:</td>
					   <td class="bienvenida" align="right"><b><%=size6 %></b></td>
					 </tr>
                     </logic:present>
				</table>	
			</logic:notEmpty>
</td>
</tr>
</table>
					
<table width="80%" border="0" cellpadding="0" cellspacing="2">	
	<tr> 
		<td valign="top" class="texto-acceso" colspan="2"><div align="center"><br>
		
				<INPUT class="botton" onclick="__retornar();" type=button value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
</table>			
<%@ include file="/footer.jsp"  %>
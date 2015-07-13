<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ include file="../head.jsp"%> 
<script language=javascript>
<%if (session.getAttribute("vencimientos.modificacion.registro")!=null){%>
function __retornar(){
	document.forms['backForm'].submit();
}
<%}else{%>
function __retornar(){
	history.back();
}
<%}%>
</script>
<%@ include file="../body.jsp"%> 
<%if (session.getAttribute("vencimientos.modificacion.registro")!=null){%>
<form action="<html:rewrite page='/vencimiento/modificacion/consulta.do'/>" name="backForm" method="post">
	<input type="hidden" name="cuenta" value="<%=(String)session.getAttribute("consulta.vencimiento.cuenta")%>"/>
	<input type="hidden" name="desde" value="<%=(String)session.getAttribute("consulta.vencimiento.fecha.desde")%>"/>
	<input type="hidden" name="hasta" value="<%=(String)session.getAttribute("consulta.vencimiento.fecha.hasta")%>"/>
	<input type="hidden" name="tipoVencimiento" value="<%=(String)session.getAttribute("tipo.vencimiento")%>"/>
	
</form>
<%}%>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
       <tr> 
         <td><div align="center">                     
               <table width="400" height="200" border="0" cellpadding="0" cellspacing="0" class="tabla-acceso">
                 <tr> 
                   <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                       <tr> 
                         <td width="46%" rowspan="2"><div align="center"> 
                             <table width="100%" border="0" cellspacing="2" cellpadding="2">
                               <tr> 
                                 <td><div align="center"><img src="<html:rewrite page='/images/success.gif'/>"></div></td>
                               </tr>
                               <tr> 
                                 <td class="bienvenida">Operación realizada</td>
                               </tr>
							   <tr>
								 <td class="bienvenida">El Registro ha sido guardado exitósamente.</td>
							   </tr>
							   <tr><td><div align="right">&nbsp;
							<INPUT class="botton" onclick="__retornar()" type="button" value="<bean:message key="lbl.retroceder"/>"></div></td></tr>
                             </table>
                             </div> 
						</td>                                
                       
                       </tr>
                       </table>
					</td>                           
                 </tr>
				</table></div></td></tr></table>  
<%@ include file="/footer.jsp" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ include file="../head.jsp"  %> 
<script language="JavaScript1.2" src="../scripts/calculos.js">

</script>

<%@ include file="../body.jsp"%>
<table width="750" border="0" align="left" cellpadding="0" cellspacing="0">
  <tr> 
	<td height="40" valign="bottom"><div align="left"> 
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="linea-botton">
		  <tr> 
			<td width="92%"><div align="left" class="login"><bean:message key="tit.proyeccion.credito"/></div></td>
                        <td width="8%"><div align="right"></div></td>
                      </tr>
                    </table>
                  </div></td>
              </tr>
              <tr> 
                <td height="41" class="texto-acceso">&nbsp;</td>
              </tr>
              <tr> 
                <td valign="top">
<form method="post" enctype="text\plain" name="forma1">
<input type="hidden" name="pagD">
<input type="hidden" name="monD">
<input type="hidden" name="menD">
</form>
<form method="post" enctype="text\plain" name="forma"> 
<table width="80%" border="0" align="left" cellpadding="0" cellspacing="2">
  <tr> 
	<td height="15" width="36%" class="celda-clave1"><div align="right" class="texto-acceso"><bean:message key="lbl.simulacion.monto"/></div></td>
    <td height="15" width="25%" class="bienvenida"><INPUT TYPE="TEXT" NAME="monto" SIZE="14" onblur="validarEntrada(document.forma.monto,'f','<bean:message key="lbl.simulacion.monto.no.valido"/>')"></TD>
	<td height="15" width="39%" class="bienvenida">&nbsp; </td>
<tr> 
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso">
			<bean:message key="lbl.simulacion.interes"/>%</div></td>
    <td height="15" class="bienvenida"><INPUT TYPE="TEXT" NAME="tasa" SIZE="14" onblur="validarEntrada(document.forma.tasa,'f','<bean:message key="lbl.simulacion.interes.no.valido"/>')"></TD>
	<td height="15" class="bienvenida">&nbsp; </td>
	</TR>
<tr> 
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso">
			<bean:message key="lbl.simulacion.plazo"/></div></td>
    <td height="15" class="bienvenida"><INPUT TYPE="TEXT" NAME="pagos" SIZE="14" onblur="validarEntrada(document.forma.pagos,'d','<bean:message key="lbl.simulacion.plazo.no.valido"/>')"></TD>
	<td height="15" class="bienvenida"></td>
<tr> 
	<td height="15" class="celda-clave1"><div align="right" class="texto-acceso">
			<bean:message key="lbl.simulacion.cuota"/></div></td>
    <td height="15" class="bienvenida"><INPUT TYPE="TEXT" NAME="mensualidad" SIZE="14" onblur="validarEntrada(document.forma.mensualidad,'f','<bean:message key="lbl.simulacion.cuota.no.valido"/>')"></TD>
	<td height="15" class="bienvenida">&nbsp; </td>
	</tr>
<tr> 
	<td></td>
	<td>	
	<input type="button" class="botton" value="<bean:message key="lbl.simulacion.calcular"/>" class="botonEnviar" onclick="verificarCampo('<bean:message key="lbl.simulacion.validacion.campos"/>','<bean:message key="lbl.simulacion.total"/>')"  name="B1">
	&nbsp;<INPUT TYPE="RESET" NAME="B1" VALUE="<bean:message key="lbl.simulacion.limpiar"/>" onclick="limpiar();" class="botton"></td></tr>
	<td></td>
</table>
</form></td></tr>
<tr><td>
<table width="80%" border="0" cellpadding="0" cellspacing="2">
	<TR class="tabla-acceso">
		<TD CLASS="texto-acceso" width="20%"><bean:message key="lbl.simulacion.cuota"/></TD>
	    <TD CLASS="texto-acceso" width="20%"><bean:message key="lbl.simulacion.total"/></TD>
	    <TD CLASS="texto-acceso" width="20%"><bean:message key="lbl.simulacion.amortizacion"/></TD>
	    <TD CLASS="texto-acceso" width="20%"><bean:message key="lbl.simulacion.interes"/></TD>
	    <TD CLASS="texto-acceso" width="20%"><bean:message key="lbl.simulacion.saldo"/></TD></TR>
</TABLE>
<DIV  STYLE="overflow:scroll; float:Left;
            width:100%; height:175px;">

<SCRIPT LANGUAGE="JavaScript">
         document.write('<TABLE border="1" class="calculo" ID="proyeccion"></TABLE>');
</SCRIPT>

</DIV>
</td></tr></table></table>
<br>
<%@ include file="../footer.jsp"  %>
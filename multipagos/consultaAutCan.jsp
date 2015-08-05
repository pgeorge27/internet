<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
System.out.print("JSP-BEGIN");
System.out.println(new java.util.Date(System.currentTimeMillis()));
%>
<%@ include file="../head.jsp"  %> 

<%@ include file="../body.jsp"%>
<script type="text/javascript">
function send(){
	
		if(document.forms['consultaForm'].cliente.value == ""){
			alert(" - Cliente es requerido. "); 
			document.forms['consultaForm'].desde.focus();
			return;
		}
		
	document.forms['consultaForm'].submit();
}

</script>

<div class="container">
	<div class="row" style="padding-right: 3%; padding-left: 3%;">

		<logic:messagesPresent>
			<div class="col-md-4 col-md-offset-4">
				<div align="center" class="well">
					<p><img src="<html:rewrite page='/images/warning.gif'/>"></p>
					<p><b><bean:message key="errors.header"/></b></p>
					<html:messages id="error">
						<p class="bienvenida">- <bean:write name="error" /></p>
					</html:messages>
				</div>
			</div>
		</logic:messagesPresent>
		<script type="text/javascript">
			CONST_Y += document.getElementById('msgError').clientHeight;
		</script>

		<div class="col-md-4 col-md-offset-4">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.transf.inter.aprobacion"/> Multipagos
					</strong>
				</div>
				<div class="panel-body">

					<html:form method="post" action="/multipagos/Consulta/autorizaciones">
						<html:hidden property="estado" value="P" /> 
						<html:hidden property="tipo" value="1" /> 
						<p><bean:message key="lbl.transf.inter.cliente"/><span class="texto-acceso">(<font color="#FF0000">*</font>)</span></p>
						<html:select property="cliente" styleClass="form-control">
							<html:option value=""><bean:message key="lbl.transf.inter.seleccione"/></html:option>
							<csic:forEachCliente orderBy="NAME_ORDER">  
								<html:option value="<%=codigo%>" ><%=nombre%>&nbsp;<%=apellido%></html:option>	
							</csic:forEachCliente>
						</html:select>

					<div align="center">
						<br>
						<input name="botonEnviar" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.consultar"/>">
						<html:reset styleClass="btn btn-default"><bean:message key="btn.limpiar"/></html:reset>
						<br>
						<br>
						<p><bean:message key="lbl.mensaje.campo.requerido"/></p>
					</div>
				</html:form>


				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../footer.jsp"  %>
<%
System.out.print("JSP-END");
System.out.println(new java.util.Date(System.currentTimeMillis()));
%>
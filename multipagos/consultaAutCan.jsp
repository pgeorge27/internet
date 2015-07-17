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
	<div class="row"> 
		<div>
			<logic:messagesPresent>
			<table cellpadding="1" cellspacing="1" width="750" align="center" class="tabla-acceso">
				<tr>
					<td>
						<table border="0" cellpadding="1" cellspacing="0" width="100%">
							<tr valign="top">
								<td width="5%"><img src="<html:rewrite page='/images/warning.gif'/>">
								</td>
								<td width="95%" class="msg">
									<span class="bienvenida"><b><bean:message key="errors.header"/></b></span>
									<span class="bienvenida">
										<table width="80%">
											<html:messages id="error">					
											<tr>
												<td class="bienvenida">- <bean:write name="error" /></td>
											</tr>
											</html:messages>
										</table>
									</span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</logic:messagesPresent>
		</div>

		<div class="col-md-4 col-md-offset-4">
			<div class="panel panel-default" >
				<div class="panel-heading" >
					<img src="<html:rewrite page='/images/logo_icon.png' />" />
					<strong>
						<bean:message key="lbl.transf.inter.aprobacion"/> Multipagos
					</strong>
				</div>

				<div class="panel-body">
						<label style="text-align:left">
							<h5>
								<span class="texto-acceso"><font color="#FF0000">*</font></span>
								<strong><bean:message key="lbl.transf.inter.cliente"/>:</strong>
							</h5>
						</label>

						<html:form method="post" action="/multipagos/Consulta/autorizaciones">
						<div class=".col-md-6" style="align: center; padding-right: 3%; width: 90%;" >
							<html:select property="cliente" styleClass="botton-acceso form-control">
								<html:option value="">
								<bean:message key="lbl.transf.inter.seleccione"/>
								</html:option>
								<csic:forEachCliente orderBy="NAME_ORDER" >  
									<html:option value="<%=codigo%>" ><%=nombre%>&nbsp;<%=apellido%>
									</html:option>	
								</csic:forEachCliente>
							</html:select>
						</div>
						<br>
						<div align="center">
							<input name="botonEnviar" onclick="send();" type="button" class="btn btn-default" value="<bean:message key="btn.consultar"/>">

							<html:reset styleClass="btn btn-default">
							<bean:message key="btn.limpiar"/>
							</html:reset>
						</div>
						</html:form>
						<div align="center" class="texto-acceso">
								<h6 style="color:#95A5A6 "><bean:message key="lbl.mensaje.campo.requerido"/></h6>
								<%@ include file="../divFooter.jsp"%>
						</div>
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
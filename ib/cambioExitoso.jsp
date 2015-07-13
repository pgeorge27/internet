<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="../head.jsp"%>
<%@ include file="../body.jsp"%>

<table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td height="300" valign="middle"><table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center"> 
					<input type=hidden name=servicio value=1>
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
                                        <td align="center" class="bienvenida"><bean:message key="msg.update.success"/>
										</td>
                                      </tr>
                                    </table>
                                  </div></td>                                
                              </tr>
                             
                            </table></td>
                        </tr>
                      </table>
                  </div></td>
              </tr>
              <tr> 
                <td></td>
              </tr>
            </table></td>
        </tr>
      </table>
<%@ include file="../footer.jsp" %>
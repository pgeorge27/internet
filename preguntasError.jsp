<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<%@ include file="head.jsp"  %>
<%@ include file="body.jsp"  %>
		   <table width="400" height="200" border="0" cellpadding="0" cellspacing="0" class="mnuItem">
                        <tr> 
                          <td height="0"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                              <tr> 
                                <td width="46%" rowspan="2"><div align="center"> 
                                    <table width="100%" border="0" cellspacing="2" cellpadding="2">
                                      <tr> 
                                        <td><div align="center"><img src="<html:rewrite page='/images/error.gif'/>"></div></td>
                                      </tr>
                                      <tr> 
                                        <td class="bienvenida"><p align="justify"><bean:message key="lbl.preg.secreta.nota"/></p></td>
                                      </tr>
                                    </table>
                                  </div></td>                                
                              </tr>                      
			</table>

<%@ include file="footer.jsp"  %>

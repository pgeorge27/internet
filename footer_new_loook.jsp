<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%
java.util.Calendar cal4 =  java.util.Calendar.getInstance();
String  serv = session.getAttribute("codigo.servicio").toString(); %>
 
 <br/>
 <br/>
 </td>
                                    <td background="<html:rewrite page='/images/linea_3.png' />"></td>
                                </tr>
                                <%if (serv.equals("1")) {%> 
                                <tr>
                                    <td background="<html:rewrite page='/images/linea_2.png' />"></td>
                                    <td align="center" class="derechos" background="<html:rewrite page='/images/FondoPie.png' />" height="20px">
                                    	 <bean:message key="msg.derechos.reservados" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
                                    </td>
                                    <td background="<html:rewrite page='/images/linea_3.png' />"></td>
                                </tr>
                                <%}   else {%>
                                 <tr>
                                    <td background="<html:rewrite page='/images/linea_2.png' />"></td>
                                    <td align="center" class="derechos" background="<html:rewrite page='/images/FondoPie.png' />" height="20px">
                                    	 <bean:message key="msg.derechos.reservados2" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
                                    </td>
                                    <td background="<html:rewrite page='/images/linea_3.png' />"></td>
                                </tr>
                                 <%} %>
                                <tr>
                                    <td width="10px"><img src="<html:rewrite page='/images/inferior_izquierda.png' />" border="0" /></td>
                                    <td background="<html:rewrite page='/images/inferior_centro.png' />"></td>
                                    <td width="10px"><img src="<html:rewrite page='/images/inferior_derecha.png' />" border="0" /></td>
                                </tr>
                              </table>
                          </td>
                    </tr>
                </tr>
            </table>
        </td>
       </tr>
</table>

</body>
</html>

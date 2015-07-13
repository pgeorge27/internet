<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

		<%
		   java.util.Calendar cal4 =  java.util.Calendar.getInstance();
		   String  serv = session.getAttribute("codigo.servicio").toString(); 
		   System.out.println("Codigo Servicio: " + serv);
	    %>

		</td></tr>
	</table></td></tr>
   </table></td></tr>
 <tr>
<%if (serv.equals("1")) {%> 
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">
        <bean:message key="msg.derechos.reservados" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
     </div></td>
 <%}   else {%>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">
        <bean:message key="msg.derechos.reservados2" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
     </div></td>
 <%} %>
 
  </tr>
</table>

</body>
</html>
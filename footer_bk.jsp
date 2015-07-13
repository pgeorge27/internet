<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
		<%java.util.Calendar cal4 =  java.util.Calendar.getInstance();%>
		</td></tr>
	</table></td></tr>
   </table></td></tr>
 <tr>
    <td height="31" colspan="4" style="width:100%;height:31;background-color:#4D4F53;"><div align="center" class="derechos">
        <bean:message key="msg.derechos.reservados" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/></div></td>
  </tr>
</table>

</body>
</html>
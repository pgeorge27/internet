<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<!DOCTYPE html>
<html>


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

<style>
/* Sticky footer styles
-------------------------------------------------- */
html {
  position: relative;
  min-height: 100%;
}
body {
  /* Margin bottom by footer height */
  margin-bottom: 60px;
}
.footer {
  position: absolute;
  bottom: 0;
  width: 100%;
  /* Set the fixed height of the footer here */
  height: 5%;
  background-color: #4D4F53;
}


/* Custom page CSS
-------------------------------------------------- */
/* Not required for template or sticky footer method. */

body > .container {
  padding: 60px 15px 0;
}
.container .text-muted {
  margin: 20px 0;
}

.footer > .container {
  padding-right: 15px;
  padding-left: 15px;
}

code {
  font-size: 80%;
}

</style>

    <td height="31" colspan="4" style="width:100%;height:31;"><div align="center" class="" style="color:white;">
        <bean:message key="msg.derechos.reservados" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
     </div></td>
 <%}   else {%>
    <td height="31" colspan="4" style="width:100%;height:31;"><div align="center" class="" style="color:white;">
        <bean:message key="msg.derechos.reservados2" arg0='<%=""+java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)%>'/>
     </div></td>
 <%} %>
 
  </tr>
</table>


</html>
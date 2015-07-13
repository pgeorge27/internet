<% session.setAttribute("selected", "custodia"); %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>

<html>
<head>
</head>
<logic:empty name="confirmError">
			<frameset rows="100%,*" border="0">  
			<frame src="http://201.225.227.246:7777/pls/apex/f?p=107:1:::::V_E,V_U:<%=(String)session.getAttribute("criptCode").toString() %>,<%=(String)session.getAttribute("userName").toString() %>"
			 frameborder="0" />  
			<frame frameborder="0" noresize />
		</logic:empty>
		<logic:notEmpty name="confirmError">
		<body>
			<%=(String)session.getAttribute("errores").toString() %>
			</body>
		</logic:notEmpty>

</html>
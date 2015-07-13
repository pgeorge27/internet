<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>


	<logic:present name="error">
		<logic:redirect page="/signup.jsp"/>
	</logic:present>
	<logic:notPresent name="error">
		<logic:redirect page="/index2.jsp"/>
	</logic:notPresent>
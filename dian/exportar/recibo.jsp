<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="/tags/asi-internet" prefix="csic" %>

<%@ include file="/head.jsp"%> 
<link rel="stylesheet" type="text/css" media="all" href="../calendar/calendar-win2k-1.css" title="win2k-1">

<!-- import the calendar script -->
<script type="text/javascript" src="../calendar/calendar.js"></script>

<!-- import the language module -->
<script type="text/javascript" src="../calendar/calendar-es.js"></script>
<!-- helper script that uses the calendar -->
<script type="text/javascript">


</script>
<body leftmargin="0" topmargin="0">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr valign="top">
    <td style="background:#00367e" height="55">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" height="55">
           <tr valign="top">
                <td width="100%"><img src="<html:rewrite page='/images/bannerprinc.gif'/>"></td>
           </tr>
        </table>
    </td>
</tr>
<tr>
    <td height="15">
	<table border="0" cellpadding="1" cellspacing="1" width="100%">
           <tr valign="top">
                <td width="70%" style="background:#00367e" class="link">&nbsp;</td>
           </tr>
        </table>
    </td>
</tr>
<tr valign="top">
    <td>

<table border="0" cellpadding="0" cellspacing="0" width="100%">

     <td colspan="2">
         
<table  border="0" cellpadding="3" cellspacing="1" width="100%" style="border:#214D73 1px solid">
<tr><td>&nbsp;</td></tr>


<tr>
<td>
<table width="75%" border="0">
<tr align="center" size="3">
   <td class=NormalBold>Cierto</td>
</tr>

</table>

<%@ include file="/footer.jsp" %>
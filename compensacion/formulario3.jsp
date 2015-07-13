<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<html>
<head></head>
<body>
<script>
document.location="<%=session.getAttribute("ruta.formularios")%><bean:write name='formulario' property='ruta'/>?"+
"clte=<bean:write name='formulario' property='clte'/>&"+          
"emp=<bean:write name='formulario' property='emp'/>&"+    
"age=<bean:write name='formulario' property='age'/>&"+    
"apl=<bean:write name='formulario' property='apl'/>&"+    
"sapl=<bean:write name='formulario' property='sapl'/>&"+    
"cta=<bean:write name='formulario' property='cta'/>&"+    
"nmov=<bean:write name='formulario' property='nmov'/>&"+    
"fmov=<bean:write name='formulario' property='fmov'/>&"+    
"est=<bean:write name='formulario' property='est'/>&"+    
"aut=<bean:write name='formulario' property='aut'/>&"+     
"usr=<bean:write name='formulario' property='usr'/>&"+      
"usrA=<bean:write name='formulario' property='usrA'/>&"+      
"seq=<bean:write name='formulario' property='seq'/>&"+  
"ctni=<bean:write name='formulario' property='ctni'/>&"+  
"ssid=<bean:write name='formulario' property='ssid'/>&"+ 
"mf=<bean:write name='formulario' property='mf'/>";
</script>
</body>
</html>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.arango.common.util.StringUtilities" %>
<%@ page import="com.arango.common.sql.ConnectionFactory" %>
<%@ page import="com.arango.internet.banking.dian.ListItem" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory" %>

<%@ page import="org.w3c.dom.Document" %>
<%@ page import="org.w3c.dom.Element" %>
<%@ page import="org.w3c.dom.NodeList" %>
<%@ page import="org.xml.sax.InputSource" %>

<%!
private String getXML(InputStream xml) throws IOException {

    StringBuffer buffer = new StringBuffer();
    int c;
    while ((c = xml.read()) > 0)
        buffer.append(String.valueOf((char) c));

    return buffer.toString();

}
public synchronized ArrayList GetList(ServletContext context, String fileName) throws Exception {
    NodeList elements = null;
    ArrayList data = new ArrayList();
    String xml = getXML(context.getResourceAsStream(
                    "/WEB-INF/resources/" + fileName + ".xml"));	
    InputSource source = new InputSource(new java.io.StringReader(xml));

    DocumentBuilderFactory builder = DocumentBuilderFactory
            .newInstance();
    Document doc = builder.newDocumentBuilder().parse(source);
    Element root = doc.getDocumentElement();
    elements = root.getElementsByTagName("row");
    Element node = null;
    ListItem item = null;
    for (int i = 0; i < elements.getLength(); i++){
	    node = (Element) elements.item(i);item = new ListItem();
		item.setCode(node.getAttribute("key"));
		item.setValue(node.getAttribute("value"));
		data.add(item);
    }
	return data;
}
%>
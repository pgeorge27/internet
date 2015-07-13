<%@ page import="com.arango.common.delegate.Manager" %>
<%@ page import="com.arango.common.beans.constant.ConstantesGlobales" %>
<%@ page import="java.awt.Color" %>
<%@ page import="java.awt.Font" %>
<%@ page import="java.awt.FontMetrics" %>
<%@ page import="java.awt.Graphics" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="javax.imageio.ImageIO" %>


<%
	String userid = session.getAttribute("user.id").toString();
	System.out.println("userid "+ userid);
	String rol =  session.getAttribute("role.user").toString();
	System.out.println("rol " + rol);
	int flag = Integer.parseInt(session.getAttribute("flag").toString());
	
	Manager mgr = new Manager();
	String url = "";
	
	String marca = request.getParameter("marca").toUpperCase();
	BufferedImage bf = mgr.getImageUser1BD(userid);
	Graphics imagen = bf.getGraphics();

	int largoTexto = 0;
	int largoImagen = bf.getWidth();
	int altoImagen = bf.getHeight();

	Font regularFont = new Font("Arial", Font.BOLD, 65);
	Font regularFont2 = new Font(marca, altoImagen, altoImagen);
	imagen.setFont(regularFont);

	// Centrea el texto
	FontMetrics fm = imagen.getFontMetrics();
	largoTexto = fm.stringWidth(marca);
	int x = (largoImagen - largoTexto) / 2;
	int y = (altoImagen / 2) + 25;
	
	
	imagen.setColor(Color.WHITE);
	imagen.drawString(marca, x, y);

	imagen.dispose();

	ByteArrayOutputStream os = new ByteArrayOutputStream();
	ImageIO.write(bf, "jpg", os);
	InputStream img = new ByteArrayInputStream(os.toByteArray());
	// byte[] buffer =
	// ((DataBufferByte)(bf).getRaster().getDataBuffer()).getData();
	// InputStream img = new ByteArrayInputStream(buffer);
	mgr.setImage(userid);
	// mgr.UserImageDelete(userid);
	mgr.updateUserImage(userid, img);
	// mgr.setUserImage(userid, img);

	
	if (flag >= 8)
	{	
		if(rol.equals(ConstantesGlobales.ROLE_AUTORIZADOR) | rol.equals(ConstantesGlobales.ROLE_OPERADOR_AUTORIZADOR))
		{
			mgr.disableFirstLogin(userid, ConstantesGlobales.PRIMERA_FIRMA_DIGITAL);
			url = request.getContextPath() + "/firstLoginFirma.jsp";			
		}
		else{
			mgr.disableFirstLogin(userid, ConstantesGlobales.DESACTIVA_PRIMER_LOGIN);
			url = request.getContextPath() + "/firstLoginOk.jsp";
		}
	}
	else
	{
		url = request.getContextPath() + "/start.jsp";
	}
	response.sendRedirect(url);
%>
<%@ page import = "com.arango.internet.util.images.UserImagesUtil" %>
<%@ page import = "java.io.*" %>
<%@ page import = "oracle.jdbc.OracleConnection" %>
<%
 
    try
    {  
       // get the image from the database
       byte[] imgData = UserImagesUtil.getUserPhoto( "pasi", "1"  ) ;   
       // display the image
       response.setContentType("image/gif");
       OutputStream o = response.getOutputStream();
       o.write(imgData);
       o.flush(); 
       o.close();
    }
    catch (Exception e)
    {
      e.printStackTrace();
      throw e;
    }
    finally
    {
       ;
    }  
  
%>
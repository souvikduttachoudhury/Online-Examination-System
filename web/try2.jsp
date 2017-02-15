<%-- 
    Document   : try2
    Created on : Jun 20, 2015, 12:09:56 PM
    Author     : abc
--%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>  
<%@page import="org.json.simple.JSONObject"%>
 <%-- <%
    JSONObject obj=new JSONObject();
    obj.put("name1","f");
    obj.put("name2","g");
    obj.put("name3","h");
    out.print(obj);
    out.flush();
  %>--%>
 <%!int flag=0,emp_ct=0,desg_ct=0;%><%!String cat[],name,emp_cd[],dept_cd,desg_cd,desg;%>
 <%         
            String emp_code = request.getParameter("emp_cd");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_EMP_MST WHERE EMP_CD=?");
            ps.setString(1, emp_code);
            rs = ps.executeQuery();
            //JSONObject obj1=new JSONObject();
            JSONObject obj1=new JSONObject();
            while(rs.next()){
            desg_cd=rs.getString("DESG_CD");
            name=rs.getString("EMP_NAME");
            ps = conn.prepareStatement ("SELECT * FROM OES_DESG_MST WHERE DESG_CD=?");
            ps.setString(1, desg_cd);
            rs1 = ps.executeQuery();
            while(rs1.next()){
                desg=rs1.getString("DESG_DESC");
            }
            obj1.put("name",desg_cd+","+desg+","+name); 
            }
             out.print(obj1);
             out.flush();
           }
            catch(Exception e){
                 e.printStackTrace();
                 out.println("                            Exception Caught");
            }
            finally {
            if (conn!=null)    conn.commit(); 
            if (rs!=null)      rs.close();
            if (ps!=null)      ps.close();
            if (conn!=null)    conn.close();
            }      
   ;%>
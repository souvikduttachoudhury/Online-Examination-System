
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
 <%!int flag=0,emp_ct=0,desg_ct=0;%><%!String cat[],emp[],emp_cd[],dept_cd,desg_cd[],desg;%>
 <%         
            String dept_code = request.getParameter("dept_cd");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_EMP_MST WHERE DEPT_CD=?");
            ps.setString(1, dept_code);
            rs = ps.executeQuery();
            //JSONObject obj1=new JSONObject();
            JSONObject obj2=new JSONObject();
            emp=new String[200];
            emp_cd=new String[200];
            desg_cd=new String[200];
            emp_ct=0;
            while(rs.next()){
            emp[emp_ct]=rs.getString("EMP_NAME");
            emp_cd[emp_ct]=rs.getString("EMP_CD");
            desg_cd[emp_ct]=rs.getString("DESG_CD");
            ps = conn.prepareStatement ("SELECT * FROM OES_DESG_MST WHERE DESG_CD=?");
            ps.setString(1, desg_cd[emp_ct]);
            rs1 = ps.executeQuery();
            while(rs1.next()){
                desg=rs1.getString("DESG_DESC");
            }
            obj2.put("name"+Integer.toString(emp_ct+1),emp[emp_ct]+","+emp_cd[emp_ct]+","+desg_cd[emp_ct]+","+desg); 
            emp_ct++;
            }
             out.print(obj2);
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
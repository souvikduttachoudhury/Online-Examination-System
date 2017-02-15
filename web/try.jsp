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
 <%!int cat_ct=0;%><%!String cat[],cat_code[];%>
 <%         
            String mod_code = request.getParameter("mod_cd");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_CATEGORY_MST WHERE MODULE_CD=? ORDER BY CATEGORY_CD");
            ps.setString(1, mod_code);
            rs = ps.executeQuery();
            cat_ct=0;
            cat_code=new String[50];
            cat=new String[50];
            //JSONObject obj1=new JSONObject();
            JSONObject obj2=new JSONObject();
            while(rs.next()){
            cat_code[cat_ct]=rs.getString("CATEGORY_CD");
            cat[cat_ct]=rs.getString("CATEGORY_DESC");
            //out.println("a               "+inst_cd[inst_ct]+""+inst[inst_ct]);
            obj2.put("name"+Integer.toString(cat_ct+1),cat_code[cat_ct]+","+cat[cat_ct]); 
            cat_ct++;
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
<%-- 
    Document   : route_login
    Created on : Jun 4, 2015, 9:47:00 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="login.css" type="text/css"/>
        <script type="text/javascript" src="jquery-latest.js"></script>
        <script type="text/javascript" src="jquery-latest_1.js"></script>
        <script type="text/javascript" src="feedback_dialog.js"></script>
        <script type="text/javascript" src="multi-screen.js"></script>
        <script type="text/javascript" src="jquery.js"></script>
        <title>Welcome</title>
        <script type="text/javascript">
          function submit_dtlsa(){
                window.setTimeout('document.forma.submit()',0);
            };
            function submit_dtlsd(){
                window.setTimeout('document.formd.submit()',0);
            };
            $(document).ready(function(){
               parent.welcome(''); 
            });
        </script>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
    </head>
    <%!String username="";%><%!String password="";%><%!String access_code="";%>
    <%
        username=request.getParameter("Username");
        password=request.getParameter("Password");
        //out.println(username);
        //out.println(password);
       if(Integer.parseInt(username)<100000){%>
        <jsp:forward page="gen_ins.jsp">
            <jsp:param name="Username" value="<%=username%>"/>
            <jsp:param name="Password" value="<%=password%>"/>
        </jsp:forward>
    <%}
        session.setAttribute("code1", username);
        session.setAttribute("code2", password);
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
        conn.setAutoCommit(false);
        ps = conn.prepareStatement ("SELECT ACCESS_CD FROM OES_USERS WHERE EMP_CD=?");
        ps.setString(1,username);
        rs = ps.executeQuery();
        while(rs.next()){
            access_code=rs.getString("ACCESS_CD");
        }
        if(access_code.equals("")){%>
            <jsp:forward page="login.jsp"/>
         <%}
        else if(access_code.equals("A")){%>
        <jsp:forward page="admin.jsp">
            <jsp:param name="username" value="<%=username%>"/>
            <jsp:param name="password" value="<%=password%>"/>
        </jsp:forward>
         <%}
        else{%>
          <jsp:forward page="dept.jsp">
            <jsp:param name="username" value="<%=username%>"/>
            <jsp:param name="password" value="<%=password%>"/>
          </jsp:forward>
         <%}
        } 
        catch (Exception e) {%>
           <jsp:forward page="login.jsp"/>
        <%
                e.printStackTrace();
                out.println("                  exception caught");
        }
        finally {
        if (conn!=null)    conn.commit(); 
        if (rs!=null)      rs.close();
        if (ps!=null)      ps.close();
        if (conn!=null)    conn.close();
        }
    %>
    <body id="bcg" style="background-color:#ccccff;opacity: 5 ">
        <div id="slct_lgn" style="margin-top: 23%;margin-left: 20.625%">
        <a href="dept.jsp" id="dept_lgn" style="height:1.875%;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:1.75px orangered solid" onclick="submit_dtlsd();">&nbsp;&nbsp;Departmental Login&nbsp;&nbsp;</a>
        <a href="admin.jsp" id="admn_lgn" style="margin-left: 10%;height:1.875%;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:22px;border:1.75px orangered solid" onclick="submit_dtlsa();">&nbsp;&nbsp;Administrative Login&nbsp;&nbsp;</a>
        </div>
        <form id="formd" name="formd" action="dept.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="password" value="<%=password%>"/>
        </form>
        <form id="forma" name="forma" action="admin.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="password" value="<%=password%>"/>
        </form>
        <!--div id="ent_emp_admn">
            <form id="lgn_frm1" method="post" action="admn.jsp" onsubmit="return validate_admn();">
                <div id="usn_ea">Enter Employee Code:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <input id="u" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:25px;width:200px;margin-left: 24px;" placeholder="             U s e r n a m e" type="text" name="Username"/></div>
                <!--div id="u_err_ea"></div>
                <div id="pwd_ea">Enter Emp<div id="u_err_ea"></div>loyee Password:   <input id="p" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:25px;width:200px;margin-left: 14px;" placeholder="             P a s s w o r d" type="password" name="Password"/></div>
                <!--div id="p_err_ea"></div>
                <input id="smt_ea" type="submit" value="Submit"/>
            </form>
        </div>
            <div id="ent_emp_dept">
            <form id="lgn_frm2" method="post" action="dept.jsp" onsubmit="return validate_dept();">
                <div id="usn_ed">Enter Employee Code:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <input id="u" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:25px;width:200px;margin-left: 24px;" placeholder="             U s e r n a m e" type="text" name="Username"/></div>
                <div id="u_err_ed"></div>
                <div id="pwd_ed">Enter Employee Password:   <input id="p" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:25px;width:200px;margin-left: 14px;" placeholder="             P a s s w o r d" type="password" name="Password"/></div>
                <div id="p_err_ed"></div>
                <input id="smt_ed" type="submit" value="Submit"/>
            </form>
        </div-->
    </body>
</html>

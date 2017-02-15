<%-- 
    Document   : profile
    Created on : Jun 4, 2015, 2:36:36 PM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="login.css" type="text/css"/>
        <link rel="stylesheet"  href="stylesheet.css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="bootstrap.js"></script>
        <script type="text/javascript" src="jquery_1.js"></script>
        <script type="text/javascript" src="jquery-latest.js"></script>
        <script type="text/javascript" src="jquery-latest_1.js"></script>
        <script type="text/javascript" src="feedback_dialog.js"></script>
        <script type="text/javascript" src="multi-screen.js"></script>
        <title>My Profile</title>
        <script type="text/javascript">
            function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function submit_dtlsh(access){
                if(access==='D'){
                window.setTimeout('document.formh.submit()',0);
                }
                else if(access==='A'){
                    window.setTimeout('document.formad.submit()',0);
                }
            }
        </script>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
    </head>
    <%!String from="N.A.",upto="N.A.";%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
           String username=request.getParameter("username");
           String emp_name=request.getParameter("emp_name");
           String emp_dept=request.getParameter("emp_dept");
           String emp_desg=request.getParameter("emp_desg");
           Connection conn = null;
           PreparedStatement ps = null;
           ResultSet rs = null;
           try {
           Class.forName("oracle.jdbc.driver.OracleDriver");
           conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
           conn.setAutoCommit(false);
           ps = conn.prepareStatement ("SELECT * FROM OES_USERS WHERE EMP_CD=?");
           ps.setString(1, username);
           rs = ps.executeQuery();
           from="N.A.";
           upto="N.A.";
           while(rs.next()){
               from=rs.getString("EFF_FROM");
               upto=rs.getString("EFF_UPTO");
           }
           if(!from.equals("N.A.")){
               from=from.substring(0,10);
               from=from.substring(8,10)+"/"+from.substring(5,7)+"/"+from.substring(0,4);
           }
           else{
               from="Not Available";
           }
           if(!upto.equals("N.A.")){
               upto=upto.substring(0,10);
               upto=upto.substring(8,10)+"/"+upto.substring(5,7)+"/"+upto.substring(0,4);
           }
           else{
               upto="Not Available";
           }
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
    %>
    <body id="bcg" style="background-image: url(back6.jpg);opacity: 50">
        <div style="margin-left:80%; margin-top:-5px" class="bs-example">
        <ul class="nav nav-pills">
            <li class="dropdown">
                <a href="#" data-toggle="dropdown" class="dropdown-toggle"><%=emp_name%><b class="caret"></b></a>
                <ul style="margin-left:-70px;" class="dropdown-menu">
                    <li><a href="javascript:void(0)" onclick="submit_dtlsh('<%=session.getAttribute("code3")%>');">My Jobs</a></li>
                    <li><a href="profile.jsp" onclick="submit_dtls();">Profile</a></li>
                    <!--li class="disabled"><a href="#">Setting</a></li>
                    <li><a href="#">Help</a></li>
                    <li class="divider"></li-->
                    <li><a href="login.jsp" onclick="parent.logout();">Log out</a></li>
                </ul>
            </li>
        </ul>
    </div>
         <form id="formh" name="formh" action="dept.jsp">
            <input type="hidden" name="username" value="<%=session.getAttribute("code1")%>"/>
            <input type="hidden" name="password" value="<%=session.getAttribute("code2")%>"/>
        </form> 
        <form id="formad" name="formad" action="admin.jsp">
            <input type="hidden" name="username" value="<%=session.getAttribute("code1")%>"/>
            <input type="hidden" name="password" value="<%=session.getAttribute("code2")%>"/>
         </form>            
         <h1 id="head">My Profile</h1>
         <table style="color:#ff6600;margin-left: 140px;margin-top: 75px;font-size: 30px;font-family:Times New Roman">
            <tr>
                <td ><span id="rw" style="color:#006600;font-size: 30px;font-family: Calibri;">NAME :-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><%=emp_name%></td>
            </tr>
            <tr>
                <td ><span id="rw" style="color:#006600;font-size: 30px;font-family: Calibri;">Department :-&nbsp;&nbsp;&nbsp;&nbsp;</span><%=emp_dept%></td>
            </tr>
            <tr>
                <td ><span id="rw" style="color:#006600;font-size: 30px;font-family: Calibri;">Designation :-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><%=emp_desg%></td>
            </tr>
            <tr>
                <td ><span id="rw" style="color:#006600;font-size: 30px;font-family: Calibri;">Access From :-&nbsp;&nbsp;&nbsp;&nbsp;</span><%=from%></td>
            </tr>
            <tr>
                <td ><span id="rw" style="color:#006600;font-size: 30px;font-family: Calibri;">Access Upto :-&nbsp;&nbsp;&nbsp;&nbsp;</span><%=upto%></td>
            </tr>
        </table>
            <form id="form1" name="form1" action="profile.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            </form>
    </body>
</html>

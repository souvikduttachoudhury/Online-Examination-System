<%-- 
    Document   : admin.jsp
    Created on : Jun 9, 2015, 2:58:23 PM
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
        <script type="text/javascript">
            function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function submit_dtlsqb(){
                window.setTimeout('document.formqb.submit()',0);
            }
            function submit_dtlsqp(){
                window.setTimeout('document.formqp.submit()',0);
            }
            function submit_dtlssd(){
                window.setTimeout('document.formsd.submit()',0);
            }
            function submit_dtlsid(){
                window.setTimeout('document.formid.submit()',0);
            }
            function submit_dtlsrd(){
                window.setTimeout('document.formrd.submit()',0);
            }
            function submit_dtlsacd(){
                window.setTimeout('document.formacd.submit()',0);
            }
            function submit_dtlsmd(){
                window.setTimeout('document.formmd.submit()',0);
            }
            function submit_dtlscd(){
                window.setTimeout('document.formcd.submit()',0);
            }
            function submit_dtlsed(){
                window.setTimeout('document.formed.submit()',0);
            }
            function submit_dtlsexd(){
                window.setTimeout('document.formexd.submit()',0);
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
        <title>Administrative Login</title>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
    </head>
    <%!Date from,upto;%><%!String u_check="default";%><%!String p_check="pswd";%>
    <%!String emp_name="";%><%!String dept_code="";%><%!String desg_code="";%>
    <%!String emp_dept="";%><%!String emp_desg="";%><%!String username="";%><%!String password="";%>
    <%
            username=request.getParameter("username");
            password=request.getParameter("password");
            if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            %>
            <script type="text/javascript">
                parent.showfwd();
            </script>
            <%
            session.setAttribute("code3", "A");
            //out.println(username);
            //out.println(password);
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_USERS WHERE EMP_CD =?");
            ps.setString(1, username);
            rs=ps.executeQuery();
            while(rs.next()){
                u_check=rs.getString("EMP_CD");
                from=rs.getDate("EFF_FROM");
                //upto=rs.getDate("EFF_UPTO");
            }
            if(u_check.equals("default")){%>
            <jsp:forward page="login.jsp"/>
            <%}
            Date todaysdate=new Date();
            try{
                if(todaysdate.compareTo(from)<0){%>
                 <script type="text/javascript">
                   parent.expired();
                 </script>
                <jsp:forward page="login.jsp"/> 
                <%}
            }
            catch(Exception e){
                //Do Nothing
            }
            ps = conn.prepareStatement ("SELECT * FROM OES_EMP_MST WHERE EMP_CD =?");
            ps.setString(1,username);
            rs = ps.executeQuery();
            while(rs.next()){
                p_check=rs.getString("EMP_PASSWD");
                emp_name=rs.getString("EMP_NAME");
                dept_code=rs.getString("DEPT_CD");
                desg_code=rs.getString("DESG_CD");
             }
            if(p_check.equals("pswd")){%>
            <jsp:forward page="login.jsp"/>
            <%}
              //session.setAttribute("code1","username");
              ps = conn.prepareStatement ("SELECT * FROM OES_DEPT_MST WHERE DEPT_CD =?");
              ps.setString(1,dept_code);
              rs = ps.executeQuery();
              while(rs.next()){
                  emp_dept=rs.getString("DEPT_DESC");
              }
              ps = conn.prepareStatement ("SELECT * FROM OES_DESG_MST WHERE DESG_CD =?");
              ps.setString(1,desg_code);
              rs = ps.executeQuery();
              while(rs.next()){
                  emp_desg=rs.getString("DESG_DESC");
              }
              //out.print(emp_dept+""+emp_desg);
            %>
            <script>
                parent.welcome('Admin:   &nbsp;'+'<%=emp_name%>');
            </script>
            <%} 
            catch (Exception e) {
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
    <body id="bcg" style="background-image: url(back6.jpg);opacity: 500">
    <div style="margin-left:85%; margin-top:-5px" class="bs-example">
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
        <div id="slct_task" style="margin-top: 7.75%;margin-left: 23.625%">        
        <a href="javascript:void(0)" id="qbank" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsmd();">&nbsp;&nbsp;Enter Module Details&nbsp;&nbsp;</a>
        <a href="javascript:void(0)" id="qpaper" style="margin-left: 7.5%;margin-right: -40%;height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlscd();">&nbsp;&nbsp;Enter Category Details&nbsp;&nbsp;</a><br/><br/><br/><br/>        
        <a href="javascript:void(0)" id="studtl" style="margin-left: -12.5%;height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsqb();">&nbsp;&nbsp;Update Question Bank&nbsp;&nbsp;</a>
        <a href="javascript:void(0)" id="instdtl" style="margin-bottom: -40px;margin-left: 30.75%;margin-right: -40%;height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsid();">&nbsp;&nbsp;Enter Institute Details&nbsp;&nbsp;</a><br/><br/><br/><br/> 
        <a href="javascript:void(0)" id="result" style="margin-left: 3.5%;margin-right: -20%;height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlssd();">&nbsp;&nbsp;Enter Student Details&nbsp;&nbsp;</a>
        <a href="javascript:void(0)" id="stuacs" style="margin-left: 24.5%;margin-right: -20%;height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsexd();">&nbsp;Enter Examination Details&nbsp;</a><br/><br/><br/><br/>
        <a href="javascript:void(0)" id="moddtl" style="margin-top: -40px;margin-left: -12.5%;height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsqp();">&nbsp;&nbsp;Set Question Paper&nbsp;&nbsp;</a>
        <a href="javascript:void(0)" id="cattdtl" style="margin-left:32.75%;margin-right: -40%;height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsacd();">&nbsp;&nbsp;Grant Student Access&nbsp;&nbsp;</a><br/><br/><br/><br/> 
        <a href="javascript:void(0)" id="empdtl" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsed();">&nbsp;&nbsp;Grant Employee Access&nbsp;&nbsp;</a>
        <a href="javascript:void(0)" id="examdtl" style="margin-left: 5%;margin-right: -40%;height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsrd();">&nbsp;&nbsp;Generate Results&nbsp;&nbsp;</a><br/><br/><br/><br/>
        </div>
        <form id="formh" name="formh" action="dept.jsp">
            <input type="hidden" name="username" value="<%=session.getAttribute("code1")%>"/>
            <input type="hidden" name="password" value="<%=session.getAttribute("code2")%>"/>
        </form> 
        <form id="formad" name="formad" action="admin.jsp">
            <input type="hidden" name="username" value="<%=session.getAttribute("code1")%>"/>
            <input type="hidden" name="password" value="<%=session.getAttribute("code2")%>"/>
         </form>         
        <form id="form1" name="form1" action="profile.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        </form>
        <form id="formqb" name="formqb" action="qbank_update.jsp">
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        </form>
        <form id="formqp" name="formqp" action="setquespaper.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        </form>
        <form id="formsd" name="formsd" action="studentdtlselect.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        </form>
        <form id="formid" name="formid" action="institutedtlselect.jsp">
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        </form>
        <form id="formrd" name="formrd" action="resultselect.jsp">
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        </form>
        <form id="formacd" name="formacd" action="studentacslct.jsp">
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        </form>
        <form id="formmd" name="formmd" action="moduledtlselect.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        </form>
        <form id="formcd" name="formcd" action="categorydtlselect.jsp">
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        </form>
        <form id="formed" name="formed" action="employeedtlselect.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        </form>
        <form id="formexd" name="formexd" action="examdtlselect.jsp">
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        </form>
        <!--a href="dept.jsp" id="home" style="height:25px;width:200px;background-color: #ccffff;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:1.75px orangered solid">&nbsp;&nbsp;Home&nbsp;&nbsp;</a-->
    </body>
</html>
<%-- 
    Document   : examdtlselect
    Created on : Jun 13, 2015, 11:22:21 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Select Action</title>
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
            function slctdtl(){
                $('#slct_lgn').hide();
                $('#enter_ins_stu').show();
            }
            function submit_dtlsexd(){
                window.setTimeout('document.formexd.submit()',0);
            }
            $(document).ready(function(){
               $('#enter_ins_stu').hide(); 
            });
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
    <%!int exam_ct=0,exam_cd[];%><%!String exam_cd_prfx[],exam[],name[][];%><%!int student_code[][];%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            %>
            <script type="text/javascript">
                parent.showback();
            </script>
            <%
            String username=request.getParameter("username");
            String emp_name=request.getParameter("emp_name");
            String emp_dept=request.getParameter("emp_dept");
            String emp_desg=request.getParameter("emp_desg");
            String dept_code=request.getParameter("dept_code");
            exam=new String[200];
            exam_cd_prfx=new String[200];
            exam_cd=new int[200];
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_MST WHERE EXAM_CANCELLED='N' ORDER BY EXAM_DATE DESC");
            rs = ps.executeQuery();
            exam_ct=0;
            while(rs.next()){
            exam_cd[exam_ct]=Integer.parseInt(rs.getString("EXAM_CD"));
            exam_cd_prfx[exam_ct]=rs.getString("EXAM_CD_PREFIX");
            exam[exam_ct]=rs.getString("EXAM_NAME");
            //out.println("a               "+inst_cd[inst_ct]+""+inst[inst_ct]);
            exam_ct++;
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
    <body id="bcg" style="background-image: url(back6.jpg);opacity: 5">
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
    <form id="formexd" name="formexd" action="examdtls.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
    </form>
    <center>
    <div id="slct_lgn" style="margin-top: 17.5%;margin-left: -10%">
        <a href="javascript:void(0);" id="create" style="height:1.875%;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:27px;border:1.75px paleturquoise solid" onclick="submit_dtlsexd();">&nbsp;&nbsp;Create New&nbsp;&nbsp;</a>
        <a href="javascript:void(0)" id="edit" style="margin-left: 10%;height:1.875%;width:250px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:27px;border:1.75px paleturquoise solid" onclick="slctdtl();">&nbsp;&nbsp;View/Edit Existing&nbsp;&nbsp;</a>
    </div>
    </center>    
    <form id="instupdate" method="post" action="examedit.jsp">            
        <div id="enter_ins_stu" style="margin-top: -50px">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>    
            <div id="usn_ea">Select Examination:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="exam_cd" id="exam_cd">
                        <option value="">&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<exam_ct;k++){%>
                        <option  value="<%=exam_cd[k]%>"/><%=exam[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
            </div>
            <input id="smt_ea" type="submit" value="SUBMIT"/>
        </div>
    </form>
    <form id="form1" name="form1" action="profile.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
    </form>            
    </body>
</html>

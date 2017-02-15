<%-- 
    Document   : setquespaper
    Created on : Jun 18, 2015, 10:38:12 AM
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
            function slct_exam(){
                $('#slct_lgn').hide();
                $('#enter_exam').show();
            }
            function submit_dtlspd(){
                window.setTimeout('document.formpd.submit()',0);
            }
            function changemode(val){
                if(val==='2'){
                    $('#modeslct').show();
                }
                else{
                    $('#modeslct').hide();
                }
            }
            $(document).ready(function(){
               $('#enter_ins_stu').hide(); 
               $('#enter_exam').hide();
               $('#modeslct').hide();
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
    <%!int exam_ct=0,dept_ct=0,exam_code[],mod_code[],cat_code[];%><%!String exam[];%><%!String dept_cd[],dept[];%>
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
            exam_code=new int[200];
            mod_code=new int[200];
            cat_code=new int[200];
            dept_cd=new String[200];
            dept=new String[200];
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_MST WHERE EXAM_CANCELLED='N'");
            rs = ps.executeQuery();
            exam_ct=0;
            while(rs.next()){
            exam_code[exam_ct]=Integer.parseInt(rs.getString("EXAM_CD"));
            exam[exam_ct]=rs.getString("EXAM_NAME");
            //out.println("a               "+inst_cd[inst_ct]+""+inst[inst_ct]);
            exam_ct++;
            }  
            ps = conn.prepareStatement ("SELECT * FROM OES_DEPT_MST");
            rs = ps.executeQuery();
            dept_ct=0;
            while(rs.next()){
            dept_cd[dept_ct]=rs.getString("DEPT_CD");
            dept[dept_ct]=rs.getString("DEPT_DESC");
            //out.println("a               "+inst_cd[inst_ct]+""+inst[inst_ct]);
            dept_ct++;
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
    <form id="formpd" name="formpd" action="paperdtls.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
            <div id="enter_exam" style="margin-top: -50px">
                <div id="usn_ea" style="margin-top: 10%">Select Exam:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="exam_code" id="exam_code">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<exam_ct;k++){%>
                        <option  value="<%=exam_code[k]%>"/><%=exam[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
              </div>
              <br/>
              <% if(dept_code.equals("001")){%>
              <div id="usn_ea" style="margin-top: 15%">Select Department:&nbsp;&nbsp;&nbsp; 
                    <select name="dept_cd" id="dept_cd">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<dept_ct;k++){%>
                        <option  value="<%=dept_cd[k]%>"/><%=dept[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
              </div>
              <br/>
              <div id="usn_ea" style="margin-top: 20%">Select Question Mode:&nbsp;&nbsp;
              <%}
              else{%>
              <input type="hidden" name="dept_cd" id="dept_cd" value="<%=dept_code%>"/>
              <div id="usn_ea" style="margin-top: 15%">Select Question Mode:&nbsp;&nbsp;
              <%}%>
                    <select name="qmode" id="qmode" onchange="changemode(this.value)">
                        <option value="">&nbsp;&nbsp;Choose
                        <option  value="1"/>AUTO
                        <option  value="2"/>SELECT
                    </select>
                    <!--div id="modeslct">
                        <div id="field" style="position: absolute;margin-top: 5%;margin-left:2.5%;height: 50px;" >
                            <span id="rw" style="color:#0000ff;font-size: 20px;font-family: Comic Sans MS;">No. of Questions:-</span><input type="number" name="no_ques" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:42%;margin-left: 7.5px;margin-right: -40%" placeholder=" *No. of Questions                      "/>
                        </div>
                    </div-->
                    <div id="field" style="margin-top: 7.5%;margin-left:5%;height: 50px;" >
                        <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Group Serial:-&nbsp;&nbsp;&nbsp;</span><input type="number" name="grpsrl" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:34%;margin-left: 16%;margin-right: -40%" placeholder=" *Group Serial                      "/>
                    </div>
                    <div id="field" style="margin-left:10%;height: 50px;" >
                        <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Marks:-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="number" name="marks" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:36%;margin-left: 23.5%;margin-right: -40%" placeholder=" *Correct Ans                      "/>
                    </div>
                    <div id="field" style="margin-left:0%;height: 50px;" >
                        <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Negative Marks:-&nbsp;</span><input type="number" name="neg_marks" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:32%;margin-left: 15%;margin-right: -40%" placeholder=" *Wrong Ans                      "/>
                    </div>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
                </div>
                    <br/><br/>
                    <input id="smt_ea" style="margin-top: 42.5%" type="submit" value="SUBMIT"/>
            </div>        
    </form>
    <center>
    <div id="slct_lgn" style="margin-top: 17.5%;margin-left: -10%">
        <a href="javascript:void(0)" id="create" style="height:1.875%;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:27px;border:1.75px paleturquoise solid" onclick="slct_exam();">&nbsp;&nbsp;Set New&nbsp;&nbsp;</a>
        <a href="javascript:void(0)" id="edit" style="margin-left: 10%;height:1.875%;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:27px;border:1.75px paleturquoise solid" onclick="slctdtl();">&nbsp;&nbsp;Edit Existing&nbsp;&nbsp;</a>
    </div>
    </center>
    <form id="stupdate" method="post" action="paperedit.jsp">            
        <div id="enter_ins_stu" style="margin-top: -50px">
                <div id="usn_ea">Select Exam:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="exam_code" id="exam_code">
                        <option value="">&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<exam_ct;k++){%>
                        <option  value="<%=exam_code[k]%>"/><%=exam[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
                </div>
                    <!--div id="pwd_ea">Select Student:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="student_code" id="student_code">
                        <option value="">&nbsp;&nbsp;-----------
                        <%--for(int k=0;k<cat_ct[m];k++){%>
                        <option  value="<%=cat_code[m][k]%>"/><%=cat[m][k]%>
                        <%}--%>
                    </select>
                    <!--input id="cat" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:32.5px;width:200px;margin-left: 16px;" placeholder="      Category Code" type="number" name="cat_cd"/-->
                <input type="hidden" name="username" value="<%=username%>"/>
                <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
                <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
                <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
                <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
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
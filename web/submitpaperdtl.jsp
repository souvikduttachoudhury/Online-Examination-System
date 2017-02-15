<%-- 
    Document   : submitpaperdtl
    Created on : Jun 18, 2015, 1:36:21 PM
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
            function submit_dtlsqp(){
                window.setTimeout('document.formqp.submit()',0);
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
        <title>Submitted</title>
    </head>
    <%!String emp_name="";%><%!String dept_code="";%><%!String desg_code="";%>
    <%!String emp_dept="";%><%!String emp_desg="";%><%!String username="";%><%!String password="";%>
    <%!int q_ct=0,mod_code,cat_code,exam_code,grpsrl,marks,neg_marks,qid[];%><%!String qmode,dept_cd,stream[],dobd[],dobm[],doby[],fname[],inst_cd[],addr1[],addr2[],addr3[],addr4[];%>
    <%!String addr_pin[],email[],phno[],pic_file[];%><%!String inst[],date="YYYY-MM-DD";%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            username=request.getParameter("username");
            emp_name=request.getParameter("emp_name");
            emp_dept=request.getParameter("emp_dept");
            emp_desg=request.getParameter("emp_desg");
            dept_code=request.getParameter("dept_code");
            exam_code=Integer.parseInt(request.getParameter("exam_code"));
            qmode=request.getParameter("qmode");
            grpsrl=Integer.parseInt(request.getParameter("grpsrl"));
            marks=Integer.parseInt("0"+request.getParameter("marks"));
            neg_marks=Integer.parseInt("0"+request.getParameter("neg_marks"));
            dept_cd=request.getParameter("dept_cd");
            mod_code=Integer.parseInt(request.getParameter("mod_code"));
            cat_code=Integer.parseInt(request.getParameter("cat_code"));
            q_ct=Integer.parseInt(request.getParameter("q_ct"));
            qid=new int[q_ct];
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement("INSERT INTO OES_PAPER_SUMM(EXAM_CD,DEPT_CD,MODULE_CD,CATEGORY_CD,GRPSRL,NO_OF_QUES,MARKS,NEG_MARKS,Q_MODE,DEL_MKR,CRT_BY) VALUES("+exam_code+",'"+dept_cd+"',"+mod_code+","+cat_code+","+grpsrl+","+q_ct+","+marks+","+neg_marks+",'"+qmode+"','N','"+username+"')");
            ps.executeUpdate();
            for(int k=0;k<q_ct;k++){
                qid[k]=Integer.parseInt(request.getParameter("qid"+k));
                 ps = conn.prepareStatement("INSERT INTO OES_PAPER_DET(EXAM_CD,GRPSRL,SRLNO,QID,DEL_MKR,CRT_BY) VALUES("+exam_code+","+grpsrl+","+(k+1)+","+qid[k]+",'N','"+username+"')");
                 ps.executeUpdate();
                }
            } 
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
    <body id="bcg" style="background-image: url(back6.jpg);opacity: 5">
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
        <form id="formqp" name="formqp" method="post" action="setquespaper.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        </form>
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
                <h1 id="head">Paper Details Updated Succesfully...</h1>
                <div id="slct_task" style="margin-top: 200px;margin-left: 37.5%">  
                    <a href="javascript:void(0)" id="moreinst" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsqp();">&nbsp;&nbsp;Add more Papers&nbsp;&nbsp;</a>
                </div>  
    </body>
</html>

<%-- 
    Document   : examdtlsubmit
    Created on : Jun 13, 2015, 12:37:03 PM
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
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
        <title>Submitted</title>
    </head>
    <%!String emp_name="";%><%!String dept_code="";%><%!String desg_code="";%>
    <%!String emp_dept="";%><%!String emp_desg="";%><%!String username="";%><%!String password="";%>
    <%!int inst_ct=0,exam_cd,tot_mrk,tot_stud;%><%!String exam_cd_prfx,qual[],inst_code[],stream[],exam_dtd,exam_dtm,exam_dty,exam_min,mod_code,cat_code,exam_venue,paper_setter,instruction,addr4[];%>
    <%!String addr_pin[],email[],phno[],pic_file[];%><%!String exam,date="YYYY-MM-DD";%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            username=request.getParameter("username");
            emp_name=request.getParameter("emp_name");
            emp_dept=request.getParameter("emp_dept");
            emp_desg=request.getParameter("emp_desg");
            dept_code=request.getParameter("dept_code");
            exam=request.getParameter("exam");
            exam_cd_prfx=request.getParameter("exam_cd_prfx");
            exam_cd=Integer.parseInt(request.getParameter("exam_cd"));
            mod_code=request.getParameter("mod_code");
            cat_code=request.getParameter("cat_code");
            exam_dtd=request.getParameter("exam_dtd");
            //exam_dtm=request.getParameter("exam_dtm");
            //exam_dty=request.getParameter("exam_dty");
            exam_min=request.getParameter("exam_min");
            exam_venue=request.getParameter("exam_venue");
            tot_mrk=Integer.parseInt(request.getParameter("tot_mrk"));
            tot_stud=Integer.parseInt(request.getParameter("tot_stud"));
            paper_setter=request.getParameter("paper_setter");
            instruction=request.getParameter("instruction");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
               //out.print("'"+exam_cd_prfx+"',"+exam_cd+","+mod_code+","+cat_code+","+exam_min+",'"+exam_venue+"',"+tot_mrk+","+tot_stud+",'"+exam+"','"+paper_setter+"','"+instruction+"','"+username+"'");
               ps = conn.prepareStatement("INSERT INTO OES_EXAM_MST(EXAM_CD_PREFIX,EXAM_CD,MODULE_CD,CATEGORY_CD,EXAM_PERIOD_MIN,EXAM_VENUE,EXAM_TOT_MRK,EXAM_TOT_STUDENTS,EXAM_NAME,EXAM_PAPER_SETTER,EXAM_INSTR,CRT_BY) VALUES('"+exam_cd_prfx+"',"+exam_cd+","+mod_code+","+cat_code+","+exam_min+",'"+exam_venue+"',"+tot_mrk+","+tot_stud+",'"+exam+"','"+paper_setter+"','"+instruction+"','"+username+"')");
               ps.executeUpdate();
               date="1111-01-01";
               if(!exam_dtd.equals(""))
               {
                   //&&(Integer.parseInt(dobm[i])>0)&&(Integer.parseInt(dobm[i])<13)&&(Integer.parseInt(dobd[i])>0)&&(Integer.parseInt(dobd[i])<32)&&(Integer.parseInt(doby[i])>0)
                   date=exam_dtd.substring(0, 2)+"-"+exam_dtd.substring(3,5 )+"-"+exam_dtd.substring(6,10);
                   //out.print("aaaaaaaaaaaaaaaaaaa ,,,,,,,"+date);
               }
               else
               {
                   date="1111-01-01";
                   //out.println(date);
               }
               //out.print("aaaaaaaaaaaaaaa      "+date+"name:"+student_code[i]);
               ps = conn.prepareStatement("UPDATE OES_EXAM_MST SET EXAM_DATE=TO_DATE('"+date+"','DD-MM-YYYY') WHERE EXAM_CD_PREFIX=? AND EXAM_CD="+exam_cd+"");
               ps.setString(1, exam_cd_prfx);
               ps.executeUpdate();
             //ps = conn.prepareStatement("UPDATE OES_LAST_ID SET LAST_STUDENT_CD="+student_code[student_ct-1]+",UPD_BY='"+username+"' WHERE LAST_STUDENT_CD="+(student_code[0]-1)+"");
             //ps.executeUpdate();
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
        <form id="formid" name="formexd" method="post" action="examdtls.jsp">
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
                <h1 id="head">Examination Details Updated Succesfully...</h1>
                <div id="slct_task" style="margin-top: 200px;margin-left: 45%">  
                <a href="javascript:void(0)" id="moreinst" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsexd();">&nbsp;&nbsp;Add another exam&nbsp;&nbsp;</a>
                </div>  
    </body>
</html>

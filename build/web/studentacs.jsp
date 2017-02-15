<%-- 
    Document   : studentacs
    Created on : Jun 24, 2015, 11:45:05 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Paper Details</title>
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
            div_ct=0;
            count=0;
            size=0;
            correct = [];
            function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function initialize(v){
                count=parseInt(v);
                for(var i=0;i<count;i++){
                    correct[i]=1;
                }
            }
            function check(id,indx){
                if(document.getElementById(id).checked){
                    count++;
                    correct[indx]=1;
                }
                else{
                    count--;
                    correct[indx]=0;
                    document.getElementById(id).name="";
                }
                document.getElementById("indcn").innerHTML="Total Added : "+count;
            }
            function validate(){
                for(var i=0;i<200;i++){
                        if(correct[i]===1){
                            document.getElementById("stud_slct"+i).name="student_code"+size;
                            size++;
                        }
                 }
                document.getElementById("student_ct").value=count;
                if(count===0){
                    return false;
                }
                return true;
            }
            function submit_dtlsh(access){
                if(access==='D'){
                window.setTimeout('document.formh.submit()',0);
                }
                else if(access==='A'){
                    window.setTimeout('document.formad.submit()',0);
                }
            }
            $(document).ready(function(){
               for(var i=0;i<200;i++){
                   correct.push(0);
               }
            });
        </script>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
    </head>
    <%!String emp_name="";%><%!String dept_code="";%><%!String desg_code="";%>
    <%!String emp_dept="";%><%!String emp_desg="";%><%!String username="";%><%!String password="";%>
    <%!int passwd[],student_ct=0,student_code[],exam_code,qmode,q_ct=0,grpsrl=1,marks=0,neg_marks=0,mod_code,cat_code,ct=0;%><%!String exam_date,exam,stream,qual[],inst[],dobd[],dobm[],doby[],fname[],inst_cd,addr1[],addr2[],addr3[],addr4[];%>
    <%!String email[],phno[],pic_file[];%><%!String dept_cd,name[];%>
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
             inst_cd=request.getParameter("inst_cd");
             stream=request.getParameter("stream");
             Connection conn = null;
             PreparedStatement ps = null;
             ResultSet rs = null;
             try {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
             conn.setAutoCommit(false);
             ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_MST WHERE EXAM_CD="+exam_code+"");
             rs=ps.executeQuery();
             while(rs.next()){
                exam=rs.getString("EXAM_NAME");
                exam_date=rs.getString("EXAM_DATE");
                if(!exam_date.equals(null)){
                exam_date=exam_date.substring(8,10 )+"/"+exam_date.substring(5, 7)+"/"+exam_date.substring(0, 4);
                }
                else{
                    exam_date="";
                }
             }
             //out.print("aaaaaaaaaaaaaaaaaaaaaaaaaaa                 "+exam_code+""+stream+""+inst_cd);
                ps = conn.prepareStatement ("SELECT * FROM OES_STUDENT_MST a,OES_INSTITUTE_MST b WHERE a.INSTITUTE_CD=b.INSTITUTE_CD AND a.INSTITUTE_CD='"+inst_cd+"' AND a.STUDENT_STREAM=?");
                ps.setString(1, stream);
                rs=ps.executeQuery();
                student_ct=0;
                student_code=new int[200];
                name=new String[200];
                qual=new String[200];
                inst=new String[200];
                passwd=new int[200];
                Random rn=new Random();
                while(rs.next()){
                    student_code[student_ct]=Integer.parseInt(rs.getString("STUDENT_CD"));
                    name[student_ct]=rs.getString("STUDENT_NAME");
                    qual[student_ct]=rs.getString("STUDENT_QUALIFICATION");
                    inst[student_ct]=rs.getString("INSTITUTE_NAME");
                    //passwd[student_ct]=rn.nextInt(10000);
                    student_ct++;
                }%>
                <script type="text/javascript">
                    initialize('<%=student_ct%>');
                    $(document).ready(function(){
                       document.getElementById("indcn").innerHTML="Total Added : "+"<%=student_ct%>"; 
                    });
                </script>
            <%}
            catch (Exception e){
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
    <body id="bcg" style="background-image: url(back6.jpg);opacity: 20">
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
    <form id="form1" name="form1" action="profile.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
    </form>                 
    <form id="formh" name="formh" action="dept.jsp">
            <input type="hidden" name="username" value="<%=session.getAttribute("code1")%>"/>
            <input type="hidden" name="password" value="<%=session.getAttribute("code2")%>"/>
    </form> 
    <form id="formad" name="formad" action="admin.jsp">
            <input type="hidden" name="username" value="<%=session.getAttribute("code1")%>"/>
            <input type="hidden" name="password" value="<%=session.getAttribute("code2")%>"/>
    </form>             
    <form action="submitstudentacs.jsp" target="blank" method="post" onsubmit="return validate();">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input type="hidden" name="exam_code" value="<%=exam_code%>"/>
        <input type="hidden" name="exam" value="<%=exam%>"/>
        <input type="hidden" name="inst_cd" value="<%=inst_cd%>"/>
        <input type="hidden" name="inst" value="<%=inst[0]%>"/>
        <input type="hidden" name="stream" value="<%=stream%>"/>
        <input id="student_ct" type="hidden" name="student_ct"/>
        <center>
            <div  style="color:#cc00cc;font-size: 30px;font-family: Calibri"><%=exam%></div>
            <div  style="color:#006633;font-size: 30px;font-family: Calibri"><%=inst[0]%></div> 
            <div id="indcn" style="color:#ff3333;font-size: 24px;font-family: Calibri"></div>
        <table border="1" style="color:black;font-size: 24px;font-family: Calibri"> 
            <tr style="color:blue;font-size: 30px;background: #66ffff;font-family: Times New Roman">
                <th><center>&nbsp;Added&nbsp;</center></th> 
                <th><center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</center></th> 
                <th><center>&nbsp;Qualification&nbsp;</center></th>
                <th><center>&nbsp;Stream&nbsp;</center></th>
                <th><center>&nbsp;Code&nbsp;</center></th>
            </tr>
            <tbody>
        <%
        for(int i=0;i<student_ct;i++){%>
        <tr>
            <td><center><input id="stud_slct<%=i%>" type="checkbox" style="width: 20px;height: 20px;" value="<%=student_code[i]%>" onchange="check('stud_slct<%=i%>','<%=i%>')" checked/></center></td>
            <td><center><%=name[i]%></center></td> 
            <td><center><%=qual[i]%></center></td>
            <td><center><%=stream%></center></td>
            <td><center><%=student_code[i]%></center></td> 
        </tr>
        <% }%>
            </tbody>
        </table>
        </center>
            <input id="smt_ea" style="margin-top: 12%" type="submit" value="SUBMIT"/>
    </form>
    </body>
</html>

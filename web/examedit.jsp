<%-- 
    Document   : examedit
    Created on : Jun 27, 2015, 9:22:15 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Edit</title>
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
            qs = [];
            function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function divshow(id,flag){
                    if(flag==='1'){
                        var fl=0;
                        for(var i=0;i<qs.length;i++)
                            {
                               if(qs[i]===id){
                                   fl++;
                               }
                            }
                              if(fl===0){
                              qs.push(id);
                              count++;
                              var temp=parseInt(id)-1;
                              alert("Fields Marked with * are compulsory.Continue?");
                              document.getElementById("nextstud"+temp).innerHTML="&nbsp;&nbsp;Next&nbsp;&nbsp;";
                          }
                    }
                    $("#sd"+div_ct).hide();
                    $("#sd"+id).show();
                    div_ct=id;
            }
            function show(val){
                $("#usn_ea").hide();
                $("#sd"+val).show();
                div_ct=val;
            }
            function change(){
               var x=confirm("Are you sure you want to cancel the exam?");
               if(x===true){
                  window.setTimeout('document.formdl.submit()',0); 
                  return true;
               }
               else{
                   return false;
               }
            }
            $(document).ready(function(){
                 count++;
                 qs.push(div_ct);
            });
            function validate(){
                //document.getElementById("student_ct").value=count;
                return true;
            }
            function setcode(i,v){
                document.getElementById(i).value=parseInt(v);
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
    <%!String emp_name="";%><%!String dept_code="";%><%!String desg_code="";%>
    <%!String emp_dept="";%><%!String emp_desg="";%><%!String username="";%><%!String password="";%>
    <%!int student_code[],sc=0,inst_ct=0;%><%!String name,venue,exam_cd_prfx,stream[],dobd,dobm[],doby[],fname[],exam_cd,mod,cat,date,min,tot_mrk,tot_stud,paper_setter,instruction;%>
    <%!String addr_pin,email,phno,pic_file;%><%!String inst;%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
             username=request.getParameter("username");
             emp_name=request.getParameter("emp_name");
             emp_dept=request.getParameter("emp_dept");
             emp_desg=request.getParameter("emp_desg");
             dept_code=request.getParameter("dept_code");
             exam_cd=request.getParameter("exam_cd");
             //out.print("aaaaaaaaaaaaaaaaaaaa        "+inst_cd);
             Connection conn = null;
             PreparedStatement ps = null;
             ResultSet rs = null;
             try{
             Class.forName("oracle.jdbc.driver.OracleDriver");
             conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
             conn.setAutoCommit(false);
             //student_code=new int[200];
             ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_MST e,OES_MODULE_MST m,OES_CATEGORY_MST c,OES_EMP_MST d WHERE e.MODULE_CD=m.MODULE_CD AND m.MODULE_CD=c.MODULE_CD AND e.CATEGORY_CD=c.CATEGORY_CD AND e.EXAM_PAPER_SETTER=d.EMP_CD AND e.EXAM_CANCELLED='N' AND e.EXAM_CD=?");
             ps.setString(1, exam_cd);
             rs=ps.executeQuery();
             inst_ct=0;
             while(rs.next()){
                 //student_code[student_ct]=Integer.parseInt(rs.getString("STUDENT_CD"));
                 name=rs.getString("EXAM_NAME");
                 //qua=rs.getString("STUDENT_QUALIFICATION");
                 //stream[student_ct]=rs.getString("STUDENT_STREAM");
                 //date[student_ct]=rs.getString("STUDENT_DOB");
                 //fname=rs.getString("FATHER_NAME");
                 exam_cd_prfx=rs.getString("EXAM_CD_PREFIX");
                 if(exam_cd_prfx==null){
                     exam_cd_prfx="Not Available";
                 }
                 mod=rs.getString("MODULE_DESC");
                 if(mod==null){
                     mod="";
                 }
                 cat=rs.getString("CATEGORY_DESC");
                 if(cat==null){
                     cat="";
                 }
                 date=rs.getString("EXAM_DATE");
                 if(date==null){
                     date="";
                 }
                 else{
                     date=date.substring(0,10);
                     date=date.substring(5,7)+"-"+date.substring(8,10)+"-"+date.substring(0,4);
                 }
                 min=rs.getString("EXAM_PERIOD_MIN");
                 if(min==null){
                     min="Not Available";
                 }
                 venue=rs.getString("EXAM_VENUE");
                 System.out.print(venue);
                 if(venue==null){
                     venue="Not Available";
                 }
                 tot_mrk=rs.getString("EXAM_TOT_MRK");
                 System.out.print(tot_mrk);
                 if(tot_mrk==null){
                     tot_mrk="Not Available";
                 }
                 tot_stud=rs.getString("EXAM_TOT_STUDENTS");
                 System.out.print(tot_stud);
                 if(tot_stud==null){
                     tot_stud="Not Available";
                 }
                 paper_setter=rs.getString("EMP_NAME");
                 System.out.print(paper_setter);
                 if(paper_setter==null){
                     paper_setter="Not Available";
                 }
                 instruction=rs.getString("EXAM_INSTR");
                 System.out.print(instruction);
                 if(instruction==null){
                     instruction="Not Available";
                 }
             }
            }
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
    <body id="bcg" style="background-image: url(back6.jpg);opacity: 10">
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
    <form id="form1" name="form1" action="profile.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
    </form>
    <form id="formdl" name="formdl" action="cancelexam.jsp">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input type="hidden" name="exam_cd" value="<%=exam_cd%>"/>
    </form>
    <form action="editexam.jsp" method="post">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input type="hidden" name="exam_cd" value="<%=exam_cd%>"/>
        <div id="sd" style="color:#660000;font-size: 22.5px;">
            <h3 id="head" style="text-align:center;color:#000066;font-weight: bold;margin-bottom: -40px;margin-top: -20px"><u>Examination Edit Page</u></h3>
            <div id="field" style="margin-left:65px;margin-top: 75px;height: 50px;margin-right: -100px" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Name of the Exam:-&nbsp;</span><div  style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:525px;margin-left: 20.5%;margin-top: -2.75%"><%=name%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Exam Code Prefix:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 22.5%;margin-top: -3.25%;"><%=exam_cd_prfx%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Exam Date:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 22.5%;margin-top: -3.25%;"><%=date%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Total Time:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 22.5%;margin-top: -3.5%;" ><%=min%>&nbsp;minutes</div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Module:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 22.5%;margin-top: -3.25%;"><%=mod%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Category:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 22.5%;margin-top: -3.5%;" ><%=cat%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Total Marks:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 22.5%;margin-top: -3.25%;"><%=tot_mrk%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Total Students:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 22.5%;margin-top: -3.25%;"><%=tot_stud%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Paper Setter:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 22.5%;margin-top: -3.25%;"><%=paper_setter%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Instructions:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 22.5%;margin-top: -3.25%;"><%=instruction%></div>
            </div>
            <div style="margin-top:-59.25%;margin-left:  20%;">
                <input id="smt" style="font-size:25px;font-family: Calibri" type="submit" value="EDIT" style="margin-left: 50%" />
                <input id="smt" type="button" value="Cancel Exam" style="width: 200px;height: 37.5px;margin-left: 55.5%" onclick="change()"/>
                <!--button id="smt" style="font-size:25px;font-family: Calibri" type="btn" value="" style="margin-left: 50%" /-->
            </div>
        </div>  
      </form>
    </body>
</html>
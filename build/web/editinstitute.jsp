<%-- 
    Document   : editinstitute
    Created on : Jun 25, 2015, 12:49:10 PM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Institute Details</title>
        <link rel="stylesheet" href="login.css" type="text/css"/>
        <link rel="stylesheet"  href="stylesheet.css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="bootstrap.js"></script>
        <script type="text/javascript" src="jquery_1.js"></script>
        <script type="text/javascript" src="jquery-latest.js"></script>
        <script type="text/javascript" src="jquery-latest_1.js"></script>
        <script type="text/javascript" src="jquery-ui.js"></script>
        <link rel="stylesheet" type="text/css" href="jquery-ui.css">
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
            $(document).ready(function(){
                 var bday=new Date();
                 var maxy=(bday.getFullYear()-18);
                 bday.setFullYear(maxy);
                for(var k=0;k<200;k++){
                $("#dobd").datepicker({
                   changeYear:true,
                   changeMonth:true,
                   changeDay:true,
                   maxDate:bday,
                   yearRange:(bday.getFullYear()+18-60)+":"+(bday.getFullYear())
                });
                }
             });
            $(document).ready(function(){
                 /*count++;
                 qs.push(div_ct);
                 $("#sd0").show();
               for(var i=1;i<200;i++){
                   $("#sd"+i).hide();
               } */
            });
            function validate(){
                document.getElementById("student_ct").value=count;
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
        </script>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
    </head>
    <%!String emp_name="";%><%!String dept_code="";%><%!String desg_code="";%>
    <%!String emp_dept="";%><%!String emp_desg="";%><%!String username="";%><%!String password="";%>
    <%!int temp,student_code,student_ct=0,inst_ct=0;%><%!String name,qual,stream,date,dobd,dobm,doby,fname,inst_cd,addr1,addr2,addr3,addr4;%>
    <%!String addr_pin,email,phno,pic_file;%><%!String inst[],inst_code[];%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
             username=request.getParameter("username");
             emp_name=request.getParameter("emp_name");
             emp_dept=request.getParameter("emp_dept");
             emp_desg=request.getParameter("emp_desg");
             dept_code=request.getParameter("dept_code");
             inst_cd=request.getParameter("inst_cd");
             //out.print("...................................,"+inst_cd);
             //student_code=Integer.parseInt(request.getParameter("student_code"));
             Connection conn = null;
             PreparedStatement ps = null;
             ResultSet rs = null;
             try {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
             conn.setAutoCommit(false);
             ps = conn.prepareStatement ("SELECT * FROM OES_INSTITUTE_MST WHERE INSTITUTE_CD=?");
             ps.setString(1, inst_cd);
             rs=ps.executeQuery();
             while(rs.next()){
                 name=rs.getString("INSTITUTE_NAME");
                 if(name==null){
                     name="";
                 }
                 addr1=rs.getString("INSTITUTE_ADDR1");
                 if(addr1==null){
                     addr1="";
                 }
                 addr2=rs.getString("INSTITUTE_ADDR2");
                 if(addr2==null){
                     addr2="";
                 }
                 addr3=rs.getString("INSTITUTE_ADDR3");
                 if(addr3==null){
                     addr3="";
                 }
                 addr4=rs.getString("INSTITUTE_ADDR4");
                 if(addr4==null){
                     addr4="";
                 }
                 addr_pin=rs.getString("INSTITUTE_ADDR_PIN");
                 if(addr_pin==null){
                     addr_pin="";
                 }
                 email=rs.getString("INSTITUTE_EMAIL");
                 if(email==null){
                     email="";
                 }
                 phno=rs.getString("INSTITUTE_PHNO");
                 if(phno==null){
                     phno="";
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
     <form action="submitinstedit.jsp" method="post">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input type="hidden" name="inst_cd" value="<%=inst_cd%>"/>
        <%--
        student_ct=0;
        while(student_ct<200){--%>
        <input type="hidden" name="student_code" value="<%=inst_cd%>"/>
            <h3 id="head" style="text-align:center;color:#000066;font-weight: bold;margin-bottom: -40px;margin-top: -20px">Institute Edit Page</h3>
            <div id="field" style="margin-left:65px;margin-top: 75px;height: 50px;margin-right: -100px" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Full Name:-<span style="color:red">*</span>&nbsp;</span><input type="text" name="name" value="<%=name%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 4%;" placeholder="                            Institute Name   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Address:-<span style="color:red">*</span>&nbsp;&nbsp;</span><input type="text" name="addr1" value="<%=addr1%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 6%;" placeholder="                  Address Line 1   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="addr2" value="<%=addr2%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 11.25%;" placeholder="                    Address Line 2   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="addr3" value="<%=addr3%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 11.25%;" placeholder="                    Address Line 3   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="addr4" value="<%=addr4%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 11.25%;" placeholder="                    Address Line 4   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">PIN Code:-<span style="color:red">*</span>&nbsp;&nbsp;</span><input type="text" name="addr_pin" value="<%=addr_pin%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 4.75%;" placeholder="                        PIN CODE   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Email Address:-<span style="color:red">*</span>&nbsp;</span><input type="text" name="email" value="<%=email%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 0.50%;" placeholder="                            @xyz.com   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Phone No:-<span style="color:red">*</span>&nbsp;</span><input type="text" name="phno" value="<%=phno%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 4.5%;" placeholder="       +91XXXXXXXXXX   "/>
            </div>
            <input id="smt" type="submit" value="SUBMIT" style="margin-top:-52.5px;margin-left: 60%;margin-bottom: 5px"/>            
    </form>
    </body>
</html>

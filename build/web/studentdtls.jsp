<%-- 
    Document   : studentdtls.jsp
    Created on : Jun 9, 2015, 3:16:02 PM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Details</title>
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
                        var temp=parseInt(id)-1;
                        var fl=0;
                        for(var i=0;i<qs.length;i++)
                            {
                               if(qs[i]===id){
                                   fl++;
                               }
                            }
                              if(fl===0){    
                              if(document.getElementById("name"+temp).value==="" || document.getElementById("inst_cd"+temp).value==="" || document.getElementById("dobd"+temp).value==="" || document.getElementById("addr1"+temp).value==="" || document.getElementById("addr_pin"+temp).value==="" || document.getElementById("email"+temp).value==="" || document.getElementById("phno"+temp).value===""){
                                  alert("Fields marked with * are compulsory");
                                  return false;
                              }
                              var x=document.getElementById("addr_pin"+temp).value;
                              if(parseInt(x)>999999){
                                  alert("Pin code should not be more than 6 characters");
                                  return false;
                              }
                              var y=document.getElementById("phno"+temp).value;
                              if(parseInt(y)<10000000 || parseInt(y)>9999999999){
                                  alert("Invalid Phone number");
                                  return false;
                              }
                              var z=document.getElementById("email"+temp).value;
                              var z1=z+"@abc";
                              var z2=z+".abc";
                              if(z1.split('@').length!==3 || z2.split('.').length<3){
                                  alert("Invalid Email-Id");
                                  return false;
                              }
                              qs.push(id);
                              count++;
                              document.getElementById("nextstud"+temp).innerHTML="&nbsp;&nbsp;Next&nbsp;&nbsp;";
                              }
                              else{
                                  if(document.getElementById("name"+temp).value==="" || document.getElementById("inst_cd"+temp).value==="" || document.getElementById("dobd"+temp).value==="" || document.getElementById("addr1"+temp).value==="" || document.getElementById("addr_pin"+temp).value==="" || document.getElementById("email"+temp).value==="" || document.getElementById("phno"+temp).value===""){
                                      alert("Fields marked with * are compulsory");
                                }
                                var x=document.getElementById("addr_pin"+temp).value;
                                if(parseInt(x)>999999){
                                      alert("Pin code should not be more than 6 characters");
                                      //return false;
                                }
                                var y=document.getElementById("phno"+temp).value;
                                if(parseInt(y)<10000000 || parseInt(y)>9999999999){
                                    alert("Invalid Phone number");
                                    //return false;
                                }
                                var z=document.getElementById("email"+temp).value;
                                var z1=z+"@abc";
                                var z2=z+".abc";
                                if(z1.split('@').length!==3 || z2.split('.').length<3){
                                    alert("Invalid Email-Id");
                                }
                              }
                    }
                    else{
                              var temp=parseInt(id)+1;
                              if(document.getElementById("name"+temp).value==="" || document.getElementById("inst_cd"+temp).value==="" || document.getElementById("dobd"+temp).value==="" || document.getElementById("addr1"+temp).value==="" || document.getElementById("addr_pin"+temp).value==="" || document.getElementById("email"+temp).value==="" || document.getElementById("phno"+temp).value===""){
                                  alert("Fields marked with * are compulsory");
                              }
                              var x=document.getElementById("addr_pin"+temp).value;
                              if(parseInt(x)>999999){
                                  alert("Pin code should not be more than 6 characters");
                                  //return false;
                              }
                              var y=document.getElementById("phno"+temp).value;
                              if(parseInt(y)<10000000 || parseInt(y)>9999999999){
                                  alert("Invalid Phone number");
                                  //return false;
                              }
                              var z=document.getElementById("email"+temp).value;
                                var z1=z+"@abc";
                                var z2=z+".abc";
                                if(z1.split('@').length!==3 || z2.split('.').length<3){
                                    alert("Invalid Email-Id");
                                }
                    }
                    $("#sd"+div_ct).hide();
                    $("#sd"+id).show();
                    div_ct=id;
                    return true;
            }
            $(document).ready(function(){
                 count++;
                 qs.push(div_ct);
                 $("#sd0").show();
               for(var i=1;i<200;i++){
                   $("#sd"+i).hide();
               } 
            });
             $(document).ready(function(){
                 var bday=new Date();
                 var maxy=(bday.getFullYear()-18);
                 bday.setFullYear(maxy);
                for(var k=0;k<100;k++){
                $("#dobd"+k).datepicker({
                   dateFormat:'dd/mm/yy',
                   changeYear:true,
                   changeMonth:true,
                   changeDay:true,
                   maxDate:bday,
                   yearRange:(bday.getFullYear()+18-60)+":"+(bday.getFullYear())
                });
                }
             });
            function validate(){
                //alert(count);
                if(count===1){
                    temp=0;
                    if(document.getElementById("name"+temp).value==="" || document.getElementById("inst_cd"+temp).value==="" || document.getElementById("dobd"+temp).value==="" || document.getElementById("addr1"+temp).value==="" || document.getElementById("addr_pin"+temp).value==="" || document.getElementById("email"+temp).value==="" || document.getElementById("phno"+temp).value===""){
                                alert("Fields marked with * are compulsory");
                                return false;
                    }
                    var x=document.getElementById("addr_pin"+temp).value;
                    if(parseInt(x)>999999){
                    alert("Pin code should not be more than 6 characters");
                    return false;
                    }
                    var y=document.getElementById("phno"+temp).value;
                    if(parseInt(y)<10000000 || parseInt(y)>9999999999){
                        alert("Invalid Phone number");
                        return false;
                    }
                    var z=document.getElementById("email"+temp).value;
                    var z1=z+"@abc";
                    var z2=z+".abc";
                    if(z1.split('@').length!==3 || z2.split('.').length<3){
                        alert("Invalid Email-Id");
                        return false;
                    }
                }
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
    <%!int student_code[],student_ct=0,inst_ct=0;%><%!String name[],qual[],stream[],dobd[],dobm[],doby[],fname[],inst_cd[],addr1[],addr2[],addr3[],addr4[];%>
    <%!String addr_pin[],email[],phno[],pic_file[];%><%!String inst[];%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
             username=request.getParameter("username");
             emp_name=request.getParameter("emp_name");
             emp_dept=request.getParameter("emp_dept");
             emp_desg=request.getParameter("emp_desg");
             dept_code=request.getParameter("dept_code");
             Connection conn = null;
             PreparedStatement ps = null;
             ResultSet rs = null;
             try {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
             conn.setAutoCommit(false);
             student_code=new int[200];
             ps = conn.prepareStatement ("SELECT * FROM OES_LAST_ID");
             rs=ps.executeQuery();
             while(rs.next()){
               student_code[0]=Integer.parseInt(rs.getString("LAST_STUDENT_CD"));
             }
             student_code[0]++;
             inst=new String[200];
             inst_cd=new String[200];
             ps = conn.prepareStatement ("SELECT * FROM OES_INSTITUTE_MST");
             rs = ps.executeQuery();
             inst_ct=0;
             while(rs.next()){
               inst_cd[inst_ct]=rs.getString("INSTITUTE_CD");
               inst[inst_ct]=rs.getString("INSTITUTE_NAME");
               //out.println("a               "+inst_cd[inst_ct]+""+inst[inst_ct]);
               inst_ct++;
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
    <form action="submitstudtl.jsp" method="post" onsubmit="return validate();" enctype="multipart/form-data">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input id="student_ct" type="hidden" name="student_ct"/>
        <%
        student_ct=0;
        while(student_ct<100){%>
        <input type="hidden" name="student_code<%=student_ct%>" value="<%=student_code[student_ct]%>"/>
        <div id="sd<%=student_ct%>">
            <h3 id="head" style="text-align:center;color:#000066;font-weight: bold;margin-bottom: -40px;margin-top: -20px"><u>Student Details Entry</u></h3>
            <div id="field" style="margin-left:65px;margin-top: 75px;height: 100px;margin-right: -100px" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Full Name:-<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input id="name<%=student_ct%>" type="text" name="name<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 10px;" placeholder="                          Student Name   "/>
            </div>
            <div id="usn_ea" style="font-size: 25px;font-family: Calibri;margin-top:-5%;margin-left:65px">Select Institute:&nbsp;&nbsp;<span style="color:red">*</span> 
                <select id="inst_cd<%=student_ct%>" name="inst_cd<%=student_ct%>" id="inst_cd<%=student_ct%>">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<inst_ct;k++){%>
                        <option  value="<%=inst_cd[k]%>"/><%=inst[k]%>
                        <%}%>
                </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Qualification:-<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;</span><input type="text" name="qual<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:225px;margin-left: 12.5px;" placeholder="        Degree/Diploma   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Stream:-<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="stream<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:225px;margin-left: 25px;" placeholder="           Stream   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Date of Birth:-<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" id="dobd<%=student_ct%>" name="dobd<%=student_ct%>" style="background: white;border-radius: 0px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:150px;margin-left: 12.5px;" placeholder="DD-MM-YYYY"/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Father's Name:-<span style="color:red">*</span></span><input type="text" name="fname<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 12.5px;" placeholder="                       Father/Guardian   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Address:-<span style="color:red">*</span>&nbsp;</span><input id="addr1<%=student_ct%>" type="text" name="addr1<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 72.5px;" placeholder="                        Address Line 1   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="addr2<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 122.5px;" placeholder="                        Address Line 2   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="addr3<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 122.5px;" placeholder="                        Address Line 3   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="addr4<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 122.5px;" placeholder="                        Address Line 4   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">PIN Code:-<span style="color:red">*</span>&nbsp;</span><input id="addr_pin<%=student_ct%>" type="number" name="addr_pin<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 60px;" placeholder="                        PIN CODE   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Photograph:-</span><input style="margin-top:-2.75%;margin-left: 21.5%" type="file" accept="image/*" name="photo<%=student_ct%>">
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Email Address:-<span style="color:red">*</span></span><input id="email<%=student_ct%>" type="text" name="email<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 20px;" placeholder="                    @xyz.com   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Phone No:-<span style="color:red">*</span></span><input type="number" id="phno<%=student_ct%>" name="phno<%=student_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 62.5px;" placeholder="             +91XXXXXXXXXX   "/>
            </div>
            <div id="navqs" style="margin-top: 10px;margin-left: 275px"> 
            <%if(student_ct!=0){%>    
            <a href="javascript:void(0)" id="prevstud" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="divshow('<%=(student_ct-1)%>','0');">&nbsp;&nbsp;Previous&nbsp;&nbsp;</a>
            <%}%>
            <%if(student_ct!=199){%>
            <a href="javascript:void(0)" id="nextstud<%=student_ct%>" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="divshow('<%=(student_ct+1)%>','1');">&nbsp;&nbsp;New&nbsp;&nbsp;</a>
            <%}%>
            </div>
            <input id="smt" type="submit" value="SUBMIT" style="margin-top:-32.5px;margin-left: 650px;margin-bottom: 25px"/>
        </div>            
        <% 
         student_ct++;
         student_code[student_ct]=student_code[student_ct-1]+1;
         System.out.print(student_code[student_ct-1]+",");
        }%>
    </form>
    </body>
</html>

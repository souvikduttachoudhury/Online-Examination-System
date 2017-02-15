<%-- 
    Document   : institutedtls
    Created on : Jun 10, 2015, 4:18:43 PM
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
                              if(document.getElementById("name"+temp).value==="" || document.getElementById("addr1"+temp).value==="" || document.getElementById("addr_pin"+temp).value==="" || document.getElementById("email"+temp).value==="" || document.getElementById("phno"+temp).value===""){
                                  alert("Fields marked with * are mandatory");
                                  return false;
                              }
                              var y=document.getElementById("phno"+temp).value;
                                if(y<10000000 || y>9999999999){
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
                                if(document.getElementById("name"+temp).value==="" || document.getElementById("addr1"+temp).value==="" || document.getElementById("addr_pin"+temp).value==="" || document.getElementById("email"+temp).value==="" || document.getElementById("phno"+temp).value===""){
                                    alert("Fields marked with * are mandatory");
                                } 
                                var y=document.getElementById("phno"+temp).value;
                                if(y<10000000 || y>9999999999){
                                    alert("Invalid Phone number");
                                    //return false;
                                }
                                var z=document.getElementById("email"+temp).value;
                                var z1=z+"@abc";
                                var z2=z+".abc";
                                if(z1.split('@').length!==3 || z2.split('.').length<3){
                                alert("Invalid Email-Id");
                                //return false;
                                }
                             }
                    }
                    else{
                            var temp=parseInt(id)+1;
                            if(document.getElementById("name"+temp).value==="" || document.getElementById("addr1"+temp).value==="" || document.getElementById("addr_pin"+temp).value==="" || document.getElementById("email"+temp).value==="" || document.getElementById("phno"+temp).value===""){
                                    alert("Fields marked with * are mandatory");
                            } 
                            var y=document.getElementById("phno"+temp).value;
                                if(y<10000000 || y>9999999999){
                                    alert("Invalid Phone number");
                                    //return false;
                            }
                            var z=document.getElementById("email"+temp).value;
                            var z1=z+"@abc";
                            var z2=z+".abc";
                            if(z1.split('@').length!==3 || z2.split('.').length<3){
                                alert("Invalid Email-Id");
                                //return false;
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
            function validate(){
                if(count===1){
                    temp=0;
                   //if(document.getElementById("name"+temp).value==="" || document.getElementById("inst_cd"+temp).value==="" || document.getElementById("dobd"+temp).value==="" || document.getElementById("addr1"+temp).value==="" || document.getElementById("addr_pin"+temp).value==="" || document.getElementById("email"+temp).value==="" || document.getElementById("phno"+temp).value===""){
                    if(document.getElementById("name"+temp).value==="" || document.getElementById("addr1"+temp).value==="" || document.getElementById("addr_pin"+temp).value==="" || document.getElementById("email"+temp).value==="" || document.getElementById("phno"+temp).value===""){
                    alert("Fields marked with * are compulsory");
                    return false;
                    }
                    var x=document.getElementById("addr_pin"+temp).value;
                    if(parseInt(x)>999999){
                    alert("Pin code should not be more than 6 characters");
                    return false;
                    }
                    var y=document.getElementById("phno"+temp).value;
                    if(y<10000000 || y>9999999999){
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
                //alert(count);
                document.getElementById("inst_ct").value=count;
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
    <%!int student_code[],student_ct=0,inst_ct=0,ct=0;%><%!String name[],qual[],stream[],dobd[],dobm[],doby[],fname[],inst_cd[],addr1[],addr2[],addr3[],addr4[];%>
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
             ps = conn.prepareStatement ("SELECT INSTITUTE_CD FROM OES_INSTITUTE_MST");
             rs=ps.executeQuery();
             ct=0;
             while(rs.next()){
               ct++;
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
     <form action="submitinstdtl.jsp" method="post" onsubmit="return validate();">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input id="inst_ct" type="hidden" name="inst_ct"/>
        <%
        inst_ct=0;
        inst_cd=new String[200];
        //inst_cd[0]="A"+Integer.toString(inst_ct+3);
        while(inst_ct<200){
        inst_cd[inst_ct]="A"+Integer.toString(inst_ct+ct+1);%>
        <input type="hidden" name="inst_cd<%=inst_ct%>" value="<%=inst_cd[inst_ct]%>"/>
        <div id="sd<%=inst_ct%>">
            <h3 id="head" style="text-align:center;color:#000066;margin-left: -10%;font-weight: bold;margin-bottom: -40px;margin-top: 1.5%"><u>Institute Details Form</u></h3>
            <div id="field" style="margin-left:65px;margin-top: 75px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Institute Name:-<span style="color:red">*</span></span><input type="text" id="name<%=inst_ct%>" name="name<%=inst_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:42%;margin-left: 1%;margin-right: -40%" placeholder="                           Institute Name                      "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Address:-<span style="color:red">*</span>&nbsp;</span><input type="text" id="addr1<%=inst_ct%>" name="addr1<%=inst_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:35%;margin-left: 7%;" placeholder="                        Address Line 1   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="addr2<%=inst_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:35%;margin-left: 12.25%;" placeholder="                          Address Line 2   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="addr3<%=inst_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:35%;margin-left: 12.25%;" placeholder="                          Address Line 3   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="addr4<%=inst_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:35%;margin-left: 12.25%;" placeholder="                          Address Line 4   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">PIN Code:-<span style="color:red">*</span>&nbsp;</span><input type="number" id="addr_pin<%=inst_ct%>" name="addr_pin<%=inst_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:30%;margin-left: 5.75%;" placeholder="                        PIN CODE   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Email ID:-<span style="color:red">*</span>&nbsp;</span><input type="text" id="email<%=inst_ct%>" name="email<%=inst_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:35%;margin-left: 6.75%;" placeholder="                                   @xyz.com   "/>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Phone No:-<span style="color:red">*</span>&nbsp;</span><input type="number" id="phno<%=inst_ct%>" name="phno<%=inst_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:30%;margin-left: 5%;" placeholder="             +91XXXXXXXXXX   "/>
            </div>
            <div id="navqs" style="margin-top: 10px;margin-left: 275px"> 
            <%if(inst_ct!=0){%>    
            <a href="javascript:void(0)" id="prevstud" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="divshow('<%=(inst_ct-1)%>','0');">&nbsp;&nbsp;Previous&nbsp;&nbsp;</a>
            <%}%>
            <%if(inst_ct!=199){%>
            <a href="javascript:void(0)" id="nextstud<%=inst_ct%>" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="divshow('<%=(inst_ct+1)%>','1');">&nbsp;&nbsp;New&nbsp;&nbsp;</a>
            <%}%>
            </div>
            <input id="smt" type="submit" value="SUBMIT" style="margin-top:-32.5px;margin-left: 650px;margin-bottom: 25px"/>
        </div>            
        <% 
          inst_ct++;
        }%>
    </form>
    </body>
</html>

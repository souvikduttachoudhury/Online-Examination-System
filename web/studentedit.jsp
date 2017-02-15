<%-- 
    Document   : studentedit
    Created on : Jun 12, 2015, 2:07:41 PM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Edit</title>
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
            function change(cg){
                $("#sd"+cg).hide();
                $("#usn_ea").show();
            }
            $(document).ready(function(){
                 count++;
                 qs.push(div_ct);
               for(var i=0;i<200;i++){
                  $("#sd"+i).hide();
               } 
            });
            function schange(cd){
               var x=confirm("Are you sure you want to delete this student?");
               if(x===true){
                  document.getElementById("s_code").value=parseInt(cd);
                  window.setTimeout('document.formdl.submit()',0); 
                  return true;
               }
               else{
                   return false;
               }
            }
            function validate(){
                document.getElementById("student_ct").value=count;
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
    <%!int student_code[],sc=0,student_ct=0,inst_ct=0;%><%!String name[],qual[],stream[],date[],dobd[],dobm[],doby[],fname[],inst_cd,addr1[],addr2[],addr3[],addr4[];%>
    <%!String addr_pin[],email[],phno[],pic_file[];%><%!String inst;%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
             username=request.getParameter("username");
             emp_name=request.getParameter("emp_name");
             emp_dept=request.getParameter("emp_dept");
             emp_desg=request.getParameter("emp_desg");
             dept_code=request.getParameter("dept_code");
             inst_cd=request.getParameter("inst_code");
             //out.print("aaaaaaaaaaaaaaaaaaaa        "+inst_cd);
             Connection conn = null;
             PreparedStatement ps = null;
             ResultSet rs = null;
             try {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
             conn.setAutoCommit(false);
             ps = conn.prepareStatement ("SELECT * FROM OES_INSTITUTE_MST WHERE INSTITUTE_CD=?");
             ps.setString(1, inst_cd);
             rs = ps.executeQuery();
             while(rs.next()){
                 inst=rs.getString("INSTITUTE_NAME");
             }
             student_code=new int[200];
             name=new String[200];
             qual=new String[200];
             stream=new String[200];
             date=new String[200];
             dobd=new String[200];
             dobm=new String[200];
             doby=new String[200];
             fname=new String[200];
             addr1=new String[200];
             addr2=new String[200];
             addr3=new String[200];
             addr4=new String[200];
             addr_pin=new String[200];
             email=new String[200];
             phno=new String[200];
             pic_file=new String[200];
             ps = conn.prepareStatement ("SELECT * FROM OES_STUDENT_MST WHERE INSTITUTE_CD=?");
             ps.setString(1, inst_cd);
             rs=ps.executeQuery();
             student_ct=0;
             while(rs.next()){
                 student_code[student_ct]=Integer.parseInt(rs.getString("STUDENT_CD"));
                 name[student_ct]=rs.getString("STUDENT_NAME");
                 qual[student_ct]=rs.getString("STUDENT_QUALIFICATION");
                 stream[student_ct]=rs.getString("STUDENT_STREAM");
                 date[student_ct]=rs.getString("STUDENT_DOB");
                 fname[student_ct]=rs.getString("FATHER_NAME");
                 addr1[student_ct]=rs.getString("STUDENT_ADDR1");
                 if(addr2[student_ct]==null){
                     addr2[student_ct]="";
                 }
                 addr2[student_ct]=rs.getString("STUDENT_ADDR2");
                 if(addr2[student_ct]==null){
                     addr2[student_ct]="";
                 }
                 addr3[student_ct]=rs.getString("STUDENT_ADDR3");
                 if(addr3[student_ct]==null){
                     addr3[student_ct]="";
                 }
                 addr4[student_ct]=rs.getString("STUDENT_ADDR4");
                 if(addr4[student_ct]==null){
                     addr4[student_ct]="";
                 }
                 addr_pin[student_ct]=rs.getString("STUDENT_ADDR_PIN");
                 if(addr_pin[student_ct]==null){
                     addr_pin[student_ct]="Not Available";
                 }
                 email[student_ct]=rs.getString("STUDENT_EMAIL");
                 if(email[student_ct]==null){
                     email[student_ct]="Not Available";
                 }
                 phno[student_ct]=rs.getString("STUDENT_PHNO");
                 if(phno[student_ct]==null){
                     phno[student_ct]="Not Available";
                 }
                 pic_file[student_ct]=rs.getString("PIC_FILE");
                 student_ct++;
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
    <form id="formdl" name="formdl" action="deletestudent.jsp">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input id="s_code" type="hidden" name="student_cd"/>
    </form>
    <div id="usn_ea">Select Student:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="student_code" id="student_code" onchange="show(this.value)">
                        <option value="">&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<student_ct;k++){%>
                        <option  value="<%=k%>"/><%=name[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
    </div>
        <%
        sc=0;
        while(sc<student_ct){%>
    <form action="editstudent.jsp" method="post">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input type="hidden" name="inst_cd" value="<%=inst_cd%>"/>
        <input type="hidden" id="scd" name="student_code" value="<%=student_code[sc]%>"/>
        <div id="sd<%=sc%>" style="color:#660000;font-size: 22.5px;">
            <h3 id="head" style="text-align:center;color:#000066;font-weight: bold;margin-bottom: -40px;margin-top: -20px">Student Edit Page</h3>
            <div id="field" style="margin-left:65px;margin-top: 75px;height: 100px;margin-right: -100px" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Name:-&nbsp;&nbsp;</span><div  style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:525px;margin-left: 14.75%;margin-top: -2.5%"><%=name[sc]%></div>
            </div>
            <div id="usn_ea" style="margin-top:-4.25%;margin-left:65px"> 
                 
                 <%if(pic_file[sc]!=null){ 
                 if(!pic_file[sc].equals("nil") && pic_file[sc].length()>3){%>
                  <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Institute:-&nbsp;&nbsp;</span><div style="color:#660000;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;font-size: 22.5px;  height:30px;width:525px;margin-left: 16.75%;margin-top: -3.25%"><%=inst%></div>
                  <img src="<%=pic_file[sc]%>" style="height: 100%;width:20%; margin-left:53.5%;margin-top: 14%;border-radius: 7px;border-spacing: 1px;border:1.5px solid paleturquoise"/>
                 <%}
                 }
                 else{%>
                 <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Institute:-&nbsp;&nbsp;</span><div style="color:#660000;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;font-size: 22.5px;  height:30px;width:525px;margin-left: 32%;margin-top: -6.75%"><%=inst%></div>
                 <%}%>     
                 <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Qualification:-&nbsp;&nbsp;</span><div  style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:225px;margin-left: 16.5%;margin-top: -3.25%"><%=qual[sc]%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Stream:-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:250px;margin-left: 16.5%;margin-top: -3.25%;"><%=stream[sc]%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Date of Birth<span style="color:red">&nbsp;</span>&nbsp;:-</span><div style="border-radius: 0px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:40px;margin-left: 16.5%;margin-top: -3.25%;"><%=date[sc].substring(8,10)%>/<%=date[sc].substring(5,7)%>/<%=date[sc].substring(0,4)%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Father's Name:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 16.5%;margin-top: -3.25%;"><%=fname[sc]%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Address:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 16.5%;margin-top: -3.25%;"><%=addr1[sc]%></div>
            </div>
            <%if(!addr2[sc].equals("")){%>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 16.5%;margin-top: -3.25%;"><%=addr2[sc]%></div>
            </div>
            <%}%>
            <%if(!addr3[sc].equals("")){%>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 16.5%;margin-top: -3.25%;"><%=addr3[sc]%></div>
            </div>
            <%}%>
            <%if(!addr4[sc].equals("")){%>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 16.5%;margin-top: -3.25%;"><%=addr4[sc]%></div>
            </div>
             <%}%>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">PIN Code:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 16.5%;margin-top: -3.25%;"><%=addr_pin[sc]%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Email Address:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:425px;margin-left: 16.5%;margin-top: -3.25%;" ><%=email[sc]%></div>
            </div>
            <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Phone No:-&nbsp;&nbsp;</span><div style="border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 16.5%;margin-top: -3.25%;"><%=phno[sc]%></div>
            </div>
            <div style="margin-top:-77.5%;">
                <input id="smt" type="submit" value="EDIT" style="margin-left: 50%" />
                <input id="smt" type="button" value="Change Student" style="width: 200px;height: 37.5px;margin-left: 65.5%" onclick="change('<%=sc%>')"/>
            </div>
            <br/><br/>
            <div>
                 <input id="smt" type="button" value="Delete" style="width: 200px;height: 37.5px;margin-left: 55.5%" onclick="schange('<%=student_code[sc]%>')"/>
            </div>
        </div>  
      </form>
        <% 
         sc++;
        }%>
    </body>
</html>
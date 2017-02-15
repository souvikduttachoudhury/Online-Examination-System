<%-- 
    Document   : employeedtls
    Created on : Jun 11, 2015, 3:36:39 PM
    Author     : abc
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employee Details</title>
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
            s = [];
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
            $(document).ready(function() {
                 $('#dept_cd').change(function(event) {
                 var deptcd = $("select#dept_cd").val();
                 document.getElementById("desg").innerHTML="";
                $.post('try1.jsp', {
                    dept_cd : deptcd
                 }, function(data,status) {
                  var json = eval('(' + data +')');
                     var select = $('#emp_code');
                      select.find('option').remove();
                      //alert(json.name1);
                     $('<option>').val("").text("  Choose   ").appendTo(select);
                     $.each(json, function(index,value) {
                         var str=value.split(",");
                         //alert(str[0]);
                      //s.push(str[3]);
                      //document.getElementById("desg").innerHTML=str[3];
                      $('<option>').val(str[1]).text(str[0]).appendTo(select);
                });
             });
             });
             $(document).ready(function(){
                 var dt = new Date();
                 var yr = (dt.getFullYear())+":"+(dt.getFullYear()+20);
                $('#fromy').datepicker({
                   dateFormat:'dd/mm/yy',
                   changeYear:true,
                   changeMonth:true,
                   changeDay:true,
                   yearRange:yr,
                   minDate:'today'
                });
                var dt1 = new Date();
                var yr1 = (dt.getFullYear())+":"+(dt.getFullYear()+30);
                $('#uptoy').datepicker({
                   dateFormat:'dd/mm/yy',
                   changeYear:true,
                   changeMonth:true,
                   changeDay:true,
                   yearRange:yr1,
                   minDate:'today'
                });
             });
             $('#emp_code').change(function(event) {
                 var empcd = $("select#emp_code").val();
                $.post('try2.jsp', {
                    emp_cd : empcd
                 }, function(data,status) {
                  var json = eval('(' + data +')');
                      //alert(json.name1);
                     //$('<option>').val("").text("      -----------------------  ").appendTo(select);
                     $.each(json, function(index,value) {
                         var str=value.split(",");
                         //alert(str[0]);
                      document.getElementById("desg").innerHTML=str[1];
                      document.getElementById("desg_cd").value=str[0];
                       document.getElementById("name").value=str[2];
                });
             });
             });
             
             });
            function access(id1,id2,id3){
                if(document.getElementById(id2).value==="001"){
                    document.getElementById(id1).value="A";
                }
                else{
                    document.getElementById(id1).value="D";
                }
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
    <%!int ct,student_code[],dept_ct=0,desg_ct=0,emp_ct=0;%><%!String emp[],emp_cd[],passwd[],desg_cd[],dept_cd[],fromd[],fromm[],fromy[],dept[],emp_code[],desg[],uptod[],uptom[],uptoy[];%>
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
             ps = conn.prepareStatement ("SELECT * FROM OES_EMP_MST");
             rs=ps.executeQuery();
             emp_cd=new String[500];
             emp=new String[500];
             emp_ct=0;
             while(rs.next()){
                 emp[emp_ct]=rs.getString("EMP_NAME");
                 emp_cd[emp_ct]=rs.getString("EMP_CD");
                 emp_ct++;
             }
             ps = conn.prepareStatement ("SELECT * FROM OES_DEPT_MST");
             rs=ps.executeQuery();
             dept_ct=0;
             dept_cd=new String[200];
             dept=new String[200];
             while(rs.next()){
               dept_cd[dept_ct]=rs.getString("DEPT_CD");
               dept[dept_ct]=rs.getString("DEPT_DESC");
               dept_ct++;
             }
             ps = conn.prepareStatement ("SELECT EMP_CD FROM OES_EMP_MST");
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
     <form action="submitempdtl.jsp" method="post" onsubmit="return validate();">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
            <h3 id="head" style="text-align:center;font-weight: bold;color:#000066;margin-bottom: -40px;margin-top: -20px">Employee Access Permission</h3>
            <input id="name" type="hidden" name="name"/>
            <div id="usn_ea" style="margin-top:10%;margin-left:65px;font-weight: normal;font-family: Calibri;font-size: 25px;color:#0000ff">Department:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red">*</span> 
                <select name="dept_cd" id="dept_cd" onchange="access('access_code','dept_cd','acupto');" >
                        <option value="">&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<dept_ct;k++){%>
                        <option  value="<%=dept_cd[k]%>"/><%=dept[k]%>
                        <%}%>
                </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
            </div>
            <div id="usn_ea" style="margin-top:16%;margin-left:65px;font-weight: normal;font-family: Calibri;font-size: 25px;color:#0000ff">Employee:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red">*</span> 
                <select name="emp_code" id="emp_code">
                    <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Choose
                </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
            </div>
            <div id="field" style="margin-top: 22%;margin-left:65px;height: 65px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Designation:-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="desg" style="font-size:25px;font-family: Calibri;color:#cc3300"></span></span><input type="hidden" id="desg_cd" name="desg_cd"/> 
            </div>
            <input type="hidden" name="passwd" value="cesc"/>
            <input type="hidden" id="access_code" name="access_code"/>    
            <div id="field" style="margin-left:65px;height: 65px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Access From:<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;</span><input id="fromy" type="text" name="fromy" style="background: white;border-radius: 0px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:150px;margin-left: 7.5px;" placeholder=" DD-MM-YYYY"/>
            </div>
            <div id="field" style="margin-left:65px;height: 65px;">
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Access Upto:&nbsp;&nbsp;<span style="color:red">&nbsp;</span>&nbsp;&nbsp;&nbsp;</span><input id="uptoy" type="text" name="uptoy" style="background: white;border-radius: 0px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:150px;margin-left: 7px;" placeholder=" DD-MM-YYYY"/>
            </div>
            <input id="smt" type="submit" value="SUBMIT" style="margin-top:-32.5px;margin-left: 650px;margin-bottom: 25px"/><br/><br/><br/>           
    </form>
    </body>
</html>

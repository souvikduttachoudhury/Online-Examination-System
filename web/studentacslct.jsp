<%-- 
    Document   : studentacslct
    Created on : Jun 24, 2015, 10:52:41 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Access</title>
        <link rel="stylesheet" href="login.css" type="text/css"/>
        <link rel="stylesheet"  href="stylesheet.css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="bootstrap.js"></script>
        <script type="text/javascript" src="jquery_1.js"></script>
        <script type="text/javascript" src="jquery-latest.js"></script>
        <script type="text/javascript" src="jquery-latest_1.js"></script>
        <script type="text/javascript" src="feedback_dialog.js"></script>
        <script type="text/javascript" src="multi-screen.js"></script>
        <script src="jquery-1.11.1.js" type="text/javascript"></script>
         <script type="text/javascript">
         function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function submit_dtlsh(access){
                if(access==='D'){
                window.setTimeout('document.formh.submit()',0);
                }
                else if(access==='A'){
                    window.setTimeout('document.formad.submit()',0);
                }
            }
            $(document).ready(function() {
                 $('#inst_cd').change(function(event) {
                 var module = $("select#inst_cd").val();
                $.post('try3.jsp', {
                    inst_cd : module
                 }, function(data,status) {
                  var json = eval('(' + data +')');
                     var select = $('#stream');
                      select.find('option').remove();
                      //alert(json.name1);
                     //$('<option>').val("").text("      -----------------------  ").appendTo(select);
                     $.each(json, function(index,value) {
                         //var str=value.split(",");
                         //alert(str[0]);
                      $('<option>').val(value).text(value).appendTo(select);
                });
             });
             });
            });
        </script>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
    </head>
    <%!int inst_ct=0,exam_ct,cat_ct[];%><%!String exam_date[],exam[],inst[],inst_cd[],cat[][];%><%!int exam_code[],cat_code[][];%>
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
            exam_code=new int[100];
            exam=new String[100];
            exam_date=new String[100];
            inst_cd=new String[100];
            inst=new String[100];
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_MST  WHERE EXAM_CANCELLED='N' ORDER BY EXAM_DATE");
            rs=ps.executeQuery();
            exam_ct=0;
            while(rs.next()){
              exam_code[exam_ct]=Integer.parseInt(rs.getString("EXAM_CD"));
              exam[exam_ct]=rs.getString("EXAM_NAME");
              exam_date[exam_ct]=rs.getString("EXAM_DATE");
              if(!exam_date[exam_ct].equals(null)){
              exam_date[exam_ct]=exam_date[exam_ct].substring(8,10 )+"/"+exam_date[exam_ct].substring(5, 7)+"/"+exam_date[exam_ct].substring(0, 4);
              }
              else{
                  exam_date[exam_ct]="";
              }
              exam_ct++;
            }
            inst_ct=0;
            ps = conn.prepareStatement ("SELECT * FROM OES_INSTITUTE_MST");
            rs=ps.executeQuery();
            while(rs.next()){
              inst_cd[inst_ct]=rs.getString("INSTITUTE_CD");
              inst[inst_ct]=rs.getString("INSTITUTE_NAME");
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
    <form id="StudentAccess" method="post" action="studentacs.jsp">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <div id="entermodcat" style="margin-top: -25px">
                <div id="usn_ea">Select Examination:&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="exam_code" id="exam_code">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<exam_ct;k++){%>
                        <option  value="<%=exam_code[k]%>"/><%=exam[k]%>&nbsp;<%=exam_date[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
                </div><br/><br/><br/><br/>
                <div id="usn_ea">Select Institute:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="inst_cd" id="inst_cd">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<inst_ct;k++){%>
                        <option  value="<%=inst_cd[k]%>"/><%=inst[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
                </div>   
                <div id="pwd_ea" style="font-family: Calibri;font-size: 25px">Select Stream:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="stream" id="stream">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;Choose
                    </select>
                    <!--input id="cat" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:32.5px;width:200px;margin-left: 16px;" placeholder="      Category Code" type="number" name="cat_cd"/-->
                </div>
                <input id="smt_ea" type="submit" value="Proceed"/>
    </form>
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
    </body>
</html>
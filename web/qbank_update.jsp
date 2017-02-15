<%-- 
    Document   : qbank_update
    Created on : Jun 5, 2015, 9:53:32 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Question Bank</title>
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
                 $('#mod_code').change(function(event) {
                 var module = $("select#mod_code").val();
                $.post('try.jsp', {
                    mod_cd : module
                 }, function(data,status) {
                  var json = eval('(' + data +')');
                     var select = $('#cat_code');
                      select.find('option').remove();
                      //alert(json.name1);
                     //$('<option>').val("").text("      -----------------------  ").appendTo(select);
                     $.each(json, function(index,value) {
                         var str=value.split(",");
                         //alert(str[0]);
                      $('<option>').val(str[0]).text(str[1]).appendTo(select);
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
    <%!int mod_ct=0,cat_ct[];%><%!String mod[],cat[][];%><%!int mod_code[],cat_code[][];%>
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
            mod=new String[100];
            mod_code=new int[100];
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_MODULE_MST");
            rs=ps.executeQuery();
            mod_ct=0;
            while(rs.next()){
              mod_code[mod_ct]=Integer.parseInt(rs.getString("MODULE_CD"));
              mod[mod_ct]=rs.getString("MODULE_DESC");
              mod_ct++;
            }
            cat=new String[mod_ct][100];
            cat_code=new int[mod_ct][100];
            cat_ct=new int[100];
            for(int i=0;i<100;i++){
               cat_ct[i]=0;  
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
    <form id="qbank" method="post" action="enterques.jsp">            
        <div id="entermodcat" style="margin-top: -25px">
                <div id="usn_ea">Select Module:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="mod_code" id="mod_code">
                        <option value="">&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<mod_ct;k++){
                        if(mod[k]!=null){%>
                        <option  value="<%=mod_code[k]%>"><%=mod[k]%>
                        <%}
                        }%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
                </div>
                    <div id="pwd_ea" style="font-family: Calibri;font-size: 25px">Select Category:&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="cat_code" id="cat_code">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;Choose
                    </select>
                    <!--input id="cat" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:32.5px;width:200px;margin-left: 16px;" placeholder="      Category Code" type="number" name="cat_cd"/-->
                </div>
                <input type="hidden" name="username" value="<%=username%>"/>
                <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
                <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
                <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
                <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
                <input id="smt_ea" type="submit" value="Update"/>
        </div>
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

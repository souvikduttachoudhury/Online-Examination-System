<%-- 
    Document   : examdtls
    Created on : Jun 13, 2015, 11:36:09 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Details</title>
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
        <script type="text/javascript" src="jquery-ui.js"></script>
        <link rel="stylesheet" type="text/css" href="jquery-ui.css">
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
            function validate(){
                if(document.getElementById("exam").value==="" || document.getElementById("mod_code").value==="" || document.getElementById("cat_code").value==="" || document.getElementById("paper_setter").value==="" || document.getElementById("exam_cd").value==="" || document.getElementById("exam_cd_prfx").value==="" || document.getElementById("tot_mrk").value==="" || document.getElementById("tot_stud").value==="" || document.getElementById("exam_min").value==="" || document.getElementById("exam_dtd").value===""){
                alert("Field marked with * are mandatory");
                return false;
                }
                return true;
            }
            $(document).ready(function(){
               $('#exam_dtd').datepicker({
                  dateFormat:'dd/mm/yy',
                  changeYear:true,
                  changeMonth:true,
                  changeDay:true,
                  minDate:'today'
               });
            });
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
    <body id="bcg" style="background-image: url(back6.jpg);background-size: 150% 110%;background-repeat: no-repeat;opacity: 10">
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
            <form id="qbank" method="post" action="examdtlsubmit.jsp" onsubmit="return validate();">            
                <input type="hidden" name="username" value="<%=username%>"/>
                <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
                <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
                <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
                <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
                <h3 id="head" style="text-align:center;color:#000066;font-weight: bold;margin-bottom: -40px;margin-top: -20px">Enter Examination details</h3>
                <div id="field" style="margin-left:65px;margin-top: 75px;height: 50px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Name of the exam:-<span style="color:red">*</span></span><input type="text" id="exam" name="exam" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:32%;margin-left: 4.5%;margin-right: -40%" placeholder="                     Exam Name                      "/>
                </div>
                <div id="field" style="margin-left:65px;margin-top: 135px;height: 30px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Exam Code Prefix:-<span style="color:red">*</span>&nbsp;</span><input type="text" id="exam_cd_prfx" name="exam_cd_prfx" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:25%;margin-left: 5.5%;margin-right: -40%" placeholder="          Exam Code Prefix                      "/>
                </div>
                <div id="field" style="margin-left:65px;margin-top: 45px;height: 50px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Exam Code:-<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input id="exam_cd" type="number" name="exam_cd" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:25%;margin-left: 9.5%;margin-right: -40%" placeholder="                Exam Code                      "/>
                </div>
                <div id="field">
                    <div id="usn_ea" style="margin-top: -250px;font-size: 25px;margin-left:65px;height: 50px;">Select Module:<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="mod_code" id="mod_code">
                        <option value="">&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<mod_ct;k++){%>
                        <option  value="<%=mod_code[k]%>"/><%=mod[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
                </div>
                    <div id="pwd_ea" style="margin-top: -200px;font-size: 25px;font-family: Calibri;margin-left:65px;height: 50px;">Select Category:<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="cat_code" id="cat_code">
                        <option value="">&nbsp;&nbsp;&nbsp;&nbsp;Choose
                    </select>
                    <!--input id="cat" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:32.5px;width:200px;margin-left: 16px;" placeholder="      Category Code" type="number" name="cat_cd"/-->
                </div>
                </div>    
                <div id="field" style="margin-top: 1.5%;margin-left:65px;height: 60px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Exam Date:-<span style="color:red">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="exam_dtd" name="exam_dtd" style="background: white;border-radius: 0px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:150px;margin-left: 11%" placeholder="DD-MM-YYYY"/>
                </div>
                <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Time Period in Minutes:-<span style="color:red">*</span></span><input id="exam_min" type="number" name="exam_min" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 0%;" placeholder="                      mins   "/>
                </div>
                <div id="field" style="margin-left:65px;margin-top: 12.5px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Exam Venue:-<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;</span><input type="text" name="exam_venue" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:29.5%;margin-left: 9%;margin-right: -40%" placeholder="                     Venue                      "/>
                </div>
                <div id="field" style="margin-left:65px;height: 50px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Total Marks:-<span style="color:red">*</span>&nbsp;</span><input id="tot_mrk" type="number" name="tot_mrk" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 10.5%;" placeholder="                  Total Marks   "/>
                </div>
                <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Total Candidates:-<span style="color:red">*</span></span><input type="number" id="tot_stud" name="tot_stud" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:325px;margin-left: 6%;" placeholder="                  Total students   "/>
                </div>
                <div id="field" style="margin-left:65px;margin-top: 12.5px;height: 50px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Paper Setter:-<span style="color:red">*</span>&nbsp;</span><input id="paper_setter" type="number" name="paper_setter" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:31.5%;margin-left: 10%;margin-right: -40%" placeholder="                      Paper setter                      "/>
                </div>
                <div id="field" style="margin-left:65px;margin-top: 12.5px;height: 50px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Instructions:-&nbsp;&nbsp;</span><input type="text" name="instruction" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:120px;width:35%;margin-left: 9%;margin-right: -40%" placeholder="                        Instructions                      "/>
                </div>
                <input id="smt_ea" style="margin-bottom:25px;margin-top: -25px;margin-left: 62.5%" type="submit" value="Create"/>
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

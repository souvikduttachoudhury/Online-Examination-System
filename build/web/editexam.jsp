<%-- 
    Document   : editexam
    Created on : Jun 27, 2015, 11:08:37 AM
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
    <%!int mod_ct=0,cat_ct[];%><%!String venue,tot_mrk,tot_stud,paper_setter,instruction,min,name,exam_cd_prfx,exam_cd,module,date,module_cd,category,category_cd,mod[],cat[][];%><%!int mod_code[],cat_code[][];%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
           String username=request.getParameter("username");
           String emp_name=request.getParameter("emp_name");
           String emp_dept=request.getParameter("emp_dept");
           String emp_desg=request.getParameter("emp_desg");
           String dept_code=request.getParameter("dept_code");
           exam_cd=request.getParameter("exam_cd");
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
            System.out.println("::::::,");
            System.out.println(exam_cd);
            ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_MST e,OES_MODULE_MST m,OES_CATEGORY_MST c,OES_EMP_MST d WHERE e.MODULE_CD=m.MODULE_CD AND m.MODULE_CD=c.MODULE_CD AND e.CATEGORY_CD=c.CATEGORY_CD AND e.EXAM_PAPER_SETTER=d.EMP_CD AND e.EXAM_CANCELLED='N' AND e.EXAM_CD=?");
            ps.setString(1, exam_cd);
            rs=ps.executeQuery();
             //inst_ct=0;
             while(rs.next()){
                 //student_code[student_ct]=Integer.parseInt(rs.getString("STUDENT_CD"));
                 name=rs.getString("EXAM_NAME");
                 if(name==null){
                     name="Not Available";
                 }
                 //qua=rs.getString("STUDENT_QUALIFICATION");
                 //stream[student_ct]=rs.getString("STUDENT_STREAM");
                 //date[student_ct]=rs.getString("STUDENT_DOB");
                 //fname=rs.getString("FATHER_NAME");
                 exam_cd_prfx=rs.getString("EXAM_CD_PREFIX");
                 if(exam_cd_prfx==null){
                     exam_cd_prfx="Not Available";
                 }
                 System.out.print(exam_cd_prfx);
                 module=rs.getString("MODULE_DESC");
                 if(module==null){
                     module="";
                 }
                 else{
                 module_cd=rs.getString("MODULE_CD");
                 }
                 System.out.print(module_cd);
                 category=rs.getString("CATEGORY_DESC");
                 if(category==null){
                     category="";
                 }
                 else{
                 category_cd=rs.getString("CATEGORY_CD");
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
                 paper_setter=rs.getString("EMP_CD");
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
            <form id="qbank" method="post" action="submitexamedit.jsp" onsubmit="return validate();">            
                <input type="hidden" name="username" value="<%=username%>"/>
                <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
                <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
                <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
                <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
                 <input type="hidden" name="exam_cd" value="<%=exam_cd%>"/>
                <h3 id="head" style="text-align:center;color:#000066;font-weight: bold;margin-bottom: -40px;margin-top: -20px">Enter Examination details</h3>
                <div id="field" style="margin-left:65px;margin-top: 75px;height: 50px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Name of the exam:-<span style="color:red">*</span>&nbsp;</span><input type="text" value="<%=name%>" id="exam" name="exam" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:32%;margin-left: 4.5%;margin-right: -40%" placeholder="                     Exam Name                      "/>
                </div>
                <div id="field" style="margin-left:65px;margin-top: 10%;height: 30px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Exam Code Prefix:-<span style="color:red">*</span>&nbsp;</span><input type="text" value="<%=exam_cd_prfx%>" id="exam_cd_prfx" name="exam_cd_prfx" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:25%;margin-left: 5.5%;margin-right: -40%" placeholder="          Exam Code Prefix                      "/>
                </div>
                <div id="field">
                    <div id="usn_ea" style="margin-top: -137.5px;font-size: 25px;margin-left:65px;height: 50px;">Select Module:<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="mod_code" id="mod_code">
                        <option value="<%=module_cd%>">&nbsp;&nbsp;<%=module%>
                        <%for(int k=0;k<mod_ct;k++){
                        if(mod_code[k]!=Integer.parseInt(module_cd)){%>
                        <option  value="<%=mod_code[k]%>"/><%=mod[k]%>
                        <%}
                        }%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
                </div>
                    <div id="pwd_ea" style="margin-top: -87.5px;font-size: 25px;font-family: Calibri;margin-left:65px;height: 50px;">Select Category:<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="cat_code" id="cat_code">
                        <option value="<%=category_cd%>">&nbsp;&nbsp;&nbsp;<%=category%>
                    </select>
                    <!--input id="cat" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:32.5px;width:200px;margin-left: 16px;" placeholder="      Category Code" type="number" name="cat_cd"/-->
                </div>
                </div>    
                <div id="field" style="margin-top: 1.75%;margin-left:65px;height: 60px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Exam Date:-<span style="color:red">*</span></span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%=date%>" id="exam_dtd" name="exam_dtd" style="background: white;border-radius: 0px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 25px;font-family: Calibri;  height:35px;width:150px;margin-left: 11.25%" placeholder="MM-DD-YYYY"/>
                </div>
                <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Time Period in Minutes:-<span style="color:red">*</span></span><input id="exam_min" type="text" value="<%=min%>" name="exam_min" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:29.5%;margin-left: 0.5%;" placeholder="                      mins   "/>
                </div>
                <div id="field" style="margin-left:65px;margin-top: 12.5px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Exam Venue:-<span style="color:red">*</span>&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="exam_venue" value="<%=venue%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:29.5%;margin-left: 9%;margin-right: -40%" placeholder="                     Venue                      "/>
                </div>
                <div id="field" style="margin-left:65px;height: 50px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Total Marks:-<span style="color:red">*</span>&nbsp;&nbsp;</span><input id="tot_mrk" type="text" name="tot_mrk" value="<%=tot_mrk%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:29.5%;margin-left: 10.75%;" placeholder="                  Total Marks   "/>
                </div>
                <div id="field" style="margin-left:65px;height: 50px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Total Candidates:-<span style="color:red">*</span>&nbsp;</span><input type="number" id="tot_stud" name="tot_stud" value="<%=tot_stud%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:29.5%;margin-left: 6.5%;" placeholder="                  Total students   "/>
                </div>
                <div id="field" style="margin-left:65px;margin-top: 12.5px;height: 50px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Paper Setter:-<span style="color:red">*</span>&nbsp;&nbsp;</span><input id="paper_setter" type="text" name="paper_setter" value="<%=paper_setter%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:29.5%;margin-left: 10.25%;margin-right: -40%" placeholder="                      Paper setter                      "/>
                </div>
                <div id="field" style="margin-left:65px;margin-top: 12.5px;height: 100px;" >
                    <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Instructions:-&nbsp;&nbsp;</span><input type="text" name="instruction" value="<%=instruction%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:120px;width:35%;margin-left: 10.5%;margin-right: -40%" placeholder="                        Instructions                      "/>
                </div>
                <input id="smt_ea" style="margin-bottom:25px;margin-top: -25px;margin-left: 64%" type="submit" value="Update"/>
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
<%-- 
    Document   : enterques
    Created on : Jun 5, 2015, 10:33:20 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
             dlt=0;
            function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function divshow(id,flag){
                    $("#qc"+div_ct).hide();
                    $("#qc"+id).show();
                    div_ct=id;
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
                          }
                    }
            }
            function delqs(id){
                if(document.getElementById("delques"+id).innerHTML==='&nbsp;&nbsp;Delete&nbsp;&nbsp;'){
                   document.getElementById("delmkr"+id).value="1";
                   document.getElementById("delques"+id).innerHTML="&nbsp;&nbsp;Restore&nbsp;&nbsp;";
                }
                else{
                    document.getElementById("delmkr"+id).value="0";
                    document.getElementById("delques"+id).innerHTML="&nbsp;&nbsp;Delete&nbsp;&nbsp;";
                }
            }
            function validate(){
                document.getElementById("q_ct").value=count;
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
            function insert(id1,id2){
                var x=document.getElementById(id1).value;
                document.getElementById(id2).value=x;
            }
            $(document).ready(function(){
                count++;
                 qs.push(div_ct);
                 $("#qc0").show();
               for(var i=1;i<200;i++){
                   $("#qc"+i).hide();
               } 
            });
        </script>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
        <title>Enter Questions</title>
    </head>
    <%!int qid[];%><%!String username="";%><%!String emp_name="";%><%!String emp_dept="";%><%!String emp_desg="";%>
    <%!String dept_code="";%><%!String mod_code="";%><%!String cat_code="";%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            username=request.getParameter("username");
            emp_name=request.getParameter("emp_name");
            emp_dept=request.getParameter("emp_dept");
            emp_desg=request.getParameter("emp_desg");
            dept_code=request.getParameter("dept_code");
            mod_code=request.getParameter("mod_code");
            cat_code=request.getParameter("cat_code");
            qid=new int[200];
            for(int k=0;k<200;k++){
                qid[k]=-1;
            }
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT LAST_QID FROM OES_LAST_ID");
            rs = ps.executeQuery();
            while(rs.next()){
              qid[0]=Integer.parseInt(rs.getString("LAST_QID"));
            }
            qid[0]++;
            } 
            catch (Exception e) {
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
    <%!int q_count=0;%><%!int maxq=200;%><%!String qdesc[];%><%!String qfile[];%><%!int delmkr[];%>
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
    <form action="submitques.jsp" method="post" enctype="multipart/form-data" onsubmit="return validate();">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input type="hidden" name="mod_code" value="<%=mod_code%>"/>
        <input id="q_ct" type="hidden" name="q_count"/>
        <input type="hidden" name="cat_code" value="<%=cat_code%>"/>
        <%
        q_count=0;
        while(q_count<maxq){%>
        <div id="qc<%=q_count%>">
            <h3 id="head" style="text-align:center;color:#000066;font-weight: bold;margin-bottom: -40px;margin-top: -20px">Department of <%=emp_dept%></h3>
            <div id="field" style="margin-left:65px;margin-top: 75px;height: 275px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Q<%=(q_count+1)%>:-&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" name="qdesc<%=q_count%>" style="background: white;border-radius: 20px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 30px;font-family: Times New Roman;  height:42.5px;width:750px;margin-left: 10px;" placeholder="                             Question Description   "/>
            </div>
            <div id="field" style="margin-left:100px;margin-top: -200px;height: 275px;" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">File Source :-&nbsp;&nbsp;</span><input type="file" id="qfile<%=q_count%>" name="qfile<%=q_count%>" accept="image/*"  style="margin-top:-3%;margin-left: 20%;"> 
            </div>
            <div id="optns" style="margin-top:-175px;">
            <% for(int l=0;l<5;l++){%>
            <input type="checkbox" style="height:20px;width: 20px;margin-right: 15px;border-radius: 2px;margin-left: 90px;" name="crct<%=q_count%><%=l%>" value="1"/><input type="text" name="ans1<%=q_count%><%=l%>" style="background: white;border-radius: 20px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:400px;margin-left: 10px;" placeholder="                        Option <%=(l+1)%>   "/><input type="file" id="ans1file<%=q_count%><%=l%>" name="ans1file<%=q_count%><%=l%>" accept="image/*"  style="margin-top:-2%;margin-left: 60%;"><br/><br/>
            <!--input type="hidden" name="crct<%--=q_count--%><%--=l--%>" value="30"/-->
            <%}%>
            </div>
            <div id="navqs" style="margin-top: 10px;margin-left: 275px"> 
            <input type="hidden" name="qid<%=q_count%>" value="<%=qid[q_count]%>"/>
            <%if(q_count!=0){%>    
            <a href="javascript:void(0)" id="prevques" style="height:30px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:27px;border:2.75px #cccccc solid" onclick="divshow('<%=(q_count-1)%>','0');">&nbsp;&nbsp;Previous&nbsp;&nbsp;</a>
            <%}%>
            <%if(q_count!=199){%>
            <a href="javascript:void(0)" id="nextques" style="height:30px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:27px;border:2.75px #cccccc solid" onclick="divshow('<%=(q_count+1)%>','1');">&nbsp;&nbsp;Next&nbsp;&nbsp;</a>
            <%}%>
            <a href="javascript:void(0)" id="delques<%=q_count%>" style="height:30px;width:200px;background-color: #66ffff;text-decoration: none;border-radius: 12px;color:black;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:27px;border:2.75px #cccccc solid" onclick="delqs('<%=q_count%>');">&nbsp;&nbsp;Delete&nbsp;&nbsp;</a>
            </div>
            <input type="hidden" id="delmkr<%=q_count%>" name="delmkr<%=q_count%>" value="0"/>
            <input id="smt" type="submit" value="SUBMIT" style="margin-top:-32.5px;margin-left: 650px;margin-bottom: 25px"/>
        </div>
        <%
        q_count++;
        qid[q_count]=qid[q_count-1]+1;
        }
        %>
        <%for(int i=0;i<maxq;i++){%>
            <input type="hidden" name="qid<%=i%>" value="<%=qid[i]%>"/>
        <%}
        %>
    </form>
    </body>
</html>

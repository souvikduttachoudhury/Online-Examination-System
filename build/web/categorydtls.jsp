<%-- 
    Document   : categorydtls
    Created on : Jun 11, 2015, 12:31:15 PM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category Details</title>
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
                              if(document.getElementById("name"+temp).value===""){
                                  alert("Field marked with * is mandatory");
                                  return false;
                              }      
                              qs.push(id);
                              count++;
                              //alert("Fields Marked with * are compulsory.Continue?");
                              document.getElementById("nextstud"+temp).innerHTML="&nbsp;&nbsp;Next&nbsp;&nbsp;";
                          }
                          else{
                              if(document.getElementById("name"+temp).value===""){
                                  alert("Field marked with * is mandatory");
                              }  
                          }
                    }
                    else{
                        var temp=parseInt(id)+1;
                        if(document.getElementById("name"+temp).value===""){
                                  alert("Field marked with * is mandatory");
                              }  
                    }
                    $("#sd"+div_ct).hide();
                    $("#sd"+id).show();
                    div_ct=id;
            }
            $(document).ready(function(){
                 count++;
                 qs.push(div_ct);
                 $("#sd0").show();
               for(var i=1;i<20;i++){
                   $("#sd"+i).hide();
               } 
            });
            function validate(){
                if(count===1){
                    var temp=0;
                    if(document.getElementById("name"+temp).value===""){
                        alert("Field marked with * is mandatory");
                    } 
                }
                document.getElementById("cat_ct").value=count;
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
    <%!int ct,cat_code[],cat_ct=0,mod_ct=0,mod_code;%><%!String name[],qual[],stream[],dobd[],dobm[],doby[],fname[],addr1[],addr2[],addr3[],addr4[];%>
    <%!String addr_pin[],email[],phno[],pic_file[];%><%!String mod;%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
             username=request.getParameter("username");
             emp_name=request.getParameter("emp_name");
             emp_dept=request.getParameter("emp_dept");
             emp_desg=request.getParameter("emp_desg");
             dept_code=request.getParameter("dept_code");
             mod_code=Integer.parseInt(request.getParameter("mod_code"));
             Connection conn = null;
             PreparedStatement ps = null;
             ResultSet rs = null;
             try {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
             conn.setAutoCommit(false);
             cat_code=new int[200];
             ps = conn.prepareStatement ("SELECT MODULE_DESC FROM OES_MODULE_MST WHERE MODULE_CD=?");
             ps.setString(1, Integer.toString(mod_code));
             rs=ps.executeQuery();
             while(rs.next()){
               mod=rs.getString("MODULE_DESC");
             }
             //mod_code=new int[200];
             ps = conn.prepareStatement ("SELECT CATEGORY_CD FROM OES_CATEGORY_MST WHERE MODULE_CD=?");
             ps.setString(1, Integer.toString(mod_code));
             rs = ps.executeQuery();
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
     <form action="submitcatdtl.jsp" method="post" onsubmit="return validate();">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input type="hidden" name="mod_code" value="<%=mod_code%>"/>
        <input id="cat_ct" type="hidden" name="cat_ct"/>
        <%
        cat_ct=0;
        while(cat_ct<20){
        cat_code[cat_ct]=cat_ct+ct+1;
        %>
        <input type="hidden" name="cat_code<%=cat_ct%>" value="<%=cat_code[cat_ct]%>"/>
        <div id="sd<%=cat_ct%>">
            <h3 id="head" style="text-align:center;color:#000066;font-weight: bold;margin-bottom: -40px;margin-top: -20px"><u>Category Entry Page</u></h3><br/><br/>
            <h3 id="head" style="text-align:center;color:#000066;font-weight: bold;margin-bottom: -40px;">Module : <span style="color:#009900"><%=mod%></span></h3>
            <div id="field" style="margin-left:65px;margin-top: 75px;height: 100px;margin-right: -100px" >
                <span id="rw" style="color:#0000ff;font-size: 25px;font-family: Calibri;">Category:-<span style="color:red">*</span>&nbsp;</span><input type="text" id="name<%=cat_ct%>" name="name<%=cat_ct%>" style="background: white;border-radius: 10px;border-color:black;padding:0.5px;border-width: 1.5px;font-size: 20px;font-family: Times New Roman;  height:30px;width:525px;margin-left: 10px;" placeholder="                                  Category   "/>
            </div>
            <div id="navqs" style="margin-top: 10px;margin-left: 275px"> 
            <%if(cat_ct!=0){%>    
            <a href="javascript:void(0)" id="prevstud" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="divshow('<%=(cat_ct-1)%>','0');">&nbsp;&nbsp;Previous&nbsp;&nbsp;</a>
            <%}%>
            <%if(cat_ct!=199){%>
            <a href="javascript:void(0)" id="nextstud<%=cat_ct%>" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="divshow('<%=(cat_ct+1)%>','1');">&nbsp;&nbsp;New&nbsp;&nbsp;</a>
            <%}%>
            </div>
            <input id="smt" type="submit" value="SUBMIT" style="margin-top:-32.5px;margin-left: 520px;margin-bottom: 25px"/>
        </div>            
        <% 
         cat_ct++;
        }%>
    </form>
    </body>
</html>

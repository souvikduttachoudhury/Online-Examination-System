<%-- 
    Document   : submitinstedit
    Created on : Jun 26, 2015, 11:46:55 AM
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
            function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function submit_dtlssd(){
                window.setTimeout('document.formsd.submit()',0);
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
        <title>Submitted</title>
    </head>
    <%!String emp_name="";%><%!String dept_code="";%><%!String desg_code="";%>
    <%!String emp_dept="";%><%!String emp_desg="";%><%!String username="";%><%!String password="";%>
    <%!int student_code,student_ct=0,inst_ct=0,ct=0;%><%!String name,qual,stream,dobd,dobm,doby,fname,inst_cd,addr1,addr2,addr3,addr4;%>
    <%!String addr_pin,email,phno,pic_file;%><%!String inst,date="YYYY-MM-DD";%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            username=request.getParameter("username");
            emp_name=request.getParameter("emp_name");
            emp_dept=request.getParameter("emp_dept");
            emp_desg=request.getParameter("emp_desg");
            dept_code=request.getParameter("dept_code");
            inst_cd=request.getParameter("inst_cd");
            //student_code=Integer.parseInt(request.getParameter("student_code"));
           // for(int k=0;k<student_ct;k++){
                //student_code=Integer.parseInt(request.getParameter("student_code"));
            name=request.getParameter("name");
            addr1=request.getParameter("addr1");
            addr2=request.getParameter("addr2");
            addr3=request.getParameter("addr3");
            addr4=request.getParameter("addr4");
            addr_pin=request.getParameter("addr_pin");
            email=request.getParameter("email");
            phno=request.getParameter("phno");
               // pic_file[k]=request.getParameter("pic_file"+k);
           // }
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
           // for(int i=0;i<student_ct;i++){
               //out.print("ccccccccccccccccccccccc"+student_ct+""+student_code[i]+""+name[i]+""+qual[i]+""+stream[i]+""+fname[i]+""+inst_cd[i]+""+addr1[i]+""+addr2[i]+""+addr3[i]+""+addr4[i]+""+addr_pin[i]+""+email[i]+""+phno[i]+""+pic_file[i]+""+username);
               ps = conn.prepareStatement("UPDATE OES_INSTITUTE_MST SET INSTITUTE_NAME='"+name+"',INSTITUTE_ADDR1='"+addr1+"',INSTITUTE_ADDR2='"+addr2+"',INSTITUTE_ADDR3='"+addr3+"',INSTITUTE_ADDR4='"+addr4+"',INSTITUTE_ADDR_PIN='"+addr_pin+"',INSTITUTE_EMAIL='"+email+"',INSTITUTE_PHNO='"+phno+"' WHERE INSTITUTE_CD='"+inst_cd+"'");
               ps.executeUpdate();
               //date="1111-01-01";
               /*if(!dobd.equals(""))
               {
                   //&&(Integer.parseInt(dobm[i])>0)&&(Integer.parseInt(dobm[i])<13)&&(Integer.parseInt(dobd[i])>0)&&(Integer.parseInt(dobd[i])<32)&&(Integer.parseInt(doby[i])>0)
                   date=dobd.substring(0,2)+"-"+dobd.substring(3, 5)+"-"+dobd.substring(6, 10);
               }
               else
               {
                   date="1111-01-01";
                   //out.println(date);
               }
               //out.print("aaaaaaaaaaaaaaa      "+date+"name:"+student_code[i]);
               ps = conn.prepareStatement("UPDATE OES_STUDENT_MST SET STUDENT_DOB=TO_DATE('"+date+"','MM-DD-YYYY') WHERE STUDENT_CD="+student_code+"");
               ps.executeUpdate();*/
            // }
            // ps = conn.prepareStatement("UPDATE OES_LAST_ID SET LAST_STUDENT_CD="+student_code[student_ct-1]+",UPD_BY='"+username+"' WHERE LAST_STUDENT_CD="+(student_code[0]-1)+"");
            // ps.executeUpdate();
            } 
            catch (Exception e) {
                 e.printStackTrace();
                 System.out.println("                            Exception Caught");
            }
            finally {
            if (conn!=null)    conn.commit(); 
            if (rs!=null)      rs.close();
            if (ps!=null)      ps.close();
            if (conn!=null)    conn.close();
            }
    %>
    <body id="bcg" style="background-image: url(back6.jpg);opacity: 5">
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
        <form id="formsd" name="formsd" method="post" action="institutedtlselect.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        </form>
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
        
                <h1 id="head">Institute Details Edited Succesfully...</h1>
                <div id="slct_task" style="margin-top: 200px;margin-left: 37.5%">  
                <a href="javascript:void(0)" id="morestud" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlssd();">&nbsp;&nbsp;Edit more Institutes&nbsp;&nbsp;</a>
                </div> 
    
    </body>
<
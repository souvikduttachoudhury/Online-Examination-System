<%-- 
    Document   : submitinstdtl
    Created on : Jun 11, 2015, 9:24:17 AM
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
                window.setTimeout('document.formid.submit()',0);
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
    <%!int inst_ct=0;%><%!String name[],qual[],inst_code[],stream[],dobd[],dobm[],doby[],fname[],inst_cd[],addr1[],addr2[],addr3[],addr4[];%>
    <%!String addr_pin[],email[],phno[],pic_file[];%><%!String inst[],date="YYYY-MM-DD";%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            username=request.getParameter("username");
            emp_name=request.getParameter("emp_name");
            emp_dept=request.getParameter("emp_dept");
            emp_desg=request.getParameter("emp_desg");
            dept_code=request.getParameter("dept_code");
            inst_ct=Integer.parseInt(request.getParameter("inst_ct"));
            inst_code=new String[inst_ct];
            name=new String[inst_ct];
            inst_cd=new String[inst_ct];
            addr1=new String[inst_ct];
            addr2=new String[inst_ct];
            addr3=new String[inst_ct];
            addr4=new String[inst_ct];
            addr_pin=new String[inst_ct];
            email=new String[inst_ct];
            phno=new String[inst_ct];
            for(int k=0;k<inst_ct;k++){
                inst_cd[k]=request.getParameter("inst_cd"+k);
                name[k]=request.getParameter("name"+k);
                addr1[k]=request.getParameter("addr1"+k);
                addr2[k]=request.getParameter("addr2"+k);
                addr3[k]=request.getParameter("addr3"+k);
                addr4[k]=request.getParameter("addr4"+k);
                addr_pin[k]=request.getParameter("addr_pin"+k);
                email[k]=request.getParameter("email"+k);
                phno[k]=request.getParameter("phno"+k);
            }
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            for(int i=0;i<inst_ct;i++){
               //out.print("ccccccccccccccccccccccc"+student_ct+""+student_code[i]+""+name[i]+""+qual[i]+""+stream[i]+""+fname[i]+""+inst_cd[i]+""+addr1[i]+""+addr2[i]+""+addr3[i]+""+addr4[i]+""+addr_pin[i]+""+email[i]+""+phno[i]+""+pic_file[i]+""+username);
               ps = conn.prepareStatement("INSERT INTO OES_INSTITUTE_MST(INSTITUTE_CD,INSTITUTE_NAME,INSTITUTE_ADDR1,INSTITUTE_ADDR2,INSTITUTE_ADDR3,INSTITUTE_ADDR4,INSTITUTE_ADDR_PIN,INSTITUTE_EMAIL,INSTITUTE_PHNO,CRT_BY) VALUES('"+inst_cd[i]+"','"+name[i]+"','"+addr1[i]+"','"+addr2[i]+"','"+addr3[i]+"','"+addr4[i]+"','"+addr_pin[i]+"','"+email[i]+"','"+phno[i]+"','"+username+"')");
               ps.executeUpdate();
               //date="1111-01-01";
               /*if(((!doby[i].equals("")) && (!dobm[i].equals("")) && (!dobd[i].equals(""))))
               {
                   //&&(Integer.parseInt(dobm[i])>0)&&(Integer.parseInt(dobm[i])<13)&&(Integer.parseInt(dobd[i])>0)&&(Integer.parseInt(dobd[i])<32)&&(Integer.parseInt(doby[i])>0)
                   date=doby[i]+"-"+dobm[i]+"-"+dobd[i];
               }
               else
               {
                   date="1111-01-01";
                   //out.println(date);
               }
               //out.print("aaaaaaaaaaaaaaa      "+date+"name:"+student_code[i]);
               ps = conn.prepareStatement("UPDATE OES_STUDENT_MST SET STUDENT_DOB=TO_DATE('"+date+"','YYYY-MM-DD') WHERE STUDENT_CD="+student_code[i]+"");
               ps.executeUpdate();*/
             }
             //ps = conn.prepareStatement("UPDATE OES_LAST_ID SET LAST_STUDENT_CD="+student_code[student_ct-1]+",UPD_BY='"+username+"' WHERE LAST_STUDENT_CD="+(student_code[0]-1)+"");
             //ps.executeUpdate();
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
        <form id="formid" name="formid" method="post" action="institutedtls.jsp">
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
                <h1 id="head">Institute Details Updated Succesfully...</h1>
                <div id="slct_task" style="margin-top: 200px;margin-left: 37.5%">  
                <a href="javascript:void(0)" id="moreinst" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlssd();">&nbsp;&nbsp;Add more Institutes&nbsp;&nbsp;</a>
                </div>  
    </body>
</html>
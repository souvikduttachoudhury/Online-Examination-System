<%-- 
    Document   : submitempdtl
    Created on : Jun 12, 2015, 10:33:39 AM
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
            function submit_dtlsed(){
                window.setTimeout('document.formed.submit()',0);
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
    <%!int ct,dept_ct=0,desg_ct=0,emp_ct=0;%><%!String name[],access_code[],passwd[],desg_cd[],dept_cd[],fromd[],fromm[],fromy[],dept[],emp_code[],desg[],uptod[],uptom[],uptoy[];%>
    <%!String addr_pin[],email[],phno[],pic_file[];%><%!String inst[],datef="YYYY-MM-DD",datet="YYYY-MM-DD";%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            username=request.getParameter("username");
            emp_name=request.getParameter("emp_name");
            emp_dept=request.getParameter("emp_dept");
            emp_desg=request.getParameter("emp_desg");
            dept_code=request.getParameter("dept_code");
            //emp_ct=Integer.parseInt(request.getParameter("emp_ct"));
            emp_ct=1;
            emp_code=new String[emp_ct];
            name=new String[emp_ct];
            passwd=new String[emp_ct];
            dept_cd=new String[emp_ct];
            desg_cd=new String[emp_ct];
            fromd=new String[emp_ct];
            fromm=new String[emp_ct];
            fromy=new String[emp_ct];
            uptod=new String[emp_ct];
            uptom=new String[emp_ct];
            uptoy=new String[emp_ct];
            access_code=new String[emp_ct];
            //for(int k=0;k<emp_ct;k++){
                emp_code[0]=request.getParameter("emp_code");
                name[0]=request.getParameter("name");
                passwd[0]=request.getParameter("passwd");
                dept_cd[0]=request.getParameter("dept_cd");
                desg_cd[0]=request.getParameter("desg_cd");
                //fromd[0]=request.getParameter("fromd");
                //fromm[0]=request.getParameter("fromm");
                fromy[0]=request.getParameter("fromy");
                uptod[0]=request.getParameter("uptod");
                uptom[0]=request.getParameter("uptom");
                uptoy[0]=request.getParameter("uptoy");
                access_code[0]=request.getParameter("access_code");
                //out.print("aaaaaaaaaaaaaaaaaaaa     ,"+emp_code[0]+","+name[0]+","+dept_cd[0]+","+desg_cd[0]+","+access_code[0]);
            //}
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            for(int i=0;i<1;i++){
               datef="YYYY-MM-DD";
               datet="YYYY-MM-DD";
               //out.print("ccccccccccccccccccccccc"+student_ct+""+student_code[i]+""+name[i]+""+qual[i]+""+stream[i]+""+fname[i]+""+inst_cd[i]+""+addr1[i]+""+addr2[i]+""+addr3[i]+""+addr4[i]+""+addr_pin[i]+""+email[i]+""+phno[i]+""+pic_file[i]+""+username);
               //ps = conn.prepareStatement("INSERT INTO OES_EMP_MST(EMP_CD,EMP_NAME,EMP_PASSWD,DEPT_CD,DESG_CD) VALUES('"+emp_code[i]+"','"+name[i]+"','"+passwd[i]+"','"+dept_cd[i]+"','"+desg_cd[i]+"')");
               //ps.executeUpdate();
               //date="1111-01-01";
               ps = conn.prepareStatement("INSERT INTO OES_USERS(EMP_CD,ACCESS_CD,CRT_BY) VALUES('"+emp_code[i]+"','"+access_code[i]+"','"+username+"')");
               ps.executeUpdate();
                if(!fromy[i].equals(""))
               {
                   //&&(Integer.parseInt(dobm[i])>0)&&(Integer.parseInt(dobm[i])<13)&&(Integer.parseInt(dobd[i])>0)&&(Integer.parseInt(dobd[i])<32)&&(Integer.parseInt(doby[i])>0)
                   datef=fromy[i].substring(0,2)+"-"+fromy[i].substring(3, 5)+"-"+fromy[i].substring(6, 10);
               }
               else
               {
                   datef="1111-01-01";
                   //out.println(date);
               }
                 if(!uptoy[i].equals(""))
               {
                   //&&(Integer.parseInt(dobm[i])>0)&&(Integer.parseInt(dobm[i])<13)&&(Integer.parseInt(dobd[i])>0)&&(Integer.parseInt(dobd[i])<32)&&(Integer.parseInt(doby[i])>0)
                   datet=uptoy[i].substring(0,2)+"-"+uptoy[i].substring(3, 5)+"-"+uptoy[i].substring(6, 10);
               }
               else
               {
                   datet="1111-01-01";
                   //out.println(date);
               }
               //out.print("aaaaaaaaaaaaaaa      "+date+"name:"+student_code[i]);
               ps = conn.prepareStatement("UPDATE OES_USERS SET EFF_FROM=TO_DATE('"+datef+"','DD-MM-YYYY'),EFF_UPTO=TO_DATE('"+datet+"','DD-MM-YYYY') WHERE EMP_CD="+emp_code[i]+"");
               ps.executeUpdate();
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
        <form id="formed" name="formed" method="post" action="employeedtls.jsp">
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
                <h1 id="head">Employee Details Updated Succesfully...</h1>
                <div id="slct_task" style="margin-top: 200px;margin-left: 37.5%">  
                <a href="javascript:void(0)" id="moreemp" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsed();">&nbsp;&nbsp;Add more Employees&nbsp;&nbsp;</a>
                </div>  
    </body>
</html>

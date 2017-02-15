<%-- 
    Document   : submitstudtl.jsp
    Created on : Jun 10, 2015, 11:17:17 AM
    Author     : abc
--%>

<%@page import="java.io.File"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
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
    <%!int upd_st=0,pswd,student_code[],student_ct=200,inst_ct=0,ct=0;%><%!String img_name="",name[],qual[],stream[],dobd[],dobm[],doby[],fname[],inst_cd[],addr1[],addr2[],addr3[],addr4[];%>
    <%!String fieldname,fieldvalue,fieldname1,fieldvalue1,addr_pin[],email[],phno[],pic_file[];%><%!String inst[],date="YYYY-MM-DD";%>
    <%
            student_code=new int[student_ct];
            name=new String[student_ct];
            inst_cd=new String[student_ct];
            qual=new String[student_ct];
            stream=new String[student_ct];
            dobd=new String[student_ct];
            dobm=new String[student_ct];
            doby=new String[student_ct];
            fname=new String[student_ct];
            addr1=new String[student_ct];
            addr2=new String[student_ct];
            addr3=new String[student_ct];
            addr4=new String[student_ct];
            addr_pin=new String[student_ct];
            email=new String[student_ct];
            phno=new String[student_ct];
            pic_file=new String[student_ct];
            try{
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                for(FileItem item : multiparts){
                    if(item.isFormField()){
                        fieldname = item.getFieldName();
                        fieldvalue = item.getString();
                        if(fieldname.equals("username")){
                            username=fieldvalue;
                        }
                        if(fieldname.equals("emp_name")){
                            emp_name=fieldvalue;
                        }if(fieldname.equals("emp_dept")){
                            emp_dept=fieldvalue;
                        }if(fieldname.equals("emp_desg")){
                            emp_desg=fieldvalue;
                        }
                        if(fieldname.equals("dept_code")){
                            dept_code=fieldvalue;
                        }
                        if(fieldname.equals("student_ct")){
                            student_ct=Integer.parseInt(fieldvalue);
                        }
                    }
                }
                fieldname="";
                fieldname="";
                    for(FileItem item1 : multiparts){
                        if(item1.isFormField()){
                        fieldname = item1.getFieldName();
                        fieldvalue = item1.getString();
                        for(int k=0;k<student_ct;k++){
                        if(fieldname.equals("student_code"+k)){
                           student_code[k]=Integer.parseInt(fieldvalue);
                        }
                        if(fieldname.equals("name"+k)){
                           name[k]=fieldvalue;
                        }
                        if(fieldname.equals("inst_cd"+k)){
                           inst_cd[k]=fieldvalue;
                        }
                        if(fieldname.equals("qual"+k)){
                           qual[k]=fieldvalue;
                        }
                        if(fieldname.equals("stream"+k)){
                           stream[k]=fieldvalue;
                        }
                        if(fieldname.equals("dobd"+k)){
                           dobd[k]=fieldvalue;
                        }
                        if(fieldname.equals("fname"+k)){
                           fname[k]=fieldvalue;
                        }
                        if(fieldname.equals("addr1"+k)){
                           addr1[k]=fieldvalue;
                        }
                         if(fieldname.equals("addr2"+k)){
                           addr2[k]=fieldvalue;
                        }
                         if(fieldname.equals("addr3"+k)){
                           addr3[k]=fieldvalue;
                        }
                        if(fieldname.equals("addr4"+k)){
                           addr4[k]=fieldvalue;
                        }
                        if(fieldname.equals("addr_pin"+k)){
                           addr_pin[k]=fieldvalue;
                        }
                        if(fieldname.equals("email"+k)){
                           email[k]=fieldvalue;
                        }
                         if(fieldname.equals("phno"+k)){
                           phno[k]=fieldvalue;
                        }
                        //dobd[k]=request.getParameter("dobd"+k);
                //dobm[k]=request.getParameter("dobm"+k);
                //doby[k]=request.getParameter("doby"+k);
                        //fname[k]=request.getParameter("fname"+k);
                        //addr1[k]=request.getParameter("addr1"+k);
                        //addr2[k]=request.getParameter("addr2"+k);
                        //addr3[k]=request.getParameter("addr3"+k);
                        //addr4[k]=request.getParameter("addr4"+k);
                        //addr_pin[k]=request.getParameter("addr_pin"+k);
                        //email[k]=request.getParameter("email"+k);
                        //phno[k]=request.getParameter("phno"+k);
                         pic_file[k]="nil";
                        }
                        }
                }
                for(FileItem item2 : multiparts){
                    if(!item2.isFormField()){
                        fieldname1=item2.getFieldName();
                        fieldvalue1=item2.getString();
                        for(int k=0;k<student_ct;k++){
                            if(fieldname1.equals("photo"+k)){
                            img_name = new File(item2.getName()).getName();
                            if (img_name!=null && !img_name.replace(" ","").equals("")) {
                                String filename = "C:"+File.separator+"Users"+File.separator+"CESC"+File.separator+"Documents"+File.separator+"NetBeansProjects"+File.separator+"OES"+File.separator+"web"+File.separator+img_name;
                                item2.write( new File(filename));
                            }
                            pic_file[k]=img_name;
                            }
                        }
                    }
                    fieldname1="";
                    fieldvalue1="";
                }
            } catch (Exception ex) {
                out.println("                            Exception Caught2");
            }
    %>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            /*username=request.getParameter("username");
            emp_name=request.getParameter("emp_name");
            emp_dept=request.getParameter("emp_dept");
            emp_desg=request.getParameter("emp_desg");
            dept_code=request.getParameter("dept_code");
            student_ct=Integer.parseInt(request.getParameter("student_ct"));*/
            /*for(int k=0;k<student_ct;k++){
                student_code[k]=7;//Integer.parseInt(request.getParameter("student_code"+k));
                name[k]=request.getParameter("name"+k);
                inst_cd[k]=request.getParameter("inst_cd"+k);
                qual[k]=request.getParameter("qual"+k);
                stream[k]=request.getParameter("stream"+k);
                dobd[k]=request.getParameter("dobd"+k);
                //dobm[k]=request.getParameter("dobm"+k);
                //doby[k]=request.getParameter("doby"+k);
                fname[k]=request.getParameter("fname"+k);
                addr1[k]=request.getParameter("addr1"+k);
                addr2[k]=request.getParameter("addr2"+k);
                addr3[k]=request.getParameter("addr3"+k);
                addr4[k]=request.getParameter("addr4"+k);
                addr_pin[k]=request.getParameter("addr_pin"+k);
                email[k]=request.getParameter("email"+k);
                phno[k]=request.getParameter("phno"+k);
                pic_file[k]="";
            }*/
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            //Random rn=new Random();
            for(int i=0;i<student_ct;i++){
               //pswd=rn.nextInt(10000);
               System.out.println(student_ct+""+student_code[i]+""+name[i]+""+qual[i]+""+stream[i]+""+dobd[i]+""+fname[i]+""+inst_cd[i]+""+addr1[i]+""+addr2[i]+""+addr3[i]+""+addr4[i]+""+addr_pin[i]+""+email[i]+""+phno[i]+""+pic_file[i]+""+username);
               ps = conn.prepareStatement("INSERT INTO OES_STUDENT_MST(STUDENT_CD,STUDENT_NAME,STUDENT_QUALIFICATION,STUDENT_STREAM,FATHER_NAME,INSTITUTE_CD,STUDENT_ADDR1,STUDENT_ADDR2,STUDENT_ADDR3,STUDENT_ADDR4,STUDENT_ADDR_PIN,STUDENT_EMAIL,STUDENT_PHNO,PIC_FILE,CRT_BY) VALUES("+student_code[i]+",'"+name[i]+"','"+qual[i]+"','"+stream[i]+"','"+fname[i]+"','"+inst_cd[i]+"','"+addr1[i]+"','"+addr2[i]+"','"+addr3[i]+"','"+addr4[i]+"','"+addr_pin[i]+"','"+email[i]+"','"+phno[i]+"','"+pic_file[i]+"','"+username+"')");
               upd_st=ps.executeUpdate();
               System.out.println(upd_st);
               date="1111-01-01";
               System.out.print(dobd[i]);
               if(!dobd[i].equals(""))
               {
                   //&&(Integer.parseInt(dobm[i])>0)&&(Integer.parseInt(dobm[i])<13)&&(Integer.parseInt(dobd[i])>0)&&(Integer.parseInt(dobd[i])<32)&&(Integer.parseInt(doby[i])>0)
                   date=dobd[i].substring(0,2)+"-"+dobd[i].substring(3, 5)+"-"+dobd[i].substring(6, 10);
               }
               else
               {
                   date="1111-01-01";
                   //out.println(date);
               }
               //out.print("aaaaaaaaaaaaaaa      "+date+"name:"+student_code[i]);
               ps = conn.prepareStatement("UPDATE OES_STUDENT_MST SET STUDENT_DOB=TO_DATE('"+date+"','DD-MM-YYYY') WHERE STUDENT_CD="+student_code[i]+"");
               ps.executeUpdate();
             }
             ps = conn.prepareStatement("UPDATE OES_LAST_ID SET LAST_STUDENT_CD="+student_code[student_ct-1]+",UPD_BY='"+username+"' WHERE LAST_STUDENT_CD="+(student_code[0]-1)+"");
             ps.executeUpdate();
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
        <form id="formsd" name="formsd" method="post" action="studentdtls.jsp">
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
                <h1 id="head">Student Details Updated Succesfully...</h1>
                <div id="slct_task" style="margin-top: 200px;margin-left: 37.5%">  
                <a href="javascript:void(0)" id="morestud" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlssd();">&nbsp;&nbsp;Add more students&nbsp;&nbsp;</a>
                </div>  
    </body>
</html>
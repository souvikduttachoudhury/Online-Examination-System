<%-- 
    Document   : submitques.jsp
    Created on : Jun 8, 2015, 9:58:14 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
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
            function submit_dtlsqb(){
                window.setTimeout('document.formqb.submit()',0);
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
     <%!int qid[],q_count,mod_code,cat_code;%><%!String qdesc[];%><%!String qfile[],opt[][],optfile[][];%><%!String delmkr[];%><%!int optnct[];%>
    <%!String username="";%><%!String img="",img_name="",fieldname="",fieldvalue="",fieldname1="",fieldvalue1="",emp_name="";%><%!String emp_dept="";%><%!String emp_desg="";%><%!String dept_code="";%>
    <%!String crct[][];%>
    <%
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
                        if(fieldname.equals("mod_code")){
                            mod_code=Integer.parseInt(fieldvalue);
                        }
                        if(fieldname.equals("cat_code")){
                            cat_code=Integer.parseInt(fieldvalue);
                        }
                        if(fieldname.equals("q_count")){
                            q_count=Integer.parseInt(fieldvalue);
                        }
                    }
                }
                    qid=new int[q_count];
                    qdesc=new String[q_count];
                    qfile=new String[q_count];
                    delmkr=new String[q_count];
                    optnct=new int[q_count];
                    opt=new String[q_count][10];
                    optfile=new String[q_count][10];
                    crct=new String[q_count][10];
                    for(FileItem item1 : multiparts){
                        if(item1.isFormField()){
                        fieldname = item1.getFieldName();
                        fieldvalue = item1.getString();
                        for(int k=0;k<q_count;k++){
                        if(fieldname.equals("qid"+k)){
                           qid[k]=Integer.parseInt(fieldvalue);
                        }
                        if(fieldname.equals("qdesc"+k)){
                           qdesc[k]=fieldvalue;
                        }
                        if(fieldname.equals("delmkr"+k)){
                           delmkr[k]=fieldvalue;
                        }
                        optnct[k]=0;
                        qfile[k]="nil";
                        for(FileItem item2:multiparts){
                           if(item2.isFormField()){ 
                           fieldname1=item2.getFieldName();
                           fieldvalue1=item2.getString();
                           //while(opt[k][optnct[k]]!=null){
                            if(fieldname1.equals("ans1"+k+""+optnct[k])){
                                opt[k][optnct[k]]=fieldvalue1;
                                optfile[k][optnct[k]]="";
                                crct[k][optnct[k]]="0";
                                optnct[k]++;
                            
                            }
                           }
                           
                         }
                        for(FileItem item2:multiparts){
                           if(item2.isFormField()){ 
                           fieldname1=item2.getFieldName();
                           fieldvalue1=item2.getString();
                           //while(opt[k][optnct[k]]!=null){
                            for(int r=0;r<optnct[k];r++){
                            if(fieldname1.equals("crct"+k+""+r)){
                                crct[k][r]=fieldvalue1;
                            }
                            }
                    //out.println("a                 "+opt[k][optnct[k]]+"   "+q_count+"   "+crct[k][optnct[k]]);
                        }
                        
                       }
                        
                      }
                     }
                    }         
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        fieldname=item.getFieldName();
                        fieldvalue=item.getString();
                        for(int k=0;k<q_count;k++){
                            if(fieldname.equals("qfile"+k)){
                            img_name = new File(item.getName()).getName();
                            if (img_name!=null && !img_name.replace(" ","").equals("")) {
                                String filename = "C:"+File.separator+"Users"+File.separator+"CESC"+File.separator+"Documents"+File.separator+"NetBeansProjects"+File.separator+"OES"+File.separator+"web"+File.separator+img_name;
                                item.write( new File(filename));
                            }
                            qfile[k]=img_name;
                            }
                            for(FileItem item2:multiparts){
                            if(!item2.isFormField()){ 
                            fieldname1=item2.getFieldName();
                            fieldvalue1=item2.getString();   
                           //while(opt[k][optnct[k]]!=null){
                            for(int r=0;r<optnct[k];r++){
                               if(fieldname1.equals("ans1file"+k+""+r)){
                                img = new File(item2.getName()).getName();
                                if (img!=null && !img.replace(" ","").equals("")) {
                                    String filename = "C:"+File.separator+"Users"+File.separator+"CESC"+File.separator+"Documents"+File.separator+"NetBeansProjects"+File.separator+"OES"+File.separator+"web"+File.separator+img;
                                    item2.write( new File(filename));
                                }
                                optfile[k][r]=img;
                                } 
                            }//out.println("a                 "+opt[k][optnct[k]]+"   "+q_count+"   "+crct[k][optnct[k]]);
                           }
                        
                        
                        }
                      }
                    }
                }
            }
            catch(Exception ex) {
                ex.printStackTrace();
                out.println("                            Exception Caught2");
            }
    %>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
           
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            //ps = conn.prepareStatement("INSERT INTO OES_QBANK() VALUES()");
            //ps.executeUpdate();
            for(int i=0;i<q_count;i++){
               // out.println(qid[i]+"          "+cat_code+"  "+qdesc[i]);
              System.out.println(qid[i]+","+qdesc[i]+","+qfile[i]+","+dept_code);
              ps = conn.prepareStatement("INSERT INTO OES_QBANK(DEPT_CD,MODULE_CD,CATEGORY_CD,QID,QDESC,QFILE,DEL_MKR,CRT_BY) VALUES('"+dept_code+"',"+mod_code+","+cat_code+","+qid[i]+",'"+qdesc[i]+"','"+qfile[i]+"','"+delmkr[i]+"','"+username+"')"); 
              ps.executeQuery();
              for(int k=0;k<optnct[i];k++){
                System.out.println(opt[i][k]+","+optfile[i][k]);  
               //out.println("a             "+qid[i]+"  "+opt[i][k]+"   "+optfile[i][k]+"   "+crct[i][k]);   
               ps = conn.prepareStatement("INSERT INTO OES_QBANK_ANS(QID,ANS_SRLNO,ANS1,ANS1FILE,ANS1_C,CRT_BY) VALUES("+qid[i]+","+(k+1)+",'"+opt[i][k]+"','"+optfile[i][k]+"',"+crct[i][k]+",'"+username+"')");
               ps.executeUpdate();
              }
             }
             ps = conn.prepareStatement("UPDATE OES_LAST_ID SET LAST_QID="+qid[q_count-1]+",UPD_BY='"+username+"' WHERE LAST_QID="+(qid[0]-1)+"");
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
        <form id="formqb" name="formqb" action="qbank_update.jsp">
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
                <h1 id="head">Question Bank Updated Succesfully...</h1>
                <div id="slct_task" style="margin-top: 200px;margin-left: 37.5%">  
                <a href="qbank_update.jsp" id="dept_lgn" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Comic Sans MS;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlsqb();">&nbsp;&nbsp;Add more questions&nbsp;&nbsp;</a>
                </div>  
    </body>
</html>

<%-- 
    Document   : paperdtls
    Created on : Jun 18, 2015, 11:48:10 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Paper Details</title>
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
            size=0;
            marks=0;
            correct = [];
            function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function initialize(v){
                count=parseInt(v);
                for(var i=0;i<count;i++){
                    correct[i]=1;
                }
            }
            function init_marks(m){
                marks=parseInt(m);
            }
            function check(id,indx){
                if(document.getElementById(id).checked){
                    count++;
                    correct[indx]=1;
                }
                else{
                    count--;
                    correct[indx]=0;
                    document.getElementById(id).name="";
                }
                document.getElementById("indcn").innerHTML="Total Added : "+count+", Marks : "+(marks*count);
            }
            function validate(){
                for(var i=0;i<200;i++){
                        if(correct[i]===1){
                            document.getElementById("qslct"+i).name="qid"+size;
                            size++;
                        }
                 }
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
            $(document).ready(function(){
               for(var i=0;i<200;i++){
                   correct.push(0);
               } 
            });
        </script>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
    </head>
    <%!String emp_name="";%><%!String dept_code="";%><%!String desg_code="";%>
    <%!String emp_dept="";%><%!String emp_desg="";%><%!String username="";%><%!String password="";%>
    <%!int exam_code,qmode,q_ct=0,grpsrl=1,marks=0,neg_marks=0,mod_code,qid[],cat_code,ct=0;%><%!String qdesc[],qfile[],dobd[],dobm[],doby[],fname[],inst_cd[],addr1[],addr2[],addr3[],addr4[];%>
    <%!String addr_pin[],email[],phno[],pic_file[];%><%!String dept_cd;%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
             username=request.getParameter("username");
             emp_name=request.getParameter("emp_name");
             emp_dept=request.getParameter("emp_dept");
             emp_desg=request.getParameter("emp_desg");
             dept_code=request.getParameter("dept_code");
             exam_code=Integer.parseInt(request.getParameter("exam_code"));
             dept_cd=request.getParameter("dept_cd");
             qmode=Integer.parseInt(request.getParameter("qmode"));
             grpsrl=Integer.parseInt(request.getParameter("grpsrl"));
             marks=Integer.parseInt(request.getParameter("marks"));
             neg_marks=Integer.parseInt(request.getParameter("neg_marks"));%>
             <script type="text/javascript">
                 init_marks('<%=marks%>');
             </script>
             <%
             Connection conn = null;
             PreparedStatement ps = null;
             ResultSet rs = null;
             try {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
             conn.setAutoCommit(false);
             ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_MST WHERE EXAM_CD="+exam_code+"");
             rs=ps.executeQuery();
             while(rs.next()){
                 mod_code=Integer.parseInt(rs.getString("MODULE_CD"));
                 cat_code=Integer.parseInt(rs.getString("CATEGORY_CD"));
             }
             //out.print("aaaaaaaaaaaaaaaaaaaaaaaaaaa                 "+exam_code+""+mod_code+""+cat_code);
             ps = conn.prepareStatement ("SELECT * FROM OES_QBANK WHERE MODULE_CD="+mod_code+" AND CATEGORY_CD="+cat_code+" AND DEL_MKR='0'");
             rs=ps.executeQuery();
             qid=new int[500];
             qdesc=new String[500];
             qfile=new String[500];
             ct=0;
             while(rs.next()){
               qid[ct]=Integer.parseInt(rs.getString("QID"));
               qdesc[ct]=rs.getString("QDESC");
               qfile[ct]=rs.getString("QFILE");
               ct++;
             }
             if(qmode==1){%>
             <script type="text/javascript"> 
                 initialize('<%=ct%>');
                 $(document).ready(function(){
                       document.getElementById("indcn").innerHTML="Total Added : "+"<%=ct%>"; 
                });
             </script>
             <%}
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
    <body id="bcg" style="background-image: url(back6.jpg);opacity: 20">
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
    <form action="submitpaperdtl.jsp" method="post" onsubmit="return validate();">
        <input type="hidden" name="username" value="<%=username%>"/>
        <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
        <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
        <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
        <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        <input type="hidden" name="exam_code" value="<%=exam_code%>"/>
        <input type="hidden" name="qmode" value="<%=qmode%>"/>
        <input type="hidden" name="grpsrl" value="<%=grpsrl%>"/>
        <input type="hidden" name="marks" value="<%=marks%>"/>
        <input type="hidden" name="neg_marks" value="<%=neg_marks%>"/>
        <input type="hidden" name="dept_cd" value="<%=dept_cd%>"/>
        <input type="hidden" name="mod_code" value="<%=mod_code%>"/>
        <input type="hidden" name="cat_code" value="<%=cat_code%>"/>
        <input id="q_ct" type="hidden" name="q_ct"/>
        <center>
        <div  style="color:#67b168;font-size: 30px;font-family: Calibri">Group : <%=grpsrl%></div>    
        <div id="indcn" style="color:#ff3333;font-size: 24px;font-family: Calibri"></div>
        <table border="1" style="color:black;font-size: 24px;font-family: Calibri"> 
            <tr style="color:blue;font-size: 25px;background: #66ffff;font-family: Calibri">
                <th><center>&nbsp;Added&nbsp;</center></th>
                <th><center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Questions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</center></th>    
            </tr>
            <tbody>
        <%
        for(int i=0;i<ct;i++){%>
        <tr>
            <td><center><input id="qslct<%=i%>" type="checkbox" style="width: 20px;height: 20px;" value="<%=qid[i]%>" onchange="check('qslct<%=i%>','<%=i%>')" <%if(qmode==1){%>checked<%}%>/></center></td>
            <td><center><%=qdesc[i]%></center></td>
        </tr>
        <% }%>
            </tbody>
        </table>
        </center>
            <input id="smt_ea" style="margin-top: 12%" type="submit" value="SUBMIT"/>
    </form>
    </body>
</html>
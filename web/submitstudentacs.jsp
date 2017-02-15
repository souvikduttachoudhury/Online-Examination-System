<%-- 
    Document   : submitstudentacs
    Created on : Jun 24, 2015, 1:16:21 PM
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
        <script type="text/javascript" src="jquery-latest_2.js"></script>
        <!--script type="text/javascript" src="jquery-ui.js"></script-->
        <!--link rel="stylesheet" type="text/css" href="jquery-ui.css"-->
        <script type="text/javascript" src="jquery.tablesorter.min.js"></script>
        <script type="text/javascript" src="jquery.tablesorter.pager.js"></script> 
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
            function printpage(){
                $('#pager').hide();
                $('#slct_task').hide();
                $('#btn').hide();
                $('#header').css('font-size','40px');
                document.getElementById("log").innerHTML="";
            }
            function pageset(){
                   var x=document.getElementById("pno").value;
                   //alert(x);
                   document.getElementById("pageno").innerHTML=x;
            }
        </script>
        <script type="text/javascript">
$(function() {
		$("table")
			.tablesorter({widthFixed: true, widgets: ['zebra']})
			.tablesorterPager({container: $("#pager")});
	});
</script>
<script type="text/javascript">

function searchRows(tblId) {
var tbl = document.getElementById(tblId);
var headRow = tbl.rows[1];
var arrayOfHTxt = new Array();
var arrayOfHtxtCellIndex = new Array();

for (var v = 0; v < headRow.cells.length; v++) {
 if (headRow.cells[v].getElementsByTagName('input')[0]) {
 var Htxtbox = headRow.cells[v].getElementsByTagName('input')[0];
  if (Htxtbox.value.replace(/^\s+|\s+$/g, '') !== '') {
    arrayOfHTxt.push(Htxtbox.value.replace(/^\s+|\s+$/g, ''));
    arrayOfHtxtCellIndex.push(v);
  }
 }
}

for (var i = 2; i < tbl.rows.length; i++) {
 
    tbl.rows[i].style.display = 'table-row';
 
    for (var v = 0; v < arrayOfHTxt.length; v++) {
 
        var CurCell = tbl.rows[i].cells[arrayOfHtxtCellIndex[v]];
 
        var CurCont = CurCell.innerHTML.replace(/<[^>]+>/g, "");
 
        var reg = new RegExp(arrayOfHTxt[v] + ".*", "i");
 
        if (CurCont.match(reg) === null) {
 
            tbl.rows[i].style.display = 'none';
 
       }
 
    }
 
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
    <%!int student_ct=0,student_code[],passwd[],exam_code;%><%!String prfx,name[],qual[],inst_code[],stream,inst_cd,addr1[],addr2[],addr3[],addr4[];%>
    <%!String today,addr_pin[],email[],phno[],pic_file[];%><%!String exam,inst,date="YYYY-MM-DD";%>
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
            exam=request.getParameter("exam");
            inst_cd=request.getParameter("inst_cd");
            inst=request.getParameter("inst");
            stream=request.getParameter("stream");
            student_ct=Integer.parseInt(request.getParameter("student_ct"));
            student_code=new int[student_ct];
            name=new String[student_ct];
            passwd=new int[student_ct];
            qual=new String[student_ct];
            phno=new String[student_ct];
            email=new String[student_ct];
            Date d1=new Date();
            today=d1.toString();
            today=today.substring(8, 10)+" "+today.substring(4,7)+","+today.substring(24);
            for(int k=0;k<student_ct;k++){
                student_code[k]=Integer.parseInt(request.getParameter("student_code"+k));
            }
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement("SELECT * FROM OES_EXAM_MST WHERE EXAM_CD="+exam_code+"");
            rs=ps.executeQuery();
            while(rs.next()){
                prfx=rs.getString("EXAM_CD_PREFIX");
            }
            Random rn=new Random();
            for(int i=0;i<student_ct;i++){
               //out.print("ccccccccccccccccccccccc"+student_ct+""+student_code[i]+""+name[i]+""+qual[i]+""+stream[i]+""+fname[i]+""+inst_cd[i]+""+addr1[i]+""+addr2[i]+""+addr3[i]+""+addr4[i]+""+addr_pin[i]+""+email[i]+""+phno[i]+""+pic_file[i]+""+username);
               ps = conn.prepareStatement("SELECT * FROM OES_STUDENT_MST WHERE STUDENT_CD=?");
               ps.setString(1, Integer.toString(student_code[i]));
               rs=ps.executeQuery();
               while(rs.next()){
                   name[i]=rs.getString("STUDENT_NAME");
                   qual[i]=rs.getString("STUDENT_QUALIFICATION");
                   email[i]=rs.getString("STUDENT_EMAIL");
                   if(email[i]==null){
                       email[i]="";
                   }
                   phno[i]=rs.getString("STUDENT_PHNO");
                   if(phno[i]==null){
                       phno[i]="";
                   }
               }
                   passwd[i]=rn.nextInt(10000);
                   ps = conn.prepareStatement("INSERT INTO OES_EXAM_STUDENT(EXAM_CD_PREFIX,EXAM_CD,STUDENT_CD,STUDENT_ID) VALUES('"+prfx+"',"+exam_code+","+student_code[i]+","+passwd[i]+")");
                   ps.executeUpdate();
             }
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
    <body id="bcg" style="background-color: white;opacity: 5">
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
        <form id="formid" name="formid" method="post" action="studentacslct.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
        </form>
       <div style="margin-left:80%; margin-top:-5px" class="bs-example">
        <ul class="nav nav-pills">
            <li class="dropdown">
                <a href="#" id="log" data-toggle="dropdown" class="dropdown-toggle"><%=emp_name%><b id="log" class="caret"></b></a>
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
      <img src="Rpg.png" style="margin-left: 2.5%" id="left_logo" alt="cesc"/>
    <img src="logo1.png" style="margin-right: 2.5%" id="right_logo" alt="rpg"/>
    <h2 id="header" style="text-align:center">Online Examination System</h2>
    <h1 id="head" style="text-align: center;color:#00ff00"><%=exam%></h1><br/>
    <div id="dt" style="margin-left:15%;font-size: 20px;font-family: Times New Roman;color:#262626"><span style="font-size: 20px;font-family: Times New Roman;color:#ff3333">Date:&nbsp;</span><%=today%></div><br/>              
      <center>
        <div  style="color:#006633;font-size: 25px;font-family: Calibri"><%=inst%></div> 
        <table border="1" style="color:black;font-size: 24px;font-family: Calibri" id="domainsTable1" class="tablesorter"> 
            <thead>
            <tr style="color:blue;font-size: 30px;background: #66ffff;font-family: Times New Roman"> 
                <th><center>&nbsp;Code&nbsp;</center></th>
                <th><center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</center></th> 
                <th><center>&nbsp;Qualification&nbsp;</center></th>
                <th><center>&nbsp;Stream&nbsp;</center></th>
                <th><center>&nbsp;Password&nbsp;</center></th>
                <th><center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</center></th>
                <th><center>&nbsp;Contact&nbsp;</center></th>
            </tr>
            </thead>
            <tbody>
        <%
        for(int i=0;i<student_ct;i++){%>
        <tr>
            <td><center><%=student_code[i]%></center></td>
            <td><center><%=name[i]%></center></td> 
            <td><center><%=qual[i]%></center></td>
            <td><center><%=stream%></center></td>
            <td><center><%=passwd[i]%></center></td>
            <td><center><%=email[i]%></center></td>
            <td><center><%=phno[i]%></center></td> 
        </tr>
        <% }%>
            </tbody>
        </table>
            <button id="btn" style="font-family:Arial;margin-top: 10%;width: 100px;font-size: 25px;height: 37.5px;color:#330033" class="btn-default" onclick="printpage(),window.print();"/><b>Print</b></button>    
            <center>
            <div  id="pager" style="position: relative;margin-bottom: 5%;margin-left: 40%" class="pager">
            <form>
                <img src="first.png" class="first"/>
                <img src="prev.png" class="prev"/>
                <input type="text" id="pno" class="pagedisplay" onchange="pageset();"/>
    		<img src="next.png" class="next"/>
    		<img src="last.png" class="last"/>
    		<select class="pagesize">
    			<option selected="selected"  value="10">10</option>
    			<option value="20">20</option>
    			<option value="30">30</option>
    			<option  value="40">40</option>
    		</select>
            </form>
            </div>    
            </center>     
               
    <div id="slct_task" style="margin-top: 5%;">  
        <a href="javascript:void(0)" id="moreinst" style="height:25px;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:22px;border:2.75px #cccccc solid" onclick="submit_dtlssd();">&nbsp;&nbsp;Grant more Students&nbsp;&nbsp;</a>
    </div>
       </center>  
    <div id="pageno" style="float:right;color:black;margin-top: 80%;margin-right: 4%;font-size: 20px;font-family: Times New Roman">1/1</div>
    </body>
</html>

<%-- 
    Document   : printresults
    Created on : Jun 22, 2015, 11:38:51 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>&nbsp;</title>
        <link rel="stylesheet" href="login.css" type="text/css"/>
        <link rel="stylesheet"  href="stylesheet.css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script src="jquery-1.11.1.js" type="text/javascript"></script>
        <script type="text/javascript" src="bootstrap.js"></script>
        <!--script type="text/javascript" src="jquery_1.js"></script>
        <script type="text/javascript" src="jquery-latest.js"></script>
        <script type="text/javascript" src="jquery-latest_1.js"></script-->
        <script type="text/javascript" src="jquery-latest_2.js"></script>
        <!--script type="text/javascript" src="jquery-ui.js"></script-->
        <!--link rel="stylesheet" type="text/css" href="jquery-ui.css"-->
        <script type="text/javascript" src="jquery.tablesorter.min.js"></script>
        <script type="text/javascript" src="jquery.tablesorter.pager.js"></script> 
        <!--link rel="stylesheet" href="styletable.css" type="text/css" media="print, projection, screen" /-->
        <script type="text/javascript">
            div_ct=0;
            count=0;
            qs = [];
            s = [];
            function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function divshow(id,flag){
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
                              var temp=parseInt(id)-1;
                              alert("Fields Marked with * are compulsory.Continue?");
                              document.getElementById("nextstud"+temp).innerHTML="&nbsp;&nbsp;Next&nbsp;&nbsp;";
                          }
                    }
                    $("#sd"+div_ct).hide();
                    $("#sd"+id).show();
                    div_ct=id;
            }
            function access(id1,id2,id3){
                if(document.getElementById(id2).value==="001"){
                    document.getElementById(id1).value="A";
                }
                else{
                    document.getElementById(id1).value="D";
                }
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
                $('#btn').hide();
                $('#header').css('font-size','32.5px');
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
    </head>
    <%!String emp_name="";%><%!String dept_code="";%><%!String desg_code="";%>
    <%!String emp_dept="";%><%!String emp_desg="";%><%!String username="";%><%!String password="";%>
    <%!String student_code[],marks[],rank[];%><%!int ct,dept_ct=0,desg_ct=0,emp_ct=0;%><%!String exam_cd,exam,exam_cd_prfx,exam_date,student_name[],institute_name[],passwd[],qual[],stream[],dept_cd[],fromd[],fromm[],fromy[],dept[],emp_code[],desg[],uptod[],uptom[],uptoy[];%>
    <%!String email[],phno[],pic_file[];%><%!String inst[],today;%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
             username=request.getParameter("username");
             emp_name=request.getParameter("emp_name");
             emp_dept=request.getParameter("emp_dept");
             emp_desg=request.getParameter("emp_desg");
             dept_code=request.getParameter("dept_code");
             exam_cd=request.getParameter("exam_cd");
             Date d1=new Date();
             today=d1.toString();
             today=today.substring(8, 10)+" "+today.substring(4,7)+","+today.substring(24);
             //out.println("aaaaaaaaa,"+exam_cd);
             Connection conn = null;
             PreparedStatement ps = null;
             ResultSet rs = null;
             try {
             Class.forName("oracle.jdbc.driver.OracleDriver");
             conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
             conn.setAutoCommit(false);
             ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_MST WHERE EXAM_CD=?");
             ps.setString(1, exam_cd);
             rs=ps.executeQuery();
             while(rs.next()){
                 exam_cd_prfx=rs.getString("EXAM_CD_PREFIX");
                 exam=rs.getString("EXAM_NAME");
                 exam_date=rs.getString("EXAM_DATE");
             }
             ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_STUDENT WHERE EXAM_CD="+exam_cd+" ORDER BY RANK");
             rs=ps.executeQuery();
             ct=0;
             student_code=new String[200];
             marks=new String[200];
             rank=new String[200];
             while(rs.next()){
               student_code[ct]=rs.getString("STUDENT_CD");
               marks[ct]=rs.getString("MARKS");
               rank[ct]=rs.getString("RANK");
               ct++;
             }
             student_name=new String[ct];
             qual=new String[ct];
             stream=new String[ct];
             institute_name=new String[ct];
             for(int i=0;i<ct;i++){
             ps = conn.prepareStatement ("SELECT * FROM OES_STUDENT_MST a,OES_INSTITUTE_MST b WHERE a.INSTITUTE_CD=b.INSTITUTE_CD AND a.STUDENT_CD=?");
             ps.setString(1, student_code[i]);
             rs=ps.executeQuery();
             while(rs.next()){
                 student_name[i]=rs.getString("STUDENT_NAME");
                 qual[i]=rs.getString("STUDENT_QUALIFICATION");
                 stream[i]=rs.getString("STUDENT_STREAM");
                 institute_name[i]=rs.getString("INSTITUTE_NAME");
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
    <body id="bcg" style="background-color: white;opacity: 10">
    <div style="margin-left:80%; margin-top:-5px" class="bs-example">
        <ul class="nav nav-pills">
            <li class="dropdown">
                <a id="log" href="#" data-toggle="dropdown" class="dropdown-toggle"><%=emp_name%><b id="log" class="caret"></b></a>
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
    <img src="Rpg.png" style="margin-left: 2.5%" id="left_logo" alt="cesc"/>
    <img src="logo1.png" style="margin-right: 2.5%" id="right_logo" alt="rpg"/>
    <h2 id="header" style="text-align: center">Online Examination System</h2>
    <h1 id="head" style="text-align: center;color:#00ff00"><%=exam%></h1><br/>
    <div id="dt" style="margin-left:15%;font-size: 20px;font-family: Times New Roman;color:#262626"><span style="font-size: 20px;font-family: Times New Roman;color:#ff3333">Date:&nbsp;</span><%=today%></div><br/> 
    <center>
            <table border="1" style=" width: 90%;color:black;font-size: 24px;font-family: Calibri" id="domainsTable1" class="tablesorter"> 
            <thead>
            <tr style="color:blue;font-size: 30px;background: #66ffff;font-family: Times New Roman">
                <th><center>&nbsp;Rank&nbsp;</center></th>
                <th><center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</center></th> 
                <th><center>&nbsp;&nbsp;&nbsp;Institute&nbsp;&nbsp;&nbsp;</center></th>
                <th><center>&nbsp;Qualification&nbsp;</center></th>
                <th><center>&nbsp;Stream&nbsp;</center></th>
                <th><center>&nbsp;Marks Obtained&nbsp;</center></th>
            </tr>
            </thead>
            <tbody>
            <%
            for(int i=0;i<ct;i++){
            if(rank[i]!=null && marks[i]!=null){%>
            <tr>
                <td><center><%=rank[i]%></center></td>
                <td><center><%=student_name[i]%></center></td>
                <td><center><%=institute_name[i]%></center></td>
                <td><center><%=qual[i]%></center></td>
                <td><center><%=stream[i]%></center></td>
                <td><center><%=marks[i]%></center></td>
            </tr>
            <%} 
            }%>
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
    </center>
    <div id="pageno" style="float:right;color:black;margin-top: 80%;margin-right: 4%;font-size: 20px;font-family: Times New Roman">1/1</div>
    </body>
</html>

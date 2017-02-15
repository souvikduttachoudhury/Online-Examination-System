<%-- 
    Document   : categorydtlselect
    Created on : Jun 11, 2015, 12:18:20 PM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Select Action</title>
        <link rel="stylesheet" href="login.css" type="text/css"/>
        <link rel="stylesheet"  href="stylesheet.css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="bootstrap.js"></script>
        <script type="text/javascript" src="jquery_1.js"></script>
        <script type="text/javascript" src="jquery-latest.js"></script>
        <script type="text/javascript" src="jquery-latest_1.js"></script>
        <script type="text/javascript" src="feedback_dialog.js"></script>
        <script type="text/javascript" src="multi-screen.js"></script>
        <script src="jquery-1.11.1.js" type="text/javascript"></script>
        <!--script src="jquery-1.11.1.js" type="text/javascript"></script-->
         <script type="text/javascript">
         function submit_dtls(){
                window.setTimeout('document.form1.submit()',0);
            }
            function slctdtl(){
                $('#slct_lgn').hide();
                $('#enter_ins_stu').show();
            }
            function submit_dtlssd(){
               $('#slct_lgn').hide();
                $('#enter_module').show();
            }
            function submit_dtlsh(access){
                if(access==='D'){
                window.setTimeout('document.formh.submit()',0);
                }
                else if(access==='A'){
                    window.setTimeout('document.formad.submit()',0);
                }
            }
            $(document).ready(function() {
                $('#mod_cd').change(function(event){
                 var module = $("select#mod_cd").val();
                $.post('try.jsp', {
                    mod_cd : module
                 }, function(data,status){
                  var json = eval('(' + data +')');
                     var select = $('#cat_code');
                      select.find('option').remove();
                      //alert(json.name1);
                     //$('<option>').val("").text("      -----------------------  ").appendTo(select);
                     $.each(json, function(index,value) {
                         var str=value.split(",");
                         //alert(str[0]);
                      $('<option>').val(str[0]).text(str[1]).appendTo(select);
                });
             });
             });
             //$('#enter_ins_stu').hide(); 
             //$('#enter_module').hide(); 
            });
            $(document).ready(function(){
               $('#enter_ins_stu').hide(); 
               $('#enter_module').hide(); 
            });
        </script>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.util.*"%>
    </head>
    <%!int mod_ct=0,cat_ct[];%><%!String mod[],name[][];%><%!int mod_code[],cat_code[][];%>
    <%
           if(session.getAttribute("code1").equals(null)){%>
            <jsp:forward page="login.jsp"/>
            <%}
            %>
            <script type="text/javascript">
                parent.showback();
            </script>
            <%
            String username=request.getParameter("username");
            String emp_name=request.getParameter("emp_name");
            String emp_dept=request.getParameter("emp_dept");
            String emp_desg=request.getParameter("emp_desg");
            String dept_code=request.getParameter("dept_code");
            mod=new String[200];
            mod_code=new int[200];
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_MODULE_MST");
            rs = ps.executeQuery();
            mod_ct=0;
            while(rs.next()){
            mod_code[mod_ct]=Integer.parseInt(rs.getString("MODULE_CD"));
            mod[mod_ct]=rs.getString("MODULE_DESC");
            //out.println("a               "+inst_cd[inst_ct]+""+inst[inst_ct]);
            mod_ct++;
            }  
        }
          /* for(int j=0;j<mod_ct;j++){
                  ps = conn.prepareStatement ("SELECT * FROM OES_CATEGORY_MST WHERE MODULE_CD=?");
                  ps.setString(1, Integer.toString(mod_code[j]));
                  rs=ps.executeQuery();
                  while(rs.next()){
                  cat_code[j][cat_ct[j]]=Integer.parseInt(rs.getString("CATEGORY_CD"));
                  cat[j][cat_ct[j]]=rs.getString("CATEGORY_DESC");
                  cat_ct[j]++;
               }
              }*/
            catch(Exception e){
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
        <div style="margin-left:85%; margin-top:-5px" class="bs-example">
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
    <form id="formsd" name="formcd" action="categorydtls.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
            <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
            <div id="enter_module" style="margin-top: -50px">
            <div id="usn_ea">Select Module:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="mod_code" id="mod_code">
                        <option value="">&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<mod_ct;k++){%>
                        <option  value="<%=mod_code[k]%>"/><%=mod[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
            </div>
                    <input id="smt_ea" type="submit" value="SUBMIT"/>
            </div>        
    </form>
    <center>                
    <div id="slct_lgn" style="margin-top: 17.5%;margin-left: -10%">
        <a href="javascript:void(0)" id="create" style="height:1.875%;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;padding:0.5px;border-width: 3.5px; font-size:27px;border:1.75px paleturquoise solid" onclick="submit_dtlssd();">&nbsp;&nbsp;Create New&nbsp;&nbsp;</a>
        <a href="javascript:void(0)" id="edit" style="margin-left: 10%;height:1.875%;width:200px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;padding:0.5px;border-width: 3.5px; font-weight: normal;font-size:27px;border:1.75px paleturquoise solid" onclick="slctdtl();">&nbsp;&nbsp;Edit Existing&nbsp;&nbsp;</a>
    </div>
    </center>    
    <form id="catupdate" method="post" action="categoryedit.jsp">            
        <div id="enter_ins_stu" style="margin-top: -50px">
                <div id="usn_ea">Select Module:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="mod_code" id="mod_cd">
                        <option value="">&nbsp;&nbsp;&nbsp;Choose
                        <%for(int k=0;k<mod_ct;k++){%>
                        <option  value="<%=mod_code[k]%>"/><%=mod[k]%>
                        <%}%>
                    </select>
                    <!--input id="mod" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:32.5px;width:200px;margin-left: 6.5px;" placeholder="     Module Code" type="number" name="mod_cd"/-->
                </div>
                    <div id="pwd_ea" style="font-family: Calibri;font-size: 25px">Select Category:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <select name="cat_code" id="cat_code">
                        <option value="">Choose
                        <%--for(int k=0;k<cat_ct[m];k++){%>
                        <option  value="<%=cat_code[m][k]%>"/><%=cat[m][k]%>
                        <%}--%>
                    </select>
                    <!--input id="cat" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:32.5px;width:200px;margin-left: 16px;" placeholder="      Category Code" type="number" name="cat_cd"/-->
                </div>
                <input type="hidden" name="username" value="<%=username%>"/>
                <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
                <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
                <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
                <input type="hidden" name="dept_code" value="<%=dept_code%>"/>
                <input id="smt_ea" type="submit" value="SUBMIT"/>
        </div>
    </form>
    <form id="form1" name="form1" action="profile.jsp">
            <input type="hidden" name="username" value="<%=username%>"/>
            <input type="hidden" name="emp_name" value="<%=emp_name%>"/>
            <input type="hidden" name="emp_dept" value="<%=emp_dept%>"/>
            <input type="hidden" name="emp_desg" value="<%=emp_desg%>"/>
    </form>            
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>General Instructions</title>
        <link rel="stylesheet" href="login.css" type="text/css"/>
         <link href="reset.css" type="text/css" rel="stylesheet" />
                
         <link href="multi_pg_style.css" type="text/css" rel="stylesheet" />
         <link href="multi-screen-css.css" type="text/css" rel="stylesheet" />
         <script type="text/javascript" src="jquery.js"></script>
         <script type="text/javascript" src="jquery-latest.js"></script>
         <script type="text/javascript" src="jquery-latest_1.js"></script>
         <script type="text/javascript" src="feedback_dialog.js"></script>
         <script type="text/javascript" src="multi-screen.js"></script>
         <script type="text/javascript" src="jquery-latest.js"></script>
         <script type="text/javascript">
           var flag=1; 
           function enable_proceed() {
                if (document.getElementById("accept_cb").checked) {
                    document.getElementById("proceed_btn").removeAttribute("disabled");
                } else {
                    document.getElementById("proceed_btn").setAttribute("disabled", "disabled");
                }
            }
            $(document).ready(function() {
                    function disableBack() { window.history.forward(); }
                    window.onload = disableBack();
                    window.onpageshow = function(evt) { if (evt.persisted) disableBack(); };
                    $(document).bind('contextmenu',function(e){
                    e.preventDefault();
                    });
                        window.onload = function () {
                        document.onkeydown = function (e) {
                        //alert(e.keyCode);    
                        return (e.which || e.keyCode) !== 116;
                    };
                };
                /*$(document).keyup(function(e){
                        if(e.which || e.keyCode===44){
                           $('body').hide();
                       }
                        $('body').show();
                    });*/
            });
            
           /* function noBack() { 
                var x=parent.geturl();
                //alert(x);
                //window.close();
                if(flag===1){
                parent.load(x);
                flag++;
                }
                //window.open (x,document.getElementById("MY_IFRAME").name,"status=1,toolbar=1");
            }*/
        </script>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
    </head>
    <body id="bcg" style="height:500px;background-color: lightskyblue;overflow-y: hidden" >
        <%!int q_count[];%><%!int t;%><%!int m;%><%!String r;%><%!int opt_count[][];%><%!String optn[][][],optfile[][][];%>
        <%!int grp_srl[],qid[][];%><%!int gr_ct=0,tq=0;%>
        <%!int exam_code,exam_min;%><%!String exam_cd_prfx;%><%!String instruction;%><%!String s7="",s8="";%>
        <%!int mod_code;%><%!int cat_code;%> 
        <% String s1=request.getParameter("Username");
           String s2=request.getParameter("Password");
           String s3="default";
           String s4="pswd";
           String s5="nme";
           String s6="exam_cd";
           String qdesc[][]=new String[30][100];
           String qfile[][]=new String[30][100];
           qid=new int[100][100];
           //out.println(s1.substring(1, 4));
        //if((!s1.equals("Souvik")&& !s1.equals("Souvik Dutta Choudhury")) || (!s2.equals(s1.substring(1,5)))){
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_STUDENT a,OES_EXAM_MST b WHERE a.EXAM_CD=b.EXAM_CD AND a.STUDENT_CD =?");
            ps.setString(1, s1);
            rs=ps.executeQuery();
            while(rs.next()){
                s3=rs.getString("STUDENT_CD");
                s8=rs.getString("EXAM_NAME");
                //s7=rs.getString("INSTITUTE_NAME");
             }
            if(s3.equals("default")){%>
                <!--jsp:forward page="login_redirect.jsp" /-->
                <%}
            ps = conn.prepareStatement ("SELECT STUDENT_ID,EXAM_CD FROM OES_EXAM_STUDENT WHERE STUDENT_CD =?");
            ps.setString(1, s1);
            //ps.setString(1, s4);
            rs=ps.executeQuery();
            while(rs.next()){
                s4=rs.getString("STUDENT_ID");
                s6=rs.getString("EXAM_CD");
             }
            if((!s4.equals(s2))||(s4.equals("pswd"))){%>
                <jsp:forward page="login_redirect.jsp"/>
            <%}
            ps = conn.prepareStatement ("SELECT * FROM OES_STUDENT_MST a,OES_INSTITUTE_MST b WHERE a.INSTITUTE_CD=b.INSTITUTE_CD AND a.STUDENT_CD=?");
            ps.setString(1,s1);
            rs=ps.executeQuery();
            while(rs.next()){
                s5=rs.getString("STUDENT_NAME");
                s7=rs.getString("INSTITUTE_NAME");
            }
            if(s6.equals("exam_cd")){%>
            <script>
                parent.noexm();
            </script>
            <jsp:forward page="login.jsp" />
            <%}
             s5=s5+"&nbsp;of&nbsp;"+s7;
            %>
            <script>
                parent.welcome('<%=s5%>');
                parent.setname('<%=s8%>');
            </script>
            <%
            session.setAttribute("code", s1);
            ps = conn.prepareStatement ("SELECT * FROM OES_EXAM_MST WHERE EXAM_CD=?");
            ps.setString(1, s6);
            rs=ps.executeQuery();
            while(rs.next()){
            exam_cd_prfx=rs.getString("EXAM_CD_PREFIX");
            exam_code=Integer.parseInt(rs.getString("EXAM_CD"));
            mod_code=Integer.parseInt(rs.getString("MODULE_CD"));
            cat_code=Integer.parseInt(rs.getString("CATEGORY_CD"));
            exam_min=Integer.parseInt(rs.getString("EXAM_PERIOD_MIN"));
            instruction=rs.getString("EXAM_INSTR");
            }
            grp_srl=new int[100];
            ps = conn.prepareStatement ("SELECT * FROM OES_PAPER_SUMM WHERE DEL_MKR='N' AND EXAM_CD=? ORDER BY GRPSRL");
            ps.setString(1, Integer.toString(exam_code));
            rs=ps.executeQuery();
            gr_ct=0;
            while(rs.next()){
                grp_srl[gr_ct]=Integer.parseInt(rs.getString("GRPSRL"));
                gr_ct++;
            }
                q_count=new int[gr_ct];
                optn=new String[100][200][10];
                optfile=new String[100][200][10];
                opt_count=new int[100][200];
                tq=0;
              for(int k=0;k<gr_ct;k++){
                q_count[k]=0;
                ps = conn.prepareStatement ("SELECT * FROM OES_PAPER_DET WHERE GRPSRL="+grp_srl[k]+" AND DEL_MKR='N' AND EXAM_CD=? ORDER BY GRPSRL");
                ps.setString(1, Integer.toString(exam_code));
                //System.out.println (exam_code);
                rs=ps.executeQuery();
                while(rs.next()){
                    qid[k][q_count[k]]=Integer.parseInt(rs.getString("QID"));
                    //out.print("aaaaaaaaa"+qid[k][q_count[k]]+"rs"+rs.getString("QID")+".........");
                    ps = conn.prepareStatement ("SELECT QDESC,QFILE FROM OES_QBANK WHERE DEL_MKR='0' AND QID =?");
                    ps.setString(1, Integer.toString(qid[k][q_count[k]]));
                    //out.println ("aaaaaaaaaaaa"+qid[k][q_count[k]]);
                    rs1=ps.executeQuery();
                    while(rs1.next()){
                        qdesc[k][q_count[k]]=rs1.getString("QDESC");
                        qfile[k][q_count[k]]=rs1.getString("QFILE");
                        //qid[k][q_count[k]]=Integer.parseInt(rs.getString("QID"));
                        ps = conn.prepareStatement ("SELECT ANS1,ANS1FILE FROM OES_QBANK_ANS WHERE QID =?");
                        ps.setString(1, Integer.toString(qid[k][q_count[k]]));
                        //System.out.println (qid[k][q_count[k]]);
                        rs2=ps.executeQuery();
                        opt_count[k][q_count[k]]=0;
                        while(rs2.next()){
                            qid[k][q_count[k]]=Integer.parseInt(rs.getString("QID"));
                            optn[k][q_count[k]][opt_count[k][q_count[k]]]=rs2.getString("ANS1");
                            optfile[k][q_count[k]][opt_count[k][q_count[k]]]=rs2.getString("ANS1FILE");
                            if(optn[k][q_count[k]][opt_count[k][q_count[k]]]!=null || optfile[k][q_count[k]][opt_count[k][q_count[k]]]!=null){
                            opt_count[k][q_count[k]]=opt_count[k][q_count[k]]+1;
                            }
                            //out.print("   qid:"+qid[k][q_count[k]]);
                        }
                    }
                    q_count[k]++;
                    tq++;
            }
                //out.print("aaaaaaaaaaaaaaaaaaa          "+q_count[k]);
           }
              /*for(int k=0;k<gr_ct;k++){
                  for(int n=0;n<q_count[k];n++){
                      out.println("ccccc"+qid[k][n]);
                  }
              }*/
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
        <form action="backbone.jsp">
                    <input type="hidden" name="student_name" value="<%=s5%>" />
                    <input type="hidden" id="welcome" value="welcome"/>
        </form>
                    
        <h1 style="text-align: center;color:blue;font-family:Times New Roman">General Instructions:-</h1>
        <table style="position: absolute;margin-left:100px;margin-top: -15%">
            <tr>
                <td><img src="hand.png" id="hb" style="margin-bottom: -20%"/></td>
                <td id="ins" style="font-family: Calibri;font-size: 20px">Usage of <b>mobile phones,calculators</b> or any other <b>electronic gadgets</b> is strictly prohibited.</td>
            </tr><br/><br/>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>            
                <td><img src="hand.png" id="hb" style="margin-bottom: -20%"/></td> 
                <td id="ins" style="font-family: Calibri;font-size: 20px">You shall not be allowed to leave the room untill the examination is over.</td>
            </tr><br/><br/>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td><img src="hand.png" id="hb" style="margin-bottom: -20%"/></td> 
                <td id="ins" style="font-family: Calibri;font-size: 20px">Check if your <b>Internet</b> Connection is working properly.Report to the Invigilator immediately before starting your test.</td>
            </tr><br/><br/>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td><img src="hand.png" id="hb" style="margin-bottom: -20%"/></td> 
                <td id="ins" style="font-family: Calibri;font-size: 20px">Close all web browsers and disable all plugins except the CESC's <b>OES</b> page.</td>
            </tr><br/><br/>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td><img src="hand.png" id="hb" style="margin-bottom: -20%"/></td> 
                <td id="ins" style="font-family: Calibri;font-size: 20px">Do not <b>refresh</b> or click the <b>back</b> button.</td>
            </tr><br/><br/>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td ><img src="hand.png" id="hb" style="margin-bottom: -20%"/></td> 
                <td id="ins" style="font-family: Calibri;font-size: 20px">Any kind of <b>unfair means</b> practiced during the examination period shall subject to <b>disqualification</b> of candidature.</td>
            </tr><br/><br/>
        </table>
        <div style="margin-top: 140px;margin-left: 400px;">
        <form method='post' action="exam_demo.jsp">
            <input type="checkbox" name="accept" value="default" id="accept_cb"  onclick="enable_proceed();"
                   style="border-radius: 1px;height: 20px;width:20px;margin-right: 10px"/> 
            <span id="tx">I have read the instructions carefully&nbsp&nbsp&nbsp;</span>
            <input type="hidden" name="gr_ct" value="<%=gr_ct%>"/>
            <%
               for(int k=0;k<gr_ct;k++){%>
               <input  id="qcount" type="hidden" name="quescount<%=k%>" value="<%=q_count[k]%>"/>
               <input type="hidden" name="grp_srl<%=k%>" value="<%=grp_srl[k]%>"/>
               <%
                for(int i=0;i<q_count[k];i++){
                t=opt_count[k][i];%>
                <input  type="hidden" name="Q<%=k%>,<%=i%>" value="<%=qdesc[k][i]%>" />
                <input  type="hidden" name="QF<%=k%>,<%=i%>" value="<%=qfile[k][i]%>" />
                <input  type="hidden" name="OC<%=k%>,<%=i%>" value="<%=t%>"/>
                <input  type="hidden" name="qid<%=k%>,<%=i%>" value="<%=qid[k][i]%>" />
                <%}
                for(int i=0;i<q_count[k];i++){
                    t=opt_count[k][i];
                    for(int j=0;j<t;j++){
                        r=optn[k][i][j];%>
                        <input type="hidden" name="O<%=k%>,<%=i%>,<%=j%>" value="<%=r%>"/>
                        <input type="hidden" name="OF<%=k%>,<%=i%>,<%=j%>" value="<%=optfile[k][i][j]%>"/>
                    <%}
                }
               }
            %>
            <input type="hidden" name="exam_code" value="<%=exam_code%>"/>
            <input type="hidden" name="mod_code" value="<%=mod_code%>"/>
            <input type="hidden" name="cat_code" value="<%=cat_code%>"/>
            <input type="hidden" name="exam_cd_prfx" value="<%=exam_cd_prfx%>"/>
            <input type="hidden" name="student_code" value="<%=s1%>"/>
            <input type="hidden" name="student_id" value="<%=s2%>"/>
            <input type="hidden" name="exam_min" value="<%=exam_min%>"/>
            <input type="hidden" name="instruction" value="<%=instruction%>"/>
            <input type="hidden" name="tq" value="<%=tq%>"/>
                <input type="submit" value="Proceed" class="nt" disabled="disabled" id="proceed_btn"/>
        </form>
        </div>
    </body>
</html>
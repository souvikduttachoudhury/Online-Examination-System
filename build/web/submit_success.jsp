<%-- 
    Document   : submit_success
    Created on : May 26, 2015, 4:28:52 PM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width: 100%;height:100%">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thank You</title>
                <link href="reset.css" type="text/css" rel="stylesheet" />
                <link rel="stylesheet" href="login.css" type="text/css"/>
                <link href="multi_pg_style.css" type="text/css" rel="stylesheet" />
                <link href="multi-screen-css.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="jquery-latest.js"></script>
		<script type="text/javascript" src="feedback_dialog.js"></script>
		<script type="text/javascript" src="multi-screen.js"></script>
                <script type="text/javascript">
                    $(document).ready(function() {
                    function disableBack() { window.history.forward(); }
                    window.onload = disableBack();
                    window.onpageshow = function(evt) { if (evt.persisted) disableBack(); };
                    $(document).bind('contextmenu',function(e){
                        e.preventDefault();
                    });
                        window.onload = function () {
                        document.onkeydown = function (e) {
                        return (e.which || e.keyCode) !== 116;
                    };
                    };
                });
                </script>
    </head>
    <body id="bcg" style="background-image: url(back4.jpg);background-size: 350% 350%;opacity: 500">
    <center>
        <center><h1 id="head" style="color:#ff6600">Congratulations</h1><br/><br/><br/></center>
        <center><h3 id="msg" align="center" style="color:#333333;font-weight: bold;font-size: 36px;margin: auto">You have successfully submitted your test.</h3><br/><br/><br/><br/></center>
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="java.sql.ResultSet"%>
        <%!String an[][],str[][];%>
        <%!String atmpt[];%>
        <%!String temp="0",test="def";%>
        <%!int at[],atc=0;%>
        <%!int qc[],count=0,opt,crt_ct[],tq=0;%>
        <%!int arr[],hash[],opt_ordr[];%>
        <%!int mrv[],crtans[][],optnct[][];%>
        <%!int grp_srl[],qid[][],qno[][];%><%!int gr_ct=0;%>
        <%!int exam_code;%><%!String exam_cd_prfx;%>
        <%!int mod_code,student_code,student_id;%><%!int cat_code;%>
        <%!int marks[];%><%!int neg_marks[],stud_rank[],stu_id[],stu_mrk[];%>
        <%!int marks_obtd;%><%!int grs_total[];%><%!int total_marks=0;%><%!int student_count=0;%>
        <%
               exam_cd_prfx=request.getParameter("exam_cd_prefix");
               exam_code=Integer.parseInt(request.getParameter("exam_code"));
               mod_code=Integer.parseInt(request.getParameter("mod_code"));
               cat_code=Integer.parseInt(request.getParameter("cat_code"));
               student_code=Integer.parseInt(request.getParameter("student_code"));
               student_id=Integer.parseInt(request.getParameter("student_id"));
               gr_ct=Integer.parseInt(request.getParameter("gr_ct"));
               tq=Integer.parseInt(request.getParameter("tq"));
        %>
        <%!int j=0,k=0,flag,attempted=0;%>
        <% 
            
            qc=new int[gr_ct];
            optnct=new int[gr_ct][200];
            an=new String[gr_ct][100];
            at=new int[gr_ct];
            marks=new int[gr_ct];
            neg_marks=new int[gr_ct];
            grs_total=new int[gr_ct];
            grp_srl=new int[gr_ct];
            atmpt=new String[gr_ct];
            crt_ct=new int[gr_ct];
            qid=new int[gr_ct][100];
            qno=new int[gr_ct][100];
            str=new String[gr_ct][100];
            crtans=new int[gr_ct][10];
            crt_ct=new int[gr_ct];
            atmpt=new String[gr_ct];
            stud_rank=new int[200];
            stu_id=new int[200];
            stu_mrk=new int[200];
            arr=new int[100];
            total_marks=0;
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@10.50.82.11:1521:sos2", "trainee", "trainee");
            conn.setAutoCommit(false);
            ps =conn.prepareStatement ("SELECT * FROM OES_STUDENT_QA WHERE STUDENT_ID=?");
            ps.setString(1, Integer.toString(student_id));
            rs=ps.executeQuery();
            test="def";
            while(rs.next()){
                test=rs.getString("STUDENT_ID");
            }
            if(test.equals("def")){
                ps =conn.prepareStatement ("INSERT INTO OES_STUDENT_QA(STUDENT_ID,CRT_BY) VALUES("+student_id+",'"+student_code+"')");
                ps.executeUpdate(); 
            }
            attempted=0;
            for(int g=0;g<gr_ct;g++){
            grp_srl[g]=Integer.parseInt(request.getParameter("grp_srl"+g));
            String total_qs=request.getParameter("tot_qs"+g);
            qc[g]=Integer.parseInt(total_qs);
            for(int l=0;l<qc[g];l++){
                optnct[g][l]=Integer.parseInt(request.getParameter("optnct"+g+","+l));
            }
            %>
            <%
                  at[g]=0;
                  for(int i=0;i<qc[g];i++){
                  qid[g][i]=Integer.parseInt(request.getParameter("qid"+g+","+i));
                  qno[g][i]=Integer.parseInt(request.getParameter("qno"+g+","+i));
                  //out.println(qid[i]+""+i+""+student_id);
                  ps =conn.prepareStatement ("UPDATE OES_STUDENT_QA SET QNO="+(i+1)+",QID="+qid[g][i]+" WHERE STUDENT_ID=?");
                  ps.setString(1, Integer.toString(student_id));
                  ps.executeUpdate();
                  opt_ordr=new int[optnct[g][i]];
                  for(int k=0;k<optnct[g][i];k++){
                      opt_ordr[k]=Integer.parseInt(request.getParameter("order"+i+""+k));
                      ps =conn.prepareStatement ("UPDATE OES_STUDENT_QA SET ANS"+(k+1)+"_SRLNO="+opt_ordr[k]+" WHERE STUDENT_ID="+student_id+" AND QID="+qid[g][i]);
                      ps.executeUpdate();
                   }
                  }
                  
                  for(int i=0;i<qc[g];i++){
                    an[g][i]=request.getParameter("ans"+g+","+i);
                    //out.println("aaaaaaaaaaaaaaaaaaa "+qc[0]+","+an[0][i]);
                    if((an[g][i].equals("1"))||(an[g][i].equals("2"))||(an[g][i].equals("3"))||(an[g][i].equals("4"))||(an[g][i].equals("5"))){
                        at[g]++;
                        for(int k=0;k<optnct[g][i];k++){
                            if(k==(Integer.parseInt(an[g][i])-1)){
                            ps =conn.prepareStatement ("UPDATE OES_STUDENT_QA SET ANS"+(k+1)+"_ST=1 WHERE STUDENT_ID="+student_id+" AND QID="+qid[g][i]);
                            ps.executeUpdate();
                            }
                            else{
                            ps = conn.prepareStatement ("UPDATE OES_STUDENT_QA SET ANS"+(k+1)+"_ST=0 WHERE STUDENT_ID="+student_id+" AND QID="+qid[g][i]);
                            ps.executeUpdate();
                            }
                        }
                    }
                    else{
                        for(int k=0;k<optnct[g][i];k++){    
                        ps = conn.prepareStatement ("UPDATE OES_STUDENT_QA SET ANS"+(k+1)+"_ST=0 WHERE STUDENT_ID="+student_id+" AND QID="+qid[g][i]);
                        ps.executeUpdate();
                        ps = conn.prepareStatement ("UPDATE OES_STUDENT_QA SET CORRECT_ANS='N' WHERE STUDENT_ID="+student_id+" AND QID="+qid[g][i]);
                        ps.executeUpdate();
                        }
                    }
                  }
                  atmpt[g]=Integer.toString(at[g]);
                  attempted+=at[g];
                  //out.print("aaaaaaaaaaaaaaaaaaa,"+atmpt);
                  crt_ct[g]=0;
                  for(int i=1;i<=qc[g];i++){   
                  ps = conn.prepareStatement ("SELECT ANS1_C FROM OES_QBANK_ANS WHERE QID =?");
                  ps.setString(1, Integer.toString(qid[g][i-1]));
                  System.out.println(g+","+qid[g][i-1]+",");
                  rs=ps.executeQuery();
                  opt=1;
                  while(rs.next()){
                      //out.println("         "+opt+"   "+student_id+"   "+qid[i-1]);
                  if((rs.getString("ANS1_C")).equals("1")){
                      crtans[g][i-1]=opt;
                      System.out.print(g+","+(i-1)+","+qid[g][i-1]);
                      ps = conn.prepareStatement ("UPDATE OES_STUDENT_QA SET ANS"+opt+"_C=1 WHERE STUDENT_ID="+student_id+" AND QID="+qid[g][i-1]);
                     // break;
                  }
                  else{
                      ps = conn.prepareStatement ("UPDATE OES_STUDENT_QA SET ANS"+opt+"_C=0 WHERE STUDENT_ID="+student_id+" AND QID="+qid[g][i-1]);
                  }
                  ps.executeUpdate();
                  opt++;
              }
                  
                  //out.print(qno[i-1]);
                  //ps = conn.prepareStatement ("UPDATE OES_STUDENT_QA SET QNO="+qno[i-1]+" WHERE QID="+qid[i-1]+"");
                  //ps.executeUpdate();
                  //out.print("aaaaaaaaaaaaaaaaaaaaaa   "+qno[g][i-1]);
                  if(an[g][qno[g][i-1]].equals(Integer.toString(crtans[g][i-1]))){
                      crtans[g][i-1]=0;
                      ps = conn.prepareStatement ("UPDATE OES_STUDENT_QA SET CORRECT_ANS='Y' WHERE STUDENT_ID="+student_id+" AND QID="+qid[g][i-1]);
                      ps.executeUpdate();
                      crt_ct[g]++;
                  }
                  else if(!an[g][qno[g][i-1]].equals("30")){
                      ps = conn.prepareStatement ("UPDATE OES_STUDENT_QA SET CORRECT_ANS='W' WHERE STUDENT_ID="+student_id+" AND QID="+qid[g][i-1]);
                      ps.executeUpdate();
                  }
                } 
                /*Assuming groupserial count is 1*/
                 ps = conn.prepareStatement ("SELECT MARKS,NEG_MARKS FROM OES_PAPER_SUMM WHERE GRPSRL="+grp_srl[g]+" AND EXAM_CD =?"); 
                 ps.setString(1, Integer.toString(exam_code));
                 rs=ps.executeQuery();
                 while(rs.next()){
                     marks[g]=Integer.parseInt(rs.getString("MARKS"));
                     neg_marks[g]=Integer.parseInt(rs.getString("NEG_MARKS"));
                        } 
                     grs_total[g]=0;
                 //for(int j=0;j<qc;j++){
                     grs_total[g]=(marks[g]*crt_ct[g])-((at[g]-crt_ct[g])*neg_marks[g]);
                     total_marks+=grs_total[g];
                     //System.out.print(marks[g]+","+grs_total[g]);
                     
                    } 
                     
                     ps = conn.prepareStatement ("UPDATE OES_EXAM_STUDENT SET MARKS="+total_marks+" WHERE STUDENT_CD="+student_code+" AND EXAM_CD="+exam_code+""); 
                     //ps.setString(1, "1");
                     ps.executeUpdate();
                     ps = conn.prepareStatement ("SELECT STUDENT_CD,MARKS FROM OES_EXAM_STUDENT WHERE MARKS IS NOT NULL AND EXAM_CD="+exam_code+"");
                     rs=ps.executeQuery();
                     while(rs.next()){
                         stu_id[student_count]=Integer.parseInt(rs.getString("STUDENT_CD"));
                         stu_mrk[student_count]=Integer.parseInt(rs.getString("MARKS"));
                         student_count=student_count+1;
                     }
                     for(int o_ct=0;o_ct<student_count-1;o_ct++){
                         for(int i_ct=o_ct+1;i_ct<student_count;i_ct++){
                             if(stu_mrk[o_ct]<stu_mrk[i_ct]){
                                 int temp=stu_mrk[o_ct];
                                 stu_mrk[o_ct]=stu_mrk[i_ct];
                                 stu_mrk[i_ct]=temp;
                                 temp=stu_id[o_ct];
                                 stu_id[o_ct]=stu_id[i_ct];
                                 stu_id[i_ct]=temp;
                             }
                         }
                     }
                     //out.print(stu_id[0]);
                     for(int c=0;c<student_count;c++){
                         int p=c+1;
                     ps = conn.prepareStatement ("UPDATE OES_EXAM_STUDENT SET RANK="+p+" WHERE STUDENT_CD="+stu_id[c]+" AND EXAM_CD="+exam_code+""); 
                     //ps.setString(1, "1");
                     ps.executeUpdate();
                     }
                 //};
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
            <% String s=request.getParameter("revqs");
                System.out.print("review:"+s);
                for(int i=0;i<s.length();i++){
                    k=i;
                    flag=0;
                    while(s.charAt(k)!='-' && k<s.length()){
                        k++;
                        flag++;
                    }
                    if(flag!=0 && i!=k){
                    arr[j]=Integer.parseInt(s.substring(i, k));
                    j++;
                    i=k;
                    }
                }
                mrv=new int[tq];
                hash=new int[1000];
                for(int i=0;i<1000;i++){
                    hash[i]=0;
                }
                for(int i=0;i<j;i++)
                {
                        hash[arr[i]]=1;
                }
                count=0;
                for(int i=0;i<1000;i++)
                {
                   if(hash[i]==1)
                     mrv[count++]=i;
                }
            %>
            
            <%--=s--%>
        <center>
            <div id="stats" style="color:#ff0033;font-size: 30px;margin: auto;">    
            <!--h4>Time Required to complete the TEST: 2 hours</h4-->
            <h4>Total number of Questions: <%=tq%></h4><br/>
            <h4>Questions attempted in total: <%=attempted%></h4><br/>
        <%
                for(int g=0;g<gr_ct;g++){%>
           <h4>No. of questions attempted in Section(<%=(g+1)%>): <%=atmpt[g]%></h4><br/>
           <!--h4>No. of questions attempted correctly: <%--=crt_ct[g]--%></h4><br/><br/-->
           <!--h4>Marks Obtained in Group (<%--=(g+1)--%>) : <%--=grs_total[g]--%></h4><br/><br/-->
                <%}
        %>
           <!--h4>No. of questions marked for Review: <%--=count--%></h4><br/><br/-->
           <!--h4>Marks Obtained in Total : <%--=total_marks--%></h4><br/><br/-->
        <h4></h4>
        </div>
        </center>
        <a href="login.jsp" style="margin-top: -10%;margin-bottom: 50px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;font-size:27px;border:2px threedlightshadow solid">&nbsp;&nbsp;Exit&nbsp;&nbsp;</a><br/><br/>
    </center>
    </body>
</html>

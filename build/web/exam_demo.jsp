<%-- 
    Document   : exam_demo.jsp
    Created on : May 23, 2015, 9:34:42 AM
    Author     : Souvik Dutta Choudhury
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width: 100%;height:100%">
    <head>
                <link href="reset.css" type="text/css" rel="stylesheet" />
                <link rel="stylesheet" href="login.css" type="text/css"/>
                <link href="multi_pg_style.css" type="text/css" rel="stylesheet" />
                <link href="multi-screen-css.css" type="text/css" rel="stylesheet" />
                <script type="text/javascript" src="jquery.js"></script>
		<script type="text/javascript" src="jquery-latest.js"></script>
                <script type="text/javascript" src="jquery-latest_1.js"></script>
		<script type="text/javascript" src="feedback_dialog.js"></script>
		<script type="text/javascript" src="multi-screen.js"></script>
                <script type="text/javascript">
                   rev = [];
                   str='-';
                   ct=0;
                   function review_invert(id,qc){
                          //var p=Integer.toString(id);
                          var x= document.getElementById(id).innerHTML;
                          var fl=0;
                          if(x==="&nbsp;&nbsp;Mark for Review"){
                              document.getElementById(id).innerHTML="&nbsp;&nbsp;Unmark";
                              for(var k=0;k<parseInt(qc);k++){
                              //alert("nav"+k+","+id);
                              $("#nav"+k+"_"+id).css('background-color','white');
                            }
                              for(var i=0;i<rev.length;i++)
                            {
                               if(rev[i]===id){
                                   fl++;
                               }
                            }
                              if(fl===0)
                              rev.push(id);
                          }
                       else{
                           document.getElementById(id).innerHTML="&nbsp;&nbsp;Mark for Review";
                           for(var k=0;k<parseInt(qc);k++){
                              $("#nav"+k+"_"+id).css('background-color','powderblue');
                          }
                           for(var i=0;i<rev.length;i++)
                           {
                               if(rev[i]===id){
                                   break;
                               }
                           }
                           rev.splice(i,1);
                       } 
                     };
                   function validate(){
                       var x=confirm("Are you sure you want to submit your paper?");
                       if(x===true){
                       str='-';
                       for(var i=0;i<rev.length;i++){
                           str=str+'-'+rev[i];
                       }
                       str=str+'-';
                       document.getElementById("rev_fwd").value=str;
                       str='-';
                       parent.stopTimer();
                       return true;
                       }
                       else{
                           return false;
                       }
                   };
                   function autovalidate(){
                       //var x=confirm("Are you sure you want to submit your paper?");
                      // if(x===true){
                       parent.stopTimer();
                       str='-';
                       for(var i=0;i<rev.length;i++){
                           str=str+'-'+rev[i];
                       }
                       str=str+'-';
                       document.getElementById("rev_fwd").value=str;
                       str='-';
                       return true;
                        //}
                   };
                   function autosubmit(hour,min,sec){
                       var h=(3600*(parseInt(hour)))+(60*(parseInt(min)))+(parseInt(sec));
                       h=h*1000;
                       window.setTimeout('autovalidate()',h);
                       window.setTimeout('document.f1.submit()',h);
                   };
                   function check(id1,val,id2){
                       if(document.getElementById(id1).checked===true){
                           ct++;
                           if(ct%2===0){
                           document.getElementById(id1).checked=false;
                           }
                           else{
                              //alert(val);
                              document.getElementById(id2).value=parseInt(val); 
                           }
                       }
                   };
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
                    /*$(document).keyup(function(e){
                       if(e.which===44 || e.keyCode===44){
                           $('body').hide();
                       }
                        $('body').show();
                    });*/
                });
                   
                </script>
                <script type="text/javascript">
		$(document).ready(function() { 
                        MultiScreen.init(); 
			$('#topleft-via-top').click(function () {

				MultiScreen.switch_screens(
					{target_id: 'top-screen', enter_animation_command: 'top', exit_animation_command: 'bottom', chain_animation_options: 
						{target_id: 'topleft-screen', enter_animation_command: 'left', exit_animation_command: 'right'}
					});

			});

			$('#right-via-bottomright').click(function () {

				MultiScreen.switch_screens(
					{target_id: 'bottomright-screen', enter_animation_command: 'bottomright', exit_animation_command: 'topleft', chain_animation_options: 
						{target_id: 'right-screen', enter_animation_command: 'top', exit_animation_command: 'bottom'}
					});

			});

			$('#go-crazy').click(function () {

				// inception...
				MultiScreen.switch_screens(
					{target_id: 'bottomright-screen', enter_animation_command: 'bottomright', exit_animation_command: 'topleft', chain_animation_options: 
						{target_id: 'right-screen', enter_animation_command: 'top', exit_animation_command: 'bottom',
							chain_animation_options: 
							{target_id: 'topright-screen', enter_animation_command: 'top', exit_animation_command: 'bottom',
								chain_animation_options: 
								{target_id: 'top-screen', enter_animation_command: 'left', exit_animation_command: 'right',
									chain_animation_options: 
									{target_id: 'topleft-screen', enter_animation_command: 'left', exit_animation_command: 'right',
										chain_animation_options: 
										{target_id: 'left-screen', enter_animation_command: 'bottom', exit_animation_command: 'top',
											chain_animation_options: 
											{target_id: 'bottomleft-screen', enter_animation_command: 'bottom', exit_animation_command: 'top',chain_animation_options: 
												{target_id: 'bottom-screen', enter_animation_command: 'right', exit_animation_command: 'left',chain_animation_options: 
													{target_id: 'center-screen', enter_animation_command: 'top', exit_animation_command: 'bottom'}
												}
											}
										}
									}
								}
							}
						}
					});

			});

		});

		</script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All the best!!</title>
         <%@page import="java.util.*"%>
    </head>
    <body id="bcg" style="background:url(bcg.jpg);height:50%;width:50%;opacity: 50">
        <%!int q_ct[];%><%!String q_count[];%><%!String optfile[][][],option[][][];%><%!int o_ct[][];%><%!String tmp;%><%!String tmp1;%> 
        <%!int grp_srl[],qid[][];%><%!int gr_ct=0;%>
        <%!int exam_code,exam_min,min,hr,tq,student_code,student_id;%><%!String exam_cd_prfx;%>
        <%!int mod_code;%><%!int cat_code,oc=0;%> 
        <%!int indx[],totq=0;%><%int rev[]=new int[200];%><%!String instruction="";%><%!String p="";%>
        <%
               try{if(session.getAttribute("code")==null){%>
               <jsp:forward page="login.jsp"/>
               <%} 
               }
               catch(Exception e){%>
                   <jsp:forward page="login.jsp"/>
               <%}
               finally{
               exam_cd_prfx=request.getParameter("exam_cd_prefix");
               exam_code=Integer.parseInt(request.getParameter("exam_code"));
               mod_code=Integer.parseInt(request.getParameter("mod_code"));
               cat_code=Integer.parseInt(request.getParameter("cat_code"));
               student_code=Integer.parseInt(request.getParameter("student_code"));
               student_id=Integer.parseInt(request.getParameter("student_id"));
               exam_min=Integer.parseInt(request.getParameter("exam_min"));
               instruction=request.getParameter("instruction");
               tq=Integer.parseInt(request.getParameter("tq"));
               gr_ct=Integer.parseInt(request.getParameter("gr_ct"));
               }
        %>
        <%
               min=exam_min%60;
               hr=exam_min/60;
               q_count=new String[gr_ct];
               q_ct=new int[gr_ct];
               o_ct=new int[gr_ct][100];
               option=new String[gr_ct][100][10];
               optfile=new String[gr_ct][100][10];
               String qdesc[][]=new String[gr_ct][100];
               String qfile[][]=new String[gr_ct][100];
               qid=new int[gr_ct][100];
               grp_srl=new int[gr_ct];
                //out.print("aaaaaaaaaaaaaaaaaaaaaaaaa              "+gr_ct);
               totq=0;
               for(int m=0;m<gr_ct;m++){
                q_count[m]=request.getParameter("quescount"+m);
                //out.print("aaaaaaaaaaaaaaaaa   "+q_count[m]);
                grp_srl[m]=Integer.parseInt(request.getParameter("grp_srl"+m));
                q_ct[m]=Integer.parseInt(q_count[m]);
                for(int j=0;j<q_ct[m];j++){
                    qdesc[m][j]=request.getParameter("Q"+m+","+j);
                    qfile[m][j]=request.getParameter("QF"+m+","+j);
                    System.out.println(qfile[m][j]);
                    qid[m][j]=Integer.parseInt(request.getParameter("qid"+m+","+j));
                    o_ct[m][j]=Integer.parseInt(request.getParameter("OC"+m+","+j));
                    for(int k=0;k<o_ct[m][j];k++){
                        option[m][j][k]=request.getParameter("O"+m+","+j+","+k);
                        optfile[m][j][k]=request.getParameter("OF"+m+","+j+","+k);
                    }
                };
                indx=new int[q_ct[m]];
                for(int k=0;k<q_ct[m];k++){
                    indx[k]=k;
                }
                Random rn = new Random();
                for (int i = q_ct[m]; i > 0; i--){
                int j = rn.nextInt(i);
                int tm=indx[j];
                indx[j]=indx[i-1];
                indx[i-1]=tm;
               }
        %>
        <%!int i=0;%><%String id[]=new String[q_ct[m]];%>
        <form id="f1" name="f1" action="submit_success.jsp" onsubmit="return validate();">
            <div id="welcome" class="ms-container ms-default">
                <h1 id="head" style="font-size:75px">Ready?</h1>
                <img src="Q-Meieriene logo.png" style="height: 35px;width:35px;margin-left: 50px;margin-top: 50px;"/>&nbsp;&nbsp;<h2 id="perm" style="font-family: Calibri;color:forestgreen;margin-left: 110px;margin-top:-75px;font-size: 35px;">Are you sure you want to start the test now?</h2>
                <% if(instruction!=null){
                   if(instruction.length()>10){%>
                   <table id="spec_ins" style="margin-left:140px;margin-top:50px;width:650px;font-family:Calibri;color:#ff0000;font-size:25px">
                   <%//for(int ct=0;ct<instruction.length();ct++){
                    int ct=0;
                    while(ct<instruction.length()){
                    //System.out.println("length:"+instruction.length()+","+ct);
                    p="";
                    while(instruction.charAt(ct)!='.' && ct<(instruction.length()-1)){
                    System.out.println("length:"+instruction.length()+","+ct);    
                    p=p+instruction.charAt(ct);
                    ct++;
                    }%>    
                   <tr>
                       <%if(p.length()>3){
                       p=p+".";%> 
                       <td><img src="hand.png" id="hb" style="margin-bottom:-20%"/></td>
                       <%}%>
                   <td>
                       <%=p%>
                       <br/><br/>
                   </td>
                   </tr>
                   <%p="";
                    ct++;
                   }%>
                   </table> 
                <%}
                }%>
                <a href="javascript:void(0)" data-ms-target="q<%=totq%>" data-ms-exit-animation="left" data-ms-enter-animation="right"  style="position: absolute;margin-left: 350px;margin-top: -5%;height:27px;width:185px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;font-size:27px;border:2px sienna solid" class="ms-nav-link" onclick="parent.timer('<%=hr%>','<%=min%>','0'),autosubmit('<%=hr%>','<%=min%>','0');">&nbsp;&nbsp;&nbsp;Yes,Start now</a>
            </div>
            <%for (int i=0; i<q_ct[m]; i++) {%>
            <%id[i]=Integer.toString(totq);%>
            <div id="q<%=totq%>" class="ms-container ms-default">
                <h1 id="head" style="font-family: Calibri;font-size:45px">Section <%=grp_srl[m]%></h1>
                <img src="Q-Meieriene logo.png" style="height: 30px;width:30px;margin-left: 50px;margin-top: 50px;"/><span style="position: absolute;color:#009933;margin-top: 46.5px;font-weight: bold;font-family:Calibri;font-size: 35px">&nbsp;<%=(totq+1)%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<h4 id="perm" style="font-family: Calibri;color:#333333;margin-left: 125px;margin-top:-37.5px;font-size: 40px;"><%=qdesc[m][indx[i]]%></h4><br/><%if(qfile[m][indx[i]]!=null){if(qfile[m][indx[i]].length()>5){%><img style="height:200px;width:400px;margin-left: 20%" src="<%=qfile[m][indx[i]]%>"/><%}}%><br/>
                <input type="hidden" name="qid<%=m%>,<%=i%>" value="<%=qid[m][indx[i]]%>"/>
                <input type="hidden" name="qno<%=m%>,<%=i%>" value="<%=indx[i]%>"/>
                <input type="hidden" name="optnct<%=m%>,<%=indx[i]%>" value="<%=o_ct[m][indx[i]]%>"/>
                <%
                    int opt_ordr[]=new int[o_ct[m][(indx[i])]];
                    for(int k=0;k<o_ct[m][(indx[i])];k++){
                    opt_ordr[k]=k;
                    }
                    for (int n=o_ct[m][indx[i]];n>0;n--){
                    int x = rn.nextInt(n);
                    int tm=opt_ordr[x];
                    opt_ordr[x]=opt_ordr[n-1];
                    opt_ordr[n-1]=tm;
                    }
                %>
                <div id="ipcls">
                    <%  for(int l=0;l<o_ct[m][indx[i]];l++){%>
                    <input type="radio" style="height:25px;width: 15px" id="rd_btn<%=m%>,<%=indx[i]%>,<%=opt_ordr[l]%>" onclick="check('rd_btn<%=m%>,<%=indx[i]%>,<%=opt_ordr[l]%>',this.value,'ani<%=m%>,<%=indx[i]%>')" name="ans<%=m%>,<%=indx[i]%>" value="<%=((opt_ordr[l])+1)%>"/>&nbsp;&nbsp;&nbsp;<%=option[m][indx[i]][opt_ordr[l]]%><br/><%if(optfile[m][indx[i]][opt_ordr[l]]!=null){if(optfile[m][indx[i]][opt_ordr[l]].length()>5){%><img style="height:200px;width:300px;margin-left: 20%": 15px" src="<%=optfile[m][indx[i]][opt_ordr[l]]%>"/><%}}%><br/>
                    <input type="hidden" name="order<%=indx[i]%><%=l%>" value="<%=opt_ordr[l]%>"/>
                    <%}%>
                    <input id="ani<%=m%>,<%=indx[i]%>" type="hidden" name="ans<%=m%>,<%=indx[i]%>" value="30"/>
                <a id="<%=id[i]%>" href="javascript:void(0)"  style="position:absolute;margin-left:9.5%;margin-top:22px;margin-bottom: -220px;height:27px;width:210px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;font-size:27px;border:2px paleturquoise solid" class="ms-nav-link" onclick="review_invert('<%=id[i]%>','<%=tq%>')">&nbsp;&nbsp;Mark for Review</a> 
                <%if(totq!=0){%>
                <a href="javascript:void(0)" data-ms-target="q<%=(totq-1)%>" data-ms-exit-animation="right" data-ms-enter-animation="left"  style="position: absolute;margin-left: 29.75%;margin-top:  22px;margin-bottom: -220px;height:27px;width:110px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;font-size:27px;border:2px solid paleturquoise" class="ms-nav-link">&nbsp;Previous&nbsp;&nbsp;</a>
                <%}%>
                <%if(totq!=(tq-1)){
                %>
                <a href="javascript:void(0)" data-ms-target="q<%=(totq+1)%>" data-ms-exit-animation="left" data-ms-enter-animation="right"  style="position: absolute;margin-left: 500px;margin-top:  20px;margin-bottom: -220px;height:27px;width:90px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;font-size:27px;border:2px paleturquoise solid" class="ms-nav-link">&nbsp;&nbsp;&nbsp;Next</a>
                <%}%>
                <% if(totq!=(tq-1)){%>
                <input type="submit" style="position: absolute;margin-left: 29.75%;margin-top:  70px;margin-bottom: 5px;height:35px;width:105px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;font-size:27px;border:2px threedlightshadow solid" value="&nbsp;Submit&nbsp;&nbsp;&nbsp"/>
                <%}
                else{%>
                <input type="submit" style="position: absolute;margin-left: 500px;margin-top:  22px;margin-bottom: -220px;height:35px;width:105px;background-color: palegreen;text-decoration: none;border-radius: 12px;color:blue;font-family: Calibri;font-weight: normal;font-size:27px;border:2px threedlightshadow solid" value="&nbsp;Submit&nbsp;&nbsp;&nbsp"/>
                <%}%>
                </div>
                 <div id="qnav" style="float:right;margin-right: 50px;margin-top: 11.875%;margin-bottom: 15px;margin-left: 50px">
                    <% for(int k=0;k<tq;k++){%>
                    <a id="nav<%=totq%>_<%=k%>" href="javascript:void(0)"   data-ms-target="q<%=k%>" data-ms-exit-animation="none" data-ms-enter-animation="none" style="height:55px;width:55px;text-decoration: none;color:red;font-family: Calibri;font-weight: normal;font-size:27px;border-radius: 5px;background-color:powderblue;border-spacing: 1px;border: 2px solid blue" class="ms-nav-link">&nbsp;<%=(k+1)%>&nbsp;</a>
                    <%//}
                    }%>
                 </div>
            </div><%
                    totq++;
                    }%>
            <input type="hidden" name="tot_qs<%=m%>" value="<%=q_ct[m]%>" />
            <input type="hidden" name="grp_srl<%=m%>" value="<%=grp_srl[m]%>"/>
            <%}%>
            <input type="hidden" name="revqs" id="rev_fwd"/>
            <input type="hidden" name="exam_code" value="<%=exam_code%>"/>
            <input type="hidden" name="mod_code" value="<%=mod_code%>"/>
            <input type="hidden" name="cat_code" value="<%=cat_code%>"/>
            <input type="hidden" name="exam_cd_prfx" value="<%=exam_cd_prfx%>"/>
            <input type="hidden" name="student_code" value="<%=student_code%>"/>
            <input type="hidden" name="student_id" value="<%=student_id%>"/>
            <input type="hidden" name="gr_ct" value="<%=gr_ct%>"/>
            <input type="hidden" name="tq" value="<%=tq%>"/>
        </form>
    </body>
</html>
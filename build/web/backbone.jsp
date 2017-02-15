
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OES:CESC Limited</title>
        <link rel="stylesheet" href="login.css" type="text/css"/>
        <script type="text/javascript" src="jquery-latest.js"></script>
        <script type="text/javascript">
            function timer(h,m,s) {
                start=new Date();
                hr1 =start.getHours();
                hr1=hr1+parseInt(h);
                min1=start.getMinutes();
                min1=min1+parseInt(m);
                sec1=start.getSeconds();
                sec1=sec1+parseInt(s);
                clock();
            }
            function stopTimer(){
                flag=false;
            }
            function clock(){
                var time=new Date();
                var hr= time.getHours();
                var min=time.getMinutes();
                var sec=time.getSeconds();
                var rs=sec1-sec;
                if(rs<0){
                    rs+=60;
                    min++;
                }
                var rm=min1-min;
                if(rm<0){
                    rm+=60;
                    hr++;
                }
                var rh=hr1-hr;
                if(rh<0){
                    rh=0;
                    rm=0;
                    rs=0;
                }
                var tm=rh+' hr '+rm+' min '+rs+' sec';
                document.getElementById("cur_tm").innerHTML="Time Left : "+tm;
                if(flag===false || (rs===0 && rm===0 && rh===0)){
                document.getElementById("cur_tm").innerHTML="";
                document.getElementById("welc_msg").innerHTML="                           Thank You";
                    rs=0;
                    rm=0;
                    rh=0;
                    flag=true;
                    return;
                }
                else{
                    setTimeout (function(){clock();}, 1000);
                }
            }
            function welcome(name){
                document.getElementById("welc_msg").innerHTML="Welcome&nbsp;&nbsp;"+name;
            }
            function setname(exam){
                document.getElementById("exm_name").innerHTML="<h4>"+exam+"</h4>";
            }
            function logout(){
                document.getElementById("welc_msg").innerHTML="&nbsp;&nbsp;&nbsp;You have successfully logged out.";
            }
            function expired(){
                document.getElementById("welc_msg").innerHTML="Access Denied!Try Later";
            }
            function exam_name(name){
                document.getElementById("exm_nme").innerHTML="<h2 id="+"header"+">"+name+"</h2>";
            }
            function showback(){
                $('#bck').show();
            }
            function showfwd(){
                $('#fwd').show();
            }
            function back(){
                var x=document.getElementById("MY_IFRAME").contentWindow.location.href;
                //alert(x);
                var y=x.split('/')[x.split('/').length-1];
                //if(x!=='http://localhost:8080/Back_end/Trial1/route_login.jsp'){
                if(y!=='route_login.jsp'){
                history.back();
                }
                else{
                    alert("Click on logout to end your Session");
                }
            }
            $(document).ready(function(){
                flag=true;
                $('#bck').hide();
                $('#fwd').hide();
            });
            $(document).ready(function(){
                //flag=true;
                $(document).bind('contextmenu',function(e){
                e.preventDefault();
                });
                        window.onload = function () {
                        document.onkeydown = function (e) {
                        return (e.which || e.keyCode) !== 116;
                    };
                };
});
            });
            $(document).ready(function() {
            function disableBack() { window.history.forward(); }

            window.onload = disableBack();
            window.onpageshow = function(evt) { if (evt.persisted) disableBack(); };
        });
        </script>
        <style>
            html{
                height: 105%;
                width: 102.5%;
            }
            body  {
                height: 95%;
                //overflow-y: hidden;
                overflow-x: hidden;
                width:90%;
                //margin-right:100px;margin-left: 100px;margin-top: -8px;margin-bottom: 8px;position: relative;
            }
        </style>
    </head>
    <body id="mb" style="text-align:center;">
        <div style="text-align:center; margin:auto;margin-left: -5.7%;margin-right:5%">
            <img src="Rpg.png" id="left_logo" alt="cesc"/>
            <img src="logo1.png" id="right_logo" alt="rpg"/>
            <div id="exm_nme"><h2 id="header">Online Examination System</h2></div>
            <div id="exm_name" style="color:#0000ff;font-family: Calibri;font-size: 30px;text-align: center;margin-top: -2%;margin-bottom: -2%;"></div>
            <div id="welc_msg" style="margin-left: -42.5%;color:red;font-size: 20px"></div>
            <div id="cur_tm" style="color:red;margin-left: 800px;font-size: 20px;margin-top: -20px;margin-bottom: 20px"></div>
        </div>
        <iframe id="MY_IFRAME" src="login.jsp" style="margin: auto;margin-left: -5.7%;margin-right: 0%;overflow:hidden;border-color: window;padding: 1px;border-radius: 30px;height:77.5%;width:90%">
        </iframe>
        <div id="bck" style="margin-top: 25%;margin-left: -4.5%;float:left">
                <a href="javascript:void(0)" onclick="back();"><img src="Back-Button.gif" style="height: 50px;width: 50px;border-radius:50%"/></a>
        </div>
        <div id="fwd" style="margin-top: 25%;margin-right: 2.5%;margin-left: -5.75%;float:right">
            <a href="javascript:void(0)" onclick="history.forward();"><img src="images_1.jpg" style="height: 50px;width: 50px;border-radius:50%"/></a>
        </div>
    </body>
</html>
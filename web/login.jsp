<%-- 
    Document   : login
    Created on : May 22, 2015, 8:45:06 AM
    Author     : abc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OES:CESC Limited</title>
        <link rel="stylesheet" href="login.css" type="text/css"/>
        <script type="text/javascript" src="jquery-latest.js"></script>
        <script type="text/javascript">
            function validate(){
                   var x=document.getElementById("u").value;
                   var y=document.getElementById("p").value;
                   if(x<0 || x===""){
                       document.getElementById("u_err").innerHTML="Enter a valid username";
                       return false;
                   }
                   else{
                       document.getElementById("u_err").innerHTML="";
                   }
                   if(y===''){
                       document.getElementById("p_err").innerHTML="Enter your password";
                       return false;
                       }
                   return true;
            }
            $(document).ready(function(){
                //flag=true;
                $(document).parent('#bck').hide();
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
    <body id="bcg" style="height: 56.25%;width: 99%;background-image: url(11.jpg);background-position-y: 0%;background-position-x: 70%;opacity: 40000">
        <!--iframe class="frame"-->
    <center><div id="quote" style="opacity: 1;width:40%;margin-top: 3%;color:black;font-size:30px;font-family: Monotype Corsiva;font-style: italic;text-align:center"><b style="font-style: normal">"</b> If you wish to touch the sky far ahead, you have no other choice than set afoot on a road whose end is known but the journey shall be decided by your efforts.<b style="font-style: normal">"</b></div></center>
        <div id="ip_form">
            <form method="post" action="route_login.jsp" onsubmit="return validate();">
                <div id="usn" style="color:white;font-family: Calibri;font-size: 25px;margin-left: 27.5%;margin-top: 10.25%">Enter Username:   <input id="u" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:30px;width:200px;margin-left: 10px;" placeholder="             U s e r n a m e" type="text" name="Username"/></div>
                <div id="u_err" style="margin-top: 13.5%"></div>
                <div id="pwd" style="color:white;font-family: Calibri;font-size: 25px;margin-left: 27.5%;margin-top: 16.75%">Enter Password:   <input id="p" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:30px;width:200px;margin-left: 14px;" placeholder="             P a s s w o r d" type="password" name="Password"/></div>
                <div id="p_err"></div>
                <input id="smt" style="margin-left: 40.5%;margin-top: 24.75%;background-color: #00ffff" type="submit" value="LOGIN"/>
            </form>
        </div>
        <!--/iframe-->
    </body>
</html>

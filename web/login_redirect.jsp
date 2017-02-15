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
                   if(x<0 || x>5000){
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
        </script>
    </head>
    <body id="bcg" id="bcg" style="height: 56.25%;width: 99%;background-image: url(11.jpg);opacity: 35">
        <!--iframe class="frame"-->
        <div id="ip_form">
            <form method="post" action="gen_ins.jsp" onsubmit="return validate();">
                <div id="usn" style="margin-left: 27.5%;margin-top: 23.5%">Enter Username:   <input id="u" style=" background: white;border-radius: 15px;border-color:blue;padding:0.5px;border-width: 1.5px;    height:25px;width:200px;margin-left: 10px;" placeholder="             U s e r n a m e" type="number" name="Username"/></div>
                <div id="u_err"></div>
                <div id="pwd" style="margin-left: 27.5%;margin-top: 30%">Enter Password:   <input id="p" style="background: white;padding:0.5px;border-color: blue;border-radius: 15px;border-width: 1.5px;height:25px;width:200px;margin-left: 14px;" placeholder="             P a s s w o r d" type="password" name="Password"/></div>
                <div id="p_err"></div>
                <input id="smt" style="margin-left: 37.5%;margin-top: 39.5%" type="submit" value="LOGIN"/>
                <h2  id="head" style='text-align: center;color: #009900;margin-bottom:-100px'>The Password you have entered doesn't match with your username.Try Again</h2>
            </form>
        </div>
        <!--/iframe-->
    </body>
</html>
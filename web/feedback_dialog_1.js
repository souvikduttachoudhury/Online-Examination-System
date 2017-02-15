
function open_feedback(obj1,obj2){

    document.getElementById("feedbk").style.visibility = 'visible';
    document.getElementById("feedback").style.visibility = 'visible';
    document.getElementById("feedback").src="https://www.cesc.co.in/consinfo/web_multi_feedback.jsp?cons="+obj1+"&mkr="+obj2;
}

function rate_submit(obj1,obj2){
      var xmldiffrnciator = Math.floor(Math.random() * 100000);
       var parameter = "";
       parameter    += "cons="+obj1;
       parameter    += "&mkr="+obj2;
       for(var i = 0; i < f1.r1.length; i++){
         if (f1.r1[i].checked)
            parameter    += "&rt1="+f1.r1[i].value;
       }
       for(var i = 0; i < f1.r1.length; i++){
         if (f1.r2[i].checked)
          parameter    += "&rt2="+f1.r2[i].value;
       }
       for(var i = 0; i < f1.r1.length; i++){
         if (f1.r3[i].checked)
          parameter    += "&rt3="+f1.r3[i].value;
       }
       parameter    += "&cmt1="+document.getElementById('comm1').value;
       parameter    += "&cmt2="+document.getElementById('comm2').value;
       parameter    += "&cmt3="+document.getElementById('comm3').value;
       parameter    += "&xmldiffrnciator=" + xmldiffrnciator;
       var url = "web_feedback_process.jsp?" + parameter;

       //alert(url);
       var myval = new Object();
       var myval1 = new Object();
        try {
                req_modify = new ActiveXObject("Msxml2.XMLHTTP");
        }catch(e){
        try {
                req_modify = new ActiveXObject("Microsoft.XMLHTTP");
        }catch(E){
                req_modify = new XMLHttpRequest();
                }
        }
        req_modify.open('GET',url, true);
        req_modify.send('');
        req_modify.onreadystatechange = function(){
             if(req_modify.readyState == 4){
                      //alert(req_modify.responseText);
                      myval = req_modify.responseXML.getElementsByTagName("OKAY")[0];
                      if(myval.childNodes[0].nodeValue != ""){
                         if(myval.childNodes[0].nodeValue == 'Y'){
                            document.getElementById('right-most-screen').style.visibility='visible';
                         }
                         else{
                            document.getElementById('right-most-screen').style.visibility='visible';
                            document.getElementById('right-most-screen').innerHTML='SOME ERROR !!!';
                         }
                       }
                       else{
                           alert("SOME ERROR OCCURED");
                       }
            }
        }

}

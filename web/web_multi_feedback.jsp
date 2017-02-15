<!--
 FEEDBACK SCREEN
 Author: SUMAN CHAKRABORTY
 License: CESC LTD.
 -->
<%
  String cons_num = request.getParameter("cons");
  String pg_mkr = request.getParameter("mkr");
%>
<!DOCTYPE html>
<html style="width:100%; height:100%">
	<head>
		<link href="reset.css" type="text/css" rel="stylesheet" />
		<link href="multi_pg_style.css" type="text/css" rel="stylesheet" />
		<link href="multi-screen-css.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="jquery-latest.js"></script>
		<script type="text/javascript" src="feedback_dialog.js"></script>
		<script type="text/javascript" src="multi-screen.js"></script>
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
		<title>Feedback</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	</head>
	<body style="width:100%; height:100%">
             <form id="f1" name="f1" >
		<div id="center-screen" class="ms-container ms-default">
			<h2 class="margin-bottom1" ><strong><br/><br/><br/>
                              Please take a moment to complete our Survey.Your feedback is important to us.</strong></h2>
			<p class="line-height vertical-margin" style="float:left; padding:0 0 0 30px;">
				<a href="javascript:void(0)" data-ms-target="next-screen" data-ms-exit-animation="left" data-ms-enter-animation="right" style="color: #800000; background-color:#dbdbdb; font-weight: bold; float:left; padding:0 10px 5px 10px; border:1px black solid;" class="ms-nav-link" >START</a>
                                <!--div style="width:25%; float:right;">
                                    <img src="cesclogo.gif" style="width:70%; height:50%;"/>
                                </div-->
			</p>
		</div>
		<div id="next-screen" class="ms-container ms-default">
			<h2 class="margin-bottom1"><strong>(1 of  3) How do you rate the overall experience of CESC website ? <br/> (1-Poor, 2-Good, 3-Excellent) </strong></h2>
                        <div style="margin:auto; width:80%">
                       
                        <div class="divclass1" style="float:left;">
                              <div style="width:40%; background-color:#ffffff; border : 2px #FF6600 solid;">
                                 <input type="radio" id="r11" name="r1" value="1" /> 1 
                              </div>
                        </div>
                        <div class="divclass1" style="float:left;">
                              <div style="width:40%; background-color:#ffffff;  border : 2px #FF6600 solid;">
                                <input type="radio" id="r12" name="r1" value="2" /> 2 
                              </div>
                        </div>
                        <div class="divclass1" style="float:right;">
                              <div style="width:40%;  background-color:#ffffff; border : 2px #FF6600 solid;">
                                 <input type="radio" id="r13" name="r1" value="3" /> 3 
                              </div>
                        </div>
                        <div id="comment1">
                           Comment : <textarea id="comm1" style="width:60%; resize:none;" maxlength="700"></textarea> 
                        </div>

                        </div>
			<p class="line-height vertical-margin" style="float:left; padding:0 0 0 30px;">
				<a href="javascript:void(0)" style="color: #800000; background-color:#dbdbdb; font-weight: bold; float:left; padding:0 10px 5px 10px; border:1px black solid;" class="ms-nav-link" 
                               onclick=" for(var i=0; i<f1.r1.length; i++){
                                            if(f1.r1[i].checked){
                                               MultiScreen.switch_screens({target_id:'right-screen',enter_animation_command:'right',exit_animation_command:'left'});
                                               break;
                                            }
                                          //this.data-ms-target='right-screen';
                                       }">Next</a>
                                <!--div style="width:25%; float:right;">
                                    <img src="cesclogo.gif" style="width:70%; height:50%;"/>
                                </div!-->
			</p>
		</div>
		<div id="right-screen" class="ms-container">
			<h2 class="margin-bottom1"><strong>
                            (2 of 3) How easy was it to find the exact service you were looking for ? <br/>
                            (1-Poor, 2-Good, 3-Excellent)
                        </strong></h2>
                        <div style="margin:auto; width:80%">
                       
                        <div class="divclass1" style="float:left;">
                              <div style="width:40%;  background-color:#ffffff; border : 2px #FF6600 solid;">
                                 <input type="radio" id="r21" name="r2" value="1" /> 1 
                              </div>
                        </div>
                        <div class="divclass1" style="float:left;">
                              <div style="width:40%;  background-color:#ffffff; border : 2px #FF6600 solid;">
                                <input type="radio" id="r22" name="r2" value="2" /> 2 
                              </div>
                        </div>
                        <div class="divclass1" style="float:right;">
                              <div style="width:40%;  background-color:#ffffff; border : 2px #FF6600 solid;">
                                 <input type="radio" id="r23" name="r2" value="3" /> 3 
                              </div>
                        </div>
                        <div id="comment2">
                           Comment : <textarea id="comm2" style="width:60%; resize:none;" maxlength="700"></textarea> 
                        </div>

                        </div>
			<p class="line-height vertical-margin" style="float:left; padding:0 0 0 20px;">
				<a href="javascript:void(0)" style="color: #800000; background-color:#dbdbdb; font-weight: bold; float:left; padding:0 10px 5px 10px; border:1px black solid;" class="ms-nav-link" 
                                        onclick=" for(var i=0; i<f1.r2.length; i++){
                                            if(f1.r2[i].checked){
                                               MultiScreen.switch_screens({target_id:'left-screen',enter_animation_command:'right',exit_animation_command:'left'});
                                               break;
                                            }
                                          //this.data-ms-target='right-screen';
                                       }">Next</a>
                                <!--div style="width:25%; float:right;">
                                    <img src="cesclogo.gif" style="width:70%; height:50%;"/>
                                </div-->
			</p>
		</div>
		<div id="left-screen" class="ms-container">
			<h2 class="margin-bottom1"><strong>
                            (3 of 3) How easy was it to complete your transaction?<br/>
                            (1-Poor, 2-Good, 3-Excellent)
                        </strong></h2>
                        <div style="margin:auto; width:80%">
                       
                        <div class="divclass1" style="float:left;">
                              <div style="width:40%;  background-color:#ffffff; border : 2px #FF6600 solid;">
                                 <input type="radio" id="r31" name="r3" value="1" /> 1 
                              </div>
                        </div>
                        <div class="divclass1" style="float:left;">
                              <div style="width:40%;  background-color:#ffffff; border : 2px #FF6600 solid;">
                                <input type="radio" id="r31" name="r3" value="2" /> 2 
                              </div>
                        </div>
                        <div class="divclass1" style="float:right;">
                              <div style="width:40%;  background-color:#ffffff; border : 2px #FF6600 solid;">
                                 <input type="radio" id="r33" name="r3" value="3" /> 3 
                              </div>
                        </div>
                        <div id="comment3">
                           Comment : <textarea id="comm3" style="width:60%; resize:none;" maxlength="700"></textarea> 
                        </div>

                        </div>
			<p class="line-height vertical-margin" style="float:left; padding:0 0 0 30px;">
				<a href="javascript:void(0)" style="color: #800000; background-color:#dbdbdb; font-weight: bold; float:left; padding:0 10px 5px 10px; border:1px black solid;" class="ms-nav-link" 
                             onclick=" for(var i=0; i<f1.r3.length; i++){
                                            if(f1.r3[i].checked){
                                               MultiScreen.switch_screens({target_id:'right-most-screen',enter_animation_command:'right',exit_animation_command:'left'});
                                               rate_submit('<%=cons_num%>','<%=pg_mkr%>');
                                               break;
                                            }
                                       }"    >Submit</a>
                                <!--div style="width:25%; float:right;">
                                    <img src="cesclogo.gif" style="width:70%; height:50%;"/>
                                </div-->
			</p>
		</div>
		<div id="right-most-screen" class="ms-container" style="visibility:hidden">
			<h2 class="margin-bottom1" style="width:70%; padding:20% 0 10% 20%;"><strong>
                           Thank you for taking the Survey.
                        </strong></h2>
			<p class="centralize line-height vertical-margin" style="float:left; padding:0 0 0 30px;">
				<!--button><a href="javascript:void(0)" style="color: #800000; font-weight: bold; " class="ms-nav-link" data-ms-target="left-screen" data-ms-exit-animation="right" data-ms-enter-animation="left" style="width:30%; float:left">CLOSE</a></button-->
                                <!--div style="width:25%; float:right;">
                                    <img src="cesclogo.gif" style="width:70%; height:50%;"/>
                                </div-->
			</p>
		</div>
             </form>
	</body>
</html>

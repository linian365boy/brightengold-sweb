<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="brightengold furniture,brightengold,furniture, Hotel furniture, dining tables, restaurant furniture, hotel furniture accessories, decorative furniture">
<meta name="description" content="Welcome to the home of Brightengold Furniture, a leader in contemporary furniture design in China! Our sofa suites, dining table and other furniture are well-received in hotels and restaurants.">
<link href="${ctx }resources/css/index.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/feedback.css" />
<title>Feedback|Brightengold Furniture</title>
<link rel="icon" href="${ctx }/resources/images/favicon.ico" type="image/x-icon">
	<link rel="shortcut icon" href="${ctx }/resources/images/favicon.ico" type="image/x-icon" />
<script type="text/javascript">
	$(document).ready(function(){
		$("#form").validate({
			rules:{
				"name":{
					required:true,
					rangelength:[1,100],
				},
				"telePhone":{
					required:true,
					rangelength:[1,20]
				},
				"email":{
					required:true,
					email:true,
					rangelength:[1,100]
				},
				"content":{
					required:true
				}
			},
			messages:{
				"name":{
					required:"Name can't be empty!",
					rangelength:jQuery.format("Length is between {0} and {1}")
				},
				"telePhone":{
					required:"Telephone can't be empty!",
					rangelength:jQuery.format("Length is between {0} and {1}")
				},
				"email":{
					required:"email can't be empty!",
					email:"email format error!",
					rangelength:jQuery.format("Length is between {0} and {1}")
				},
				"content":{
					required:"Content can't be empty!"
				}
			}
		});
		var error = getQueryString("error");
		if(error!=null){
			if(error=="false"){
				$("#alertDiv").removeClass("alert-info");
				$("#alertDiv").addClass("alert-success");
				$("#alertDiv").html("<strong>Well done!</strong>You successfully submit the message. ");
			}else{
				$("#alertDiv").removeClass("alert-info");
				$("#alertDiv").addClass("alert-danger");
				$("#alertDiv").html("<strong>Oh snap!</strong>Change a few things up and try submitting again.");
			}
		}
	});
</script>
</head>
<body>
	<jsp:include page="/commons/top.jsp"></jsp:include>
<jsp:include page="/commons/menu.jsp"></jsp:include>
<div id="container"> 
  <div id="center"> 
  <div style="left: 100px ! important;" class="Z_TypeList" id="Z_TypeList">
    <h1 class="title">Product categories<s class="btn_group bleft"><a class="bleft"></a><a class="bright"></a></s></h1>
    <jsp:include page="/commons/left.jsp"></jsp:include>
     <div class="footerlist">
     <jsp:include page="/commons/contact.jsp"></jsp:include>
     </div>
  </div>
  <script type="text/javascript" src="${ctx }resources/js/jquery.tmailsider.js"></script>
<script type="text/javascript">
    $('#Z_TypeList').Z_TMAIL_SIDER();
    function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); 
    return null;
    }
</script>
<div class="etw_hometitle"><img width="665px" height="28" border="0" src="/resources/images/feedback.jpg"/></div>
<div class="alert alert-info" id="alertDiv">Please <strong>fill out</strong> the information <strong>truthfully</strong>!</div>
<div id="etw_right"> 
<div class="clear"></div>
	<div>
		<form class="form-horizontal" action="${ctx }views/submitFeedback.do" method="post" name="feedbackForm" id="form">
			<div class="form-group">
				<label for="name" class="col-xs-3 control-label" style="text-align: right;">Name</label>
            	<div class="col-xs-3">
            		<input id="name" class="form-control" style="width:55%;" name="name" placeholder="Name"  type="text"  autocomplete="off"/>
            	</div>
			</div>
			<div class="form-group">
				<label for="telephone" class="col-xs-3 control-label" style="text-align: right;">Telephone</label>
            	<div class="col-xs-3">
            		<input id="telephone" class="form-control" style="width:55%;" name="telePhone" placeholder="Telephone"  type="text" />
            	</div>
			</div>
			<div class="form-group">
				<label for="email" class="col-xs-3 control-label" style="text-align: right;">E-mail</label>
            	<div class="col-xs-3">
            		<input id="email" class="form-control" style="width:55%;" name="email" placeholder="E-mail"  type="text" />
            	</div>
			</div>
			
			<div class="form-group">
				<label for="content" class="col-xs-3 control-label" style="text-align: right;">Content</label>
            	<div class="col-xs-3">
            		<textarea id="content" class="form-control" style="width:75%;" name="content" rows="8"></textarea>
            	</div>
			</div>
			
			<div class="form-group">
			<div class="col-xs-offset-3 col-sm-3">
				<input type="submit" value="Submit"/>&nbsp;&nbsp;&nbsp;
				<input type="reset" value="Reset"/>
				</div>
			</div>
		</form>
	</div>
<div class="clear"></div>
</div>
  <div class="clear"></div>
</div>
  <div class="clear"></div>
  </div>
  <div class="clear" id="etwclear"></div>
  <jsp:include page="/commons/bottom.jsp"></jsp:include>
</body>
</html>
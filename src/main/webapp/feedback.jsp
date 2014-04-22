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
<title>Feedback|Brightengold Furniture</title>
<style type="text/css">
#etw_banner{background:url() no-repeat;}
.left{ margin:0 50px 30px 0;}
#etw_con .left,#etw_con .left1{width:100%; margin:0px;}
</style>
</head>
<body>
	<jsp:include page="commons/top.html"></jsp:include>
<jsp:include page="commons/menu.html"></jsp:include>
<div class="clear"></div>
<div id="container"> 
  <div id="center"> 
  <div style="left: 100px ! important;" class="Z_TypeList" id="Z_TypeList">
    <h1 class="title">Product categories<s class="btn_group bleft"><a class="bleft"></a><a class="bright"></a></s></h1>
    <jsp:include page="commons/left.html"></jsp:include>
     <div class="footerlist">
     <jsp:include page="commons/contact.html"></jsp:include>
     </div>
  </div>
  <script type="text/javascript" src="${ctx }resources/js/jquery.tmailsider.js"></script>
<script type="text/javascript">
    $('#Z_TypeList').Z_TMAIL_SIDER();
</script>
<div class="etw_hometitle"><img width="665px" height="28" border="0" src="/resources/images/feedback.jpg"/></div>
<div id="etw_right"> 
<div class="clear"></div>
	<div>
		<form action="#" method="post" name="feedbackForm">
			<table cellpadding="0" border="0" cellspacing="0">
			<tr style="height: 35px;">
				<td align="right">Name:</td>
				<td><input name="name" type="text"/></td>
			</tr>
			<tr style="height: 35px;">
				<td align="right">Telephone:</td>
				<td><input name="telephone" type="text"/></td>
			</tr>
			<tr style="height: 35px;">
				<td align="right">E-mail:</td>
				<td><input name="e-mail" type="text"/></td>
			</tr>
			<tr style="height: 35px;">
				<td align="right">Content:</td>
				<td><textarea name="content" cols="60" rows="5"></textarea></td>
			</tr>
			<tr style="height: 35px;">
				<td>&nbsp;</td>
				<td><input type="submit" value="Submit"/>&nbsp;&nbsp;&nbsp;
				<input type="reset" value="Reset"/></td>
			</tr>
			</table>
		</form>
	</div>
<div class="clear"></div>
</div>
  <div class="clear"></div>
</div>
  <div class="clear"></div>
  </div>
  <div class="clear" id="etwclear"></div>
  <jsp:include page="commons/bottom.html"></jsp:include>
</body>
</html>
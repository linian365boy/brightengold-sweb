<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="brightengold furniture,brightengold,furniture, Hotel furniture, dining tables, restaurant furniture, hotel furniture accessories, decorative furniture">
<meta name="description" content="Welcome to the home of Brightengold Furniture, a leader in contemporary furniture design in China! Our sofa suites, dining table and other furniture are well-received in hotels and restaurants.">
<link href="${ctx }resources/css/index.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<title>Product|Brightengold Furniture</title>
<style type="text/css">
#etw_banner{background:url() no-repeat;}
.left{ margin:0 50px 30px 0;}
#etw_con .left,#etw_con .left1{width:100%; margin:0px;}
</style>
</head>
<body>
	<jsp:include page="/commons/top.jsp"></jsp:include>
<jsp:include page="/commons/menu.jsp"></jsp:include>
<div class="clear"></div>
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
</script>
<div class="etw_hometitle">
<img width="665px" height="28" border="0" src="/resources/images/chapinreg.jpg"/></div>
<div id="etw_right"> 
<div id="productsformat">
<div class="productsformat_sub">
<ul>
<c:forEach items="${pages.result }" var="product" varStatus="status">
	<li><ol ><li class="etw_pro_img">
	<a href="${ctx }${product.url}" target="_blank">
	<img src="/resources/${product.picUrl }" width="186px" height="126px" title="${product.enName }">
	</a>
	</li><li class="etw_pro_name">
	<a href="${product.url }" target="_blank">${product.enName }</a>
	<p>${product.introduce }</p>
	 <a href="${product.url }" class="more" target="_blank">View Details &gt;&gt;</a>
	 </li>
	</ol>
	 </li>
</c:forEach>
               </ul>
				</div>
                </div>
                <div>
                	First Previous Next Last Page No.:1/2page  12Products/page Turn to:
                </div>
</div> 
  <div class="clear"></div>
</div>
  <div class="clear"></div>
  </div>
  <div class="clear" id="etwclear"></div>
  <jsp:include page="/commons/bottom.jsp"></jsp:include>
</body>
</html>
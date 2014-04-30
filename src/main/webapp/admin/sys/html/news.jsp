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
<title>News|Brightengold Furniture</title>
<style type="text/css">
.left{ margin:0 50px 30px 0;}
#etw_con .left,#etw_con .left1{width:100%; margin:0px;}


.tool-list {
    font-size: 14px;
    padding-top: 5px;
}
ul, ol {
    list-style: none outside none;
    margin: 0;
    padding: 0;
}

.tool-list li {
    background: url("/resources/images/line1x3.gif") repeat-x scroll left bottom rgba(0, 0, 0, 0);
    line-height: 15px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    width: 100%;
}

.icon-no2 {
    background-position: -20px -20px;
}
.icon-no3 {
    background-position: -40px -20px;
}
.icon-no4 {
    background-position: -60px -20px;
}
.icon-no5 {
    background-position: -80px -20px;
}
.icon-no6 {
    background-position: -100px -20px;
}
.icon-no7 {
    background-position: -120px -20px;
}
.icon-no8 {
    background-position: -140px -20px;
}

.icon-no9 {
    background-position: -160px -20px;
}
.icon-no10 {
    background-position: -180px -20px;
}

.tool-list li i {
    margin: 3px 8px 0 0;
}
.tool-list li span {
    float: right;
    margin-right: 20px;
}
.icon-no1 {
    background-position: 0 -20px;
}
[class^="icon-"], [class*=" icon-"] {
    background-image: url("/resources/images/icon.png");
    background-repeat: no-repeat;
    display: inline-block;
    height: 14px;
    line-height: 14px;
    vertical-align: text-top;
    width: 14px;
}

a {
    color: #333333;
    text-decoration: none;
}

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
<div class="etw_hometitle"><img width="665" height="28" border="0" src="/resources/images/news.jpg"/></div>
<div id="etw_right"> 
	<div class="clear"></div>
	<div id="etw_instruction" class="cer">
	<ul class="tool-list te-hot">
	<c:forEach items="${page.result }" var="news" varStatus="status">
		 <li>
		 <i class="icon-no${status.index+1 }"></i>
		 <a class="t-title" target="_blank" title="${news.title }" href="${ctx }${news.url}" id="n1">${news.title }</a>
		 <span>${news.publishDate }</span>
		 </li>
	</c:forEach>
	</ul>
	<div id="pageDiv">
	 <ul id="pagination-flickr">
		<c:import url="/views/page.jsp">
            <c:param name="url" value="views/getProduct.do"/>
        </c:import>
	</ul>
	</div>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="GELAIMEI furniture industrial, GELAIMEI, furniture, hotel furniture, bedroom furniture, hotel dining table and chair, hotel sofa, lobby sofa and occasional table, lounge chair, bar chair, door, hospitality furniture supplier, FF&E supplier, hotel loose furniture supplier, casegoods and furniture.">
<meta name="description" content="Welcome to the home of GELAIMEI hotel furniture industrial, a leader in contemporary star grade furniture design and manufacturing in China! Our hotel bedroom furniture, sofa suites, dining table and other furniture are well-received in hotels, restaurants, apartments and other hospitality sectors.">
<link href="${ctx }resources/css/index.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<title>Projects|GELAIMEI Furniture</title>
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
	<c:set value="${(status.index+1)+(page.pageSize*(page.currentPageIndex-1)) }" var="newCount"/>
		 <li>
		 <c:choose>
		 	<c:when test="${newCount<=10 }">
				 <i class="icon-no${newCount }"></i>
		 	</c:when>
		 	<c:otherwise>
				 <i>${newCount}</i>
		 	</c:otherwise>
		 </c:choose> 
		 <a class="t-title" target="_blank" title="${news.title }" href="${ctx }${news.url}" id="n1">${news.title }</a>
		 <%-- <span>${news.publishDate }</span> --%>
		 </li>
	</c:forEach>
	</ul>
	<div id="pageDiv">
	 <ul id="pagination-flickr">
		<c:import url="/views/page.jsp">
            <c:param name="url" value="views/getNews.do"/>
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
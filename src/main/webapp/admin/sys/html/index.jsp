<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/commons/includeIndex.jsp"></jsp:include>
<title>Brightengold Furniture</title>
<link rel="icon" href="${ctx }/resources/images/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="${ctx }/resources/images/favicon.ico" type="image/x-icon" />
</head>
<body>
<jsp:include page="/commons/top.jsp"></jsp:include>
<jsp:include page="/commons/menu.jsp"></jsp:include> 
<div id="container"> 
  <div id="center"> 
   <div style="left: 100px ! important;" class="Z_TypeList" id="Z_TypeList">
    <h1 class="title">Product categories<s class="btn_group bleft"><a class="bleft"></a>
    <a class="bright"></a></s></h1>
    <jsp:include page="/commons/left.jsp"></jsp:include>
    <div class="footerlist">
     <jsp:include page="/commons/contact.jsp"></jsp:include>
     </div>
  </div> 
  <script type="text/javascript" src="${ctx }resources/js/jquery.tmailsider.js"></script>
<script type="text/javascript">
    $('#Z_TypeList').Z_TMAIL_SIDER();
</script>
<jsp:include page="/commons/products.jsp"></jsp:include>
  <jsp:include page="/commons/last.jsp"></jsp:include>
</div>
  </div>  
<div class="clear" id="etwclear"></div>
<jsp:include page="/commons/bottom.jsp"></jsp:include>
</body>
</html>
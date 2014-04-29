<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8"/>
	<title>Brightengold</title>
	<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
	<jsp:include page="commons/jsCss.jsp"/>
</head>

<body>
	<jsp:include page="commons/header.jsp"/>
	<jsp:include page="commons/left.jsp"/>
	
	<section id="main" class="column" style="text-align:center;">
		<div style="height: 180px">&nbsp;</div>
		<img src="${ctx }resources/images/bglogo.jpg"/>
	</section>
</body>
</html>
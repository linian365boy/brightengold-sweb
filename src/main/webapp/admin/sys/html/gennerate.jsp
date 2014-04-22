<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/commons/include.jsp" %>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/admin/commons/listJsCss.jsp" %>
<%@include file="/admin/commons/jsCss.jsp" %>
<title>公司信息</title>
<script type="text/javascript">
	function gennerateHome(){
		windown.location.href="${ctx}/sys/html/index.do";
	}
	function gennerateAboutUs(){
		windown.location.href="${ctx}/sys/html/index.do";
	}
	function gennerateProducts(){
		windown.location.href="${ctx}/sys/html/index.do";
	}
	function gennerateNews(){
		windown.location.href="${ctx}/sys/html/index.do";
	}
	function gennerateFeedback(){
		windown.location.href="${ctx}/sys/html/index.do";
	}
	function gennerateContactUs(){
		windown.location.href="${ctx}/sys/html/";
	}
</script>

</head>
<body>
	<jsp:include page="/admin/commons/header.jsp"/>
	<jsp:include page="/admin/commons/left.jsp">
	<jsp:param value="13" name="menuId"/>
		<jsp:param value="生成管理" name="menuName"/>
	</jsp:include>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">生成管理</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
			<form action="#" class="form-horizontal">
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="生成Home" onclick="gennerateHome();" title="生成首页静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="生成About Us" onclick="gennerateAboutUs();" title="生成首页静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="生成Products" onclick="gennerateProducts();" title="生成首页静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="生成News" onclick="gennerateNews();" title="生成首页静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="生成Feedback" onclick="gennerateFeedback();" title="生成首页静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="生成Contact Us" onclick="gennerateContactUs();" title="生成首页静态页面"/>
				</div>
			</form>
		</div>
		</div>
		</article>
	</section>
</body>
</html>
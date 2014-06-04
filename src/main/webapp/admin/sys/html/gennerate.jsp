<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/commons/include.jsp" %>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/admin/commons/listJsCss.jsp" %>
<%@include file="/admin/commons/jsCss.jsp" %>
<title>生成管理|brightengold后台管理系统</title>
</head>
<body>
	<jsp:include page="/admin/commons/header.jsp"/>
	<jsp:include page="/admin/commons/left.jsp">
	<jsp:param value="13" name="menuId"/>
		<jsp:param value="生成管理" name="menuName"/>
	</jsp:include>
	<section id="main" class="column">
	<jsp:include page="/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">生成管理</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
			<form action="#" class="form-horizontal">
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="预览Home页面" onclick="purviewHome();" title="预览Home静态页面"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-danger" value="生成Home页面" onclick="gennerateHome();" title="生成Home静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="预览About Us页面" onclick="purviewAboutUs();" title="预览About Us静态页面"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-danger" value="生成About Us页面" onclick="gennerateAboutUs();" title="生成About Us静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="预览Products页面" onclick="purviewProducts();" title="预览Products静态页面"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-danger" value="生成Products页面" onclick="gennerateProducts();" title="生成Products静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="预览Projects页面" onclick="purviewNews();" title="预览Projects静态页面"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-danger" value="生成Projects页面" onclick="gennerateNews();" title="生成Projects静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="预览Feedback页面" onclick="purviewFeedback();" title="预览Feedback静态页面"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-danger" value="生成Feedback页面" onclick="gennerateFeedback();" title="生成Feedback静态页面"/>
				</div>
				<div style="margin: 10px 50px;">
					<input type="button" class="btn btn-danger" value="预览Contact Us页面" onclick="purviewContactUs();" title="预览Contact Us静态页面"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" class="btn btn-danger" value="生成Contact Us页面" onclick="gennerateContactUs();" title="生成Contact Us静态页面"/>
				</div>
			</form>
		</div>
		</div>
		</article>
	</section>
	<script type="text/javascript">
	function gennerateHome(){
		window.location.href="${ctx}admin/sys/gennerate_index.do";
	}
	function gennerateAboutUs(){
		window.location.href="${ctx}admin/sys/gennerate_aboutUs.do";
	}
	function gennerateProducts(){
		window.location.href="${ctx}admin/sys/gennerate_products.do";
	}
	function gennerateNews(){
		window.location.href="${ctx}admin/sys/gennerate_news.do";
	}
	function gennerateFeedback(){
		window.location.href="${ctx}admin/sys/gennerate_feedback.do";
	}
	function gennerateContactUs(){
		window.location.href="${ctx}admin/sys/gennerate_contactUs.do";
	}
	
	function purviewHome(){
		window.open("${ctx}admin/sys/gennerate_toHome.do");
	}
	function purviewAboutUs(){
		window.open("${ctx}admin/sys/gennerate_toAboutUs.do");
	}
	function purviewProducts(){
		window.open("${ctx}admin/sys/gennerate_toProduct.do");
	}
	function purviewNews(){
		window.open("${ctx}admin/sys/gennerate_toNews.do");
	}
	function purviewFeedback(){
		window.open("${ctx}admin/sys/gennerate_toFeedback.do");
	}
	function purviewContactUs(){
		window.open("${ctx}admin/sys/gennerate_toContactUs.do");
	}
</script>
</body>
</html>
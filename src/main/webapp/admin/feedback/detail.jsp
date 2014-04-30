<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>反馈详情|brightengold后台管理系统</title>
<%@include file="/admin/commons/jsCss.jsp" %>
 <%@include file="/admin/commons/listJsCss.jsp" %>
 <link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
</head>
<body>
<jsp:include page="/admin/commons/header.jsp"/>
	<jsp:include page="/admin/commons/left.jsp">
		<jsp:param value="12" name="menuId"/>
		<jsp:param value="反馈管理" name="menuName"/>
		<jsp:param value="反馈详情" name="menuSubName"/>
	</jsp:include>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">反馈详情</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" class="form-horizontal" action="..." method="post">
		<div class="form-group">
			<label for="name" class="col-sm-2 control-label">账号</label>
			<div class="col-sm-6">
            <input type="text" class="form-control"  value="${model.name }"/>
            </div>
        </div>
          <div class="form-group">
		<label for="telePhone" class="col-sm-2 control-label">联系方式</label>
		<div class="col-sm-6">
          	<input type="text" class="form-control"  value="${model.telePhone }"/>
          	</div>
          </div>
          
          <div class="form-group">
		<label for="email" class="col-sm-2 control-label">邮箱</label>
		<div class="col-sm-6">
          	<input type="text" class="form-control"  value="${model.email }"/>
          	</div>
          </div>
          <div class="form-group">
		<label for="content" class="col-sm-2 control-label">内容</label>
		<div class="col-sm-6">
          	<textarea class="form-control" rows="8" >${model.content }</textarea>
          	</div>
          </div>
          <div class="form-group">
		<label for="createTime" class="col-sm-2 control-label">反馈时间</label>
		<div class="col-sm-6">
          	<input type="text" disabled class="form-control"  disabled="disabled" value="${model.createTime }"/>
          	</div>
          </div>
		</form>
		</div>
          </div>
          </article>
       </section>
</body>
</html>
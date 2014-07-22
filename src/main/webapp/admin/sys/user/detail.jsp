<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@include file="../../../commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户详情|GELAIMEI Furniture后台管理系统</title>
</head>
<body>
		<form id="form" class="form-horizontal" action="..." method="post">
			<div class="form-group">
				<label for="username" class="col-xs-5 control-label">账号</label>
				<div class="col-xs-6">
            	<input type="text" class="form-control"  disabled="disabled" id="inputyc" value="${model.username }"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="realName" class="col-xs-5 control-label">姓名</label>
            	<div class="col-xs-6">
	            <input type="text" class="form-control" disabled="disabled" id="inputyc" value="${model.realName }"/>
	            </div>
            </div>
            
			<div class="form-group"> 
				<label for="role" class="col-xs-5 control-label">是否可用</label>
				<div class="col-xs-6">
				<c:choose>
					<c:when test="${model.enabled }">
						 <input class="form-control" type="text" disabled="disabled" id="inputyc" value="可用"/>
					</c:when>
					<c:otherwise>
						 <input class="form-control" type="text" disabled="disabled" id="inputyc" value="禁用"/>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
			<div class="form-group"> 
				<label for="role" class="col-xs-5 control-label">最近关闭日期</label>
				<div class="col-xs-6">
				<input type="text" class="form-control" id="inputyc" disabled="disabled"
				value="<fmt:formatDate value='${model.lastCloseDate}' type='date'/>"/>
				</div>
			</div>
		</form>
</body>
</html>
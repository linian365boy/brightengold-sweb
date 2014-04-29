<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/commons/include.jsp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改密码</title>
</head>
<body>
		<br/>
		<form id="form" class="form-horizontal" action="${ctx }admin/sys/user/user_modifyPass.do" method="post" target="_parent">
			<div class="form-group">
            	<label for="oldPassword" class="col-xs-4 control-label" >原密码</label>
            	<div class="col-xs-8">
            		<input id="oldPassword" class="form-control" name="oldPassword" placeholder="原密码"  type="password"  autocomplete="off"/>
            	</div>
			</div>
			
			<div class="form-group">
            	<label for="newPassword1" class="col-xs-4 control-label" >新密码</label>
            	<div class="col-xs-8">
            		<input id="newPassword1" class="form-control"  name="newPassword1" placeholder="新密码"  type="password" />
            	</div>
			</div>
			
			<div class="form-group">
            	<label for="newPassword2" class="col-xs-4 control-label" >确认密码</label>
            	<div class="col-xs-8">
            		<input id="newPassword2" class="form-control" name="newPassword2" placeholder="确认密码"  type="password" />
            	</div>
			</div>
          </form>
</body>
</html>

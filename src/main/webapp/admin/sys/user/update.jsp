<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/commons/include.jsp" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息|brightengold后台管理系统</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx }resources/js/validatePlugin/jquery.validatePlugin.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
<script type="text/javascript">
	$(document).ready(function(){
		$("#form").validate({
			rules:{
				"username":{
					required:true,
					chrnum:true,
					rangelength:[1,12],
					remote:{
						type:'POST',
						url:'${ctx}admin/sys/user_existUser.do',
						data:{
							username:function(){
								return $("#username").val();
							},
							u:function(){
								return "${model.username}";
							}
						}
					}
				},
				"realName":{
					required:true,
					rangelength:[1,5]
				}
			},
			messages:{
				"username":{
					required:"账号不能为空！",
					chrnum:"账号需数字、字母！",
					remote:"账号已存在！",
					rangelength:jQuery.format("账号长度在{0}与{1}之间")
				},
				"realName":{
					required:"姓名不能为空！",
					rangelength:jQuery.format("姓名字数在{0}与{1}之间！")
				}
			}
		});
	});
</script>
</head>
<body>
	<form id="form" class="form-horizontal" action="${ctx}admin/sys/user_update.do" method="post" target="_parent">
            <div class="form-group" style="width:500px;">
            	<label for="username" class="col-xs-3 control-label" style="text-align: right;">账号</label>
            	<div class="col-xs-9">
	            	<input id="username" class="form-control" style="width:55%;" placeholder="账号" name="username" value="${model.username }" type="text"/>
            	</div>
			</div>
			
            <div class="form-group" style="width:500px;">
            	<label for="realName" class="col-xs-3 control-label" style="text-align: right;">姓名</label>
            	<div class="col-xs-9">
            		<input name="realName" class="form-control" style="width:55%;" placeholder="姓名" value="${model.realName }" type="text"/>
            	</div>
             </div>
             <c:forEach items="${model.roles }" var="myRole">
	            	<c:if test="${myRole.name ne 'ROLE_DEFAULT' }">
	            		<c:set var="mr" value="${myRole.name }" scope="page"/>
	            	</c:if>
	            </c:forEach>
            <div class="form-group" style="width:500px;">
            	<label for="role" class="col-xs-3 control-label" style="text-align: right;">角色分配</label>
            	<div class="col-xs-9">
	            <select name="role" id="roles" style="width:55%;" class="form-control">
	            	<c:forEach items="${rolesAjax }" var="r">
	            		<option value="${r[0] }"
	            			<c:if test="${r[0] eq mr }">
	            				selected="selected"
	            			</c:if>
	            		>
	            			${r[1] }
	            		</option>
	            	</c:forEach>
	            </select>
	            </div>
            </div>
			<div class="form-group" style="width:500px;">
				<div class="col-xs-offset-3 col-sm-3">
					<div class="checkbox">
						<label>
            	<input type="checkbox" name="enabled"
           		<c:choose>
			 		<c:when test="${model.enabled }">
			 			checked="checked"
			 		</c:when>
			 	</c:choose>
			 />是否启用账号
			 </label>
			 </div>
			 </div>
            </div>
            
            <input type="hidden" name="id" value="${model.id }"/>
            <input type="hidden" name="pageNo" value="${pageNo }"/>
            <div class="form-group" style="width:500px;">
            <div class="col-xs-offset-3 col-sm-3">
              <button class="btn btn-info" type="submit">提交</button>&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;<button type="reset" class="btn btn-default">重置</button>
            </div>
            </div>
          </form>
</body>
</html>
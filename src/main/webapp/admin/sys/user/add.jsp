<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户添加</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
	<script type="text/javascript">
	$(document).ready(function(){
		$.getJSON("${ctx}admin/sys/role_getRolesByAjax.do",function(returnJson){
			var json = $(returnJson);
			var str = "";
			for(var i=0;i<json.length;i++){
				str+="<option value="+json.get(i)[0]+">"+json.get(i)[1]+"</option>";
			}
			$("#roles").append(str);
		});
		
		$("#form").validate({
			rules:{
				"username":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}admin/sys/user_existUser.do',
						data:{
							username:function(){
								return $("#username").val();
							}
						}
					}
				},
				"password":{
					required:true
				},
				"realName":{
					required:true
				}
			},
			messages:{
				"username":{
					required:"用户名不能为空",
					remote:"用户名已存在"
				},
				"password":{
					required:"密码不能为空"
				},
				"realName":{
					required:"姓名不能为空"
				}
			}
		});
	});
	</script>
</head>
<body>
	<form id="form" class="form-horizontal" action="${ctx }admin/sys/user_add.do" method="post" target="_parent">
            <div class="form-group" style="width:550px;">
            	<label for="username" class="col-xs-3 control-label" style="text-align: right;">用户名</label>
            	<div class="col-xs-8">
            		<input id="username" class="form-control" style="width:55%;" name="username" placeholder="用户名"  type="text"  autocomplete="off"/>
            	</div>
			</div>
			
            <div class="form-group" style="width:550px;">
            	<label for="password" class="col-xs-3 control-label" style="text-align: right;">密码 </label>
            	<div class="col-xs-8">
            		<input name="password" class="form-control" style="width:55%;" autocomplete="off" type="password"/>
            	</div>
            </div>
            
            <div class="form-group" style="width:550px;">
            	<label for="realName" class="col-xs-3 control-label" style="text-align: right;">姓名</label>
            	<div class="col-xs-8">
	            	<input name="realName" class="form-control" style="width:55%;" placeholder="姓名" type="text" id="realName"/>
            	</div>
            </div>
            
            <div class="form-group" style="width:550px;">
            	<label for="role" class="col-xs-3 control-label" style="text-align: right;">角色分配</label>
            	<div class="col-xs-8">
	            <select name="role" id="roles" style="width:55%;" class="form-control">
	              <%--<option value="0">=====角色分配=====</option>--%>
	             </select>
	             </div>
             </div>
             <div class="form-group" style="width:550px;">
            	<div class="col-xs-offset-3 col-sm-3">
					<div class="checkbox">
						<label>
		            	<input type="checkbox" name="enabled"/>是否启用账号
		            	</label>
					</div>
			</div>
            </div>
            
            <input type="hidden" value="${param.pageNo }" name="pageNo"/>
            <div class="form-group" style="width:550px;">
            	<div class="col-xs-offset-3 col-sm-3">
             		<button class="btn btn-info" type="submit">提交</button>&nbsp;&nbsp;&nbsp;
             		&nbsp;&nbsp;&nbsp;<button type="reset" class="btn btn-default">重置</button>
             	</div>
             </div>
          </form>
</body>
</html>
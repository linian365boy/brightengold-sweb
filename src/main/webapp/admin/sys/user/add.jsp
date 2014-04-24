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
			 errorPlacement: function(error, element) {
			        error.appendTo( element.siblings("span"));
			 },
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
            <div class="form-group">
            	<label for="username" class="col-xs-2 control-label">用户名</label>
            	<div class="col-xs-4">
            		<input id="username" class="form-control" name="username" placeholder="用户名"  type="text"  autocomplete="off"/>
            	</div>
			</div>
			
            <div class="form-group">
            	<label for="password" class="col-xs-2 control-label">密码 </label>
            	<div class="col-xs-4">
            		<input name="password" class="form-control" autocomplete="off" type="password"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="realName" class="col-xs-2 control-label">姓名</label>
            	<div class="col-xs-4">
	            	<input name="realName" class="form-control" type="text" id="realName"/>
            	</div>
            </div>
            
            <div id="label">
            	<label for="role">角色分配：</label>
	            <select name="role" id="roles" style="width: 158px; margin-left: 0px;margin-bottom: 5px;">
	              <%--<option value="0">=====角色分配=====</option>--%>
	             </select>
             </div>
			<div id="label"><label for="status">状态：</label></div>
            	<input type="checkbox" name="enabled"/>
            <span>（勾选表示启用此账号，否则禁用）</span>
            <br/>
            <input type="hidden" value="${param.pageNo }" name="pageNo"/>
            <div class="aui_buttons" style="width:388px;">
              <button class="aui_state_highlight" type="submit">提交</button>
              <button type="reset">重置</button>
            </div>
          </form>
</body>
</html>
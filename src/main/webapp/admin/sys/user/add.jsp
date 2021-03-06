<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/commons/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户添加|GELAIMEI Furniture后台管理系统</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx }resources/js/validatePlugin/jquery.validatePlugin.js"></script>
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
					chrnum:true,
					rangelength:[1,12],
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
					required:true,
					rangelength:[6,12]
				},
				"realName":{
					required:true,
					rangelength:[1,5]
				}
			},
			messages:{
				"username":{
					required:"账号不能为空",
					chrnum:"账号需数字、字母",
					remote:"账号已存在",
					rangelength:jQuery.format("长度在{0}与{1}之间")
				},
				"password":{
					required:"密码不能为空",
					rangelength:jQuery.format("长度在{0}与{1}之间")
				},
				"realName":{
					required:"姓名不能为空",
					rangelength:jQuery.format("字数在{0}与{1}之间")
				}
			}
		});
	});
	</script>
</head>
<body>
	<form id="form" class="form-horizontal" action="${ctx }admin/sys/user_add.do" method="post" target="_parent">
            <div class="form-group" style="width:500px;">
            	<label for="username" class="col-xs-3 control-label" style="text-align: right;">账号</label>
            	<div class="col-xs-9">
            		<input id="username" class="form-control" style="width:55%;" name="username" placeholder="账号"  type="text"  autocomplete="off"/>
            	</div>
			</div>
			
            <div class="form-group" style="width:500px;">
            	<label for="password" class="col-xs-3 control-label" style="text-align: right;">密码 </label>
            	<div class="col-xs-9">
            		<input name="password" id="password" class="form-control" style="width:55%;" placeholder="密码" autocomplete="off" type="password"/>
            	</div>
            </div>
            
            <div class="form-group" style="width:500px;">
            	<label for="realName" class="col-xs-3 control-label" style="text-align: right;">姓名</label>
            	<div class="col-xs-9">
	            	<input name="realName" class="form-control" style="width:55%;" placeholder="姓名" type="text" id="realName"/>
            	</div>
            </div>
            
            <div class="form-group" style="width:500px;">
            	<label for="role" class="col-xs-3 control-label" style="text-align: right;">角色</label>
            	<div class="col-xs-9">
	            <select name="role" id="roles" style="width:55%;" class="form-control">
	              <%--<option value="0">=====角色分配=====</option>--%>
	             </select>
	             </div>
             </div>
             <div class="form-group" style="width:500px;">
            	<div class="col-xs-offset-3 col-sm-3">
					<div class="checkbox">
						<label>
		            	<input type="checkbox" name="enabled"/>是否启用账号
		            	</label>
					</div>
				</div>
            </div>
            
            <input type="hidden" value="${param.pageNo }" name="pageNo"/>
            <div class="form-group" style="width:500px;">
            	<div class="col-xs-offset-3 col-sm-3">
             		<button class="btn btn-info" type="submit">提交</button>&nbsp;&nbsp;&nbsp;
             		&nbsp;&nbsp;&nbsp;<button type="reset" class="btn btn-default">重置</button>
             	</div>
             </div>
          </form>
</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 <%@include file="../../../commons/include.jsp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>角色新增|brightengold后台管理系统</title>
<link href="${ctx}resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx}resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx}resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${ctx}resources/css/style.css" />
<script type="text/javascript">
	$(document).ready(function(){
		$(function(){
			$("#form").validate({
				rules:{
					"desc":{
						required:true
					}
				},
				messages:{
					"desc":{
						required:"角色不能为空"
					}
				}
			});
		});
	});
</script>
</head>
<body>
		<form id="form" class="form-horizontal" action="${ctx}admin/sys/role_add.do" method="post" target="_parent">
			 <div class="form-group" style="width:500px;">
            	<label for="desc" class="col-xs-3 control-label" style="text-align: right;">角色 </label>
            	<div class="col-xs-9">
            		<input name="desc" class="form-control" placeholder="角色" style="width:55%;" type="text" id="desc"/>
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

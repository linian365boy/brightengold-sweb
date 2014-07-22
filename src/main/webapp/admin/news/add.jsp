<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/commons/include.jsp" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/admin/commons/listJsCss.jsp" %>
<%@include file="/admin/commons/jsCss.jsp" %>
 <script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
<style type="text/css">
body{
		font-size: 12px;
		font-family: Arial, Tahoma, Verdana;
	}
</style>
<title>添加项目|GELAIMEI Furniture后台管理系统</title>
<script type="text/javascript">
	var valiResult;
	$(document).ready(function(){
		valiResult = $("#form").validate({
			meta:"validate",
			rules:{
				"title":{
					required:true,
					rangelength:[1,100]
				},
				"priority":{
					number:true
				}
			},
			messages:{
				"title":{
					required:"标题不能为空！",
					rangelength:jQuery.format("标题长度在{0}与{1}之间")
				},
				"priority":{
					number:"优先值为数字！"
				}
			}
		});
	});
	
	function doSubmit(){
		CKEDITOR.instances.content.updateElement();
		var content = $("#content").val();
		var length = $.trim(content).length;
		if(length<=0){
			$("#contentSpan").show();
		}
		if(valiResult.form()&&length>0){
			$("#contentSpan").hide();
			$("#form").submit();
			return true;
		}
		return false;
	}
</script>
</head>
<body>
<jsp:include page="/admin/commons/header.jsp"/>
	<jsp:include page="/admin/commons/left.jsp">
		<jsp:param value="10" name="menuId"/>
		<jsp:param value="项目管理" name="menuName"/>
		<jsp:param value="添加项目" name="menuSubName"/>
	</jsp:include>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">添加项目</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
		<form role="form" action="${ctx }admin/news/news_add.do" class="form-horizontal" id="form" method="post">
			<div class="form-group">
	            <label for="title" class="col-sm-3 control-label">标题</label>
				<div class="col-sm-4">
		            <input class="form-control" id="title" name="title" type="text"  placeholder="标题"/>
				</div>
			</div>
			
			<div class="form-group">
				<label for="introduce" class="col-sm-3 control-label">摘要</label>
				<div class="col-sm-6">
				<textarea class="form-control" rows="3" name="introduce"></textarea>
				</div>
			</div>
			
			<div class="form-group">
	            <label for="keyWords" class="col-sm-3 control-label">关键字（多个以英文;隔开）</label>
				<div class="col-sm-4">
		            <input id="keyWords" class="form-control" name="keyWords" type="text" placeholder="关键字"/>
				</div>
			</div>
			
			<div class="form-group">
	            <label for="priority" class="col-sm-3 control-label">优先值（越大排名越前）</label>
				<div class="col-sm-4">
		            <input id="priority" class="form-control" name="priority" type="text" placeholder="优先值"/>
				</div>
			</div>
			
			<div class="form-group">
	            <label for="content" class="col-sm-3 control-label">内容</label>
				<div class="col-sm-8">
		            <textarea id="content" class="ckeditor form-control" name="content"></textarea>
		            <span id="contentSpan" style="background: url(/resources/images/x.png) no-repeat 0px 0px;color:red;padding-left:18px;display: none;">内容不能为空！</span>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-10">
					<button type="button" onclick="return doSubmit();" class="btn btn-info">提交</button>&nbsp;&nbsp;&nbsp;
            	&nbsp;&nbsp;&nbsp;<button type="reset" class="btn btn-default">重置</button>
				</div>
			</div>
          </form>
          </div>
          </div>
          </article>
         </section>
</body>
</html>
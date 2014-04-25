<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/commons/include.jsp" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品新增</title>
<%@include file="/admin/commons/jsCss.jsp" %>
 <%@include file="/admin/commons/listJsCss.jsp" %>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx }resources/js/validatePlugin/jquery.validatePlugin.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
	<script type="text/javascript">
	$(document).ready(function(){
		$("#form").validate({
			rules:{
				"enName":{
					required:true
				},
				"photo":{
					required:true,
					isImgFile:true
				}
			},
			messages:{
				"enName":{
					required:"商品名称不能为空！"
				},
				"photo":{
					required:"商品图片不能为空！",
					isImgFile:"请上传jpg|jpeg|bmp|gif|png图片格式文件!"
				}
			}
		});
	});
	
		$.getJSON("${ctx}admin/goods/category_getParentByAjax.do?flag=0",function(returnJson){
			var json = $(returnJson);
			var str = "";
			for(var i=0;i<json.length;i++){
				str+="<option value="+json.get(i)[0]+">"+json.get(i)[1]+"</option>";
			}
			$("#parentCs").append(str);
		});
	</script>
</head>
<body>
<jsp:include page="/admin/commons/header.jsp"/>
	<jsp:include page="/admin/commons/left.jsp">
		<jsp:param value="8" name="menuId"/>
		<jsp:param value="商品管理" name="menuName"/>
		<jsp:param value="新增商品" name="menuSubName"/>
	</jsp:include>
	<section id="main" class="column">
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">新增商品</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" role="form" class="form-horizontal" action="${ctx }admin/goods/product_add.do" method="post" enctype="multipart/form-data">
		
		<div class="form-group">
			<label for="enName" class="col-sm-2 control-label">商品名称</label>
			<div class="col-sm-4">
				<input type="text" class="form-control" placeholder="商品名称" id="enName" name="enName"/>
			</div>
		</div>
             <div class="form-group">
             	<label for="introduce" class="col-sm-2 control-label">商品介绍</label>
             	<div class="col-sm-6">
            		<textarea class="form-control" rows="3" id="introduce" name="introduce"></textarea>
            	</div>
             </div>

            <div class="form-group">
            	<label for="photo" class="col-sm-2 control-label">商品图片</label>
            	<div class="col-sm-4">
	            	<input type="file" name="photo"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="category" class="col-sm-2 control-label">商品分类</label>
            	<div class="col-sm-4">
            	<select class="form-control" name="parentC" id="parentCs">
            	</select>
            	</div>
            </div>
            <div class="form-group">
            	<div class="col-sm-offset-2 col-sm-10">
            		<div class="checkbox">
            			<label>
		            		<input name="hot" type="checkbox"/>是否热门
		            	</label>
            		</div>
            	</div>
            </div>
            
            <div class="form-group">
            	<div class="col-sm-offset-2 col-sm-10">
            		 <button class="btn btn-info" type="submit">提交</button>&nbsp;&nbsp;&nbsp;
            		 &nbsp;&nbsp;&nbsp;<button class="btn btn-default" type="reset">重置</button>
            	</div>
            </div>
            
          </form>
          </div>
          </div>
          </article>
       </section>
</body>
</html>
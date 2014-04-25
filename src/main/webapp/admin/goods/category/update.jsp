<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品分类编辑</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
<script type="text/javascript">
$(document).ready(function(){
	$("#form").validate({
			rules:{
				"enName":{
					required:true,
					remote:{
						type:'POST',
						url:'${ctx}admin/goods/category_existCategory.do',
						data:{
							enName:function(){
								return $("#enName").val();
							},
							en:function(){
								return "${model.enName}";
							}
						}
					}
				}
			},
			messages:{
				"enName":{
					required:"商品分类不能为空",
					remote:"分类已存在，请更换！"
				}
			}
	});
});
</script>
</head>
<body>
	<form id="form" class="form-horizontal" action="${ctx}admin/goods/category_update.do" method="post" target="_parent">
            <div class="form-group" style="width:100%;">
            	<label for="parents" class="col-xs-3 control-label" style="text-align: right;">一级分类</label>
            	<div class="col-xs-9">
             	<select name="parents" id="parents" class="form-control" style="width:55%;">
		            <c:forEach items="${parents }" var="parent">
		            	<option value="${parent[0] }"
		            			<c:if test="${parent[0] eq model.parent.id }">
		            				selected="selected"
		            			</c:if>
		            		>
		            			${parent[1] }
		            		</option>
		            </c:forEach>
            	</select>
            	</div>
            </div>
            <div class="form-group" style="width:100%;">
            	<label for="enName" class="col-xs-3 control-label" style="text-align: right;">名称</label>
            	<div class="col-xs-9">
	            	<input name="enName" id="enName" value="${model.enName }" class="form-control" style="width:55%;"  type="text" />
            	</div>
            </div>	
            <input type="hidden" value="${pageNo }" name="pageNo"/>
            <input type="hidden" name="id" value="${model.id }"/>
            <div class="form-group" style="width:100%;">
            <div class="col-xs-offset-3 col-sm-3">
              <button class="btn btn-info" type="submit" >提交</button>&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;<button type="reset" class="btn btn-default">重置</button>
            </div>
            </div>
          </form>
</body>
</html>
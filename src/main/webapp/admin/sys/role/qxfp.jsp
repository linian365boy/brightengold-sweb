<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../../commons/include.jsp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>角色权限分配|brightengold后台管理系统</title>
<link rel="stylesheet" type="text/css" href="${ctx}resources/css/dhtmlxtree.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}resources/css/style.css" />
<script src="${ctx}resources/js/dhtmlxcommon.js"></script>
<script src="${ctx}resources/js/dhtmlxtree.js"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
 <%@include file="/admin/commons/jsCss.jsp" %>
<script src="${ctx}resources/js/jquery-1.8.3.js" type="text/javascript"></script>
<link href="${ctx }resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="${ctx}resources/css/style.css" />
<script type="text/javascript">
	$(document).ready(function() {
		$.getJSON("${ctx}admin/sys/role_getRolesByAjax.do", function(data) {
			var da = $(data);
			var str = "";
			for ( var i = 0; i < da.length; i++) {
				str += "<option value=" + da.get(i)[0] + ">" + da.get(i)[1];
				str += "</option>";
			}
			$("#roles").append(str);
		});
	});
	var tree = null;
	var selectValue = null;
	function change(obj){
		//alert(obj.value);
		selectValue = obj.value;
		if(selectValue!=0&&selectValue!=null&&selectValue!="null"&&selectValue!=undefined){
			$("#tree").empty();
			tree = new dhtmlXTreeObject({
				parent : "tree",
				image_path : "${ctx}resources/css/imgs/csh_dhx_skyblue/",
			});
			tree.setDataMode("xml");
			tree.enableCheckBoxes(true);
		    tree.enableThreeStateCheckboxes(true);
			tree.setXMLAutoLoading("${ctx}admin/sys/menu_findMenuByRole.do?name="+selectValue)+"&flag=true";
		   	tree.loadXML("${ctx}admin/sys/menu/menu_findMenuByRole.do?id=0&name="+selectValue+"&flag=true",function(){
		   		tree.openAllItems(0);
		   	});
		}
	}
	function sub(){
		if(selectValue==null||selectValue==0){
			alert("请选择角色");
			return false;
		}else{
			//所有选择的
			//var allChecked = tree.getAllChecked().split(',');
			//所有叶子节点
			//var leaf = tree.getAllChildless().split(',');
			//所有选择的（更全，包括两种状态的选择），它包括了allChecked
			var allCheckedBranches = tree.getAllCheckedBranches().split(",");
			//var str = "";
			//var strMenu = "";
			//alert("allChecked："+allChecked+"leaf："+leaf+"allCheckedBranched："+allCheckedBranches);
			//alert("allCheckedBranched："+allCheckedBranches);
			//得到全为叶子并且已经选择的str
			/*$.each(allChecked,function(key,val){
				if($.inArray(val,leaf)>=0){
					if(key<allChecked.length-1){
						str+=val+",";
					}else{
						str+=val;
					}
				}
			});*/
			//var checkedleaf = str.split(",");
			//排除掉选择叶子的节点，（就是一级二级已经选择的节点，不管是不是全选）
			/*$.each(allCheckedBranches,function(key,val){
				if($.inArray(val,checkedleaf)==-1){
					if(key<allCheckedBranches.length-1){
						strMenu+=val+",";
					}else{
						strMenu+=val;
					}
				}
			});*/
			$("#name").attr("value",selectValue);
			$("#str").attr("value",allCheckedBranches);
			$("#actionForm").submit();
		}
	}
</script>
<!--[if IE]>
<link rel="stylesheet" type="text/css" href="css/ie-sucks.css" />
<![endif]-->
<style type="text/css">
#tree table tr td,th{
	clear:both;
	padding:0px;
	border:0px;
	text-align:left;
}
</style>
</head>
<body>
<jsp:include page="/admin/commons/header.jsp"/>
<jsp:include page="/admin/commons/left.jsp">
	<jsp:param value="3" name="menuId"/>
	<jsp:param value="角色管理" name="menuName"/>
	<jsp:param value="分配权限" name="menuSubName"/>
</jsp:include>
<section id="main" class="column">
	<jsp:include page="/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">分配权限</h3>
		</header>
			<div class="tab_container">
		<div id="wrapper">
			<div id="content">
				<div id="infobox">
					<div id="box">
						<div style="width:500px;height:650px; text-align:left;">
							<form class="form-horizontal" action="${ctx }admin/sys/role_distribute.do" id="actionForm" method="post">
								<div class="form-group">
									<label for="roles" class="col-sm-3 control-label">选择角色</label>
									<div class="col-sm-4">
										<select id="roles" class="form-control" onchange="change(this);">
											<option value="0">--请选择--</option>
										</select> 
									</div>
								</div>
								<div class="form-group">
									<label for="tree" class="col-sm-3 control-label">选择权限 </label> 
									<div class="col-sm-4">
										<div class="demo">
											<div style="width: 500px; height: 500px; overflow: auto;">
												<div id="tree" ></div>
											</div>
										</div>
									</div>
								</div>
								<input type="hidden" name="name" id="name"/>
								<%--包括所有被选中的菜单与资源 --%>
								<input type="hidden" name="str" id="str"/>
								<%--很诡异的一个错误，下面这个input的type不能为submit，否则在IE下会出现提交两次的结果 --%>
								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-10">
									<input type="button" class="btn btn-danger" id="button" value="确认分配" onclick="return sub();" />
								<%--&nbsp;&nbsp; <input type="reset" id="button"value="重置" />--%>
									</div>
								</div>
							</form>
							<br />
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</article>
		</section>
</body>
</html>

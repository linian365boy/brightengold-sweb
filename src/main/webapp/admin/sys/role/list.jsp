<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/admin/commons/listJsCss.jsp" %>
 <%@include file="/admin/commons/jsCss.jsp" %>
<title>角色管理|GELAIMEI Furniture后台管理系统</title>

<script type="text/javascript">

	var update = function(obj){
		var roleName = $(obj).attr("name");
		var url = '${ctx}admin/sys/role_updatePre.do?pageNo=${pageNo}&name='+roleName;
		art.dialog.open(url,{
			title:'编辑角色信息',
			id:'bianji',
			width:500,
			resize: false
			});
		};
		
		var tianjia = function(){
			var url = "${ctx}admin/sys/role/add.jsp?pageNo=${pageNo}";
			art.dialog.open(url,{
				title:'添加角色',
				id:'tianjia',
				width: 500,
				resize: false
			});
		};
		
		var del = function(obj){
			var roleName = $(obj).attr("name");
			art.dialog.confirm('确定删除此角色',function(){
				var url = '${ctx}admin/sys/role_del.do?pageNo=${pageNo}&name='+roleName;
				window.location.href=url;
			});
		};
		
		function qxfp(){
			window.location.href = '${ctx}admin/sys/role/qxfp.jsp';
		}
		
</script>
</head>
<body>
	<jsp:include page="/admin/commons/header.jsp"/>
	<jsp:include page="/admin/commons/left.jsp">
		<jsp:param value="3" name="menuId"/>
		<jsp:param value="角色管理" name="menuName"/>
	</jsp:include>
	<section id="main" class="column">
	<jsp:include page="/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">角色列表</h3>
		<ul class="tabs">
			<c:url value="${ctx }admin/sys/role_export.do" var="exportUrl" scope="page"/>
   			<li><a href="javascript:void(0);" onclick="tianjia();">新增角色</a></li>
   			<li><a href="javascript:void(0);" onclick="qxfp();">权限分配</a></li>
		</ul>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th >序号</th>
					<th >角色</th>
					<th width="600px">权限</th>
					<th >操作</th>
				</tr> 
			</thead> 
			<tbody id="dataContent"> 
				<c:forEach items="${page.result }" var="role" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td>${role.desc }</td>
					<td>
						<c:forEach items="${role.resources }" var="resource" varStatus="rowm">
							<span class="label label-primary" title="${resource.descn }">${resource.descn }
							</span>&nbsp;
              			</c:forEach>
					</td>
					<td>
						<input type="image" name="${role.name }" onclick="update(this);"
						src="${ctx }resources/images/icn_edit.png" title="修改"/>
						<input type="image" name="${role.name }" onclick="del(this);" 
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;&nbsp;
					</td>
				</tr>
			</c:forEach>
			</tbody> 
			<tfoot>
				<tr>
                <td colspan="12">
                	<div class="paginationD">
                		<c:import url="/admin/commons/page.jsp">
                			<c:param name="url" value="admin/sys/role_list.do"/>
                		</c:import>
                	</div>
                  <!-- <div class="clear"></div></td> -->
              </tr>
			</tfoot>
			</table>
			</div><!-- end of #tab1 -->
		</div><!-- end of .tab_container -->
		</article><!-- end of content manager article -->
	</section>
</body>
</html>
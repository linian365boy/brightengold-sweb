<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/admin/commons/listJsCss.jsp" %>
 <%@include file="/admin/commons/jsCss.jsp" %>
<title>项目管理|brightengold后台管理系统</title>
<script type="text/javascript">
	var update = function(obj){
		var newsId = $(obj).attr("name");
		var url = '${ctx}admin/news/news_updatePre.do?pageNo=${pageNo}&id='+newsId;
		window.location.href=url;
		};
		//del
		var del = function(obj){
			var newsId = $(obj).attr("name");
			art.dialog.confirm('确定删除此项目？',function(){
				var url = '${ctx}admin/news/news_del.do?pageNo=${pageNo}&id='+newsId;
				window.location.href=url;
			});
		};
		//purview
		var purview = function(obj){
			var newsId = $(obj).attr("name");
			var url = '${ctx}admin/news/news_detail.do?id='+newsId;
			window.open(url);
		};
		//publish
		var publish = function(obj){
			var newsId = $(obj).attr("name");
			var str = "确定发布此项目？";
			$.get("${ctx}admin/news/news_checkPub.do?id="+newsId,function(rs){
				if(rs==1){
					str = "此项目已发布，确定重新发布？";
				}
				art.dialog.confirm(str,function(){
					$.getJSON("${ctx}admin/news/news_publishNews.do?pageNo=${pageNo}&id="+newsId,function(data){
						var json = $(data);
						var dialog = art.dialog({
							id:"publish",
							lock:true
						});
						if(json[0].key==1){
							dialog.content('恭喜您，发布成功！').time(2.5);
							$("#"+newsId).html(json[0].value);
						}else{
							dialog.content('对不起，发布失败！').time(2.5);
						}
					});
				});
			});
		};
		
</script>
</head>
<body>
	<jsp:include page="/admin/commons/header.jsp"/>
	<jsp:include page="/admin/commons/left.jsp">
		<jsp:param value="10" name="menuId"/>
		<jsp:param value="项目管理" name="menuName"/>
	</jsp:include>
	<section id="main" class="column">
	<jsp:include page="/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">项目列表</h3>
		<ul class="tabs">
   			<li><a href="${ctx}admin/news/add.jsp" >新增项目</a></li>
		</ul>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th >序号</th>
					<th >项目标题</th>
					<th >创建日期</th>
					<th >发布日期</th>
					<th >优先值</th>
					<th >操作</th>
				</tr>
			</thead> 
			<tbody id="dataContent"> 
				<c:forEach items="${page.result }" var="news" varStatus="status">
				<tr>
					<td>${(page.currentPageIndex-1)*page.pageSize+status.index+1 }</td>
					<td><a href="${ctx }admin/news/news_detail.do?id=${news.id}" title="${news.title }" target="_blank">${news.title }</a></td>
					<td>${news.createDate }</td>
					<td id="${news.id }">
						<c:choose>
							<c:when test="${ empty news.publishDate}">
								<span class='label label-default' title='未发布'>未发布</span>
							</c:when>
							<c:otherwise>
								${ news.publishDate}
							</c:otherwise>
						</c:choose>
					</td>
					<td>${ news.priority}</td>
					<td>
						<input type="image" name="${news.id }" onclick="update(this);"
						src="${ctx }resources/images/icn_edit.png" title="修改"/>&nbsp;
						<input type="image" name="${news.id }" onclick="purview(this);" 
						src="${ctx }resources/images/icn_preview.png" title="预览"/>&nbsp;
						<input type="image" name="${news.id }" onclick="publish(this);" 
						src="${ctx }resources/images/icn_publish.png" title="发布"/>&nbsp;
						<input type="image" name="${news.id }" onclick="del(this);" 
						src="${ctx }resources/images/icn_trash.png" title="删除"/>&nbsp;
					</td>
				</tr>
				</c:forEach>
				</tbody> 
			<tfoot>
				<tr>
                <td colspan="12">
                	<div class="paginationD">
                		<c:import url="/admin/commons/page.jsp">
                			<c:param name="url" value="admin/news/news_list.do"/>
                		</c:import>
                	</div>
              </tr>
			</tfoot>
			</table>
			</div><!-- end of #tab1 -->
		</div><!-- end of .tab_container -->
		</article><!-- end of content manager article -->
	</section>
</body>
</html>
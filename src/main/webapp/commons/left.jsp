<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/commons/include.jsp" %>
<div class="Z_MenuList">
      <ul>
      <c:forEach items="${parentCats }" var="pCategory" varStatus="pindex">
      	<li class="${pindex.index%2!=0?'':'alt' }">
      		<h3>${pCategory.enName } </h3>
      		<c:forEach items="${pCategory.children }" var="cCategory" varStatus="cindex">
      			<p style="display: none;"> 
      				<a title="Robotica" target="_blank" href="${ctx }views/category.jsp?cateid=${cCategory.id}">${cCategory.enName }</a>
      			</p>
      		</c:forEach>
      	</li>
      </c:forEach>
      </ul>
    </div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/commons/include.jsp" %>
<script type="text/javascript">
<!--
function pCate(id){
	window.location.href = "${ctx }views/getProduct.do?cateid="+id;
}
//-->
</script>
 <div class="Z_MenuList">
      <ul>
      <c:forEach items="${parentCats }" var="pCategory" varStatus="pindex">
      	<li class="${pindex.index%2!=0?'':'alt' }" onclick="pCate(${pCategory.id });">
      		<h3>${pCategory.enName } </h3>
      		<c:forEach items="${pCategory.children }" var="cCategory" varStatus="cindex">
      			<p style="display: block;"> 
      				<a title="${cCategory.enName }" href="${ctx }views/getProduct.do?cateid=${cCategory.id}">${cCategory.enName }</a>
      			</p>
      		</c:forEach>
      	</li>
      </c:forEach>
      </ul>
    </div>

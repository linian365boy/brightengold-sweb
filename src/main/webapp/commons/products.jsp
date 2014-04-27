<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/commons/include.jsp" %>
<div id="etw_hot_products"> 
<ul class="hotproducts">
<c:forEach items="${hotPage.result }" var="hproduct" varStatus="status">
	<ol class="hot_${status.index }">
<li class="hotproductsphotos">
<a href="${ctx }${hproduct.url}">
<img src="/resources/${hproduct.picUrl }" title="${hproduct.enName }"></a>
</li><li class="hotproductsname">
<a href="${ctx }${hproduct.url}">${hproduct.enName }</a><p>${hproduct.introduce }</p>
                <a href="${ctx }${hproduct.url}" class="more">View Details &gt;&gt;</a></li>
                </ol>
</c:forEach>
     </ul>
</div> 
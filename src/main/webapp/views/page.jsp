<%@page import="java.net.URLEncoder"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/commons/include.jsp" %>
				<c:if test="${not empty page}">
					<c:choose>
						<c:when test="${page.hasPrev}">
							<li class="previous">
								<a href="${ctx}${param.url}?pageNo=${page.currentPageIndex - 1}${!empty cateId?'&cateid=':''}${cateId}">Previous</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="previous-off">«Previous</li>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="${page.startPageIndex}" end="${page.endPageIndex}"
						var="i">
						<c:choose>
							<c:when test="${i==page.currentPageIndex}">
								<li class="active">${i }</li>
		 					</c:when>
							<c:otherwise>
								<li><a title="${i }" href="${ctx}${param.url}?pageNo=${i }${!empty cateId?'&cateid=':''}${cateId}">${i }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${page.hasNext}">
							<li class="next"><a href="${ctx}${param.url}?pageNo=${page.currentPageIndex+1 }${!empty cateId?'&cateid=':''}${cateId}">Next</a></li>
						</c:when>
						<c:otherwise>
							<li class="next-off">Next»</li>
						</c:otherwise>
					</c:choose>
				</c:if>

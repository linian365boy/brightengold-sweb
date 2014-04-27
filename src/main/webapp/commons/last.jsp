<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/commons/include.jsp" %>
<div id="etw_contact">
<div class="etw_contact_title1"><a href="http://www.glmfurniture.com/add/contact">Latest Recommended</a></div>
<div class="clear"></div>
<div id="etw_contactin" class="scrolllist">
        <a class="abtn aleft" href="#left" title="move to left"></a>
		<div class="imglist_w">
			<ul style="left: -202px;" class="imglist">
				<c:forEach items="${lastPage.result }" var="lProduct" varStatus="status">
					<li>
						<a target="_blank" href="${ctx }${lProduct.url}" title="${lProduct.enName }">
						<img alt="${lProduct.enName }" src="/resources/${lProduct.picUrl}" height="126" width="186"></a>
						<p><a target="_blank" href="${ctx }${lProduct.url}">${lProduct.enName }</a></p>
					</li>
				</c:forEach>
			</ul><!--imglist end-->
		</div>
		<a class="abtn aright" href="#right" title="move to right"></a>
<div class="clear"></div> 
    </div>
     <script type="text/javascript" src="/resources/js/slider.js"></script>
     <script type="text/javascript">
     $(function(){
 		//默认状态下左右滚动
 		$("#etw_contactin").xslider({
 			unitdisplayed:3,
 			movelength:1,
 			unitlen:202,
 			dir:"H",
 			autoscroll:2000
 		});
 	});
     </script>
    </div>
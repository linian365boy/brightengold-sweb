<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/commons/include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="brightengold furniture,brightengold,furniture, Hotel furniture, dining tables, restaurant furniture, hotel furniture accessories, decorative furniture">
<meta name="description" content="Welcome to the home of Brightengold Furniture, a leader in contemporary furniture design in China! Our sofa suites, dining table and other furniture are well-received in hotels and restaurants.">
<link href="${ctx }resources/css/index.css" type="text/css" rel="stylesheet">
<link href="${ctx }resources/css/basic.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<title>${model.title }|Brightengold Furniture</title>
<script type="text/javascript">
	var content=new Object;  
	var context="";//HTML文本内容  
	var pgindex=[];//存储分页位置的数组  
	var cont=[];//存储分段内容  
	var pagesel="";//生成分页标签时用  
	var contpg=0;//页号
	$(document).ready(function(){
		initpg();
		searchpg();
	});
	
    function initpg(){
	    contpg=0;  //置空变量  
	    pgindex.splice(0,pgindex.length);  
	    pgindex[0]=0;  
	    cont.splice(0,cont.length);  
	    pagesel="";  
	    content=document.getElementById("nc_con");  //获取节点HTML文本内容，搜索所有分页标签出现位置  
	    context=content.innerHTML;  
		var i=0;  
		var j=1;  
		var tmpp=0;  
	    
   	    while(tmpp=context.indexOf("<div style=\"page-break-after: always",i)){  
   	        if(tmpp!=-1){  
   	            pgindex[j++]=tmpp;  
   	            i=tmpp+30;  
   	        }else{  
   	            break;  
   	        }  
   	    }     
	}
	
    function searchpg(){  
    if(pgindex.length>1){  
        
        for(var i=0;i<pgindex.length;i++)  
        {  
         cont[i]=context.substring(pgindex[i],pgindex[i+1]);  
        }  
        pagese();  
        content.innerHTML=cont[0];  
        document.getElementById("nc_page").innerHTML=pagesel;//换页使用的按钮内容输出在id=nc_page元素下  
    }else  
    pagese();  
    document.getElementById("nc_page").innerHTML=pagesel;  
}  
    
    function pagese(){  
        if(cont.length>0){  
            if(contpg==0){  
                pagesel="First &nbsp;&nbsp; Previous &nbsp;&nbsp;<a href='#' onclick='nextpa()'>Next</a> &nbsp;&nbsp; <a href='#' onclick='endpa()'>Last</a>";  
            }else if(contpg!=0&&contpg<cont.length-1){  
                pagesel="<a href='#' onclick='firstpa()'>First</a>&nbsp;&nbsp; <a href='#' onclick='prepa()'>Previous</a> &nbsp;&nbsp; <a href='#' onclick='nextpa()'>Next</a>&nbsp;&nbsp; <a href='#' onclick='endpa()'>Last</a>";  
            }else if(contpg==cont.length-1){  
                pagesel="<a href='#' onclick='firstpa()'>First</a>&nbsp;&nbsp; <a href='#' onclick='prepa()'>Previous</a>&nbsp;&nbsp; Next &nbsp;&nbsp; Last";  
            }  
        }  
    }
    
    function nextpa(){
    	contpg++;
    	pagese();		
    	content.innerHTML=cont[contpg];
    	document.getElementById("nc_page").innerHTML=pagesel;
    	
    }
    function prepa(){
    	contpg--;
    	pagese();
    	content.innerHTML=cont[contpg];
    	document.getElementById("nc_page").innerHTML=pagesel;
    }
    function firstpa(){
    	contpg=0;
    	pagese();
    	content.innerHTML=cont[contpg];
    	document.getElementById("nc_page").innerHTML=pagesel;
    }
    function endpa(){
    	contpg=cont.length-1;
    	pagese();
    	content.innerHTML=cont[contpg];
    	document.getElementById("nc_page").innerHTML=pagesel;
    }
    
	
</script>
</head>
  <body>
  <jsp:include page="/commons/top.jsp"></jsp:include>
	<jsp:include page="/commons/menu.jsp"></jsp:include>
	<div class="clear"></div>
<div id="container"> 
  <div id="center"> 
  <div style="left: 100px ! important;" class="Z_TypeList" id="Z_TypeList">
    <h1 class="title">Product categories<s class="btn_group bleft"><a class="bleft"></a><a class="bright"></a></s></h1>
    <jsp:include page="/commons/left.jsp"></jsp:include>
    <div class="footerlist">
     <jsp:include page="/commons/contact.jsp"></jsp:include>
     </div>
  </div>
  <script type="text/javascript" src="${ctx }resources/js/jquery.tmailsider.js"></script>
<script type="text/javascript">
    $('#Z_TypeList').Z_TMAIL_SIDER();
</script>
<div class="etw_hometitle">
<img width="665px" height="28" border="0" src="/resources/images/news.jpg"/></div>
<div id="etw_right"> 
  <div class="wrapper cFloat">
	<div class="content">
        <div class="fl cFloat" id="left">
        	<div class="info_text">
            	<h1>${model.title}</h1>
                <div class="titBar">Hits:<span id="clickcount">${model.clicks }</span> | Publish Date：<fmt:formatDate value="${model.publishDate}" pattern="yyyy-MM-dd"/></div>
                <div class="bd cFloat">
                	                	<div class="introduction"><strong>Abstract:</strong>&#12288;&#12288;${model.introduce }</div>
					                    <div id="nc_con" class="bd-content" style="word-wrap: break-word;word-break: normal; ">
					                    ${model.content }
                    </div>
                    <div class="info-text-foot cFloat">
                		<div class="fl">
                		Tag:<c:forTokens items="${model.keyWords }" delims=";" var="keyword" varStatus="n">
                			<%-- <a href="${ctx }cu/news/news_li.do?title=${keyword}"> --%>${keyword }<!-- </a> -->&nbsp;&nbsp;
                			<c:if test="${!n.last }">
                				|&nbsp;&nbsp;
                			</c:if>
                		</c:forTokens>
                		</div>
					</div>
                    <div class="hq-pagination hq-pagination-centered">
            			<div id="nc_page"></div>
            		</div><!--end hq-pagination-->
					<!-- Baidu Button END -->
                 </div><!--end bd-->
		</div><!--end info_text-->
    </div><!--end left-->
 </div><!--end content-->
</div>
</div>
</div>
</div>
  </body>
</html>

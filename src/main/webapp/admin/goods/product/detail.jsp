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
<script type="text/javascript" src="${ctx }resources/js/jquery-1.8.3.js"></script>
<title>${model.enName }|Brightengold Furniture</title>
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
<img width="665px" height="28" border="0" src="/resources/images/chapinreg.jpg"/></div>
<div id="etw_right"> 
<div id="productsformat">
<div class="productsformat_sub">
						<div align="center">
								<table width="97%" border="0" cellspacing="0" cellpadding="0" id="table16">
			<tbody><tr>
				<td style="LINE-HEIGHT: 24px"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tbody><tr>
                          <td height="1">             
							<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table20">
                        <tbody><tr>
                          <td width="452" height="25">&nbsp;<a href="${ctx }views/getProduct.do?cateid=${model.category.id}">${model.category.enName }</a>&nbsp;&gt;&gt;&nbsp;${model.enName }</td>
                          <td width="98" valign="middle">&#12288;</td>
                        </tr>
                        <tr>
                          <td height="237" colspan="2">
							<table width="95%" border="0" align="center" cellspacing="0" cellpadding="0" id="table21">
                              <tbody><tr>
                                <td width="344" height="2">
								</td>
                                <td valign="top" rowspan="2">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table24">
									<tbody><tr>
										<td height="2"></td>
									</tr>
									<tr>
										<td height="40">name:<font color="#FF6600"><strong>${model.enName }</strong></font></td>
									</tr>
									<tr>
										<td height="40">category:<font color="#FF6600"><strong>${model.category.enName}</strong></font></td>
									</tr>
									<tr>
										<td height="40">&#12288;</td>
									</tr>
								</tbody></table>
								</td>
                              </tr>
                              <tr>
                                <td width="344"><div align="center">
                                  <a target="_blank" href="/resources/${model.picUrl }">
									<img width="260" height="260" border="0" style="BORDER-LEFT-COLOR: #cccccc; BORDER-BOTTOM-COLOR: #cccccc; BORDER-TOP-COLOR: #cccccc; BORDER-RIGHT-COLOR: #cccccc" src="/resources/${model.picUrl }"></a>
                                                                  
                                </div></td>
                              </tr>
                              
                              <tr>
                                <td width="344" height="9">&nbsp;</td>
                                <td height="9"></td>
                              </tr>
                          </tbody></table></td>
                        </tr>
                        <tr>
                          <td height="37" colspan="2" class="title_right">&nbsp;&nbsp; <span style="font-weight: bold">Product description</span></td>
                        </tr>
                        <tr>
                          <td height="1" colspan="2">
							<table width="95%" border="0" align="center" cellspacing="0" cellpadding="0" id="table23">
                              <tbody><tr>
                                <td height="50">
                                ${model.introduce }
<!--EndFragment-->               </td>
                              </tr>
                          </tbody></table></td>
                        </tr>
                                               </tbody></table>
							<p>             </p></td>
                        </tr>
                    </tbody></table></td>
                  </tr>
                  									</tbody></table>
							</div>
				</div>
                </div>
                <div>
                </div>
</div> 
  <div class="clear"></div>
</div>
  <div class="clear"></div>
  </div>
  <div class="clear" id="etwclear"></div>
  <jsp:include page="/commons/bottom.jsp"></jsp:include>
</body>
</html>
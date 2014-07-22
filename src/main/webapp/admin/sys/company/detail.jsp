<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="/commons/include.jsp" %>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <%@include file="/admin/commons/listJsCss.jsp" %>
<%@include file="/admin/commons/jsCss.jsp" %>
<title>公司信息|GELAIMEI Furniture后台管理系统</title>
<link href="${ctx }resources/js/skins/blue.css" rel="stylesheet"/>
<script type="text/javascript" src="${ctx }resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx }resources/js/jquery.metadata.js"></script>
<script type="text/javascript" src="${ctx }resources/js/validatePlugin/jquery.validatePlugin.js"></script>
<script type="text/javascript" src="${ctx }resources/js/My97DatePicker/WdatePicker.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/ckeditor.js"></script>
 <script type="text/javascript" src="${ctx }resources/js/ckEditor/lang/zh-cn.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx }resources/css/style.css" />
<style type="text/css">
body{
		font-size: 12px;
		font-family: Arial, Tahoma, Verdana;
	}
</style>
<script type="text/javascript">
	var valiResult;
	$(function(){
		valiResult = $("#form").validate({
			rules:{
				"name":{
					required:true,
					rangelength:[1,100]
				},
				"logo":{
					isImgFile:true
				},
				"phone":{
					isImgFile:true
				},
				"email":{
					required:true,
					email:true,
					rangelength:[1,50]
				},
				"telPhone":{
					required:true,
					rangelength:[1,20]
				}
			},
			messages:{
				"name":{
					required:"公司名称不能为空！",
					rangelength:jQuery.format("公司名称长度在{0}与{1}之间")
				},
				"logo":{
					isImgFile:"请上传jpg|jpeg|bmp|gif|png图片格式文件！"
				},
				"phone":{
					isImgFile:"请上传jpg|jpeg|bmp|gif|png图片格式文件！"
				},
				"email":{
					required:"邮箱不能为空！",
					email:"邮箱格式不正确！",
					rangelength:jQuery.format("邮箱长度在{0}与{1}之间")
				},
				"telPhone":{
					required:"联系方式不能为空",
					rangelength:jQuery.format("联系方式长度在{0}与{1}之间")
				}
			}
		});
	});
	function doSubmit(){
		CKEDITOR.instances.introduce.updateElement();
		var content = $("#introduce").val();
		var length = $.trim(content).length;
		if(length<=0){
			$("#contentSpan").show();
		}
		if(valiResult.form()&&length>0){
			$("#contentSpan").hide();
			$("#form").submit();
			return true;
		}
		return false;
	}
</script>
</head>
<body>
	<jsp:include page="/admin/commons/header.jsp"/>
	<jsp:include page="/admin/commons/left.jsp">
		<jsp:param value="5" name="menuId"/>
		<jsp:param value="公司管理" name="menuName"/>
	</jsp:include>
	<section id="main" class="column">
	<jsp:include page="/admin/commons/message.jsp"/>
		<article class="module width_full">
		<header>
		<h3 class="tabs_involved">公司详情</h3>
		</header>
		<div class="tab_container">
		<div id="tab1" class="tab_content">
	<form id="form" class="form-horizontal" action="${ctx }admin/sys/company/company_update.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
            	<label for="name" class="col-sm-2 control-label">公司名称</label>
            	<div class="col-sm-4">
		            <input id="name" class="form-control" name="name" value="${model.name }" type="text"/>
            	</div>
             </div>
            
            <div class="form-group">
            	<label for="log" class="col-sm-2 control-label">公司logo</label>
            	<div class="col-sm-4">
           	 	<img src="${ctx }resources/${model.logo }" 
            	title="公司logo" alt="公司log" width="390px" height="130px" 
            	name="log" />
            		<input type="file" name="log" title="点击更换公司logo"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="phone" class="col-sm-2 control-label">热线图片</label>
            	<div class="col-sm-4">
            	<img src="${ctx }resources/${model.phonePic }" 
            	title="热线图片" alt="热线图片" width="307px" height="130px" 
            	name="phone" />
            		<input type="file" name="phone" title="点击更换热线图片"/>
            	</div>
            </div>

            <div class="form-group">
            	<label for="slogan" class="col-sm-2 control-label">公司口号</label>
            	<div class="col-sm-6">
	            	<textarea rows="3" class="form-control" id="slogan" name="slogan">${model.slogan }</textarea>
            	</div>
            </div>

			<div class="form-group">
				<label for="introduce" class="col-sm-2 control-label">公司介绍</label>
				<div class="col-sm-9">
            		<textarea rows="3" class="ckeditor form-control" id="introduce" name="introduce">${model.introduce }</textarea>
            		<span id="contentSpan" style="background: url(/resources/images/x.png) no-repeat 0px 0px;color:red;padding-left:18px;display: none;">内容不能为空！</span>
            	</div>
			</div>
			
            <div class="form-group">
            	<label for="createDate" class="col-sm-2 control-label">公司创建日期</label>
            	<div class="col-sm-4">
           	 		<input id="createDate" class="Wdate form-control" onfocus="WdatePicker({maxDate:'%y-%M-%d'});" name="createDate" value="${model.createDate }"/>
           	 	</div>
            </div>

            <div class="form-group">
            	<label for="address" class="col-sm-2 control-label">公司地址</label>
            	<div class="col-sm-6">
            		<input id="address" class="form-control" name="address" value="${model.address }"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="facAddress" class="col-sm-2 control-label">工厂地址</label>
            	<div class="col-sm-6">
            		<input id="facAddress" class="form-control" name="facAddress" value="${model.facAddress }"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="email" class="col-sm-2 control-label">公司邮箱</label>
            	<div class="col-sm-4">
	            	<input id="email" class="form-control" name="email" value="${model.email }"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="person" class="col-sm-2 control-label">公司联系人</label>
            	<div class="col-sm-4">
	            	<input id="person" class="form-control" name="person" value="${model.person }"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="mobile" class="col-sm-2 control-label">Mobile联系方式</label>
            	<div class="col-sm-4">
            	<input id="mobile" class="form-control" name="mobile" value="${model.mobile }"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="telPhone" class="col-sm-2 control-label">Tel联系方式</label>
            	<div class="col-sm-4">
            	<input id="telPhone" class="form-control" name="telPhone" value="${model.telPhone }"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="fax" class="col-sm-2 control-label">fax传真</label>
            	<div class="col-sm-4">
            	<input id="fax" class="form-control" name="fax" value="${model.fax }"/>
            	</div>
            </div>
            
            <div class="form-group">
            	<label for="website" class="col-sm-2 control-label">公司网址</label>
            	<div class="col-sm-4">
            	<input id="website" class="form-control" name="website" value="${model.website }"/>
            	</div>
            </div>
            <input type="hidden" name="id" value="${model.id }"/>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
		            <button onclick="return doSubmit();" class="btn btn-info" type="button">确定</button>&nbsp;&nbsp;&nbsp;
		            &nbsp;&nbsp;&nbsp;<button name="reset" class="btn btn-default" type="reset">重置</button>
				</div>
			</div>
          </form>
          </div>
          </div>
          </article>
          </section>
</body>
</html>
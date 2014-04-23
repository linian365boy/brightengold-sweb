//图片文件验证
 jQuery.validator.addMethod("isImgFile", function(value, element) {
	 var picture = /.(jpg|jpeg|bmp|gif)$/;
     return (value==''||picture.exec(value.toLowerCase()))?true:false;       
 }, "请上传jpg|jpeg|bmp|gif图片格式文件");
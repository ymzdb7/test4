<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path ;
%>
<html>
<style>
.file {
    position: relative;
    display: inline-block;
    background: #D0EEFF;
    border: 1px solid #99D3F5;
    border-radius: 4px;
    padding: 4px 12px;
    overflow: hidden;
    color: #1E88C7;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.file:hover {
    background: #AADFFD;
    border-color: #78C3F3;
    color: #004974;
    text-decoration: none;
}
</style>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="pragma" content="no-cache" />
		<span style="color: #ff0000;"><base target="_self"></span>
		<title>书籍图片上传</title>
	</head>
	<body>
		<h5>图片上传</h5><hr/>
		<p style="color: red">${requestScope.errorMsg}</p>
		<form id="form1" name="form1" action="<%=basePath%>/upload?type=bookUpload" 
			method="post" enctype="multipart/form-data">
			<div>注:图片大小最大不能超过3M!</div>
			<div><input size=20 type="file" name="file_upload"/></div>
			<div><input type="submit" value="上传"/></div>
		</form>
	</body>
</html>
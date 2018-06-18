<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath  =  request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path ;
%>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/gray/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/icon.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=basePath %>/resource/js/validator.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/css/fpcss.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.js"></script>
<html>
	<head>
		<title>添加书籍</title>
		<script type="text/javascript">
			//打开上传页面
			function openUpload(){
				var win = window.showModalDialog("<%=basePath%>/test/uploadPage.jsp","","dialogWidth:300px;dialogHeight:300px;scroll:no;status:no");
				if(win != null){
					document.getElementById("photo_id").value = win;
					document.getElementById("img_id").src = "<%=basePath%>/"+win;
				}
			}
		</script>
	</head>
	<body>
		<h5>添加书籍</h5><hr/>
			<p>
				书的封面：
				<label>
					<input type="hidden" id="photo_id" name="photo" value="images/noimg.png">
					<input type="button" onclick="openUpload()" value="上传图片"/><br/>
					<img id="img_id" alt="" src="<%=basePath%>/resource/images/main_03.gif" 
							width="200px" height="200px">
				</label>
			</p>
      </body>
</html>
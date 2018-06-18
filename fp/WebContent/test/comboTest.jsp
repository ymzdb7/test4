<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path ;
%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Basic Combo - jQuery EasyUI Demo</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/gray/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/icon.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>

<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.js"></script>
</head>
<body>
	<script type="text/javascript">
	$(function(){  
	    $.ajax({
	        url:"cust/getAllHealthyType.do",  
	        dataType:"json", 
	        type:"GET",
	        success:function(data){                                 
	                    //绑定第一个下拉框
	                    $('#qysjzt').combobox({
	                            data: data,                        
	                            valueField: 'id',
	                            textField: 'type_name'}
	                            );                       
	       },
	       error:function(error){
	           alert("初始化下拉控件失败");
	       }
	    
	    }
	    )
	</script>
	<input id="qysjzt" name="qysjzt" class="easyui-combobox" width="50px">
</body>
</html>
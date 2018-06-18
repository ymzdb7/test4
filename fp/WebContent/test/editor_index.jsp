<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="com.baidu.ueditor.ActionEnter"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;


%>
<html>
<head>
    <title>完整demo</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/editor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/editor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/editor/lang/zh-cn/zh-cn.js"></script>

    <style type="text/css">
        div{
            width:100%;
        }
    </style>
    
<script type="text/javascript">
function showContent(){
	$.ajax({
	    url:"<%=basePath %>/test/getEditorContent.do",  
	    dataType:"html", 
	    type:"GET",
	    success:function(data){                                 
	        $('#weiwf').val(data);
	   }
	});
}
</script>
</head>
<body>
<button onclick="showContent()">getContent</button>
<div id="weiwf">
${content}
</div>
<div>
    <h1>完整demo4</h1>
    <form action="<%=basePath %>/test/setEditorContent.do">
        <script id="editor" type="text/plain" style="width:1024px;height:500px;"></script>
        <button type="submit">提交</button>
    </form>
</div>
<script type="text/javascript">
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');
	//ue.setContent();
	
</script>
</body>
</html>
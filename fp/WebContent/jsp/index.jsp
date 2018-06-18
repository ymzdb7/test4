<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort() + path ;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>扶贫管理后台系统</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/resource/css/easyui/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/resource/css/easyui/icon.css">
<script type="text/javascript" src="<%=basePath%>/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/resource/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/resource/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
$(function(){

	addTab('欢迎页','jsp/main.jsp');
	/*
	$('#tabs').tabs('add',{
		title:'首页',
		tools:[{
	        iconCls:'icon-mini-refresh',
	        handler:function(){
	        	var tab = $('#tabs').tabs('getSelected');
	        
	        	tab.panel('refresh','main.jsp');
	        }
	    }],
        href:'main.jsp',
        closable:false
	});
	*/
	
	$('.easyui-tree').tree({
        onClick:function(node){
        	
        	if (node.attributes.url != '' && node.attributes.url != null){
        		addTab(node.text, node.attributes.url);
/*                if ($('.easyui-tabs').tabs('exists', node.text)){
                    $('.easyui-tabs').tabs('select', node.text);
                }else{
                    $('.easyui-tabs').tabs('add',{   
                        title:node.text,   
                        href:node.attributes.url,   
                        closable:true  
                    });
                }
*/
			}
        }
    });
	
});

function addTab(title, href){  
    var tt = $('#tabs');  
    if (tt.tabs('exists', title)){//如果tab已经存在,则选中并刷新该tab  
        tt.tabs('select', title);  
        refreshTab({tabTitle:title,url:href});  
    } else {  
        if (href){  
            var content = '<iframe scrolling="yes" frameborder="0"  src="'+href+'" style="width:100%;height:100%;"></iframe>';  
        } else {  
            var content = '未实现';  
        }  
        tt.tabs('add',{  
            title:title,  
            closable:true,  
            content:content
        });  
    }  
} 

function refreshTab(cfg){  
    var refresh_tab = cfg.tabTitle ? $('#tabs').tabs('getTab',cfg.tabTitle) : $('#tabs').tabs('getSelected');  
    if(refresh_tab && refresh_tab.find('iframe').length > 0){  
        var _refresh_ifram = refresh_tab.find('iframe')[0];  
        var refresh_url = cfg.url?cfg.url:_refresh_ifram.src;  
        _refresh_ifram.contentWindow.location.href=refresh_url;  
    }  
}  
</script>

</head>
<body class="easyui-layout" bgcolor="#E9F1FF">
	
	<div data-options="region:'north'" style="height:60px;width:100%; background:#E9F1FF">
		<span style="float:left;margin-left:20px;white-space: nowrap;">
			
			<img style="width:53px;height:53px;" 
				 src="<%=basePath%>/resource/images/20171208101251.png">
			<h2 style="font-family:宋体;font-size:28x;display:inline;">您好！欢迎使用</h2>
		</span>
		<span style="float:right;margin-top:20px;">
		当前登录用户：【${pname}(${phone}),(${oname}),(${dname})】您好！
		
		<a href="<%=basePath%>/logout.do"><img alt="" src="<%=basePath%>/resource/images/main_20.gif"></a>
		</span>
	</div>
	
	<div data-options="region:'south'" style="height:20px;"><span style="margin-left:600px;">版权所有@</span></div>
	
	<div data-options="region:'west',title:'菜单',split:true" style="width:200px;">
	 	<%-- <p>${rolepower}</p> --%>
	 	<div id='wnav' class="easyui-accordion"  border="false">
		<!--  导航内容 -->
				${menus}
		</div>
	</div>
	
	<div data-options="region:'center'">
		<div id="tabs" class="easyui-tabs" data-options="fit:true,border:false">
			
		</div>
	</div>
	
    
</body>
</html>
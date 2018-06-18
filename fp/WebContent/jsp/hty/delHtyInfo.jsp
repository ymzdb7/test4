<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path ;
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/gray/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/icon.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=basePath %>/resource/js/validator.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/css/fpcss.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.js"></script>
</head>
<script>
function initData(dataurl){
	var iurl;
	var queryParamsData;
	if (dataurl==null){
		iurl = '<%=basePath%>/hty/htyInfo.do',
		queryParamsData = {};
	}else{
		var searchhname = $('#searchhname').val();
		var searchpname = $('#searchpname').val();
		var searchhospital = $('#searchhospital').val();

		queryParamsData = {
	       		'searchhname':searchhname, 
	       		'searchpname':searchpname,
	       		'searchhospital':searchhospital
	    };
		iurl = dataurl;
	}
	$('#datagrid_hty_info').datagrid({
        url:iurl,
        queryParams:queryParamsData,
        singleSelect:true,   	//只允许选中一行
        //height:$('#tabs').height() - 50 - $('#btn').height(),
        pagination:true,   		//在数据网格（datagrid）底部显示分页工具栏
        rownumbers:true,   		//显示带有行号的列
        //selectOnCheck:true,  	//如果设置为 true，点击复选框将会选中该行。如果设置为 false，选中该行将不会选中复选框。
        //pagePosition:both,	//定义分页栏的位置。可用的值有：'top'、'bottom'、'both'
        pageSize:20,			//每页显示的记录条数
        pageList:[10,20,30,50,100],
        fitColumns:true, 		//自适应列的宽度
        striped:true,   		//行条纹化。（即奇偶行使用不同背景色）
        nowrap:true,    		//把数据显示在一行。即不换行
        toolbar : $("#tb_hty_update"),
        columns:[[
            {field:'isSelected',title:'操作',hidden:false,checkbox:true},
            {field:'fid',title:'户号',width:15},
            {field:'holderName',title:'户主姓名',width:30},
            {field:'pid',title:'个人编号',width:25},
            {field:'pname',title:'个人姓名',width:30},
            {field:'relationType',title:'户主关系',width:40,hidden:true},
            {field:'relationTypeName',title:'户主关系',width:40},
            {field:'illnessName',title:'大病名称',width:50},
            {field:'hospital',title:'就诊医院',width:50},
            {field:'cost',title:'助学金额',width:30},
            {field:'paymentTime',title:'发放日期',width:50,hidden:true},
            {field:'descb',title:'说明',width:100},
            {field:'id',title:'大病救助信息编号',width:100,hidden:true}
        ]],
        onLoadSuccess:function(data){}
    });
}


function deleteHty() {
	var selectedRows = $("#datagrid_hty_info").datagrid("getSelections");
    if (selectedRows.length == 0) {
        $.messager.alert("系统提示", "请选择要删除的数据！");
        return;
    }

    var id = selectedRows[0].id;
    var fid = selectedRows[0].fid;
    var holderName = selectedRows[0].holderName;
    var pid = selectedRows[0].pid;
    var pname = selectedRows[0].pname;
  
    confirmDelete(id,fid,holderName,pid,pname);
}

function confirmDelete(id,fid,holderName,pid,pname){
    $.messager.confirm("系统提示", "<font color=red>您确定要"
	    	+ "<h1  style='display: inline;'>删除</h1>这条教育救助信息吗？"
            + "<div style='font-size:5px'><br/></div>"
            + "将被删除的信息：<div style='font-size:5px'><br/></div>"
            + "<h2 style='display: inline;'>户主:("+fid+")"+holderName
            + "<div style='font-size:5px'><br/></div>"
            + "成员:("+pid+")"+pname+"</h2></font>", 
	      function(r) {
            	
	        if (r) {
	            $.post("<%=basePath %>/hty/deleteHtyAssistInfo.do", {
	                id : id
	            }, function(result) {
	            	//var result = eval('(' + result + ')');
	            	
	                if (result.success==true || result.success== "true") {
	                    $.messager.alert("系统提示", pname + "的数据已成功删除！");
	                    $("#datagrid_hty_info").datagrid("reload");
	                } else {
	                    $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
	                }
	            }, "json");
	        }
	    });
}


function reloadData(){
	initData(null);
}

function openSearchDialog(){
	$("#searchDiv").dialog("open").dialog("setTitle", "信息搜索");
}

function searchInfo() {
	var u = '<%=basePath%>/hty/searchInfo.do';
	initData(u);
	$("#searchDiv").dialog("close");
}

function closeSearch(){
	$("#searchDiv").dialog("close");
}

</script>
<style>
.comments {  
    width: 100%;  
    overflow: auto;  
    word-break: break-all;  
}  
</style>
<body style="margin: 1px" onload="initData(null)">
<div>
    <table id="datagrid_hty_info"></table>
</div>
    <div id="tb_hty_update">
        <a href="javascript:deleteHty()" class="easyui-linkbutton"
            iconCls="icon-add">删除大病救助信息</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:reloadData()" class="easyui-linkbutton"
        	iconCls="icon-reload">重新加载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:openSearchDialog()" class="easyui-linkbutton"
        	iconCls="icon-search">条件查询</a>
	</div>
<div id="dlg-search-buttons">
    <a href="javascript:searchInfo()" class="easyui-linkbutton"
                iconCls="icon-search">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:closeSearch()" class="easyui-linkbutton"
    iconCls="icon-clear">关闭</a>
</div>
<div id="searchDiv" class="easyui-dialog"
            style="top:30px;left:300px;width: 350px;height:300px;padding:10px 10px;" closed="true"
            buttons="#dlg-search-buttons">
            <form method="post" id="fm_search">
                <table cellspacing="8px;">
                    <tr>
                        <td><div style='font-size:12px'>请输入：户主姓名、个人姓名或医院名称</div></td>
    				</tr>
    				<tr>
                        <td><input type="text" id="searchhname" size="30"
    						onkeydown="if(event.keyCode == 13) searchInfo()" /> 
    					</td>
    				</tr>
                </table>
            </form>
</div>

</body>
</html>
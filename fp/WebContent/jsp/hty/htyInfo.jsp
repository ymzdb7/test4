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
        toolbar : $("#tb_hty"),
        columns:[[
            {field:'isSelected',title:'操作',hidden:false,checkbox:true},
            {field:'fid',title:'户号',width:20},
            {field:'holderName',title:'户主姓名',width:40},
            {field:'pid',title:'个人编号',width:25},
            {field:'pname',title:'个人姓名',width:40},
            {field:'relationType',title:'户主关系',width:40,hidden:true},
            {field:'relationTypeName',title:'户主关系',width:40},
            {field:'illnessName',title:'大病名称',width:60},
            {field:'hospital',title:'就诊医院',width:60},
            {field:'cost',title:'救助金额',width:30},
            {field:'paymentTime',title:'发放日期',width:50,hidden:true},
            {field:'descb',title:'说明',width:80},
            {field:'id',title:'大病救助信息编号',width:100,hidden:true}
        ]],
        onLoadSuccess:function(data){}
    });
}

function openDialog(){
	flaged_info='m';
    var selectedRows = $("#datagrid_hty_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要修改的数据！");
        return;
    }
    var row = selectedRows[0];
    $("#dlg-hty-assist").dialog("open").dialog("setTitle", "查看大病救助信息明细");
    $("#fm_hty").form("load", row); 
}

function buttonOk(){
	$("#dlg-hty-assist").dialog("close");
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
<body style="margin: 1px" onload="initData(null)">
    <div id="tb_hty">
        <a href="javascript:openDialog()" class="easyui-linkbutton"
            iconCls="icon-tip">查看详细信息</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:reloadData()" class="easyui-linkbutton"
        	iconCls="icon-reload">重新加载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:openSearchDialog()" class="easyui-linkbutton"
        	iconCls="icon-search">条件查询</a>
	</div>

<div>
    <table id="datagrid_hty_info"></table>
</div>
<div id="dlg-hty-assist"  class="easyui-dialog" 
	style="top:10px;left:80px;width: 950px;height:300px;padding:10px 10px;font-size:5px" 
	closed="true" buttons="#dlg-buttons">
    <form method="post" id="fm_hty">
        <table border=0 cellpadding=0 cellspacing=0 style="width:100% ">
            <tr>
                <td style="width:100%;" align="center" valign="middle">
        <table cellspacing="8px;" cellspacing="0" cellpadding="5" border="1" bordercolor="#0099CC" 
        	style="border-collapse: collapse;margin:auto" bgcolor="#F7F7F7">
            <tr>
                <td><div style='font-size:12px'>户主：</div></td>
                <td><input type="text" id="holderName" name="holderName"
                    class="easyui-validatebox" validType="chinese" editable="false"
                    data-options="required:'true',validType:'chinese'"/>
			            <input type="text" id="pid" name="pid" value="0" 
			        		style="display:none" size=5/> 
			        	<input type="text" id="id" name="id" value="0" 
			        		style="display:none" size=5/> 
                </td>
                 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><div style='font-size:12px'>救助对象：</div></td>
                <td><input type="text" id="pname" name="pname" />
                </td>
                 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><div style='font-size:12px'>大病名称：</div></td>
                <td><input type="text" id="illnessName" name="illnessName"/>
            </tr>
           <tr>
                <td><div style='font-size:12px'>救助金额：</div></td>
                <td><input type="text" id="cost" name="cost" />
                </td>
                 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><div style='font-size:12px'>就诊医院：</div></td>
                <td><input type="text" id="hospital" name="hospital"/>
                </td>
                 <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><div style='font-size:12px'>与户主关系：</div></td>
                <td><input type="text" id="relationTypeName" name="relationTypeName"/>
                </td>
            </tr>
            <tr>
<!--            <td><div style='font-size:12px'>发放日期：</div></td>
                <td colspan="4"><input type="text" id="paymentTime" name="paymentTime" 
                		class="easyui-datebox" /> 
                </td>
                 -->   
                <td><div style='font-size:12px'>说明：</div></td> 
                <td colspan=7><div>
                	<textarea style='font-size:13px' id="descb" 
                		name="descb" rows="5" cols="55" size=90 class="comments"></textarea>
                	</div>
                </td>
            </tr>
         </table>
        </td>
        </tr>
        </table>
    </form>
</div>
<div id="dlg-buttons" style="text-align:center;vertical-align:middle;" style='font-size:5px'>    
	<a href="javascript:buttonOk()" class="easyui-linkbutton"
	      iconCls="icon-ok">确定</a>
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
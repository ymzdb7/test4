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
var flaged_info = 'a';
function loadHolderInfo(){
	$('#datagrid_holder_info').datagrid({
        url:'<%=basePath%>/cust/holderInfo.do',
        singleSelect:true,   //只允许选中一行
        //height:$('#tabs').height() - 50 - $('#btn').height(),
        pagination:true,   //在数据网格（datagrid）底部显示分页工具栏
        rownumbers:true,   //显示带有行号的列
        //selectOnCheck:true,  //如果设置为 true，点击复选框将会选中该行。如果设置为 false，选中该行将不会选中复选框。
        //pagePosition:both,	//定义分页栏的位置。可用的值有：'top'、'bottom'、'both'
        pageSize:20,			//每页显示的记录条数
        pageList:[10,20,30,50,100],
        fitColumns:true, //自适应列的宽度
        striped:true,   //行条纹化。（即奇偶行使用不同背景色）
        nowrap:true,    //把数据显示在一行。即不换行
        toolbar : $("#tb"),
        columns:[[
            {field:'isSelected',title:'操作',hidden:false,checkbox:true},
            {field:'fid',title:'户号',width:40},
            {field:'holderName',title:'户主姓名',width:50},
            {field:'pid',title:'编号',hidden:true},
            {field:'pname',title:'姓名',width:50,hidden:true},
            {field:'did',title:'行政区划编号',hidden:true},
            {field:'dname',title:'行政区划名称'},
            {field:'amount',title:'户成员数'},
            {field:'isHolder',title:'是否户主',width:40,hidden:true},
            {field:'phone',title:'手机',width:70},
            {field:'cid',title:'身份证号码',width:100,hidden:true},
            {field:'faddr',title:'家庭住址',width:100},
            {field:'sex',title:'sex',width:30,hidden:true},
            {field:'sexName',title:'性别',width:30,hidden:true},
            {field:'relationType',title:'户主关系',width:40,hidden:true},
            {field:'relationTypeName',title:'户主关系',width:40},
            {field:'workType',title:'工作状况',width:40,hidden:true},
            {field:'workTypeName',title:'工作状况',width:40,hidden:true},
            {field:'marriedType',title:'婚姻状况',width:40,hidden:true},
            {field:'marriedTypeName',title:'婚姻状况',width:40,hidden:true},
            {field:'healthyType',title:'健康状况',width:40,hidden:true},
            {field:'healthyTypeName',title:'健康状况',width:40,hidden:true},
            {field:'duty',title:'用户类型',width:40},
            {field:'descb',title:'说明',width:100}
        ]],
        onCheck:function(rowIndex,rowData){selectCustomer(rowIndex,rowData);},
        onLoadSuccess:function(data){}
    });
}

function loadCustomerInfo(holder){
	$('#datagrid_customer_info').datagrid({
        url:'<%=basePath%>/cust/familyMemberInfo.do?holder='+holder,
        singleSelect:true,   //只允许选中一行
        //height:$('#tabs').height() - 50 - $('#btn').height(),
        pagination:true,   //在数据网格（datagrid）底部显示分页工具栏
        rownumbers:true,   //显示带有行号的列
        //selectOnCheck:true,  //如果设置为 true，点击复选框将会选中该行。如果设置为 false，选中该行将不会选中复选框。
        //pagePosition:both,	//定义分页栏的位置。可用的值有：'top'、'bottom'、'both'
        pageSize:20,			//每页显示的记录条数
        pageList:[10,20,30,50,100],
        fitColumns:true, //自适应列的宽度
        striped:true,   //行条纹化。（即奇偶行使用不同背景色）
        nowrap:true,    //把数据显示在一行。即不换行
        //toolbar : $("#tb"),
        columns:[[
            {field:'isSelected',title:'操作',hidden:false,checkbox:true},
            {field:'pid',title:'编号'},
            {field:'pname',title:'姓名',width:50},
            {field:'did',title:'行政区划编号',hidden:true},
            {field:'dname',title:'行政区划名称'},
            {field:'sex',title:'性别代码',width:30,hidden:true},
            {field:'sexName',title:'性别',width:30},
            {field:'relationType',title:'户主关系',width:40,hidden:true},
            {field:'relationTypeName',title:'户主关系',width:40},
            {field:'phone',title:'手机',width:70},
            {field:'cid',title:'身份证号码',width:100},
            {field:'workType',title:'工作状况',width:40,hidden:true},
            {field:'workTypeName',title:'工作状况',width:40},
            {field:'marriedType',title:'婚姻状况',width:40,hidden:true},
            {field:'marriedTypeName',title:'婚姻状况',width:40},
            {field:'healthyType',title:'健康状况',width:40,hidden:true},
            {field:'healthyTypeName',title:'健康状况',width:40},
            {field:'isHolder',title:'是否户主',width:40,hidden:true},
            {field:'fid',title:'户号',width:40,hidden:true},
            {field:'holderName',title:'户主姓名',width:40},
            {field:'faddr',title:'家庭住址',width:40},
            {field:'duty',title:'用户类型',width:40},
            {field:'descb',title:'说明',width:100}
        ]],
        onLoadSuccess:function(data){}
    });
}

function selectCustomer(rowIndex,rowData){
	//alert(rowIndex+'\t'+rowData.pname);
	loadCustomerInfo(rowData.pid);
	$("#customer_info").html('&nbsp;('+rowData.pid+')'+rowData.pname+'&nbsp;');
	$("#dlg_customer_info").dialog("open").dialog("setTitle", "选择教育救助对象");
}

function selectHolder(){
	loadHolderInfo();
	$("#dlg_holder_info").dialog("open").dialog("setTitle", "选择户主");
}

function selectCustomerOk(){
    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "您没有选择任何记录！");
        return;
    }
    var pid = selectedRows[0].pid;
    var pname = selectedRows[0].pname;
    $("#pid").val(pid);
    $("#pname").val(pname);
    closeCustomerDialog();
}

function closeHtyDialog(){
    $("#dlg-hty-assist").dialog("close");
}

function closeCustomerDialog(){
	$("#dlg_holder_info").dialog("close");
	$("#dlg_customer_info").dialog("close");
}

function saveHtyInfo(){
	if (checkInfo()) return;
	submitInfo();
}

function submitInfo(){
	var url = "<%=basePath %>/hty/addHtyAssistInfo.do?flaged=m";
    $("#fm_hty").form("submit", {
        url : url,
        onSubmit : function() {
			var r = $(this).form("validate");
			//$.messager.alert("系统提示", $("#paymentTime").combobox("getValue"));
			return r;
        },
        success : function(result) {
            var result = eval('(' + result + ')');
            //alert("result.success="+result.success);
            if (result.success) {
                $.messager.alert("系统提示", "保存成功！");
                $("#datagrid_hty_info").datagrid("reload");
                $("#dlg-hty-assist").dialog("close");
                resetInfo();
            } else {
                $.messager.alert("系统提示", "保存失败！");
                return;
            }
        }
    });
}

function checkInfo(){
	var idd = $("#pid").val();
	var idn = $("#pname").val();
	if (idd == "" || idn == ""){
		$.messager.alert("系统提示", "帮扶对象信息不能空！");
		return true;
	}
	return false;
}

function resetInfo(){
	$("#pid").val("");
	$("#pname").val("");
	$("#illnessName").val("");
	$("#hospital").val("");
	$("#cost").val("");
	$("#descb").val("");
}

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

function openModifyDialog(){
	flaged_info='m';
    var selectedRows = $("#datagrid_hty_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要修改的数据！");
        return;
    }
    var row = selectedRows[0];
    $("#dlg-hty-assist").dialog("open").dialog("setTitle", "修改教育救助信息");
    $("#fm_hty").form("load", row); 
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
    width: 100%; /*自动适应父布局宽度*/  
    overflow: auto;  
    word-break: break-all;  
}  
</style>
<div>
    <table id="datagrid_hty_info"></table>
</div>
    <div id="tb_hty_update">
        <a href="javascript:openModifyDialog()" class="easyui-linkbutton"
            iconCls="icon-edit">修改大病救助信息</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:reloadData()" class="easyui-linkbutton"
        	iconCls="icon-reload">重新加载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:openSearchDialog()" class="easyui-linkbutton"
        	iconCls="icon-search">条件查询</a>
	</div>
<body style="margin: 1px" onload="initData(null)">
  <div style='font-size:10px'><br/></div>
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
                <td><div style='font-size:12px'>大病救助对象：</div></td>
                <td><input type="text" id="pname" name="pname"
                    class="easyui-validatebox" validType="chinese" editable="false"
                    data-options="required:'true',validType:'chinese'"/>
                    &nbsp;<span style="color: red">*</span>
                    <a  href="javascript:selectHolder()" class="easyui-linkbutton"
			            iconCls="icon-remove" ><span id="ttt">选择对象</span></a>
			            <input type="text" id="pid" name="pid" value="0" 
			        		style="display:none" size=5/> 
			        	<input type="text" id="id" name="id" value="0" 
			        		style="display:none" size=5/> 
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><div style='font-size:12px'>大病名称：</div></td>
                <td><input type="text" id="illnessName" name="illnessName"/>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><div style='font-size:12px'>就诊医院：</div></td>
                <td><input type="text" id="hospital" name="hospital"/>
                </td>
            </tr>
            <tr>
                <td><div style='font-size:12px'>救助金额：</div></td>
                <td><input type="text" id="cost" name="cost" />
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<!--            <td><div style='font-size:12px'>发放日期：</div></td>
                <td colspan="4"><input type="text" id="paymentTime" name="paymentTime" 
                		class="easyui-datebox" /> 
                </td>
                 -->   
                <td><div style='font-size:12px'>说明：</div></td> 
                <td colspan=4><div>
                	<textarea style='font-size:13px' id="descb" 
                		name="descb" rows="1" cols="55" size=90 class="comments"></textarea>
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
	<a href="javascript:saveHtyInfo()" class="easyui-linkbutton"
	      iconCls="icon-ok">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	      <a href="javascript:closeHtyDialog()"
	      class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>

<div class="easyui-dialog" closed="true" id="dlg_customer_info"
           style="top:40px;left:100px;width: 850px;height:370px;padding:10px 10px;" 
           buttons="#dlg-hty-buttons">
       <span style='font-size:12px'>农户<span id="customer_info"></span>的家庭成员信息:</span>
    <table id="datagrid_customer_info"></table>
</div>
<div class="easyui-dialog" closed="true" id="dlg_holder_info"
           style="top:10px;left:30px;width: 1000px;height:470px;padding:10px 10px;" >
       <span style='font-size:12px' id="holder_info">农户信息列表:</span>
    <table id="datagrid_holder_info"></table>
</div>
<div id="dlg-hty-buttons">
    <a href="javascript:selectCustomerOk()" class="easyui-linkbutton"
        iconCls="icon-ok">确定</a> <a href="javascript:closeCustomerDialog()"
        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
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
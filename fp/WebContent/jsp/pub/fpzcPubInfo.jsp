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
var flaged = 'a';

function saveInfo(){
	if (checkInfo()) return;
	submitInfo();
}

function submitInfo(){
	var url = "<%=basePath %>/pub/savePublishInfo.do";
	//alert('flaged='+flaged);
	if (flaged == 'm'){
		url = "<%=basePath %>/pub/updatePublishInfo.do";
	}
	
    $("#fm").form("submit", {
        url : url,
        onSubmit : function() {
			var r = $(this).form("validate");
			//$.messager.alert("系统提示", r);
			return r;
        },
        success : function(result) {
            var result = eval('(' + result + ')');
            //alert("result.success="+result.success);
            if (result.success) {
                $.messager.alert("系统提示", "保存成功！");
                //$("#datagrid_info").datagrid("reload");
                window.location.href="<%=basePath %>/jsp/pub/fpzcPubInfo.jsp";
                //resetInfo();
            } else {
                $.messager.alert("系统提示", "保存失败！");
                return;
            }
        }
    });
}


function checkInfo(){
	var idd = $("#title").val();
	var idn = $("#content").val();
	if (idd == "" || idn == ""){
		$.messager.alert("系统提示", "发布标题和内容信息不能空！");
		return true;
	}
	return false;
}

function resetInfo(){
	$("#content").val("");
	$("#title").val("");
	$("#typeId").val("");
	$("#attachmentId").val("");
	$("#id").val("");
	$("#oid").val("");	
}

$(function(){
	$('#datagrid_info').datagrid({
        url:'<%=basePath%>/pub/getPublishInfo.do',
        queryParams: {'typeId': 5 },
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
        toolbar : $("#tl"),
        columns:[[
            {field:'isSelected',title:'操作',hidden:false,checkbox:true},
            {field:'id',title:'户号',width:15,hidden:true},
            {field:'oid',title:'机构ID',width:15},
            {field:'oname',title:'机构名称',width:30},
            {field:'attachmentName',title:'附件名称',width:60},
            {field:'pubDate',title:'发布时间',width:60},
            {field:'typeName',title:'发布类型名称',width:50},
            {field:'stopFlag',title:'停止发布',width:50,hidden:true},
            {field:'stopFlagDesc',title:'是否停发',width:20},
            {field:'title',title:'发布标题',width:80},
            {field:'content',title:'发布内容',width:150}
        ]],
        onCheck:function(index,row){},
        onLoadSuccess:function(data){setOname();}
    });
});

function setOname(){
    var selectedRows = $("#datagrid_info").datagrid("getRows");
    var row = selectedRows[0];
   	$("#oid").val(row.oid);
	$("#oname").text(row.oname);
}
function loadData(){
	flaged = 'm';
    var selectedRows = $("#datagrid_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "只能选择一条数据！");
        return;
    }
    var row = selectedRows[0];
	$("#fm").form("load", row); 
}

function cancelPublish(stopFlag){
	var selectedRows = $("#datagrid_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "只能选择一条数据！");
        return;
    }
    var rowid = selectedRows[0].id;
    var url ="<%=basePath %>/pub/stopPublish.do";

	$.ajax({
	    url:url,  
	    dataType:"json", 
	    type:"GET",
	    data:{
	    	"id":rowid,
	    	"stopFlag":stopFlag
	    },
	    success:function(result){  
	    	//var result = eval('(' + result + ')');
	    	//alert("result.success="+result.success)
	    	if (result.success){
	    		$.messager.alert("系统提示", "操作发布成功！");
	    		$("#datagrid_info").datagrid("reload");
	    	}
	    }
	})
}

$.ajax({
    url:"<%=basePath %>/pub/getOrgByOid.do",  
    dataType:"json", 
    type:"GET",
    success:function(data){                                 
    //   alert(data[0].oname);
       $('#oid').val(data[0].oid);
       $('#oname').text(data[0].oname);
   }
})

function uploadFile(){
	alert();
}
</script>

<style>
.comments {  
    width: 100%; 
    overflow: auto;  
    word-break: break-all;  
}  
</style>
<body style="margin: 1px">
  <div style='font-size:10px'><br/></div>
<div id="dlg-edu-assist"  style='font-size:5px'>
    <form method="post" id="fm" enctype="multipart/form-data">
        <table border=0 cellpadding=0 cellspacing=0 style="width:100% ">
            <tr>
                <td style="width:100%;" align="center" valign="middle">
        <table cellspacing="8px;" cellspacing="0" cellpadding="5" border="1" bordercolor="#0099CC" 
        	style="border-collapse: collapse;margin:auto" bgcolor="#F7F7F7">
            <tr>
                <td><div style='font-size:12px'>发布机构：</div></td>
                <td><span id="oname" name="oname"></span>
                        <input type="text" id="oid" name="oid" value="0" 
			        		style="display:none" size=5/>
			            <input type="text" id="id" name="id" value="0" 
			        		style="display:none" size=5/> 
                </td>  
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><div style='font-size:12px'>发布类型：</div></td>
                <td><span >扶贫政策</span>
                	<input type="text" id="typeId" name="typeId" value="5" 
			        		style="display:none" size=5/> 
                </td>
            </tr>  
            <tr>
                <td><div style='font-size:12px'>附件：</div></td>
                <td colspan=4><input type="file" name="fileInput" id="fileInput">
                <!--<a href="javascript:uploadFile()"class="easyui-linkbutton" iconCls="icon-up">
                	上传</a> 
                <div id="files"></div>
                <input type="text" id="attachmentId" name="attachmentId"  /> -->
            </tr>
            <tr>
                <td><div style='font-size:12px'>发布标题：</div></td> 
                <td colspan=4><input type="text" id="title" name="title" style="width:600px;"/>
                </td>
            </tr>  
            <tr>
                <td><div style='font-size:12px'>发布内容：</div></td> 
                <td colspan=4><div>
                	<textarea style='font-size:13px' id="content" style="width:600px;"
                		name="content" rows="3" cols="55" size=10000 class="comments"></textarea>
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
	<a href="javascript:saveInfo()" class="easyui-linkbutton"
	      iconCls="icon-ok">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	      <a href="javascript:resetInfo()"
	      class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
</div>
<div id="tl" style="text-align:left;vertical-align:left;" style='font-size:5px'>
		<a href="javascript:cancelPublish(0)"
	      class="easyui-linkbutton" iconCls="icon-no">取消发布</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:cancelPublish(1)"
	      class="easyui-linkbutton" iconCls="icon-undo">启用发布</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:cancelPublish(2)"
	      class="easyui-linkbutton" iconCls="icon-clear">删除发布</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:loadData()"
	      class="easyui-linkbutton" iconCls="icon-edit">修改发布内容</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div style='font-size:10px'><br/></div>
<div>
    <table id="datagrid_info"></table>
</div>

</body>
</html>
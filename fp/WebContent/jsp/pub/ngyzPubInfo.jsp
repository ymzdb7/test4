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
<script type="text/javascript" charset="utf-8" src="<%=basePath %>/editor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath %>/editor/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="<%=basePath %>/editor/lang/zh-cn/zh-cn.js"></script>
</head>
<script>
var flaged = 'a';
var typeId = ${typeId};
function saveInfo(){
	if (checkInfo()) return;
	submitInfo();
}

function submitInfo(){
	
	var url = "<%=basePath %>/pub/savePublishInfo.do";
	
	if (flaged == 'm'){
		url = "<%=basePath %>/pub/updatePublishInfo.do";
	}
	
    $("#fm").form("submit", {
        url : url,
        onSubmit : function(data) {
        	data.typeId = typeId;
        },
        success : function(result) {
        	
            var result = eval('(' + result + ')');
            
            if (result.success) {
                $.messager.alert("系统提示", "保存成功！");
                $("#datagrid_info").datagrid("reload");
                $("#dlg").hide();
                //window.location.href="<%=basePath %>/jsp/pub/ngyzPubInfo.jsp";
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
	//var idn = $("#content").val();
	if (idd == "" ) {  //}|| idn == ""){
		$.messager.alert("系统提示", "发布标题不能空！");
		return true;
	}
	return false;
}

function resetInfo(){
	ue.setContent('');
	$("#title").val("");
	//$("#typeId").val(typeId);
	//$("#attachmentId").val("");
	$("#id").val(0);
	$("#oid").val(0);	
	$("#dlg").hide();
}

$(function(){
	$('#datagrid_info').datagrid({
        url:'<%=basePath%>/pub/getPublishInfo.do',
        queryParams: {'typeId': typeId },
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
            {field:'id',title:'户号',width:10,hidden:true},
            {field:'oid',title:'机构ID',width:15},
            {field:'oname',title:'机构名称',width:20},
            //{field:'attachmentName',title:'附件名称',width:60},
            {field:'pubDate',title:'发布时间',width:50},
            //{field:'typeName',title:'发布类型名称',width:50},
            {field:'stopFlag',title:'停止发布',width:50,hidden:true},
            {field:'stopFlagDesc',title:'是否停发',width:25},
            {field:'title',title:'发布标题',width:200},
            //{field:'content',title:'发布内容',width:150}
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
	//$("#fm").form("load", row); 
	getDetail(row.id);
	$("#id").val(row.id);
    ue.setEnabled();
    $("#button-save").show();
	$("#dlg").show();
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
      // alert(data[0].oname);
       $('#oid').val(data[0].oid);
       $('#oname').text(data[0].oname);
   }
})

function addData(){
	ue.setContent('');
	$("#title").val("");
	//$("#typeId").val(typeId);
	//$("#attachmentId").val("");
	$("#id").val(0);
	$("#oid").val(0);	
	ue.setEnabled();
	$("#button-save").show();
    $("#dlg").show();
	flaged = "a";
}

function showDetailData(){
	var selectedRows = $("#datagrid_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "只能选择一条数据！");
        return;
    }
    var rowid = selectedRows[0].id;
    getDetail(rowid);
    ue.setDisabled('fullscreen');
    $("#dlg").show();
    $("#button-save").hide();
}

function getDetail(rowid){
    $.ajax({
        url:"<%=basePath %>/pub/getPublishInfoById.do",  
        data:{'id':rowid},
        dataType:"json", 
        type:"GET",
        success:function(data){
          $("#title").val(data.data[0].title);
          ue.setContent(data.data[0].content);
       }
    });
}

var ue = UE.getEditor('content');
</script>

<style>
.comments {  
    width: 100%; 
    overflow: auto;  
    word-break: break-all;  
}  
</style>
<body style="margin: 1px">
<div id="dlg" buttons="#dlg-buttons" style="display:none" >
	    <form method="post" id="fm">
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
	                <td><span >农耕养殖技术</span>
	                	
	                </td>
	            </tr>  
	            <tr>
	                <td><div style='font-size:12px'>发布标题：</div></td> 
	                <td colspan=4><input type="text" id="title" name="title" style="width:900px;"/>
	                </td>
	            </tr>  
	            <tr>
	                <td><div style='font-size:12px'>发布内容：</div></td> 
	                <td colspan=4>
	                	<script id="content" name="content" type="text/plain" style="width:900px;height:290px;"></script>
		                <!-- <input type="text" id="content" name="content" value="" 
				        		style="display:none"/>  -->
	                </td>
	            </tr>
	        </table>
	        </td>
	        </tr>
	        </table>
	    </form>
	<div id="dlg-buttons" style="text-align:center;vertical-align:middle;" style='font-size:5px'>    
		<a id="button-save" href="javascript:saveInfo()" class="easyui-linkbutton"
		      iconCls="icon-ok">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		      <a href="javascript:resetInfo()"
		      class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
	</div>
	<div><br/></div>
</div>
<div id="tl" style="text-align:left;vertical-align:left;" style='font-size:5px'>
		<a href="javascript:cancelPublish(0)"
	      class="easyui-linkbutton" iconCls="icon-no">取消发布</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:cancelPublish(1)"
	      class="easyui-linkbutton" iconCls="icon-undo">启用发布</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:cancelPublish(2)"
	      class="easyui-linkbutton" iconCls="icon-clear">删除发布</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:loadData()"
	      class="easyui-linkbutton" iconCls="icon-edit">修改发布</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:addData()"
	      class="easyui-linkbutton" iconCls="icon-add">新增发布</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="javascript:showDetailData()"
	      class="easyui-linkbutton" iconCls="icon-filter">查看明细</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div>
    <table id="datagrid_info"></table>
</div>

</body>
</html>
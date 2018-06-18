<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path ;
//System.out.println("basePath = "+basePath);
%>
<html>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/gray/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/icon.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
<script src="<%=basePath %>/resource/js/validator.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/css/fpcss.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.js"></script>
<body style="margin: 1px"  onload="initData(null)">
<script>

function initData(dataurl){
	var iurl;
	var queryParamsData;
	if (dataurl==null){
		iurl = '<%=basePath%>/consult/getConsultInfo.do',
		queryParamsData = {};
	}else{
		var searchParam = $('#searchParam').val();
		var isAns = $('#aa input[name="isAns"]:checked').val();

		queryParamsData = {
	       		'searchParam':searchParam,
	       		'isAns':isAns
	    };
		iurl = dataurl;
	}
	$('#datagrid_consult_info').datagrid({
        url:iurl,
        queryParams:queryParamsData,
        singleSelect:true,   //只允许选中一行
        //height:$('#tabs').height() - 50 - $('#btn').height(),
        pagination:true,   //在数据网格（datagrid）底部显示分页工具栏
        rownumbers:true,   //显示带有行号的列
        //selectOnCheck:true,  //如果设置为 true，点击复选框将会选中该行。如果设置为 false，选中该行将不会选中复选框。
        //pagePosition:both,	//定义分页栏的位置。可用的值有：'top'、'bottom'、'both'
        pageSize:20,			//每页显示的记录条数
        pageList:[10,20,30,50],
        fitColumns:true, //自适应列的宽度
        striped:true,   //行条纹化。（即奇偶行使用不同背景色）
        nowrap:true,    //把数据显示在一行。即不换行
        toolbar : $("#tb"),
        columns:[[
            {field:'isSelected',title:'操作',hidden:false,checkbox:true},
            {field:'id',title:'编号',hidden:true},
            {field:'pid',title:'编号',hidden:true},
            {field:'pname',title:'姓名',width:30},
            {field:'subDate',title:'提交日期',width:40},
            {field:'content',title:'咨询内容'},
            {field:'questionTypeId',title:'问题类型ID',hidden:true},
            {field:'questionTypeDesc',title:'类型',width:25},
            {field:'oid',title:'机构编号',hidden:true},
            {field:'oname',title:'机构名称'},
            {field:'isAnony',title:'是否匿名',width:25,hidden:true},
            {field:'isAnonyDesc',title:'实匿名',width:25},
            {field:'answer',title:'回复内容'},
            {field:'ansDate',title:'回复时间',width:40},
            {field:'aid',title:'回复人ID',width:25,hidden:true},
            {field:'aname',title:'回复人',width:30},
            {field:'evaluation',title:'评估ID',hidden:true},
            {field:'evaluationDesc',title:'评估'}
            
        ]]
    });
}

var taget = false;

function openDialog(f) {
    var selectedRows = $("#datagrid_consult_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请先选择一条数据！");
        return;
    }
    var row = selectedRows[0];
    //alert(row.pid+"\n"+row.pname);
	if (f) {//回复
		taget = true;
		$("#dlg_buttons_ok").show();
	}else{//查询
		taget = false;		
		$("#dlg_buttons_ok").hide();
	}
	//alert("row.dname="+row.dname);
    $("#pname").text(row.pname);
    //alert("row.subDate="+row.subDate);
    $("#subDate").text(row.subDate);
    $("#isAnonyDesc").text(row.isAnonyDesc);
    $("#oname").text(row.oname);
    $("#questionTypeDesc").text(row.questionTypeDesc);
    $("#content").text(row.content);
    //alert("row.answer="+row.answer)
    $("#answer").val(row.answer);
    $("#ansDate").text(row.ansDate);
    $("#aname").text(row.aname);
    $("#evaluationDesc").text(row.evaluationDesc);
    //$("#pid").text(row.pid);
    $("#id").val(row.id);
    //alert("row.id="+row.id);
    
    $("#dlg").dialog("open").dialog("setTitle", "咨询信息");
              
}

function closeDialog() {
    $("#dlg").dialog("close");
    if (taget) {
    	resetValue();
    }
}

function saveInfo() {
	var sid = $("#id").val();
	
    $("#fm").form("submit", {
        url : "<%=basePath %>/consult/saveConsultInfo.do?id="+sid,
        onSubmit: function(data){
        	data.id=sid;
		},
        success : function(result) {
        	//alert(555);
        	var result = eval('(' + result + ')');
            if (result.success == true || result.success=="true") {
                $.messager.alert("系统提示", "保存成功！");
                $("#datagrid_consult_info").datagrid("reload");
                $("#dlg").dialog("close");
            } else {
	            $.messager.alert("系统提示", "保存失败！请联系系统管理员！");
            }
        }
    });
}

function resetValue() {
    $("#answer").val("");	
    $("#id").val("");
    //$("pid").val("");
}

function reloadData(){
	initData(null);
}

function openSearchDialog(){
	$("#searchDiv").dialog("open").dialog("setTitle", "信息搜索");
}

function searchInfo() {
	var u = '<%=basePath%>/consult/searchInfo.do';
	initData(u);
	$("#searchDiv").dialog("close");
}

function closeSearch(){
	$("#searchDiv").dialog("close");
}
</script>

<div>
    <table id="datagrid_consult_info"></table>
</div>
    <div id="tb">
        <a  href="javascript:openDialog(true)" class="easyui-linkbutton"
            iconCls="icon-edit">回复咨询</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:reloadData()" class="easyui-linkbutton"
        	iconCls="icon-reload">重新加载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:openSearchDialog()" class="easyui-linkbutton"
        	iconCls="icon-search">条件查询</a>
            
	    <div id="dlg" class="easyui-dialog"
	        style="top:10px;left:80px;width: 600px;height:400px;padding:10px 10px;" closed="true"
	        buttons="dlg_buttons">
		    <form method="post" id="fm">
		        <table border=0 cellpadding=0 cellspacing=0 style="width:100% ">
		            <tr>
		                <td style="width:100%;" align="center" valign="middle">
				        <table cellspacing="8px;" cellspacing="0" cellpadding="5" border="1" bordercolor="#0099CC" 
				        	style="border-collapse: collapse;margin:auto" bgcolor="#F7F7F7">
				            <tr>
				                <td><div style='font-size:12px'>问题提交人阅：</div></td>
				                <td><span id="pname" name="pname"></span> 
				                </td>
				                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				                <td><div style='font-size:12px'>提交时间：</div></td>
				                <td><span id="subDate" name="subDate"></span>
				                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				                <td><div style='font-size:12px'>是否匿名：</div></td>
				                <td><span id="isAnonyDesc" name="isAnonyDesc"></span>
				                </td>
				            </tr>  
				            <tr>
				                <td><div style='font-size:12px'>机构名称：</div></td>
				                <td><span id="oname" name="oname"></span>
				                </td>
				                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				                <td><div style='font-size:12px'>问题类型：</div></td>
				                <td colspan="4"><span id=questionTypeDesc name="questionTypeDesc"></span>
				                </td>
				            </tr>
				            <tr>
				                <td><div style='font-size:12px'>咨询问题：</div></td> 
				                <td colspan=7><div><span id="content" name="content"></span></div>
				                </td>
				            </tr>
				            <tr>
				                <td><div style='font-size:12px'>咨询内容回复：</div></td> 
				                <td colspan=7>
				                	<textarea style='font-size:13px' id="answer" name="answer" 
				                		rows="4" cols="55" size=500 class="comments"></textarea>
							            <input type="text" id="id" name="id"  
							        		style="display:none" size=5/>
				                </td>
				            </tr>
				            <tr>
				                <td><div style='font-size:12px'>回复时间：</div></td>
				                <td><span id="ansDate" name="ansDate"></span>
				                </td>
				                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				                <td><div style='font-size:12px'>回复人：</div></td>
				                <td><span id=aname name="aname"></span>
				                </td>
				                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				                <td><div style='font-size:12px'>评估：</div></td>
				                <td><span id="evaluationDesc" name="evaluationDesc"></span>
				                </td>
				            </tr>
				        </table>
				      </td>
		        	</tr>
		        </table>
		    </form>
	<table style="width:100%;margin: 10px auto;text-align: center   "><tr><td style="margin: 10px auto;">
	    <div id="dlg_buttons" closed="false">
	        <span id="dlg_buttons_ok"><a href="javascript:saveInfo()" class="easyui-linkbutton"
	            iconCls="icon-ok">保存</a></span> <a href="javascript:closeDialog()"
	            class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	    </div>
	 </td></tr></table>
	  		</div>
	</div> 
<div id="dlg-search-buttons">
    <a href="javascript:searchInfo()" class="easyui-linkbutton"
                iconCls="icon-search">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:closeSearch()" class="easyui-linkbutton"
    iconCls="icon-clear">关闭</a>
</div>
<div id="searchDiv" class="easyui-dialog"
            style="top:30px;left:300px;width:450px;height:300px;padding:10px 10px;" closed="true"
            buttons="#dlg-search-buttons">
            <form method="post" id="fm_search">
                <table cellspacing="8px;">
                    <tr>
                        <td><div style='font-size:12px'>请输入：咨询人姓名或咨询内容</div></td>
                        <td><input type="text" id="searchParam" size="30"
    						onkeydown="if(event.keyCode == 13) searchInfo()" /> 
    					</td>
    				</tr>
    				<tr>
    					<td><div style='font-size:12px'>是否回复:</div></td>
    					<td><div id='aa' style='font-size:12px'>
    						<label><input name="isAns" type="radio" value="0" />未回复</label> 
    						<label><input name="isAns" type="radio" value="1" />已回复</label>
    						<label><input name="isAns" type="radio" value="2" checked/>全部</label>
    						</div>
    					</td>  
                </table>
            </form>
</div>
</body>
</html>
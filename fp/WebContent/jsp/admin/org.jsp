<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path ;
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
</html>
<body style="margin: 1px">
<script>
var flaged;
$(function(){
	$('#datagrid_org_info').datagrid({
        url:'<%=basePath%>/cust/getOrg.do',
        singleSelect:true,   //只允许选中一行
        //height:$('#tabs').height() - 50 - $('#btn').height(),
        pagination:true,   //在数据网格（datagrid）底部显示分页工具栏
        rownumbers:true,   //显示带有行号的列
        //selectOnCheck:true,  //如果设置为 true，点击复选框将会选中该行。如果设置为 false，选中该行将不会选中复选框。
        //pagePosition:both,	//定义分页栏的位置。可用的值有：'top'、'bottom'、'both'
        pageSize:20,			//每页显示的记录条数
        pageList:[10,20,30,50,100,200],
        fitColumns:true, //自适应列的宽度
        striped:true,   //行条纹化。（即奇偶行使用不同背景色）
        nowrap:true,    //把数据显示在一行。即不换行
        toolbar : $("#tb_org"),
        columns:[[
                  {field:'isSelected',title:'操作',hidden:false,checkbox:true},
                  {field:'oid',title:'机构编号',width:50},
                  {field:'oname',title:'机构名称',width:70}
        ]]
    });
});

function openOrgAddDialog() {
	flaged = "a";

    var maxOid = getMaxOId();
    $("#dlg_org").dialog("open").dialog("setTitle", "新增行政区划信息");
    var row = {	'oid':maxOid,
    			'oname':''
    		  };
    $("#fm_org").form("load", row);
}



function getMaxOId(){
    $.ajax({
        url:"<%=basePath %>/dept/getMaxOId.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){  
        	//alert('data.maxDid='+data.maxDid);
          	$("#Oid").val(data.maxOid);
          	return data.maxOid;
       }
    })
}


function openOrgModifyDialog() {
	flaged = "m";
    var selectedRows = $("#datagrid_org_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要编辑的数据！");
        return;
    }
    
    var row = selectedRows[0];    
    //$("#fm_org").form("load", row);
    $("#dlg_org").dialog("open").dialog("setTitle", "编辑行政区划信息");
    $("#fm_org").form('load', {
        "oid" :row.oid,
        "oname" :row.oname
	});
}

function saveOrg() {
	var url = "<%=basePath %>/dept/saveOrg.do";
    $("#fm_org").form("submit", {
        url : url,
        onSubmit : function(data) {
        	data.flaged=flaged;
			var r = $(this).form("validate");
			//$.messager.alert("系统提示", r);
			return r;
        },
        success : function(result) {
            var result = eval('(' + result + ')');
            if (result.success) {
                $.messager.alert("系统提示", "保存成功！");
                resetValue();
                $("#dlg_org").dialog("close");
                $("#datagrid_org_info").datagrid("reload");
            } else {
                $.messager.alert("系统提示", "保存失败！");
                return;
            }
        }
    });
}

function resetValue() {
    $("#oid").val("");	 
    $("#oname").val("");
}

function closeOrgDialog() {
	flaged = "";
    $("#dlg_org").dialog("close");
    resetValue();
}

function deleteOrg() {
	var f = false;
	var selectedRows = $("#datagrid_org_info").datagrid("getSelections");
    if (selectedRows.length == 0) {
        $.messager.alert("系统提示", "请选择要删除的数据！");
        return;
    }
    var oids = selectedRows[0].oid;
    var names = selectedRows[0].oname;
    
   	confirmDelete(selectedRows,names,oids);

}

function confirmDelete(selectedRows,names,oids){
    $.messager.confirm("系统提示", 
    		"<font color=red>您确定要"
	    	+ "<h1  style='display: inline;'>删除</h1>这个机构吗？"
            + "<div style='font-size:5px'><br/></div>"
            + "如果该机构正在使用，将有可能影响到系统功能的使用。"
            + "<div style='font-size:5px'><br/></div>"
            + "<h3 style='display: inline;'>请谨慎操作！！！</h3>"
            + "<div style='font-size:5px'><br/></div>"
            + "机构名称："
            + "<h2 style='display: inline;'>"+names + "</h2></font>", 
            function (result) {
            	if (result){
	                $.post("<%=basePath %>/dept/deleteOrg.do", {
	                    oid : oids
	                }, function(r) {
	                    if (r.success) {
	                        $.messager.alert("系统提示", names + "数据已成功删除！");
	                        $("#datagrid_org_info").datagrid("reload");
	                    } else {
	                        $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
	                    }
	                }, "json");
            	}
            }
		);
}
</script>

<div>
    <table id="datagrid_org_info"></table>
</div>
    <div id="tb_org">
        <a href="javascript:openOrgAddDialog()" class="easyui-linkbutton"
            iconCls="icon-add" plain="true">新增机构</a> 
        <a  href="javascript:openOrgModifyDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">修改机构</a> 
        <a  href="javascript:deleteOrg()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">删除机构</a>
        <div id="dlg-org-buttons">
            <a href="javascript:saveOrg()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> <a href="javascript:closeOrgDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>
        <div id="dlg_org" class="easyui-dialog"
            style="top:60px;left:80px;width: 720px;height:300px;padding:10px 10px;" closed="true"
            buttons="#dlg-org-buttons">
            <form method="post" id="fm_org">
                <table cellspacing="8px;">
	              <tr>
	                  <td><div style='font-size:12px'>机构编号：</div></td>
	                  <td><div style='font-size:12px'>
	                  	  <input type="text" id="oid" name="oid" style="width:150px" readonly >
	                      &nbsp;<span style="color: red">(自动生成)</span></div>
	                  </td>
	                  <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                  <td><div style='font-size:12px'>机构名称：</div></td>
	                  <td><input type="text" id="oname" name="oname" 
	                      class="easyui-textbox"  validType="chinese" required="true"
							data-options="required:true,validType:'chinese'" />
							<!-- validType="length(2,10)"  -->
							&nbsp;<span style="color: red">*</span>
	                  </td>
	              </tr>
                </table>
            </form>
        </div>
	</div>
</body>
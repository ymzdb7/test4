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
<script type="text/javascript" src="<%=basePath %>/resource/js/validator.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/css/fpcss.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.js"></script>
</html>
<body style="margin: 1px">
<script>
var flaged;
var rid = 0;
$(function(){
	$('#datagrid_role_info').datagrid({
        url:'<%=basePath%>/role/roleList.do',
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
        toolbar : $("#tb_role"),
        columns:[[
            {field:'isSelected',title:'操作',hidden:false,checkbox:true},
            {field:'rid',title:'角色编号',width:100},
            {field:'rname',title:'角色名称',width:200}
        ]],
        onLoadSuccess:function(data){       }
    });
});
var url;

function openRoleAddDialog() {
	flaged = "a";//新增
	//alert('$("#rid").val()='+$("#rid").val()+'\n$("#rname").val()='+$("#rname").val());
    url = "<%=basePath %>/role/addRole.do";
    getTopRoleID();	
	$("#dlgRole").dialog("open").dialog("setTitle", "添加角色信息");

}

function getTopRoleID(){
    $.ajax({
        url:"<%=basePath %>/role/getTopRoleID.do",  
        dataType:"json", 
        type:"GET",
        success:function(result){  
        	//alert(typeof(result.success)+'\t1\t'+result.success);
        	if (result.success == true || result.success == 'true'){
	        	//alert(typeof(result.success)+'\t3\t'+result.success)
	         	//$("#rid").val(result.topRid);
	        	var row = {'rid':result.topRid,'rname':''};
	        	//alert(row.rid);
	            $("#fm").form("load", row);
        	}
       }
    })
}

function openRoleModifyDialog() {
	flaged = "m";//修改
    var selectedRows = $("#datagrid_role_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要编辑的数据！");
        return;
    }
    
    var row = selectedRows[0];
    $("#dlgRole").dialog("open").dialog("setTitle", "编辑角色名称");
    $("#fm").form("load", row);
}

function saveRole() {
    $("#fm").form("submit", {
        url : "<%=basePath %>/role/saveRole.do", 
        onSubmit : function(data) {
        	data.flaged = flaged;
			var r = $(this).form("validate");
			return r;
        },
        success : function(result) {
            var result = eval('(' + result + ')');
            if (result.success) {
                $.messager.alert("系统提示", "保存成功！");
                resetValue();
                $("#dlgRole").dialog("close");
                $("#datagrid_role_info").datagrid("reload");
            } else {
                $.messager.alert("系统提示", "保存失败！");
                return;
            }
        }
    });
}

function resetValue() {
    $("#rid").val("");	//    
    $("#rname").val("");
}

function closeRoleDialog() {
	flaged = "";
    $("#dlgRole").dialog("close");
    resetValue();
}

function deleteRole() {
	var f = false;
	var selectedRows = $("#datagrid_role_info").datagrid("getSelections");
    if (selectedRows.length == 0) {
        $.messager.alert("系统提示", "请选择要删除的数据！");
        return;
    }
    var strIds = [];
    var strNames = [];
    for ( var i = 0; i < selectedRows.length; i++) {
        strIds.push(selectedRows[i].rid);
        strNames.push(selectedRows[i].rname);
    }
    var rids = strIds.join(",");
    var names = strNames.join(",");

    $.post("<%=basePath %>/role/checkRoleIsUsed.do", 
    		{rid : rids }, 
    		function(result) {
	    	//var result  = eval('(' + result + ')');
	        if (result.isUsed == "true") {
	            $.messager.alert("系统提示", "该角色正在被使用，不能删除！");
	            return;
	        }else{
	        	confirmDelete(selectedRows,names,rids);
	        }
	    }, "json");	
}

function confirmDelete(selectedRows,names,rids){
    $.messager.confirm("系统提示", "<font color=red>您确定要"
	    	+ "<h1  style='display: inline;'>删除</h1>这"
    		+ "<h2  style='display: inline;'>" + selectedRows.length + "</h2>个角色吗？"
            + "<div style='font-size:5px'><br/></div>"
            + "如果该数据正在使用，将使得具有该角色的用户无法登录系统。"
            + "<div style='font-size:5px'><br/></div>"
            + "角色名称："
            + "<h2 style='display: inline;'>"+names + "</h2></font>", 
	      function(r) {
	        if (r) {
	            $.post("<%=basePath %>/role/deleteRole.do", 
	            	{rids : rids },  
	            	function(result) {
		                if (result.success) {
		                    $.messager.alert("系统提示", names + "数据已成功删除！");
		                    $("#datagrid_role_info").datagrid("reload");
		                } else {
		                    $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
		                }
	            	}, "json");
	        }
	    });
}

function openMenuRole(){
	var selectedRows = $("#datagrid_role_info").datagrid("getSelections");
    if (selectedRows.length == 0) {
        $.messager.alert("系统提示", "请选择要操作的数据！");
        return;
    }

    rid = selectedRows[0].rid;
    if (rid == null || rid == 0 || rid == "undefined"){
    	return ;
    }
	
   	opMenuTree(rid);
    
    $("#dlgMenuRole").dialog("open").dialog("setTitle", 
    					"编辑角色与菜单功能，角色ID："+ rid 
    					+ "，角色名称："+selectedRows[0].rname);
}

function opMenuTree(rid){
	var urlTree = "<%=basePath %>/role/getMenuByRid.do";
 	
   	$("#tt").tree({
        url: urlTree,
        checkbox: true,
        cascadeCheck: false,
        lines: true,
        onBeforeLoad: function(node, param){param.rid=rid;},
        onCheck: function (node, checked) {
          if (checked) {
            var parentNode = $("#tt").tree('getParent', node.target);
            if (parentNode != null) {
              $("#tt").tree('check', parentNode.target);
            }
          } else {
            var childNode = $("#tt").tree('getChildren', node.target);
            if (childNode.length > 0) {
              for (var i = 0; i < childNode.length; i++) {
                $("#tt").tree('uncheck', childNode[i].target);
              }
            }
          }
        }
      });
} 

function closeMenuRoleDialog(){
    $("#dlgMenuRole").dialog("close");
    //resetValue();
}

function saveMenuRole(){
    var arrMids = [];
    var checkeds = $('#tt').tree('getChecked', 'checked');
    for (var i = 0; i < checkeds.length; i++) {
    	arrMids.push(checkeds[i].id);
    }
    
    var mids = arrMids.join(',');
    var ust = "<%=basePath %>/role/saveMenuRoleMap.do";
    if (rid) {
        $.post(ust, 
        {	rid : rid,
            mids : mids
        }, function(result) {
        	  //
              if (result.success) {
                $.messager.alert("系统提示", "数据已成功保存！");
                closeMenuRoleDialog();
            } else {
                $.messager.alert("系统提示", "<font color=red>数据保存失败！</font>");
            }
        }, "json");
    }
}
</script>

<div>
    <table id="datagrid_role_info"></table>
</div>
    <div id="tb_role">
        <a href="javascript:openRoleAddDialog()" class="easyui-linkbutton"
            iconCls="icon-add" plain="true">新增角色</a> 
        <a  href="javascript:openRoleModifyDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">修改角色</a> 
        <a  href="javascript:deleteRole()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">删除角色</a>
        <a  href="javascript:openMenuRole()" class="easyui-linkbutton"
            iconCls="icon-filter" plain="true">功能管理</a>
        <div id="dlg-buttons">
            <a href="javascript:saveRole()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> <a href="javascript:closeRoleDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>
        <div id="dlgRole" class="easyui-dialog"
            style="top:10px;left:80px;width: 700px;height:150px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm">
                <table cellspacing="8px;" class="radioSpan">
                    <tr>
                        <td><div style='font-size:12px'>菜单编号：</div></td>
                        <td><div style='font-size:12px'><input type="text" id="rid" name="rid" 
                            class="easyui-textbox"  editable="false" readonly
                            data-options="editable:false"/>
                            &nbsp;<span style="color: red">(自动生成)</span></div>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>菜单名称：</div></td>
                        <td><input type="text" id="rname" name="rname" 
                            class="easyui-textbox"  validType="chinese"
							data-options="required:true,validType:'chinese'" /><!-- validType="length(2,10)"  -->
							&nbsp;<span style="color: red">*</span>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div id="dlgMenuRole" class="easyui-dialog"
            style="top:10px;left:80px;width: 500px;height:500px;padding:10px 10px;" closed="true"
            buttons="#dlg-menu-role-buttons">
			<ul id="tt"></ul>
		</div>
        <div id="dlg-menu-role-buttons">
            <a href="javascript:saveMenuRole()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> <a href="javascript:closeMenuRoleDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>
        
	</div>
</body>
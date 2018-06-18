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
</html>
<body style="margin: 1px">
<script>
var flaged_mng='';
var allUser=0;
$(function(){
	$('#datagrid_usr_info').datagrid({
        url:'<%=basePath%>/cust/mngUser.do?allUser='+allUser,
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
        toolbar : $("#tb_usr"),
        columns:[[
            {field:'isSelected',title:'操作',hidden:false,checkbox:true},
            {field:'pid',title:'编号',width:25},
            {field:'pname',title:'姓名',width:30},
            {field:'oid',title:'机构编号',width:25},
            {field:'oname',title:'机构名称',width:30},
            {field:'did',title:'行政区划编号',width:25},
            {field:'dname',title:'行政区划名称',width:30},
            {field:'phone',title:'手机',width:70},
            {field:'isHolder',title:'是否户主',width:40,hidden:true},
            {field:'duty',title:'用户类型',width:40},
        ]]
    });
});
var url;

function openMngUserAddDialog() {
	flaged_mng='a';
    $("#dlg_mng_user").dialog("open").dialog("setTitle", "添加对象信息");
    getMngDid();
    getOrg();
}

function getOrg(){
    $.ajax({
        url:"<%=basePath %>/cust/getOrg.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){                                 
        		//alert(data.oid+"\n"+data.oname);
                $('#oid').combobox({
                        data: data,                        
                        valueField: 'oid',
                        textField: 'oname',
                        value:data[0].oid}
                        );                       
            	    //alert("getDid\tflaged_mng="+flaged_mng);
      	   	    if (flaged_mng == "m"){
      	    	    var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
      	    	    if (selectedRows.length != 1) {
      	    	        return;
      	    	    }
      	    	    var row = selectedRows[0];
      		    	//alert("row.did="+row.did);
       	        	$("#oid").combobox("setValue", row.oid);
      	   	    }
       }
    })
}

function getMngDid(){
    $.ajax({
        url:"<%=basePath %>/cust/getPageDid.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){                                 
                    //alert(data.id+"\n"+data.type_name);
                    $('#did').combobox({
                            data: data,                        
                            valueField: 'did',
                            textField: 'dname',
                            value:data[0].did}
                            );                       
 		             	    //alert("getDid\tflaged_mng="+flaged_mng);
			       	   	    if (flaged_mng == "m"){
			       	    	    var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
			       	    	    if (selectedRows.length != 1) {
			       	    	        return;
			       	    	    }
			       	    	    var row = selectedRows[0];
			       		    	//alert("row.did="+row.did);
				       	        $("#did").combobox("setValue", row.did);
			       	   	    }
       }
    })
}

function openMngUserModifyDialog() {
    getMngDid();
    getOrg();
    flaged_mng = "m";
    var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要编辑的数据！");
        return;
    }
    var row = selectedRows[0];
    if (row.isHolder != 0) {
        $.messager.alert("系统提示", "不能修改非管理员用户！");
        return;
    }
    $("#dlg_mng_user").dialog("open").dialog("setTitle", "编辑用户信息");
    //$("#fm_mng_usr").form("load", row);    	
    if (flaged_mng == 'a') {
    }else if (flaged_mng == 'm') {
    	//alert("row.pid="+row.pid+"\nrow.pname="+row.pname+"\nrow.cid"+row.cid+"\nrow.phone="+row.phone+"\nrow.sex="+row.sex
    	//		+"\nrow.marriedType="+row.marriedType+"\nrow.faddr="+row.faddr+"\nrow.descb="+row.descb);
    	$("#pid").val(row.pid);
    	$("#oid").val(row.oid);
    	$("#pname").val(row.pname);
    	$("#phone").val(row.phone);
    }
}

function closeMngUserDialog() {
    $("#dlg_mng_user").dialog("close");
    resetValue();
}

function saveMngUser() {
	
    $("#fm_mng_usr").form("submit", {
        url : "<%=basePath %>/cust/addCustomer.do?flaged="+flaged_mng,
        onSubmit: function(data){
        	//alert('TEST+'+$("#pid").val());
      		if (checkPhoneDup()) return false;
      		if (checkPname()) return false;
			var r = $(this).form("validate");
			return r;
		},
        success : function(result) {
        	var result = eval('(' + result + ')');
            if (result.success == true || result.success=="true") {
                $.messager.alert("系统提示", "保存成功！");
                $("#datagrid_usr_info").datagrid("reload");
                resetValue();
                $("#dlg_mng_user").dialog("close");
            } else {
            	if (result.errCode== 10002){
            		$.messager.alert("系统提示", "手机号码重复！保存失败！");
            		$("#phone").focus();
            	}else{
	                $.messager.alert("系统提示", "保存失败！请联系系统管理员！");
            	}
                return;
            }
        }
    });
}

function phoneCheck(value) {  
    return /^(13|15|18)\d{9}$/i.test(value);   
}
function pnameCheck(value){
	return /^[\Α-\￥]+$/i.test(value); 
}

function checkPname(){
	if ($("#pname").val() == "") {
	    $("#pname").focus();
	    $.messager.alert("系统提示", "姓名为必填项！");
	    return true;
	}
}

function resetValue() {
    $("#pname").val("");	//用户名    
    $("#phone").val("");
    $("#did").combobox("setValue", "");
    $("#oid").combobox("setValue", "");
}

function checkPhoneDup(){
	var phone = $("#phone").val();
	//alert("phone="+phone)
	if (phone.length !=11) {
		$.messager.alert("系统提示", "手机号码格式不正确");
		$("phone").focus(); 
		return true;
	} 
	if (flaged_mng == 'a') {
	    $.ajax({
	        url:"<%=basePath %>/cust/checkPhoneDup.do?phone="+phone,  
	        dataType:"json", 
	        type:"GET",
	        success:function(data){
				if (data.success=='true'){
					$.messager.alert("系统提示", "手机号码已经存在，不能重复");
					$("phone").focus(); 
					return true;
				}
	       	}
	    })
	}
}

function deleteMngUser() {
    var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要删除的数据！");
        return;
    }
    var pid = selectedRows[0].pid;
    var pname = selectedRows[0].pname;
    $.messager.confirm("系统提示", 
    		"您确定要<h4><font color=red>删除</font></h4>该用户吗？"
            + "<br/>用户名称：<h4><font color=red>" + pname +"</font></h4>", 
            function(r) {
		        if (r) {
		            $.post("<%=basePath %>/cust/deleteCustomer.do", 
		            	{pid : pid}, 
		            function(result) {
		                if (result.success) {
		                    $.messager.alert("系统提示", "\""+pname+"\"数据已成功删除！");
		                    $("#datagrid_usr_info").datagrid("reload");
		                } else {
		                    $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
		                }
		            }, "json");
		        }
		    });
}

var pid=0;
var pname="";
var pwdOper = "";
function openPwdResetDialog() {
	pwdOper='reset';
	var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请勾选要重置密码的用户！");
        return;
    }
    
    pid = selectedRows[0].pid;
    pname = selectedRows[0].pname;
    initPwdOper(pwdOper);

    $("#resetedName").text(pname);
	$("#dlg_user_pwd_reset").dialog("open").dialog("setTitle", "重置密码");
}

function modifyPwdCheck(){
	//修改密码前检查
	var oldPwd = $("#modifyPwdOld").val();
	
	if (oldPwd.length < 6){
		$.messager.alert("系统提示", "输入的原密码不合规！");
		$("#modifyPwdOld").focus();
        return true;
	}
	var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
	var onePwd = $("#modifyPwdOne").val();
	var twoPwd = $("#modifyPwdTwo").val();
	
	if (onePwd.length<6 || twoPwd.length<6){
		$.messager.alert("系统提示", "密码不能少于6位");
		$("#modifyPwdOne").focus();
        return true;
	}
	
	if (onePwd != twoPwd){
		$.messager.alert("系统提示", "两次输入的密码不相同，请重新输入");
		$("#modifyPwdOne").focus();
        return true;
	}
}

function modifyPwdSubmit(){
	//修改密码
	var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
	var pid = selectedRows[0].pid;
	var phone = selectedRows[0].phone;
	var oldPwd = $("#modifyPwdOld").val();
	var onePwd = $("#modifyPwdOne").val();
	var twoPwd = $("#modifyPwdTwo").val();

	//var d = {'opwd': oldPwd, 'upwd':onePwd, 'phone':phone, 'pid':pid};
	//var aa = JSON.stringify(d);

	var url = '<%=basePath %>/cust/pwdModify.do';

	$.ajax({
        url:url,  
        data:{'opwd':oldPwd,'upwd':onePwd,'phone':phone,'pid':pid},
        dataType:"json", 
        type:"GET",
        success:function(result){  
        	//var result = eval('(' + result + ')');
         	if (result.success==true || result.success=="true"){
         		$.messager.alert("系统提示", "密码修改成功！");
         		closePwdResetDialog();
         	}else if (result.errCode == "10010"){
         		$.messager.alert("系统提示", "原始密码验证失败！");
         		
         	}else {
         		$.messager.alert("系统提示", "密码修改失败！");
         	}
       }
    })
}

function pwdResetModify(){
	if (pwdOper == 'modify') {
		if (modifyPwdCheck()){
			return;
		}
		modifyPwdSubmit();
	}else if (pwdOper == 'reset') {
		//重置密码
		resetPwd();
	}
    //closePwdResetDialog()
}

function resetPwd(){
	var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
	pid = selectedRows[0].pid;
    $.ajax({
        url:"<%=basePath %>/cust/pwdReset.do", 
        data: {'pid': pid },
        dataType:"json", 
        type:"GET",
        success:function(result){ 
        	//alert('pid='+pid);
         	if (result.success==true || result.success=="true" ){
         		$.messager.alert("系统提示", "密码重置成功！");
         		closePwdResetDialog();
         	}else{
         		$.messager.alert("系统提示", "密码重置失败！");
         	}
       }
    })
}

function closePwdResetDialog() {
    $("#dlg_user_pwd_reset").dialog("close");
}

function openPwdModifyDialog(){
	pwdOper = 'modify';
	var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请勾选要修改密码的用户！");
        return;
    }

    var pid = selectedRows[0].pid;
    var pname = selectedRows[0].pname;
    var phone = selectedRows[0].phone;
    initPwdOper('modify');
	$("#pnamePwd").val(pname);
	$("#phonePwd").val(phone);
    
	$("#dlg_user_pwd_reset").dialog("open").dialog("setTitle", "修改密码");
}

function initPwdOper(f){
	if (f=='reset'){
		$("#resetedTitle").show();
		$("#modifyPwdTitle").hide();
		$("#resetedName").show();
		$("#resetedName").text('');
		$("#modifyPwd").hide();
	}else if (f=='modify'){
		$("#resetedTitle").hide();
		$("#modifyPwdTitle").show();
		$("#resetedName").hide();
		$("#modifyPwd").show();
		$("#pnamePwd").val('');
		$("#phonePwd").val('');
		$("#modifyPwdOld").val('');
		$("#modifyPwdOne").val('');
		$("#modifyPwdTwo").val('');
	}	
}

function openRoleUserDialog(){
	var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
    if (selectedRows.length == 0) {
        $.messager.alert("系统提示", "请选择要操作的数据！");
        return;
    }

    pid = selectedRows[0].pid;
    pname = selectedRows[0].pname;
    if (pid == null || pid == 0 || pid == "undefined"){
    	return ;
    }
	
   	opMenuTree(pid);
    
    $("#dlgRoleUser").dialog("open").dialog("setTitle", 
    					"编辑用户与角色功能，用户ID："+ pid +", 用户名称:"+pname);
}

function opMenuTree(pid){
	var urlTree = "<%=basePath %>/cust/getRoleUserMap.do";
		
   	$("#tt").tree({
        url: urlTree,
        //data:{'pid':pid},
        checkbox: true,
        cascadeCheck: false,
        lines: false,
        onBeforeLoad: function(node, param){param.pid=pid;},
        onCheck: function (node, checked) {
	        if (checked) {
		        var rootNodes = $("#tt").tree('getRoots');
		        if (rootNodes != null) {
		        	for (var i=0; i<rootNodes.length; i++){
		        		if (node.id != rootNodes[i].id) {
		          			$("#tt").tree('uncheck', rootNodes[i].target);
		        		}
		        	}
		        }
	        }
        }
      });
} 

function saveRoleUser(){
    var checkeds = $('#tt').tree('getChecked', 'checked');
    if (checkeds.length>1) {
    	$.messager.alert("系统提示", "一个用户只能对应一个角色！");
    	return;
    }
    //debugger;
    var rid = 0;
    if (checkeds != null && checkeds != ''){
    	rid = checkeds[0].id;
	}
	var selectedRows = $("#datagrid_usr_info").datagrid("getSelections");
	var pid = selectedRows[0].pid;
    var ust = "<%=basePath %>/cust/saveRoleUserMap.do";
    if (pid != 0) {
        $.post(ust, 
        {	pid : pid,
            rid : rid
        }, function(result) {
              if (result.success) {
                $.messager.alert("系统提示", "数据已成功保存！");
                closeRoleUserDialog();
                $("#datagrid_usr_info").datagrid("reload");
            } else {
                $.messager.alert("系统提示", "<font color=red>数据保存失败！</font>");
            }
        }, "json");
    }
}

function closeRoleUserDialog(){
    $("#dlgRoleUser").dialog("close");
    //resetValue();
}

function showAllUser(){
	if (allUser == 0){
		allUser = 1;
		$("#allUsrBut").text('管理用户');
	}else{
		allUser = 0 ;
		$("#allUsrBut").text('全部用户');
	}
    $("#datagrid_usr_info").datagrid({
    							url: '<%=basePath%>/cust/mngUser.do', 
    							queryParams: { allUser: allUser}, 
    							method: "post"})
    
}
</script>

<div>
    <table id="datagrid_usr_info"></table>
</div>
    <div id="tb_usr">
    	<div style="text-align:left;vertical-align:left;" style='font-size:5px'>
	        <a href="javascript:openMngUserAddDialog()" class="easyui-linkbutton"
	            iconCls="icon-add" >新增管理用户</a> 
	        <a  href="javascript:openMngUserModifyDialog()" class="easyui-linkbutton"
	            iconCls="icon-edit">修改管理用户</a> 
	        <a  href="javascript:deleteMngUser()" class="easyui-linkbutton"
	            iconCls="icon-remove" >删除管理用户</a>
	        <a href="javascript:openRoleUserDialog()" class="easyui-linkbutton"
	            iconCls="icon-man">分配权限</a> 
	        <a href="javascript:openPwdModifyDialog()" class="easyui-linkbutton"
	            iconCls="icon-lock">修改密码</a> 
	        <a href="javascript:openPwdResetDialog()" class="easyui-linkbutton"
	            iconCls="icon-ok">重置密码</a> 
	        <a href="javascript:showAllUser()" class="easyui-linkbutton"
	            iconCls="icon-reload"><span id="allUsrBut">全部用户</span></a> 
        </div>
        <div id="dlg-user-resetPwd-buttons">
            <a href="javascript:pwdResetModify()" class="easyui-linkbutton"
                iconCls="icon-ok">确定</a> <a href="javascript:closePwdResetDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>
        <div id="dlg_user_pwd_reset" class="easyui-dialog"
            style="top:10px;left:80px;width: 400px;height:300px;padding:10px 10px;" closed="true"
            buttons="#dlg-user-resetPwd-buttons">
           <form method="post" id="fm_pwd_usr">
            <table cellspacing="8px;">
                <tr>
                    <td align=center><font color=red>
                    	<div style='font-size:12px' style="display:none"
                    		id='resetedTitle' name='resetedTitle'>
                    		以下用户的密码将被重置
                    	</div>
                    	<div style='font-size:12px' style="display:none"
                    		id='modifyPwdTitle' name='modifyPwdTitle'>
                    		请输入原始密码
                    	</div>
                    	</font>
                    </td>
                </tr>
                <tr>
                    <td align=center><font color=red>
                    	<div style='font-size:12px'  style="display:none"
                    			id="resetedName" name="resetedName" >
                    	</div>
                    	<div style='font-size:12px'  style="display:none"
                    			id="modifyPwd" name="modifyPwd" >
	                    	<div style='font-size:12px'>
	                    		<label>用户名称</label>
	                    		<input style='font-size:12px' type='text' id="pnamePwd" name="pnamePwd" readonly>
	                    	</div>
	                    	<div style='font-size:12px'>
	                    		<label>登录账号</label>
	                    		<input style='font-size:12px' type='text' id="phonePwd" name="phonePwd" readonly>
	                    	</div>
	                    	<div style='font-size:12px'>
	                    		<label>原始密码</label>
	                    		<input type='password' id="modifyPwdOld" name="modifyPwdOld">
	                    	</div>
	                    	<div style='font-size:12px'>
	                    		<label>新输密码</label>
	                    		<input type='password' id="modifyPwdOne" name="modifyPwdOne">
	                    	</div>
	                    	<div style='font-size:12px'>
	                    		<label>确认密码</label>
	                    		<input type='password' id="modifyPwdTwo" name="modifyPwdTwo">
	                    	</div>
	                    	</div>
                    	</font>
                    </td>
                </tr>
            </table>
           </form>
        </div>
        <div id="dlg_mng-buttons">
            <a href="javascript:saveMngUser()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> <a href="javascript:closeMngUserDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>
        <div id="dlg_mng_user" class="easyui-dialog"
            style="top:10px;left:80px;width: 650px;height:300px;padding:10px 10px;" closed="true"
            buttons="#dlg_mng-buttons">
            <form method="post" id="fm_mng_usr">
                <table cellspacing="8px;">
                    <tr>
                        <td><div style='font-size:12px'>姓名：</div></td>
                        <td><input type="text" id="pname" name="pname"
                            class="easyui-validatebox" validType="chinese"
                            data-options="required:'true',validType:'chinese'"/>
                            &nbsp;<span style="color: red">*</span>
                        </td>
                         <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>手机号码：</div></td>
                        <td><input type="text" id="phone" name="phone"  onblur="checkPhoneDup()"
                            validType="mobile" class="easyui-validatebox" 
							data-options="required:true,validType:'mobile'" />
							&nbsp;<span style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>所属行政区划：</div></td> 
                        <td><div style='font-size:12px'>
                        	<input name="did" class="easyui-combobox" 
                            id="did" style="width: 154px;" editable="false"
                            required="true">
                        </div>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>所属机构：</div></td> 
                        <td><div style='font-size:12px'>
                        	<input name="oid" class="easyui-combobox" 
                            id="oid" style="width: 154px;" editable="false"
                            required="true">
                            &nbsp;<span style="color: red">*</span>
                        	<input type="text" id="isHolder" name="isHolder" value="0" 
                        		style="display:none" size=5/>                            
                        	<input type="text" id="pid" name="pid" value="0" 
                        		style="display:none" size=5/>                            
                        	</div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div id="dlgRoleUser" class="easyui-dialog"
            style="top:10px;left:80px;width: 500px;height:500px;padding:10px 10px;" closed="true"
            buttons="#dlg-menu-role-buttons">
			<ul id="tt"></ul>
		</div>
        <div id="dlg-menu-role-buttons">
            <a href="javascript:saveRoleUser()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> <a href="javascript:closeRoleUserDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>
        
	</div>
</body>
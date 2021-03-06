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
<body style="margin: 1px" onload="initData(null)">
<script>
var flaged_info='';

function initData(dataurl){
	var iurl;
	var queryParamsData;
	if (dataurl==null){
		iurl = '<%=basePath%>/cust/info.do';
		queryParamsData = {};
	}else{
		var searchpname = $('#searchpname').val();
		var searchphone = $('#searchphone').val();
		var searchcid = $('#searchcid').val();
		var searchfaddr = $('#searchfaddr').val();
		var searchdid = $('#searchdid').combobox("getValue");
		var searchsex = $('#searchsex').combobox("getValue");
		var searchrelationType = $('#searchrelationType').combobox("getValue");
		var searchworkType = $('#searchworkType').combobox("getValue");
		var searchmarriedType = $('#searchmarriedType').combobox("getValue");
		var searchhealthyType = $('#searchhealthyType').combobox("getValue");

		var cb_searchpname = $('#cb_searchpname').val();
		var cb_searchphone = $('#cb_searchphone').val();
		var cb_searchcid = $('#cb_searchcid').val();
		var cb_searchfaddr = $('#cb_searchfaddr').val();
		var cb_searchdid = $('#cb_searchdid').val();
		var cb_searchsex = $('#cb_searchsex').val();
		var cb_searchrelationType = $('#cb_searchrelationType').val();
		var cb_searchworkType = $('#cb_searchworkType').val();
		var cb_searchmarriedType = $('#cb_searchmarriedType').val();
		var cb_searchhealthyType = $('#cb_searchhealthyType').val();

		queryParamsData = {
	       		'searchpname':searchpname, 
	       		'searchphone':searchphone,
	       		'searchcid':searchcid,
	       		'searchfaddr':searchfaddr,
	       		'searchdid':searchdid,
	       		'searchsex':searchsex,
	       		'searchrelationType':searchrelationType,
	       		'searchworkType':searchworkType,
	       		'searchmarriedType':searchmarriedType,
	       		'searchhealthyType':searchhealthyType,

	       		'cb_searchpname':cb_searchpname, 
	       		'cb_searchphone':cb_searchphone,
	       		'cb_searchcid':cb_searchcid,
	       		'cb_searchfaddr':cb_searchfaddr,
	       		'cb_searchdid':cb_searchdid,
	       		'cb_searchsex':cb_searchsex,
	       		'cb_searchrelationType':cb_searchrelationType,
	       		'cb_searchworkType':cb_searchworkType,
	       		'cb_searchmarriedType':cb_searchmarriedType,
	       		'cb_searchhealthyType':cb_searchhealthyType
		};
		iurl = dataurl;
	}
	$('#datagrid_customer_info').datagrid({
		url:iurl,
		queryParams:queryParamsData,
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
        toolbar : $("#tb"),
        columns:[[
                  {field:'isSelected',title:'操作',hidden:false,checkbox:true},
                  {field:'pid',title:'编号'},
                  {field:'pname',title:'姓名',width:50},
                  {field:'did',title:'行政区划编号',hidden:true},
                  {field:'dname',title:'行政区划'},
                  {field:'sex',title:'sex',width:30,hidden:true},
                  {field:'sexName',title:'性别',width:30},
                  {field:'phone',title:'手机',width:70},
                  {field:'cid',title:'身份证号码',width:100},
                  {field:'workType',title:'工作状况',width:40,hidden:true},
                  {field:'workTypeName',title:'工作状况',width:40},
                  {field:'marriedType',title:'婚姻状况',width:40,hidden:true},
                  {field:'marriedTypeName',title:'婚姻状况',width:40},
                  {field:'healthyType',title:'健康状况',width:40,hidden:true},
                  {field:'healthyTypeName',title:'健康状况',width:40},
                  {field:'relationType',title:'户主关系',width:40,hidden:true},
                  {field:'relationTypeName',title:'户主关系',width:40},
                  {field:'isHolder',title:'是否户主',width:40,hidden:true},
                  {field:'fid',title:'户号',width:40,hidden:true},
                  {field:'holderName',title:'户主姓名',width:40},
                  {field:'faddr',title:'家庭住址',width:40,hidden:true},
                  {field:'duty',title:'用户类型',width:40,hidden:true},
                  {field:'descb',title:'说明',width:100,hidden:true}
        ]],
        onLoadSuccess:function(data){}
    });
}

var url;

function openUserAddDialog() {
	flaged_info='a';
    $("#dlg").dialog("open").dialog("setTitle", "添加对象信息");
    getAllHealthyType();
    getAllWorkType();
    getAllRelationType();
    getDid();
    getHolder();
    
}

function getDid(){
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
 		             	    //alert("getDid\tflaged_info="+flaged_info);
			       	   	    if (flaged_info == "m"){
			       	    	    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
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

function getAllHealthyType(){
	
    $.ajax({
        url:"<%=basePath %>/cust/getAllHealthyType.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){ 
        			//alert(data+"\n"+ data.data.healthyType[0].type_name);
                    //alert(data[0].id+"\n"+data[0].type_name);
                    $('#healthyType').combobox({
                            data: data,                        
                            valueField: 'id',
                            textField: 'type_name',
                            value:data[0].id}
                            );
							//alert(data.join(','));
		               	    if (flaged_info == "m"){
		                	    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
		                	    if (selectedRows.length != 1) {
		                	        return;
		                	    }
		                	    var row = selectedRows[0];
		            	    	//alert("row.healthyType="+row.healthyType);
		                	   $("#healthyType").combobox("setValue", row.healthyType);
		               	    }
       }
    })
}
function getAllWorkType(){
    $.ajax({
        url:"<%=basePath %>/cust/getAllWorkType.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){                                 
                    $('#workType').combobox({
                            data: data,                        
                            valueField: 'id',
                            textField: 'type_name',
                            value:data[0].id}
                            );                       
		               	    if (flaged_info == "m"){
		                	    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
		                	    if (selectedRows.length != 1) {
		                	        return;
		                	    }
		                	    var row = selectedRows[0];
		            	    	//alert("row.workType="+row.workType);
		            		   $("#workType").combobox("setValue", row.workType);
		               	    }
       }
    })
}
function getAllRelationType(){
    $.ajax({
        url:"<%=basePath %>/cust/getAllRelationType.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){                                 
                    $('#relationType').combobox({
                            data: data,                        
                            valueField: 'id',
                            textField: 'type_name',
                            value:data[0].id}
                            );                       
	               	    if (flaged_info == "m"){
	                	    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
	                	    if (selectedRows.length != 1) {
	                	        return;
	                	    }
	                	    var row = selectedRows[0];
	            	    	//alert("row.relationType="+row.relationType);
	                	   $("#relationType").combobox("setValue", row.relationType);
	               	    }
      }
    })
}

function getHolder(){
    $.ajax({
        url:"<%=basePath %>/cust/getHolder.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){
        	if (data==null || data==""){  
        		var d = [{'hid':1,'hname':'无数据'}];
        		//alert(d[0].hname);
                $('#isHolder').combobox({
                	disabled:true}
                );                       
       			 
        	}else{
                $('#isHolder').combobox({
                      data: data,                        
                      valueField: 'hid',
                      textField: 'hname',
                      value:data[0].hid,
                      disabled:false,
                      onSelect:function(record){
                    	 //alert(record.hid);
                    	  $('#isHolder').val(record.hid);
                      }});                       
          	    if (flaged_info == "m"){
      	    	    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
      	    	    if (selectedRows.length != 1) {
      	    	        return;
      	    	    }
      	    	    var row = selectedRows[0];
          	    	//alert("row.isHolder="+row.isHolder);
      	    	   	$("#isHolder").combobox("setValue", row.isHolder);
      	    	}
        	}
       }
    })
}

function openUserModifyDialog() {
    getAllHealthyType();
    getAllWorkType();
    getAllRelationType();
    getDid();
    //getHolder();

    flaged_info = "m";
    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要编辑的数据！");
        return;
    }
    var row = selectedRows[0];
    $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
    //$("#fm_cust").form("load", row);    	
    if (flaged_info == 'a') {
    }else if (flaged_info == 'm') {
    	//alert("row.pid="+row.pid+"\nrow.pname="+row.pname+"\nrow.cid"+row.cid+"\nrow.phone="+row.phone+"\nrow.sex="+row.sex
    	//		+"\nrow.marriedType="+row.marriedType+"\nrow.faddr="+row.faddr+"\nrow.descb="+row.descb);
    	$("#pid").val(row.pid);
    	$("#pname").val(row.pname);
    	$("#cid").val(row.cid);
    	$("#phone").val(row.phone);
    	$("#sex").combobox("setValue",row.sex);
        //$("#workType").combobox("setValue", row.workType);
        //$("#relationType").combobox("setValue", row.relationType);
        $("#marriedType").combobox("setValue", row.marriedType);
        //$("#healthyType").combobox("setValue", row.healthyType);
        //$("#isHolder").combobox("setValue", row.isHolder);
        //$("#did").combobox("setValue", row.did);
        $("#faddr").val(row.faddr);
        $("#descb").val(row.descb);
    }
	url = "<%=basePath %>/cust/updateCustumer.do?flaged=" + flaged_info;
}

function closeUserDialog() {
    $("#dlg").dialog("close");
    resetValue();
}

function saveUser() {
	
    $("#fm_cust").form("submit", {
        url : "<%=basePath %>/cust/addCustomer.do?flaged="+flaged_info,
        onSubmit: function(data){
        	//alert('TEST+'+$("#pid").val());
      		if (checkCidDup()) return false;
      		if (checkPhoneDup()) return false;
      		//if (checkHolder()) return false;
      		if (checkPname()) return false;

			var r = $(this).form("validate");
			//alert('$(this).form("validate") = '+$(this).form("validate"));
			return r;
		},
        success : function(result) {
        	//alert("1"+result);
        	var result = eval('(' + result + ')');
        	//alert("2:"+result);
            if (result.success == true || result.success=="true") {
                $.messager.alert("系统提示", "保存成功！");
                $("#datagrid_customer_info").datagrid("reload");
                resetValue();
                $("#dlg").dialog("close");
            } else {
            	if (result.errCode==10001){
            		$.messager.alert("系统提示", "身份证号码重复！保存失败！");
            		$("#cid").focus();
            	}else if (result.errCode== 10002){
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

function cidCheck(value) {  
	return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);  
}
function phoneCheck(value) {  
    return /^(13|15|18)\d{9}$/i.test(value);   
}
function pnameCheck(value){
	return /^[\Α-\￥]+$/i.test(value); 
}

function checkHolder(){
	var ih = $("#c_isHolder").combobox("getValue");
	var rt = $("#relationType").combobox("getValue");
	//alert(ih+"<br/>"+rt);
	if ((ih == null || ih == "") && (rt != 1 && rt != 13)){
		$("#c_isHolder").focus();
		$.messager.alert("系统提示", "当与户主关系不是工作关系或本人不是户主时，户主必须选择，不能空");
		return true;
	}
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
    $("#sex").val("");
    $("#cid").val("");
    $("#phone").val("");
    $("#workType").combobox("setValue", "");
    $("#relationType").combobox("setValue", "");
    $("#marriedType").combobox("setValue", "");
    $("#healthyType").combobox("setValue", "");
    $("#faddr").val("");
    $("#descb").val("");
}

function checkCidDup(){
	//$("#descb").val('');
	var cid = $("#cid").val();
	if (!cidCheck(cid)){
		$.messager.alert("系统提示", "身份证号码格式不对");
		$("cid").focus(); 
		return true;
	} 
	if (flaged_info == 'a') {
	    $.ajax({
	        url:"<%=basePath %>/cust/checkCidDup.do?cid="+cid,  
	        dataType:"json", 
	        type:"GET",
	        success:function(data){  
				if (data.success=='true'){
					$.messager.alert("系统提示", "身份证号码已经存在，不能重复");
					$("cid").focus(); 
					return true;
				}
	       	}
	    })
	}
}

function checkPhoneDup(){
	var phone = $("#phone").val();
	
	if (!phoneCheck(phone)) {
		$.messager.alert("系统提示", "手机号码格式不正确");
		$("phone").focus(); 
		return true;
	} 
	if (flaged_info == 'a') {
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

function deleteUser() {
    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要删除的数据！");
        return;
    }
    var pid = selectedRows[0].pid;
    var pname = selectedRows[0].pname;
    $.messager.confirm("系统提示", 
    		"<font color=red>您确定要"
	    	+ "<h1  style='display: inline;'>删除</h1>该对象吗？"
            + "<div style='font-size:5px'><br/></div>"
            + "<div style='font-size:5px'><br/></div>"
            + "名称："
            + "<h2 style='display: inline;'>"+pname + "</h2></font>", 
            function(r) {
		        if (r) {
		            $.post("<%=basePath %>/cust/deleteCustomer.do", {
		                pid : pid
		            }, function(result) {
		                if (result.success) {
		                    $.messager.alert("系统提示", "\""+pname+"\"数据已成功删除！");
		                    $("#datagrid_customer_info").datagrid("reload");
		                } else {
		                    $.messager.alert("系统提示", "数据删除失败，请联系系统管理员！");
		                }
		            }, "json");
		        }
		    });
}

function openDetailDialog() {
    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要查看的数据！");
        return;
    }
    var row = selectedRows[0];
    $("#dlg_detail").dialog("open").dialog("setTitle", row.pname+" 的明细信息");
  	$("#pname_div").text(row.pname);
  	$("#cid_div").text(row.cid);
  	$("#phone_div").text(row.phone);
  	$("#sex_div").text(row.sexName);
    $("#workType_div").text(row.workTypeName);
    $("#relationType_div").text(row.relationTypeName);
    $("#marriedType_div").text(row.marriedTypeName);
    $("#healthyType_div").text(row.healthyTypeName);
    $("#holder_div").text(row.holderName);
    $("#did_div").text(row.dname);
    $("#faddr_div").text(row.faddr);
    $("#descb_div").text(row.descb);
}

function closeDetailDialog() {
  	$("#pname_div").text("");
  	$("#cid_div").text("");
  	$("#phone_div").text("");
  	$("#sex_div").text("");
    $("#workType_div").text("");
    $("#relationType_div").text("");
    $("#marriedType_div").text("");
    $("#healthyType_div").text("");
    $("#holder_div").text("");
    $("#did_div").text("");
    $("#faddr_div").text("");
    $("#descb_div").text("");
    $("#dlg_detail").dialog("close");
}

function reloadData(){
	//$("#datagrid_customer_info").datagrid("reload");
	initData(null);
}

function openSearchDialog(){
	getSearchDid();
	getSearchAllHealthyType();
	getSearchAllWorkType();
	getSearchAllRelationType();
	initCheckBox();
	$("#searchDiv").dialog("open").dialog("setTitle", "户主信息搜索");
}

function initCheckBox(){
	document.getElementById("cb_searchpname").checked=true;
   	document.getElementById("cb_searchphone").checked=false;
   	document.getElementById("cb_searchcid").checked=false;
   	document.getElementById("cb_searchfaddr").checked=false;
   	document.getElementById("cb_searchdid").checked=false;
   	document.getElementById("cb_searchsex").checked=false;
   	document.getElementById("cb_searchrelationType").checked=false;
   	document.getElementById("cb_searchworkType").checked=false;
   	document.getElementById("cb_searchmarriedType").checked=false;
   	document.getElementById("cb_searchhealthyType").checked=false;

   	$("#cb_searchpname").val(1);
   	$("#cb_searchphone").val(0);
   	$("#cb_searchcid").val(0);
   	$("#cb_searchfaddr").val(0);
   	$("#cb_searchdid").val(0);
   	$("#cb_searchsex").val(0);
   	$("#cb_searchrelationType").val(0);
   	$("#cb_searchworkType").val(0);
   	$("#cb_searchmarriedType").val(0);
   	$("#cb_searchhealthyType").val(0);
   	
   	document.getElementById("searchpname").disabled=false;
   	document.getElementById("searchphone").disabled=true;
   	document.getElementById("searchcid").disabled=true;
   	document.getElementById("searchfaddr").disabled=true;
   	$("#searchdid").combobox('disable');
   	$("#searchsex").combobox('disable');
   	$("#searchrelationType").combobox('disable');
   	$("#searchworkType").combobox('disable');
   	$("#searchmarriedType").combobox('disable');
   	$("#searchhealthyType").combobox('disable');
}

function searchInfo() {
	var u = '<%=basePath%>/cust/searchInfo.do';
	initData(u);
	$("#searchDiv").dialog("close");
}

function getSearchDid(){
    $.ajax({
        url:"<%=basePath %>/cust/getPageDid.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){                                 
                    //alert(data.id+"\n"+data.type_name);
                    $('#searchdid').combobox({
                            data: data,                        
                            valueField: 'did',
                            textField: 'dname',
                            value:data[0].did}
                            );                       
       }
    })
}

function getSearchAllHealthyType(){
	
    $.ajax({
        url:"<%=basePath %>/cust/getAllHealthyType.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){ 
        			
                    //alert(data[0].id+"\n"+data[0].type_name);
                    $('#searchhealthyType').combobox({
                            data: data,                        
                            valueField: 'id',
                            textField: 'type_name',
                            value:data[0].id}
                            );
       }
    })
}
function getSearchAllWorkType(){
    $.ajax({
        url:"<%=basePath %>/cust/getAllWorkType.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){                                 
                    $('#searchworkType').combobox({
                            data: data,                        
                            valueField: 'id',
                            textField: 'type_name',
                            value:data[0].id}
                            );                       
       }
    })
}
function getSearchAllRelationType(){
    $.ajax({
        url:"<%=basePath %>/cust/getAllRelationType.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){                                 
                    $('#searchrelationType').combobox({
                            data: data,                        
                            valueField: 'id',
                            textField: 'type_name',
                            value:data[0].id}
                            );                       
      }
    })
}


function closeSearch(){
	$("#searchDiv").dialog("close");
}

function checkObject(o,t,snm){
	
	if (o.checked){
		if (t=='text'){
			var t = document.getElementById(""+snm+"");
			t.disabled=false;
		}else{
			$("#"+snm+"").combobox('enable');
		}
		$("#cb_"+snm+"").val(1);
	}else{
		if (t=='text'){
			document.getElementById(""+snm+"").disabled=true;
		}else{
			$("#"+snm+"").combobox('disable'); 
		}
		$("#cb_"+snm+"").val(0);
	}
}

</script>

<div>
    <table id="datagrid_customer_info"></table>
</div>
    <div id="tb">
        <a  href="javascript:deleteUser()" class="easyui-linkbutton"
            iconCls="icon-remove">删除信息</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a  href="javascript:openDetailDialog()" class="easyui-linkbutton"
	       iconCls="icon-tip">查看详细信息</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <a href="javascript:reloadData()" class="easyui-linkbutton"
	   		iconCls="icon-reload">重新加载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <a href="javascript:openSearchDialog()" class="easyui-linkbutton"
	   		iconCls="icon-search">条件查询</a>
        <div id="dlg-buttons">
            <a href="javascript:saveUser()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> <a href="javascript:closeUserDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>
        <div id="dlg" class="easyui-dialog"
            style="top:30px;left:30px;width: 750px;height:400px;padding:10px 10px;" closed="true"
            buttons="#dlg-buttons">
            <form method="post" id="fm_cust">
                <table cellspacing="8px;">
                    <tr>
                        <td><div style='font-size:12px'>姓名：</div></td>
                        <td><input type="text" id="pname" name="pname"
                            class="easyui-validatebox" validType="chinese"
                            data-options="required:'true',validType:'chinese'"/>
                            &nbsp;<span style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>性别：</div></td> 
                        <td><select name="sex" class="easyui-combobox" 
                            id="sex" style="width: 154px;" editable="false"
                            panelHeight="auto"  required="true">
                                <option value="F" >女</option>
                                <option value="M" selected="selected">男</option>
                        	</select> 
                        	&nbsp;<span style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>身份证号码：</div></td>
                        <td><input type="text" id="cid" name="cid" onblur="checkCidDup()"
                            class="easyui-validatebox"  validType="idcard"
                            data-options="required:true,validType:'idcard'"/>
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
                        <td><div style='font-size:12px'>工作状况：</div></td>
                        <td><input name="workType" class="easyui-combobox" 
                            id="workType" style="width: 154px;" editable="false"
                            panelHeight="auto" required="true">
							&nbsp;<span style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>与户主关系：</div></td>
                        <td><input name="relationType" class="easyui-combobox" 
                            id="relationType" style="width: 154px;" editable="false"
                            panelHeight="auto"  required="true">
							&nbsp;<span style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>婚姻状况：</div></td>
                        <td><select name="marriedType" class="easyui-combobox" 
                            id="marriedType" style="width: 154px;" editable="false"
                            panelHeight="auto"  required="true">
                                <option value="0">未婚</option>
                                <option value="1">已婚</option>
                                <option value="2" selected="selected">未知</option>
                        </select> &nbsp;<span style="color: red">*</span>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>健康状况：</div></td>
                        <td><input name="healthyType" class="easyui-combobox" 
                            id="healthyType" style="width: 154px;" editable="false"
                            panelHeight="auto"  required="true">
                            &nbsp;<span style="color: red">*</span>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>所属行政区划：</div></td> 
                        <td><div style='font-size:12px'>
                        	<input name="did" class="easyui-combobox" 
                            id="did" style="width:230px" editable="false"
                            required="true">
                            &nbsp;<span style="color: red">*</span>
                        	</div>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>户主：</div></td>
                        <td>
                        	<div id="div-holder" name="div-holder" style='font-size:12px'>
							<input name="isHolder" class="easyui-combobox" 
                            id="isHolder" style="width: 154px;" editable="false">
                            </div>
                        </td>
                    </tr>
                        <td><div style='font-size:12px'>家庭地址：</div></td>
                        <td colspan='4'><input type="text" id="faddr" name="faddr" size=75/>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>说明：</div></td> 
                        <td colspan=4><div>
                        	<textarea style='font-size:13px' id="descb" 
                        		name="descb" rows="1" cols="55" size=90></textarea>
                        	<input type="text" id="pid" name="pid" value="0" 
                        		style="display:none" size=5/>
                        	</div>
                        </td>
                    </tr>
                </table>
                
            </form>
        </div>
	</div>
	    <div id="dlg-detail-buttons">
				 <a href="javascript:closeDetailDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>
		<div id="dlg_detail" class="easyui-dialog"
            style="top:30px;left:30px;width: 750px;height:400px;padding:10px 10px;" closed="true"
            buttons="#dlg-detail-buttons">
                <table cellspacing="8px;">
                    <tr>
                        <td style="width: 100px;"><div style='font-size:12px'>姓名：</div></td>
                        <td style="width: 200px;"><div style='font-size:15px'>
                        	<span  id="pname_div" name="pname_div"></span></div>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td style="width: 100px;"><div style='font-size:12px'>性别：</div></td> 
                        <td style="width: 200px;"><div style='font-size:15px'>
                        	<span name="sex_div"  id="sex_div"></span></div>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>身份证号码：</div></td>
                        <td><div style='font-size:15px'>
                        	<span id="cid_div" name="cid_div" ></span></div>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>手机号码：</div></td>
                        <td><div style='font-size:15px'>
                        	<span id="phone_div" name="phone_div"></span></div>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>工作状况：</div></td>
                        <td><div style='font-size:15px'>
                        	<span name="workType_div" id="workType_div"></span></div>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>与户主关系：</div></td>
                        <td><div style='font-size:15px'>
                        	<span name="relationType_div" id="relationType_div"></span></div>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>婚姻状况：</div></td>
                        <td><div style='font-size:15px'>
                        	<span name="marriedType_div" id="marriedType_div"></span></div>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>健康状况：</div></td>
                        <td><div style='font-size:15px'>
                        	<span name="healthyType_div" id="healthyType_div"></span></div>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>所属行政区划：</div></td> 
                        <td><div style='font-size:15px'>
                        	<span name="did_div" id="did_div" > </span>
                        	</div>
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><div style='font-size:12px'>户主：</div></td>
                        <td><div style='font-size:15px'>
                        	<span id="holder_div" name="holder_div"></span></div>
                        </td>
                    </tr>
                        <td><div style='font-size:12px'>家庭地址：</div></td>
                        <td colspan='4'><div style='font-size:15px'>
                        	<span id="faddr_div" name="faddr_div"></span></div>
                        </td>
                    </tr>
                    <tr>
                        <td><div style='font-size:12px'>说明：</div></td> 
                        <td colspan=4><div style='font-size:15px'>
                        	<span id="descb_div" name="descb_div"></span>
                        	</div>
                        </td>
                    </tr>
                </table>
        </div>
<div id="searchDiv" class="easyui-dialog"
            style="top:30px;left:30px;width: 750px;height:300px;padding:10px 10px;" closed="true"
            buttons="#dlg-search-buttons">
            <form method="post" id="fm_search">
                <table cellspacing="8px;">
                    <tr>
                        <td><div style='font-size:12px'>姓名:</div></td>
                        <td><input type="text" id="searchpname" size="20"
    						onkeydown="if(event.keyCode == 13) searchInfo()" /> 
               				<input type="checkbox" id="cb_searchpname" value="1" checked
               					 onclick="checkObject(this,'text','searchpname')"/>
    					</td>
    					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					<td>
    							<div style='font-size:12px'>手机号码:</div></td>
    					<td><input type="text" id="searchphone" size="20" disabled
    						onkeydown="if(event.keyCode == 13) searchInfo()" /> 
               				<input type="checkbox" id="cb_searchphone" value="0" 
               					onclick="checkObject(this,'text','searchphone')"/>
    					</td>
    				</tr>
    				<tr>
    					<td><div style='font-size:12px'>身份证号码:</div></td>
    					<td><input type="text" id="searchcid" size="20" disabled
    						onkeydown="if(event.keyCode == 13) searchInfo()" />
               				<input type="checkbox" id="cb_searchcid" value="0" 
               					onclick="checkObject(this,'text','searchcid')"/>
    					</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					<td>
							<div style='font-size:12px'>家庭地址:</div></td>
						<td><input type="text" id="searchfaddr" size="20" disabled
    						onkeydown="if(event.keyCode == 13) searchInfo()" />
               				<input type="checkbox" id="cb_searchfaddr" value="0" 
               					onclick="checkObject(this,'text','searchfaddr')"/>
    					</td>
    				</tr>
    				<tr>
    					<td><div style='font-size:12px'>行政区划:</div></td>
    					<td><input name="searchdid" class="easyui-combobox" disabled
               					 id="searchdid" style="width: 230px;" editable="false"/>
               				<input type="checkbox" id="cb_searchdid" value="0" 
               					onclick="checkObject(this,'combobox','searchdid')"/>
               			</td>
               			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					<td>
               					<div style='font-size:12px'>性别:</div></td>
               			<td><select name="searchsex" class="easyui-combobox" disabled
                				id="searchsex" style="width: 154px;" editable="false"
                				panelHeight="auto">
			                    <option value="F" >女</option>
			                    <option value="M" selected="selected">男</option>
			            	</select>
               				<input type="checkbox" id="cb_searchsex" value="0" 
               					onclick="checkObject(this,'combobox','searchsex')"/>
			            </td>
			        </tr>
			        <tr>
						<td><div style='font-size:12px'>户主关系:</div></td>
						<td><input name="searchrelationType" class="easyui-combobox" disabled
                				id="searchrelationType" style="width: 154px;" editable="false"
                				panelHeight="auto">
               				<input type="checkbox" id="cb_searchrelationType" value="0" 
               					onclick="checkObject(this,'combobox','searchrelationType')"/>
                		</td>
    					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					<td>
    						<div style='font-size:12px'>工作状况:</div></td>
    					<td><input name="searchworkType" class="easyui-combobox" disabled
                				id="searchworkType" style="width: 154px;" editable="false"
                				panelHeight="auto">
               				<input type="checkbox" id="cb_searchworkType" value="0" 
               					onclick="checkObject(this,'combobox','searchworkType')"/>
                		</td>
    				</tr>
    				<tr>
    					<td><div style='font-size:12px'>婚姻状况:</div></td>
    					<td><select name="searchmarriedType" class="easyui-combobox" disabled
                				id="searchmarriedType" style="width: 154px;" editable="false"
                				panelHeight="auto" >
				                    <option value="0">未婚</option>
				                    <option value="1">已婚</option>
				                    <option value="2" selected="selected">未知</option>
				            	</select>
               				<input type="checkbox" id="cb_searchmarriedType" value="0" 
               					onclick="checkObject(this,'combobox','searchmarriedType')"/>
				        </td>
				        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					<td>
				        	<div style='font-size:12px'>健康状况:</div></td>
				        <td><input name="searchhealthyType" class="easyui-combobox" disabled
                					id="searchhealthyType" style="width: 154px;" editable="false"
                					panelHeight="auto">    
               				<input type="checkbox" id="cb_searchhealthyType"  value="0" 
               					onclick="checkObject(this,'combobox','searchhealthyType')"/>
                		</td>
				    </tr>
                </table>
            </form>
</div>
<div id="dlg-search-buttons">
    <a href="javascript:searchInfo()" class="easyui-linkbutton"
                iconCls="icon-search">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:closeSearch()" class="easyui-linkbutton"
    iconCls="icon-clear">关闭</a>
</div>	
</body>
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
<script>

function initData(dataurl){
	var iurl;
	var queryParamsData;
	if (dataurl==null){
		iurl = '<%=basePath%>/cust/holderInfo.do';
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
		url:iurl, //,
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
            {field:'fid',title:'户号',width:40,hidden:true},
            {field:'holderName',title:'户主姓名',width:40},
            {field:'pname',title:'姓名',width:50,hidden:true},
            {field:'did',title:'行政区划编号',hidden:true},
            {field:'dname',title:'行政区划'},
            {field:'amount',title:'户成员数'},
            {field:'isHolder',title:'是否户主',width:40,hidden:true},
            {field:'phone',title:'手机',width:70},
            {field:'cid',title:'身份证号码',width:100},
            {field:'sex',title:'sex',width:30,hidden:true},
            {field:'sexName',title:'性别',width:30},
            {field:'workType',title:'工作状况',width:40,hidden:true},
            {field:'workTypeName',title:'工作状况',width:40},
            {field:'marriedType',title:'婚姻状况',width:40,hidden:true},
            {field:'marriedTypeName',title:'婚姻状况',width:40},
            {field:'healthyType',title:'健康状况',width:40,hidden:true},
            {field:'healthyTypeName',title:'健康状况',width:40},
            {field:'relationType',title:'户主关系',width:40,hidden:true},
            {field:'relationTypeName',title:'户主关系',width:40,hidden:true},
            {field:'duty',title:'用户类型',width:40,hidden:true},
            {field:'faddr',title:'家庭住址',width:40,hidden:true},
            {field:'descb',title:'说明',width:100,hidden:true}
        ]],
        onLoadSuccess:function(data){}
    });
}

function familyMemberInfo(holder){
	$('#datagrid_detail_info').datagrid({
       url:'<%=basePath%>/cust/familyMemberInfo.do',
       queryParams: {'holder':holder},
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
       toolbar : $("#dlg-member"),
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
           {field:'isHolder',title:'是否户主',width:40,hidden:true},
           {field:'fid',title:'户号',width:40,hidden:true},
           {field:'relationType',title:'户主关系',width:40,hidden:true},
           {field:'relationTypeName',title:'户主关系',width:40},
           {field:'holderName',title:'户主姓名',width:40},
           {field:'faddr',title:'家庭住址',width:40,hidden:true},
           {field:'duty',title:'用户类型',width:40,hidden:true},
           {field:'descb',title:'说明',width:100,hidden:true}
       ]]
	 });
}

function closeDialog() {
    $("#dlg").dialog("close");
}


function openFamilyDetailByHolder(){
    var selectedRows = $("#datagrid_customer_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条户主数据！");
        return;
    }	
    var holder = selectedRows[0].pid;
    var holderName = selectedRows[0].holderName;
    //
    //alert("ddd");
    $("#dlg").dialog("open").dialog("setTitle", "户主("+holderName+")的家庭成员信息列表");
    familyMemberInfo(holder);
    //window.location.href='familyMemberInfo.jsp?holder='+holder;
}

//----------------------------------------------------------
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
	var u = '<%=basePath%>/cust/searchHolderInfo.do';
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

function reloadData(){
	//$("#datagrid_customer_info").datagrid("reload");
	initData(null);
}

function openDetailDialog(dgd) {
    var selectedRows = $("#"+dgd+"").datagrid("getSelections");
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

</script>

<body style="margin: 1px" onload="initData(null)">
<div>
    <table id="datagrid_customer_info"></table>
</div>
<div id="dlg-search-buttons">
    <a href="javascript:searchInfo()" class="easyui-linkbutton"
                iconCls="icon-search">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="javascript:closeSearch()" class="easyui-linkbutton"
    iconCls="icon-clear">关闭</a>
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
<div id="tb">
   <a href="javascript:openFamilyDetailByHolder()" class="easyui-linkbutton"
        iconCls="icon-man">家庭成员信息查询</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <a  href="javascript:openDetailDialog('datagrid_customer_info')" class="easyui-linkbutton"
       iconCls="icon-tip">查看详细信息</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <a href="javascript:reloadData()" class="easyui-linkbutton"
   		iconCls="icon-reload">重新加载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <a href="javascript:openSearchDialog()" class="easyui-linkbutton"
   		iconCls="icon-search">条件查询户主</a>
	<div id="dlg-buttons">
	    <a href="javascript:closeDialog()" 
	        class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	<div id="dlg" class="easyui-dialog"
	    style="top:20px;left:30px;width: 1000px;height:400px;padding:10px 10px;" closed="true"
	          buttons="#dlg-buttons">
	     <table id="datagrid_detail_info"></table>
		<div id="dlg-member">
		   <a  href="javascript:openDetailDialog('datagrid_detail_info')" class="easyui-linkbutton"
		       iconCls="icon-man">查看详细信息</a>
		</div>
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
</body>
</html>
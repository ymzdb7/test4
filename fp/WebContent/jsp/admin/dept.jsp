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
	$('#datagrid_dept_info').datagrid({
        url:'<%=basePath%>/dept/deptInfo.do',
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
        toolbar : $("#tb_dept"),
        columns:[[
                  {field:'isSelected',title:'操作',hidden:false,checkbox:true},
                  {field:'did',title:'行政区划编号',width:50},
                  {field:'dname',title:'行政区划',width:70},
                  {field:'superDid',title:'上级区划编号',width:50},
                  {field:'superDidName',title:'上级区划名称',width:70},
                  {field:'level',title:'行政区划级别编号',width:50},
                  {field:'levelName',title:'行政区划级别名称',width:70},
                  {field:'descb',title:'说明',width:100}
        ]],
        onLoadSuccess:function(data){}
    });
});

function openDeptAddDialog() {
	flaged = "a";
    getAllLevel();
    var maxId = getMaxDId();
    
    $("#dlg_dept").dialog("open").dialog("setTitle", "新增行政区划信息");
    //var d = $("#did").val();
    var l = $("#ulevel").combobox('getValue');
    var s = $("#superDid").combobox('getValue');
    //alert(d+'\n'+l+'\n'+s);
    var row = {	'did':maxId,
    			'dname':'',
    			'ulevel':l,
    			'superDid':s,
    			'descb':''
    		  };
    //alert('row.maxId='+maxId);
    $("#fm_dept").form("load", row);
}

function getAllLevel(){
	var u = "<%=basePath %>/dept/getAllLevel.do";
    $.ajax({
        url:u,  
        dataType:"json", 
        type:"GET",
        success:function(data){                                 
           $('#ulevel').combobox({
              data: data,                        
              valueField: 'ulevel',
              textField: 'dlname',
              onLoadSuccess:function(data){
            	//var types = $("#ulevel").combobox('getData');
           		//if (types.length > 0){ 
           			//$("#ulevel").combobox('select', types[0].ulevel);
           			//var l = $("#ulevel").combobox('getValue');
           			//getSuperDept(types[0].ulevel);
           		//}
          		if (flaged=='m'){
        		    var selectedRows = $("#datagrid_dept_info").datagrid("getSelections");
        		    var row = selectedRows[0];
        		    $("#ulevel").combobox('setValue', row.level);
        		}
              },
           	  onSelect:function(record){
           		  //alert(record.ulevel+"\t"+record.dlname);
           		  getSuperDept(record.ulevel);
       		  }
           });
       }
    })
}

function getMaxDId(){
    $.ajax({
        url:"<%=basePath %>/dept/getMaxDId.do",  
        dataType:"json", 
        type:"GET",
        success:function(data){  
        	//alert('data.maxDid='+data.maxDid);
          	$("#did").val(data.maxDid);
          	return data.maxDid;
       }
    })
}

function getSuperDept(l){
	if (l == 4){
		l  = 3;		
	}
	var u ="<%=basePath %>/dept/getSuperDept.do";
    $.ajax({
        url:u,  
        dataType:"json", 
        type:"GET",
	    data:{
	    	"cLevel":l
	    },
        success:function(data){                                 
            $('#superDid').combobox({
                data: data,                        
                valueField: 'did',
                textField: 'dname',
                onLoadSuccess:function(data){
             		//var typess = $("#superDid").combobox('getData');
            		//if (typess.length > 0){ 
            		//	$("#superDid").combobox('select', typess[0].did);
            		//}
            		if (flaged=='m'){
            		    var selectedRows = $("#datagrid_dept_info").datagrid("getSelections");
            		    var row = selectedRows[0];
            		    var typess = $("#superDid").combobox('getData');
            		    for (var i=0; i<typess.length; i++) {
            		    	if (typess[i].did==row.superDid){
            		    		 $("#superDid").combobox('setValue', row.superDid);
            		    		 break;
            		    	}
            		    }
            		}
                  }
                }
             );
       }
    })
}

function openDeptModifyDialog() {
	flaged = "m";
    var selectedRows = $("#datagrid_dept_info").datagrid("getSelections");
    if (selectedRows.length != 1) {
        $.messager.alert("系统提示", "请选择一条要编辑的数据！");
        return;
    }
    
    var row = selectedRows[0];
    getAllLevel();
    getSuperDept(row.level);
    
    //$("#fm_dept").form("load", row);
    $("#dlg_dept").dialog("open").dialog("setTitle", "编辑行政区划信息");
    $("#fm_dept").form('load', {
        "did" :row.did,
        "dname" :row.dname,
        "descb" : row.descb
	});
    //$("#ulevel").combobox('setValue', row.level);
    //$("#superDid").combobox('setValue', row.superDid);
    //alert(row.levelName+"\t"+row.superDidName+"\n"
    	//	+$("#ulevel").combobox('getValue')+"\t"+$("#superDid").combobox('getValue'));
}

function saveDept() {
	var url = "<%=basePath %>/dept/saveDept.do";
	
    $("#fm_dept").form("submit", {
        url : url,
        onSubmit : function(data) {
        	data.flaged=flaged;
        	//alert('这是Dept中的url='+url);
			var r = $(this).form("validate");
			//$.messager.alert("系统提示", r);
			return r;
        },
        success : function(result) {
            //alert("a:"+result+"\t"+typeof(result));
            //$.parseJSON(result);
            var result = eval('(' + result + ')');
            //alert(result);
            if (result.success) {
                $.messager.alert("系统提示", "保存成功！");
                resetValue();
                $("#dlg_dept").dialog("close");
                $("#datagrid_dept_info").datagrid("reload");
            } else {
                $.messager.alert("系统提示", "保存失败！");
                return;
            }
        }
    });
}

function resetValue() {
    $("#did").val("");	//用户名    
    $("#dname").val("");
    $("#superDid").combobox("setValue", "");
    $("#ulevel").combobox("setValue", "");
    $("#descb").val("");
}

function closeDeptDialog() {
	flaged = "";
    $("#dlg_dept").dialog("close");
    resetValue();
}

function deleteDept() {
	var f = false;
	var selectedRows = $("#datagrid_dept_info").datagrid("getSelections");
    if (selectedRows.length == 0) {
        $.messager.alert("系统提示", "请选择要删除的数据！");
        return;
    }
    var dids = selectedRows[0].did;
    var names = selectedRows[0].dname;
    
    $.post("<%=basePath %>/dept/checkDeptIsUsed.do", {
	    	did : dids
	    }, function(result) {
	    	//var result  = eval('(' + result + ')');
	    	//$.messager.alert("系统提示", "result.isUsed="+result.isUsed);
	        if (result.isUsed == "true") {
	            $.messager.alert("系统提示", "<h4>该行政区划正在被使用，不能删除！</h4>");
	            return;
	        }else{
	        	confirmDelete(selectedRows,names,dids);
	        }
	    }, "json");	
}

function confirmDelete(selectedRows,names,dids){
    $.messager.confirm("系统提示", 
    		"<font color=red>您确定要"
	    	+ "<h1  style='display: inline;'>删除</h1>这个行政区划吗？"
            + "<div style='font-size:5px'><br/></div>"
            + "如果该行政区划正在使用，将使得归属于该行政区划的用户无法登录系统。"
            + "<div style='font-size:5px'><br/></div>"
            + "<h3 style='display: inline;'>请谨慎操作！！！</h3>"
            + "<div style='font-size:5px'><br/></div>"
            + "行政区划名称："
            + "<h2 style='display: inline;'>"+names + "</h2></font>", 
            function (result) {
            	if (result){
	                $.post("<%=basePath %>/dept/deleteDept.do", {
	                    did : dids
	                }, function(r) {
	                    if (r.success) {
	                        $.messager.alert("系统提示", names + "数据已成功删除！");
	                        $("#datagrid_dept_info").datagrid("reload");
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
    <table id="datagrid_dept_info"></table>
</div>
    <div id="tb_dept">
        <a href="javascript:openDeptAddDialog()" class="easyui-linkbutton"
            iconCls="icon-add" plain="true">新增行政区划</a> 
        <a  href="javascript:openDeptModifyDialog()" class="easyui-linkbutton"
            iconCls="icon-edit" plain="true">修改行政区划</a> 
        <a  href="javascript:deleteDept()" class="easyui-linkbutton"
            iconCls="icon-remove" plain="true">删除行政区划</a>
        <div id="dlg-dept-buttons">
            <a href="javascript:saveDept()" class="easyui-linkbutton"
                iconCls="icon-ok">保存</a> <a href="javascript:closeDeptDialog()"
                class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
        </div>
        <div id="dlg_dept" class="easyui-dialog"
            style="top:60px;left:80px;width: 720px;height:300px;padding:10px 10px;" closed="true"
            buttons="#dlg-dept-buttons">
            <form method="post" id="fm_dept">
                <table cellspacing="8px;">
	              <tr>
	                  <td><div style='font-size:12px'>行政区划编号：</div></td>
	                  <td><div style='font-size:12px'>
	                  	  <input type="text" id="did" name="did" style="width:150px" readonly >
	                      &nbsp;<span style="color: red">(自动生成)</span></div>
	                  </td>
	                  <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                  <td><div style='font-size:12px'>行政区划名称：</div></td>
	                  <td><input type="text" id="dname" name="dname" 
	                      class="easyui-textbox"  validType="chinese" required="true"
							data-options="required:true,validType:'chinese'" />
							<!-- validType="length(2,10)"  -->
							&nbsp;<span style="color: red">*</span>
	                  </td>
	              </tr>
	              <tr>
	                  <td onClick="a()"><div style='font-size:12px'>所属行政区划级别：</div></td>
	                  <td><input name="ulevel" class="easyui-combobox" 
	                      id="ulevel" style="width: 154px;" editable="false"
	                      required="true"/>
							&nbsp;<span style="color: red">*</span>
	                  </td>
	                  <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                  <td><div style='font-size:12px'>上级行政区划：</div></td>
	                  <td><input name="superDid" class="easyui-combobox" 
	                      id="superDid" style="width: 154px;" editable="false"
	                     required="true" / >
							&nbsp;<span style="color: red">*</span>
	                  </td>
	              </tr>
	              <tr>
	                  <td><div style='font-size:12px'>说明：</div></td> 
	                  <td colspan="4">
	                  	<textarea style='font-size:12px' id="descb" name="descb"
								rows="2" cols="58" ></textarea>
	                  </td>
	              </tr>
                </table>
            </form>
        </div>
	</div>
</body>
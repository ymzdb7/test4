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
function saveInfo(){
	var version = $("#version").val();
	var link = $("#link").val();
	if (link == "" || version == ""){
		$.messager.alert("系统提示", "版本号和链接不能空！");
		return ;
	}

	var url = "<%=basePath %>/setAppVersion.do";
	
    $("#fm").form("submit", {
        url : url,
        onSubmit : function() {
        },
        success : function(result) {
            var result = eval('(' + result + ')');
            if (result.success) {
                $.messager.alert("系统提示", "保存成功！");
            } else {
                $.messager.alert("系统提示", "保存失败！");
                return;
            }
        }
    });
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
<div  style='font-size:5px'>
    <form method="post" id="fm" >
        <table border=0 cellpadding=0 cellspacing=0 style="width:100% ">
            <tr>
                <td style="width:100%;" align="center" valign="middle">
        <table cellspacing="8px;" cellspacing="0" cellpadding="5" border="1" bordercolor="#0099CC" 
        	style="border-collapse: collapse;margin:auto" bgcolor="#F7F7F7">
            <tr>
                <td><div style='font-size:12px'>版本：</div></td>
                <td><input type="text" id="version" name="version" style="width:600px;" /> 
                </td>
            </tr>
            <tr>  
                <td><div style='font-size:12px'>版本描述：</div></td>
                <td><input type="text" id="version_desc" name="version_desc" style="width:600px;" /> 
                </td>
            </tr>
            <tr>
                <td><div style='font-size:12px'>版本名称：</div></td>
                <td><input type="text" name="version_name" id="version_name" style="width:600px;" />
            </tr>
            <tr>
                <td><div style='font-size:12px'>链接地址：</div></td> 
                <td><input type="text" id="link" name="link" style="width:600px;"/>
                </td>
            </tr>  
            <tr>
                <td><div style='font-size:12px'>强制更新：</div></td> 
                <td><select name="forcedup" class="easyui-combobox" 
                            id="forcedup" style="width: 154px;" editable="false"
                            panelHeight="auto"  required="true">
                                <option value="0" selected>不强制</option>
                                <option value="1">强制</option>
                        </select>
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
	      iconCls="icon-ok">保存</a>
</div>
</body>
</html>
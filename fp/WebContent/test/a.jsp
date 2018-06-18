<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path ;
%>
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/gray/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/icon.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>

<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/easyui-ext/icons/icon-standard.js"></script>  
<!--自定义验证-->  
<script src="<%=basePath %>/resource/js/test/validator.js" type="text/javascript"></script>   
    <style scoped="scoped">  
        .textbox{  
            height:20px;  
            margin:0;  
            padding:0 2px;  
            box-sizing:content-box;  
        }  
.icon-filter{
background:url('<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/icons/filter.png') no-repeat 3px 2px;
}

    </style>
</head>  
<body>  
      
        <h2>常用验证格式</h2>   
    <div style="margin:20px 0;"></div>  
    <div class="easyui-panel" title="Register" style="width:400px;padding:10px 60px 20px 60px">  
        <table cellpadding="10">  
            <tr>  
                <td>dddd:</td>  
                <td><input class="easyui-validatebox textbox" data-options="required:true,validType:'length[2,10]'" invalidMessage="有效长度2-10"></td>  
            </tr>  
            <tr>  
                <td>idcard:</td>  
                <td><input class="easyui-validatebox textbox" data-options="required:true,validType:'idcard'"></td>  
            </tr>  
            <tr>  
                <td>Birthday:</td>  
                <td><input class="easyui-datebox textbox"></td>  
            </tr>  
            <tr>  
                <td>URL:</td>  
                <td><input class="easyui-validatebox textbox" data-options="required:true,validType:'url'"></td>  
            </tr>  
            <tr>  
                <td>Mobile:</td>  
                <td><input class="easyui-validatebox textbox" data-options="required:true,validType:'Mobile'"></td>  
            </tr>  
            <tr>  
                <td>Length:</td>  
                <td><input class="easyui-validatebox" data-options="required:true,validType:'length[10,12]'"></td>  
            </tr>  
            <tr>  
                <td>Chinese:</td>  
                <td><input name="txtName" class="easyui-validatebox" data-options="required:'true',validType:'CHS'"></td>  
  
            </tr>  
  
            <tr>  
                <td>ZipCode:</td>  
                <td><input name="txtName" class="easyui-validatebox" data-options="required:'true',validType:'ZipCode'"></td>  
  
            </tr>  
            <tr>  
                <td>Number:</td>  
                <td><input name="txtName" class="easyui-validatebox" data-options="required:'true',validType:'Number'"></td>  
  
            </tr>  
            <tr>  
                <td>tttttttt:</td>  
                <td><a href="" class="easyui-linkbutton"
               data-options="plain:true,iconCls:'icon-filter'" style="width: 150px;">修改个人信息</a>  
            </tr>    
        </table>  
    </div>  
 
   </body>
</html>  
<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8"%>  
<%@page isELIgnored="false" %>  
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

<script type="text/javascript">  
function dd() {  
	//alert(1111);

    var imagePath = $("#image_input").val();  
    
    if (imagePath == "") {  
        alert("please upload image file");  
        return false;  
    }  
    var strExtension = imagePath.substr(imagePath.lastIndexOf('.') + 1);  
    
    if (strExtension != 'jpg' && strExtension != 'gif'  
            && strExtension != 'png' && strExtension != 'bmp') {  
        alert("please upload file that is a image");  
        return false;  
    }  
    
    //$("#formPhoto").ajaxSubmit({ 
    $("#formPhoto").form("submit", {
        type : 'POST',  
        url : '<%=basePath %>/upload/fileUpload.do',  
        onSubmit : function(data){
        	//alert(11111111111);
        },
        success : function(data) {  
            alert("上传成功"+data);  
            //$("#imgDiv").empty();  
            //$("#imgDiv").html('<img src="/fp/'+data+'"/>');//</span><span style="color:#000099;">配置的虚拟路径加上文件名直接显示在div中</span>  
            //$("#imgDiv").show();  
        },  
        error : function() {  
            alert("上传失败，请检查网络后重试");  
        }  
    });  
    
}
</script>  
</head>  
<body>  
    <table>  
          
        <tr>  
            <td colspan="2">  
                <form id="formPhoto" enctype="multipart/form-data">  
                    <table>  
                        <tr>  
                            <td>选择文件:<input type="file" name="file" id="image_input"></td>  
                            <td><input type="button" value="上传" id="upLoadImg" onclick="dd();"></td>  
                        </tr>  
                    </table>  
                </form>  
            </td>  
        </tr>  
          
        <tr>  
            <td colspan="2">  
                <div id="imgDiv"></div>  
            </td>  
        </tr>  
    </table>  
</body>  
</html>  
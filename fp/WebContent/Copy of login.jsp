<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;

//System.out.println("wwwww   "+basePath+" wwwww");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>扶贫管理后台系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="<%=basePath%>/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/resource/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/resource/js/easyui-lang-zh_CN.js"></script>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #016aa9;
	overflow:hidden;
}
.STYLE1 {
	color: #000000;
	font-size: 12px;
}
#in1{
	background-image: url('<%=basePath%>resource/images/dl.gif');
	height:18px;
	width:49px;
	border: 0px;
}
-->

body{background:url('<%=basePath%>resource/images/login.jpg') no-repeat;}   ；
</style>

<script type="text/javascript">

	$(function(){
		$("input[name='user_num']").focus(function(){
			$("#msg").html("");
		});
	});
</script>

</head>
 <body style="background:url('<%=basePath%>resource/images/login.jpg') no-repeat;">
 <form name="from1" action="<%=basePath%>/login.do" method ="post"  onsubmit="return validator(this)" >
 
   <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                 <tr>
              	
                 <td width="100%" height="25" align="center"> <span style="color:red" id="msg">${errors }</span></td>
              </tr>
   
  	<tr>
    <td>
    	<table width="962" border="0" align="center" cellpadding="0" cellspacing="0">
      
      <tr>
        <td height="235" background="<%=basePath%>/resource/images/login_03.gif">&nbsp;</td>
      </tr>
      <tr>
        <td height="53"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          
          <tr>
            <td width="394" height="53" background="<%=basePath%>/resource/images/login_05.gif">&nbsp;</td>
            <td width="206" background="<%=basePath%>/resource/images/login_06.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="16%" height="25"><div align="right"><span class="STYLE1">用户</span></div></td>
                <td width="57%" height="25"><div align="center">
                  <input type="text" name="loginNm"  class="easyui-validatebox"  required="required" style="width:105px; height:17px;">
                </div></td>
                <td width="27%" height="25">&nbsp;</td>
              </tr>
              <tr>
                <td height="25"><div align="right"><span class="STYLE1">密码</span></div></td>
                <td height="25"><div align="center">
                  <input type="password" name="password"  class="easyui-validatebox" required="required"  style="width:105px; height:17px;">
                </div></td>
                <td height="25"><div align="left"><input type="submit" id="in1" value="登录" style="width:50px; height:17px;background:#000;color:white"/></div></td>
              </tr>

            </table></td>
            <td width="362" background="<%=basePath%>/resource/images/login_07.gif">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="213" background="<%=basePath%>/resource/images/login_08.gif">
		</td>
      </tr>
      
    </table></td>
  </tr>
</table>
</form>
  </body>
</html>

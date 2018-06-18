<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;

%>
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
body{
  font-family: "华文细黑";
  width: 100%;
  height:auto;
  background:url('<%=basePath%>/resource/images/login.jpg') no-repeat;
  background-size: 100%;
}
</style>

<script type="text/javascript">

	$(function(){
		$("input[name='user_num']").focus(function(){
			$("#msg").html("");
		});
	});
</script>

</head >
 <body >
<!-- 
style="background:url('<%=basePath%>/resource/images/login.jpg')"
 	 style="position:absolute; left:0px; top:0px; width:100%; height:100%"> <div style="position:absolute; left:0px; top:0px; width:100%; height:100%"> 
 <img src="<%=basePath%>/resource/images/login.jpg" width="100%" height="100%"/>  
 -->
 
   <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    	 <tr>	
     		 <td width="100%" height="25" align="center"> <span style="color:red" id="msg" >${errors }</span></td>
    	 </tr>
    	 
  		<tr>
  		<td>
    	<table width="80%" height="450" border="0" align="center" cellpadding="0" cellspacing="0">
			 <tr>
    			 <td height="70%" width="50%">&nbsp;</td>
        		<td  width="10%">&nbsp;</td>
       			 <td  width="40%"  bgcolor="#FFFFFF"><div style="margin-left: 48px"><span style="font-size:27px">宿城区精准扶贫信息化平台</span></div>
       		 <table width="100%" heigth="100%" border="0" cellspacing="0" cellpadding="0"  bgcolor="#FFFFFF">
          
          <tr>
            <td width="100%" align="center">
            	<img src="<%=basePath%>/resource/images/logo.png" />
            </td>
          </tr>
          
          <tr>
            <td width="100%" align="center" >
				<img src="<%=basePath%>/resource/images/yhdl.png" />
			</td>
          </tr>
          
          <tr>
            <td width="100%" >
  				<form name="from1" action="<%=basePath%>/login.do" method ="post"  onsubmit="return validator(this)" >
            <table border="0" width="100%" border="1" 
            		cellspacing="0" cellpadding="0">
              <tr>
                <td width="14%" height="25">&nbsp;</td>
                <td width="67%" height="25" bgcolor="#FFFFFF"><div align="center">
                  <input type="text" name="loginNm"   style="width:200px; height:27px;" placeholder="帐号：" >
                </div></td>
                <td width="19%" height="25">&nbsp;</td>
              </tr>
              <!--上下间的空白间隔 -->
              <tr>
              	<td height="10"><div></div></td>
              	<td bgcolor="#FFFFFF"></td>
              	<td></td>
              </tr>
              
              <tr>
                <td height="25" ></td>
                <td height="25" bgcolor="#FFFFFF"><div align="center">
                  <input type="password" name="password"  style="width:200px; height:27px;" placeholder="密码：">
                </div></td>
                <td height="25"></td>
              </tr>
              <tr>
                <td height="40"><div>&nbsp;</div></td>
                <td rowspan="2" bgcolor="#FFFFFF"><div align="center">
                <input type="submit" id="in1" value="登录" style="width:110px; height:40px;background:red;color:white;margin-left: 25px"/></div></td>
                <td ></td>
              </tr>
              <tr>
              	<td height="15"><div>&nbsp;</div></td>
             	<td></td>
              </tr>
            </table>
            </form>
            </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="3">
		</td>
        <td >
		</td>
        <td >
		</td>
      </tr>
      
    </table></td>
 		 </tr>
</table>
  </body>
</html>

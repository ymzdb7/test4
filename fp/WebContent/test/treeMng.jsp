<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path ;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title></title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/resource/easyui/jquery-easyui-1.5/themes/icon.css"/>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/easyui/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
  <script type="text/javascript">
/*     var data = [{
      "id": 1,
      "text": "系统",
      "checked":false,
      "state": "",
      "children": [{
        "id": 11,
        "text": "用户管理",
        "checked":false,
        "state": "",
        "children": [{
          "id": 111,
          "text": "增加",
          "checked":false,
          "state": "",
          "children":""
        }, {
          "id": 112,
          "text": "修改",
          "checked":false,
          "state": "",
          "children":""
        }, {
          "id": 113,
          "text": "删除",
          "checked":false,
          "state": "",
          "children":""
        }]
      }, {
        "id": 12,
        "text": "角色管理",
        "children": [{
          "id": 121,
          "text": "增加",
          "checked":false,
          "state": "",
          "children":""
        }, {
          "id": 122,
          "text": "修改",
          "checked":false,
          "state": "",
          "children":""
        }, {
          "id": 123,
          "text": "删除",
          "checked":false,
          "state": "",
          "children":""
       }]
      }]
    }, {
      "id": 2,
      "text": "其他",
      "checked":false,
      "state": "closed",
      "children":""
    }];
 */
 var data = [{"id":1,"text":"帮扶对象管理","checked":false,"state":"","children":[{"id":2,"text":"家庭信息查询","checked":false,"state":"","children":""},{"id":3,"text":"家庭信息维护","checked":false,"state":"","children":""},{"id":4,"text":"成员信息查询","checked":false,"state":"","children":""},{"id":5,"text":"成员信息维护","checked":false,"state":"","children":""},{"id":6,"text":"帮扶对象分析","checked":false,"state":"","children":""}]},{"id":7,"text":"帮扶信息管理","checked":false,"state":"","children":[{"id":8,"text":"教育救助信息查询","checked":false,"state":"","children":""},{"id":9,"text":"教育救助信息维护","checked":false,"state":"","children":""},{"id":10,"text":"教育救助分析","checked":false,"state":"","children":""},{"id":11,"text":"大病救助信息查询","checked":false,"state":"","children":""},{"id":12,"text":"大病救助信息维护","checked":false,"state":"","children":""},{"id":13,"text":"大病救助分析","checked":false,"state":"","children":""}]},{"id":14,"text":"咨询服务管理","checked":false,"state":"","children":[{"id":15,"text":"咨询信息查询","checked":false,"state":"","children":""},{"id":16,"text":"咨询回复","checked":false,"state":"","children":""},{"id":17,"text":"咨询信息分析","checked":false,"state":"","children":""}]},{"id":18,"text":"信息发布管理","checked":false,"state":"","children":[{"id":19,"text":"信息发布查询","checked":false,"state":"","children":""},{"id":20,"text":"信息发布维护","checked":false,"state":"","children":""},{"id":21,"text":"信息发布分析","checked":false,"state":"","children":""}]},{"id":22,"text":"系统管理","checked":false,"state":"","children":[{"id":23,"text":"用户管理","checked":false,"state":"","children":""},{"id":24,"text":"部门管理","checked":false,"state":"","children":""},{"id":25,"text":"角色管理","checked":false,"state":"","children":""}]}];
function opMenuTree(){
    $(function () {
      $("#tt").tree({  
        data: data,
        checkbox: true,
        cascadeCheck: false,
        lines: true,
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
    });
} 
    function getChecked()
    {
      var arr = [];
      var checkeds = $('#tt').tree('getChecked', 'checked');
      for (var i = 0; i < checkeds.length; i++) {
        arr.push(checkeds[i].id);
      }
      alert(arr.join(','));
    }
 
  </script>
</head>
<body onLoad="opMenuTree()">
  <ul id="tt"></ul>
  <input type="button" value="获取选中" onclick="getChecked()" />
</body>
</html>
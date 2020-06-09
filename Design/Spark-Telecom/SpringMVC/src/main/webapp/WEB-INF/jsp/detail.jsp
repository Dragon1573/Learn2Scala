<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 启用EL表达式 --%>
<%@ page isELIgnored="false" %>
<html>
  <head>
    <meta charset="UTF-8">
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.js"
            type="application/javascript"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/echarts/4.7.0/echarts.js"
            type="application/javascript"></script>
    <title>详情</title>
    <style rel="stylesheet" type="text/css" href="../css/style.css"></style>
  </head>
  <body>
    <table class="table">
      <tr>
        <th style="width: 100px;">用户编号</th>
        <th style="width: 100px;">IP地址</th>
        <th style="width: 100px;">请求类型</th>
        <th style="width: 100px;">首次登录时间</th>
        <th style="width: 100px;">首次登录次数</th>
      </tr>
      <!-- 定义数据集变量 --><%--@elvariable id="userDetailList" type="java.util.List<wang.dragon1573.model.ViewUserDetail>"--%>
      <c:forEach items="${userDetailList}" var="row" varStatus="status">
        <tr>
          <td style="width: 100px; text-align: center;">${row.imei}</td>
          <td style="width: 100px; text-align: center;">${row.requestIp}</td>
          <td style="width: 100px; text-align: center;">${row.requestTypeName}</td>
          <td style="width: 200px; text-align: center;">${row.first_Login_Time}</td>
          <td style="width: 100px; text-align: center;">${row.log_Times}</td>
        </tr>
      </c:forEach>
    </table>
  </body>
</html>

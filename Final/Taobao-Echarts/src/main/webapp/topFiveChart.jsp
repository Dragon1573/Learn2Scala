<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, util.MysqlConnector" %>
<%@ page isELIgnored="false" %>
<%
  ArrayList<String[]> list = MysqlConnector.topFive();
  request.setAttribute("list", list);
%>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="Content-Type" content="text/html">
  <title>ECharts 可视化分析淘宝双十一</title>
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script type="application/javascript" src="js/echarts.min.js"></script>
</head>
<body>
  <div class="header">
    <p>Echarts 可视化分析淘宝双十一</p>
  </div>
  <div class="content">
    <div class="nav">
      <ul>
        <li>
          <a href="buyChart.jsp">买家消费行为对比图</a>
        </li>
        <li>
          <a href="genderChart.jsp">买家性别交易量对比图</a>
        </li>
        <li>
          <a href="genderAgeChart.jsp">买家性别年龄段交易量对比图</a>
        </li>
        <li class="current">
          <a href="javascript:void(0);">五大热门商品统计图</a>
        </li>
        <li>
          <a href="provinceChart.jsp">各省份总成交量统计图</a>
        </li>
      </ul>
    </div>
    <div class="container">
      <div class="title">五大热门商品统计图</div>
      <div class="show">
        <div class="chart-type">柱状图</div>
        <div id="main"></div>
      </div>
    </div>
  </div>
  <noscript>错误：您的浏览器尚不支持JavaScript，ECharts无法运行！</noscript>
  <script>
      // 初始化ECharts
      let myChart = echarts.init(document.getElementById('main'));
      // 指定图表配置项和数据源
      let x = [];
      let y = [];
      <c:forEach var="item" items="${list}">
      x.push('${item[0]}');
      y.push('${item[1]}');
      </c:forEach>
      option = {
          color: ['#3398DB'],
          title: {
              text: '五大热门商品统计图',
              left: 'center'
          },
          tooltip: {
              trigger: 'axis',
              axisPointer: {
                  type: 'shadow'
              }
          },
          grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
          },
          xAxis: [{
              type: 'category',
              data: x,
              axisTick: {
                  alignWithLabel: true
              }
          }],
          yAxis: [{
              type: 'value'
          }],
          series: [{
              name: 'value',
              type: 'bar',
              barWidth: '60%',
              data: y
          }]
      };
      // 使用JSON配置EChart
      myChart.setOption(option);
  </script>
</body>
</html>

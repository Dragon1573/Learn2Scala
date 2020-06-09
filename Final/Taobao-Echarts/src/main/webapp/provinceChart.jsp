<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, util.MysqlConnector" %>
<%@ page isELIgnored="false" %>
<%
  ArrayList<String[]> list = MysqlConnector.provinceRate();
  request.setAttribute("list", list);
%>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="Content-Type" content="text/html">
  <title>ECharts 可视化分析淘宝双十一</title>
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script type="application/javascript" src="js/echarts.min.js"></script>
  <script type="application/javascript" src="js/china.js"></script>
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
        <li>
          <a href="topFiveChart.jsp">五大热门商品统计图</a>
        </li>
        <li class="current">
          <a href="javascript:void(0);">各省份总成交量统计图</a>
        </li>
      </ul>
    </div>
    <div class="container">
      <div class="title">各省份总成交量统计图</div>
      <div class="show">
        <div class="chart-type">地图</div>
        <div id="main"></div>
      </div>
    </div>
  </div>
  <noscript>错误：您的浏览器尚不支持JavaScript，ECharts无法运行！</noscript>
  <script>
    // 初始化ECharts
    const myChart = echarts.init(document.getElementById("main"));
    // 创建JSON配置对象
    let dataset = [];
    <c:forEach var="item" items="${list}">
    dataset.push({name: '${item[0]}', value: ${item[1]}});
    </c:forEach>
    option = {
        title: {
            text: '各省份总成交量统计图',
            left: 'center'
        },
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: '销售量'
        },
        visualMap: {
            min: 11950,
            max: 12870,
            left: 'left',
            top: 'bottom',
            text: ['多', '少'],
            calculable: true,
            realtime: true,
            inRange: {
                color: ['lightskyblue', 'pink']
            }
        },
        series: [{
            name: '销售量',
            type: 'map',
            map: 'china',
            roam: false,
            label: {
                normal: {
                    show: true,
                    fontSize: 8
                },
                emphasis: {
                    show: false
                }
            },
            data: dataset
        }]
    };
    // 载入配置，渲染图表
    myChart.setOption(option);
  </script>
</body>
</html>

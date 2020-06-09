<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList, util.MysqlConnector" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%
  ArrayList<String[]> list = MysqlConnector.genderAgeRate();
  request.setAttribute("list", list);
%>
<html lang="zh">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" charset="UTF-8">
  <title>ECharts 可视化分析淘宝双十一</title>
  <link href="./css/style.css" type='text/css' rel="stylesheet" />
  <script src="./js/echarts.min.js"></script>
</head>
<body>
  <div class='header'>
    <p>ECharts 可视化分析淘宝双十一</p>
  </div>
  <div class="content">
    <div class="nav">
      <ul>
        <li>
          <a href="./buyChart.jsp">买家消费行为对比图</a>
        </li>
        <li>
          <a href="./genderChart.jsp">买家性别交易量对比图</a>
        </li>
        <li class="current">
          <a href="javascript:void(0);">买家性别年龄段交易量对比图</a>
        </li>
        <li>
          <a href="./topFiveChart.jsp">五大热门商品统计图</a>
        </li>
        <li>
          <a href="./provinceChart.jsp">各省份总成交量统计图</a>
        </li>
      </ul>
    </div>
    <div class="container">
      <div class="title">买家性别年龄段交易量对比图</div>
      <div class="show">
        <div class='chart-type'>散点图</div>
        <div id="main"></div>
      </div>
    </div>
  </div>
  <script>
      // 初始化ECharts
      let myChart = echarts.init(document.getElementById('main'));
      // 指定图表的配置项和数据源
      let data = [];
      data[0] = [];
      data[1] = [];
      <c:forEach var="point" items="${list}">
      <c:choose>
      <c:when test='${"0".equals(point[0])}'>
      data[0].push([${point[1]}, ${point[2]}]);
      </c:when>
      <c:when test='${"1".equals(point[0])}'>
      data[1].push([${point[1]}, ${point[2]}]);
      </c:when>
      </c:choose>
      </c:forEach>
      option = {
          backgroundColor: new echarts.graphic.RadialGradient(0.3, 0.3, 0.8, [{
              offset: 0,
              color: '#f7f8fa'
          }, {
              offset: 1,
              color: '#cdd0d5'
          }]),
          title: {
              text: '男女买家各个年龄段交易对比'
          },
          legend: {
              right: 10,
              data: ['女', '男']
          },
          xAxis: {
              splitLine: {
                  lineStyle: {
                      type: 'dashed'
                  }
              }
          },
          yAxis: {
              splitLine: {
                  lineStyle: {
                      type: 'dashed'
                  }
              },
              scale: true
          },
          series: [{
              name: '女',
              data: data[0],
              type: 'scatter',
              symbolSize: 10,
              label: {
                  emphasis: {
                      show: true,
                      formatter: function (param) {
                          return param.data[3];
                      },
                      position: 'top'
                  }
              },
              itemStyle: {
                  normal: {
                      shadowBlur: 5,
                      shadowColor: 'rgba(120, 36, 50, 0.5)',
                      shadowOffsetY: 5,
                      color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
                          offset: 0,
                          color: 'rgb(251, 118, 123)'
                      }, {
                          offset: 1,
                          color: 'rgb(204, 46, 72)'
                      }])
                  }
              }
          }, {
              name: '男',
              data: data[1],
              type: 'scatter',
              symbolSize: 10,
              label: {
                  emphasis: {
                      show: true,
                      formatter: function (param) {
                          return param.data[3];
                      },
                      position: 'top'
                  }
              },
              itemStyle: {
                  normal: {
                      shadowBlur: 50,
                      shadowColor: 'rgba(25, 100, 150, 0.5)',
                      shadowOffsetY: 5,
                      color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
                          offset: 0,
                          color: 'rgb(129, 227, 238)'
                      }, {
                          offset: 1,
                          color: 'rgb(25, 183, 207)'
                      }])
                  }
              }
          }]
      };
      // 使用JSON配置ECharts
      myChart.setOption(option);
  </script>
</body>
</html>

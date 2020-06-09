<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, util.MysqlConnector" %>
<%@ page isELIgnored="false" %>
<%
  ArrayList<String[]> list = MysqlConnector.genderRate();
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
        <li class="current">
          <a href="javascript:void(0);">买家性别交易量对比图</a>
        </li>
        <li>
          <a href="genderAgeChart.jsp">买家性别年龄段交易量对比图</a>
        </li>
        <li>
          <a href="topFiveChart.jsp">五大热门商品统计图</a>
        </li>
        <li>
          <a href="provinceChart.jsp">各省份总成交量统计图</a>
        </li>
      </ul>
    </div>
    <div class="container">
      <div class="title">买家性别交易量对比图</div>
      <div class="show">
        <div class="chart-type">饼图</div>
        <div id="main"></div>
      </div>
    </div>
  </div>
  <noscript>错误：您的浏览器尚不支持JavaScript，ECharts无法运行！</noscript>
  <script>
      // 初始化ECharts
      const myChart = echarts.init(document.getElementById('main'));
      // 指定图表配置项和数据源
      option = {
          backgroundColor: '#2C343C',
          title: {
              text: '买家性别交易量对比图',
              left: 'center',
              top: 20,
              textStyle: {
                  color: '#CCCCCC'
              }
          },
          tooltip: {
              trigger: 'item',
              formatter: "{a} <br /> {b} : {c} ({d}%)"
          },
          visualMap: {
              show: false,
              min: 80,
              max: 600,
              inRange: {
                  colorLightness: [0, 1]
              }
          },
          series: [
              {
                  name: '消费行为',
                  type: 'pie',
                  radius: '55%',
                  center: ['50%', '50%'],
                  data: [
                      {value: '${list.get(0)[1]}', name: '女性'},
                      {value: '${list.get(1)[1]}', name: '男性'},
                      {value: '${list.get(2)[1]}', name: '未知'},
                  ].sort(function (a, b) {
                      return a.value - b.value;
                  }),
                  roseType: 'angle',
                  label: {
                      normal: {
                          textStyle: {
                              color: 'rgba(255, 255, 255, 0.5)'
                          }
                      }
                  },
                  labelLine: {
                      normal: {
                          lineStyle: {
                              color: 'rgba(255, 255, 255, 0.5)'
                          },
                          smooth: 0.2,
                          length: 10,
                          length2: 20
                      }
                  },
                  itemStyle: {
                      normal: {
                          color: '#C23531',
                          shadowBlur: 200,
                          shadowColor: 'rgba(0, 0, 0, 0.5)'
                      }
                  },
                  animationType: 'scale',
                  animationEasing: 'elasticOut',
                  animationDelay: function () {
                      return Math.random() * 200;
                  }
              }
          ]
      };
      // 使用JSON配置EChart
      myChart.setOption(option);
  </script>
</body>
</html>

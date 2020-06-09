<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- 开启EL表达式支持 --%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=chrome">
    <script type="application/javascript"
            src="https://cdn.bootcdn.net/ajax/libs/jquery/3.5.1/jquery.js"></script>
    <script type="application/javascript"
            src="https://cdn.bootcdn.net/ajax/libs/echarts/4.7.0/echarts.js"></script>
    <title>趋势分析</title>
    <style type="text/css" rel="stylesheet" href="../css/style.css"></style>
  </head>
  <body>
    <table class="chart-table">
      <tr>
        <td style="min-width: 600px;">
          <div id="areaChannel" style="width: 600px; height: 400px;"></div>
        </td>
        <td style="min-width: 300px; margin: 0; padding: 0;">
          <table class="table">
            <tr>
              <th style="width: 100px;">登陆区域</th>
              <th style="width: 100px;">渠道</th>
              <th style="width: 100px;">用户数</th>
            </tr>
            <c:forEach items="${areaChannelListAll}" var="row" varStatus="status">
              <tr>
                <td style="width: 100px; text-align: center;">${row.areaName}</td>
                <td style="width: 100px; text-align: center;">${row.channelName}</td>
                <td style="width: 100px; text-align: center;">
                  <a href="detail?areaName=${row.areaName}&channelName=${row.channelName}"> ${row.num} </a>
                </td>
              </tr>
            </c:forEach>
          </table>
        </td>
      </tr>
    </table>
    <script type="application/javascript">
        {
            // 用户渠道趋势分析数据源
            let areaChannelData = '${areaChannelData}';
            let objectAreaChannelData = JSON.parse(areaChannelData);

            // 设置图例
            let legend = {};
            // 设置横坐标
            let xAxis = {};
            xAxis.type = 'category';
            xAxis.boundaryGap = false;
            // 折线
            let series = [];
            let areaChannelList = '${areaChannelList}';
            <c:forEach items="${areaChannelList}" var="row" varStatus="status">
            // 图例列表
            areaChannelList[<c:out value="${status.index}" />] = '${row}';
            // 横坐标数组
            var numArray = [];
            var seriesObject = {};
            seriesObject.name = '${row}';
            seriesObject.type = 'line';
            var areaNameArray = [];
            for (let i = 0; i < objectAreaChannelData.${row}.length; i++) {
                areaNameArray[i] = objectAreaChannelData.${row}[i].areaName;
                numArray[i] = objectAreaChannelData.${row}[i].num;
            }
            seriesObject.data = numArray;
            series[<c:out value="${status.index}" />] = seriesObject;
            </c:forEach>
            xAxis.data = areaNameArray;
            legend.data = areaChannelList;

            // ECharts实例化
            let areaChannel = echarts.init(document.getElementById('areaChannel'));

            // 指定图表配置与数据集
            let option = {
                title: {
                    text: '用户渠道趋势分析'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: []
                },
                grid: {
                    left: '3%',
                    right: '4%',
                    bottom: '3%',
                    containLabel: true
                },
                toolbox: {
                    feature: {
                        saveAsImage: {}
                    }
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false,
                    data: []
                },
                yAxis: {
                    type: 'value'
                },
                series: []
            };
            areaChannel.setOption(option);
            option.legend = legend;
            option.xAxis = xAxis;
            option.series = series;
            areaChannel.setOption(option, true);
        }
    </script>
    <hr />
    <table class="chart_table">
      <tr>
        <td>
          <div id="areaRequestType" style="width: 600px; height: 400px;"></div>
        </td>
        <td style="min-width: 300px; margin: 0; padding: 0;">
          <table class="table">
            <tr>
              <th style="width: 100px;">登陆区域</th>
              <th style="width: 100px;">请求类型</th>
              <th style="width: 100px;">用户数量</th>
            </tr>
            <c:forEach var="row" varStatus="status" items="${areaRequestTypeListAll}">
              <tr>
                <td style="width: 100px; text-align: center;">${row.areaName}</td>
                <td style="width: 100px; text-align: center;">${row.requestTypeName}</td>
                <td style="width: 100px; text-align: center;">${row.num}</td>
              </tr>
            </c:forEach>
          </table>
        </td>
      </tr>
    </table>
    <script type="application/javascript">
        {
            // 用户渠道趋势分析数据集
            let areaRequestTypeData = '${areaRequestTypeData}';
            let objectAreaRequestTypeData = JSON.parse(areaRequestTypeData);

            // 设置图例
            let legend = {};
            let areaRequestTypeList = [];
            // 设置横坐标
            let xAxis = {
                type: 'category'
            };
            // 折线
            let series = [];
            <c:forEach items="${areaRequestTypeList}" varStatus="status" var="row">
            // 图例列表
            areaRequestTypeList[<c:out value="${status.index}" />] = '${row}';
            // 横坐标数组
            var areaNameArray = [];
            // 指标值
            var numArray = [];
            var seriesObject = {
                name: '${row}',
                type: 'bar',
                barWidth: '30%'
            };
            for (let i = 0; i < objectAreaRequestTypeData.${row}.length; i++) {
                areaNameArray[i] = objectAreaRequestTypeData.${row}[i].areaName;
                numArray[i] = objectAreaRequestTypeData.${row}[i].num;
            }
            seriesObject.data = numArray;
            series[<c:out value="${status.index}" />] = seriesObject;
            </c:forEach>
            xAxis.data = areaNameArray;
            legend.data = areaRequestTypeList;

            // 初始化ECharts实例
            let areaRequestType = echarts.init(
                document.getElementById('areaRequestType'));

            // 配置ECharts及数据源
            let option = {
                tile: {
                    text: '用户请求方式对比情况'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: []
                },
                toolbox: {
                    show: true,
                    feature: {
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['line', 'bar']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: []
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: {}
            };

            // 更新配置
            option.legend = legend;
            option.xAxis = xAxis;
            option.series = series;
            areaRequestType.setOption(option, true);
        }
    </script>
    <hr />
    <table class="chart_table">
      <tr>
        <td style="min-width: 600px;">
          <div id="channelNo" style="width: 600px; height: 400px;"></div>
        </td>
        <td style="min-width: 300px; margin: 0; padding: 0;">
          <table class="table">
            <tr>
              <th style="width: 100px;">渠道</th>
              <th style="width: 100px;">用户数量</th>
            </tr>
            <c:forEach items="${channelNoList}" var="row" varStatus="status">
              <tr>
                <td style="width: 100px; text-align: center;">${row.channelName}</td>
                <td style="width: 100px; text-align: center;">${row.num}</td>
              </tr>
            </c:forEach>
          </table>
        </td>
      </tr>
    </table>
    <script type="application/javascript">
        {
            // 设置图例
            let legend = {
                left: 'left',
                orient: 'vertical'
            };
            // 设置数据集
            let channelNoList = [];

            // 创建ECharts配置项
            let series = [];
            let seriesObject = {
                name: '渠道',
                type: 'pie',
                center: ['50%', '50%'],
                data: [],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                },
            };
            <c:forEach items="${channelNoList}" varStatus="status" var="row">
            // 图例列表
            channelNoList[<c:out value="${status.index}" />] = '${row.channelName}';
            var channelNoDate = {
                value: ${row.num},
                name: '${row.channelName}'
            };
            seriesObject.data[<c:out value="${status.index}" />] = channelNoDate;
            </c:forEach>
            series[0] = seriesObject;

            // 初始化ECharts实例
            let channelNo = echarts.init(document.getElementById('channelNo'));
            let option = {
                title: {
                    text: '用户渠道饼图情况',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{a}<br />{b} : {c} ({d}%)'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: []
                },
                series: []
            };

            // 更新配置
            option.legend = legend;
            option.series = series;
            channelNo.setOption(option, true);
        }
    </script>
  </body>
</html>

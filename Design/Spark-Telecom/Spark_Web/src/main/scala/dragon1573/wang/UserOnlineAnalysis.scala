package dragon1573.wang

import java.text.SimpleDateFormat
import java.util.Properties

import org.apache.spark.SparkContext
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.types.{IntegerType, StringType, StructField, StructType}
import org.apache.spark.sql.{Row, SaveMode, SparkSession}

/**
 * <bold>Spark数据分析主对象</bold>
 * <br />
 * <p>&emsp;&emsp;提供数据集读取、清洗、分析处理功能</p>
 *
 * @author Dragon1573
 */
object UserOnlineAnalysis {
  // 设置JDBC链接
  val jdbcURL = "jdbc:mysql://localhost:3306/spark_web?useSSL=false&charset=utf8"

  // 创建JDBC登陆配置
  val properties = new Properties()
  properties.setProperty("driver", "com.mysql.jdbc.Driver")
  properties.setProperty("user", "hive")
  properties.setProperty("password", "hive")

  /**
   * 导出数据汇总表到数据库
   *
   * @param rdd          数据集RDD
   * @param sparkSession Spark会话对象
   */
  def exportSumData(rdd: RDD[(String, List[String])], sparkSession: SparkSession): Unit = {
    println("导出前预处理...")
    // 构建字段
    val sumSchema = StructType(Array(
      StructField("imei", StringType, nullable = true),
      StructField("log_times", IntegerType, nullable = true),
      StructField("online_time", IntegerType, nullable = true)
    ))
    // 构建记录RDD
    val sumRDD: RDD[Row] = rdd.map(x => {
      // 初始化登陆次数
      var logNum = 1
      // 总在线时长（秒）
      var totalTime: Long = 0
      // 遍历原始RDD
      for (i <- x._2.indices) {
        if (i + 1 < x._2.length) {
          // 本次登录时间
          val nowTime: Long = getTimeByString(x._2(i))
          // 下次登录时间
          val nextTime = getTimeByString(x._2(i + 1))
          // 时间间隔
          val intervalTime = nextTime - nowTime
          // 筛选时长类型
          if (intervalTime < 60 * 10) {
            totalTime += intervalTime
          } else {
            logNum += 1
          }
        }
      }
      Row(x._1, logNum, totalTime.toInt)
    })
    // 拼合DataFrame
    val sumDF = sparkSession.createDataFrame(sumRDD, sumSchema)
    println("完成")
    println("导出数据汇总表...")
    sumDF.write.mode(SaveMode.Overwrite).jdbc(jdbcURL, "spark_web.sum", properties)
    println("完成！")
  }

  /**
   * 用户在线时长和登陆次数统计
   *
   * @param args 命令行参数
   */
  def main(args: Array[String]): Unit = {
    // 语法检查
    if (args.length != 1) {
      System.err.println("用法：dragon1573.wang.UserOnlineAnalysis <输入>")
      System.exit(1)
    }

    // 配置Spark运行时环境
    val sparkSession = SparkSession.builder()
      .appName("User Online Analysis").master("local[*]").getOrCreate()

    // JSON是一种结构化数据，我们使用DataFrame加载数据集
    println("载入文件 " + args(0) + " ...")
    val dataFrame = sparkSession.read.json(args(0))
    println("完成！")
    // 将当前数据表挂载为临时表，方便使用SQL语句查询过滤
    dataFrame.createOrReplaceTempView("rawData")

    // 提取数据原始明细表
    println("获取原始明细数据...")
    val cleanMapDF = sparkSession.sql(
      "SELECT imei, logId, requestip, areacode, requesttype, channelno FROM rawData"
    )
    println("完成！")
    // 将数据集写入数据库
    println("原始明细数据导出中...")
    cleanMapDF.write.mode(SaveMode.Overwrite).jdbc(
      jdbcURL, "spark_web.cleanMap", properties
    )
    println("完成！")

    // 提取数据明细表
    println("获取明细数据...")
    val rawDetailDF = sparkSession.sql(
      "SELECT imei, SUBSTRING(logid, 0, 14) AS first_login_time FROM rawData"
    )
    val rawDetailRDD = rawDetailDF.rdd // 转换为RDD
      .map(row => (row(0).asInstanceOf[String], row(1))) // 转换为键值对RDD
      .groupByKey() // 按键聚合
      .map(pair => (
        pair._1,
        pair._2.map(_.asInstanceOf[String]).toList.sorted // 强制下转数据类型，并转换为列表
      ))
    println("完成！")
    // 缓存RDD
    rawDetailRDD.cache()

    // 导出明细数据表
    exportDetail(rawDetailRDD, sparkSession)

    // 导出数据汇总表
    exportSumData(rawDetailRDD, sparkSession)

    // 释放缓存
    rawDetailRDD.unpersist()
    // 结束SparkSession会话
    sparkSession.stop()

    println("数据分析结束！")
  }

  /**
   * 导出明细数据至数据库
   *
   * @param rdd     键值对RDD数据集
   * @param session Spark会话对象
   */
  def exportDetail(rdd: RDD[(String, List[String])], session: SparkSession): Unit = {
    println("导出前处理...")
    // 由于采用DataFrame整体写入数据库，需要优先定义字段
    val detailDFSchema = StructType(Array(
      StructField("imei", StringType, nullable = true),
      StructField("first_login_time", StringType, nullable = true),
      StructField("online_time", IntegerType, nullable = true)
    ))
    // 创建记录集
    val detailRDD: RDD[Row] = rdd.flatMap(
      // RDD数据集展平
      x => {
        // 统计登陆次数
        val length = x._2.length
        // 创建记录列表
        val array = new Array[Row](length)
        // 遍历值列表（时间戳）
        for (i <- 0 until length) {
          if (i + 1 < length) {
            // 本次登录时间
            val nowTime = getTimeByString(x._2(i))
            // 下次登录时间
            val nextTime = getTimeByString(x._2(i + 1))
            // 在线时长（秒）
            val intervalTime = nextTime - nowTime
            // 每次会话的最长在线时间为10分钟，过滤超时会话
            if (intervalTime < 60 * 10) {
              array(i) = Row(x._1, x._2(i), intervalTime.toInt)
            } else {
              array(i) = Row(x._1, x._2(i), 0)
            }
          } else {
            array(i) = Row(x._1, x._2(i), 0)
          }
        }
         array
      })
    // 组装DataFrame
    val detailDF = session.createDataFrame(detailRDD, detailDFSchema)
    println("完成！")
    println("导出明细数据表中...")
    detailDF.write.mode(SaveMode.Overwrite).jdbc(jdbcURL, "spark_web.detail", properties)
    println("完成！")
  }

  /**
   * 时间戳转换为时间
   *
   * @param timeStamp 时间戳字符串
   *
   * @return 时间
   */
  def getTimeByString(timeStamp: String): Long = {
    // 创建时间戳解析对象
    val format: SimpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss")
    // 获取对应时间（秒）
    format.parse(timeStamp).getTime / 1000
  }
}

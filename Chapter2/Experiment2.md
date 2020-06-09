# 实验2&emsp;Scala编程初级实践

## 一、实验目的

1. 掌握 Scala 语言的基本语法、数据结构和控制结构。
2. 掌握面向对象编程的基础知识，能够编写自定义类和特质。
3. 掌握函数式编程的基础知识，能够熟练定义匿名函数。熟悉 Scala 的容器类库的基本层次结构，熟练使用常用的容器类进行数据操作。
4. 熟练掌握 Scala 的 REPL 运行模式和编译运行方法。

## 二、实验平台

- 操作平台：`Linux`（推荐 `Ubuntu 16.04`）。
- `JDK` 版本：1.7 或以上版本。
- `Scala` 版本：2.11.8。

## 三、实验内容和要求

1. 计算级数

   &emsp;&emsp;请用脚本的方式编程计算并输出下列技术的前 $n$ 项之和 $S_n$ ，直到 $S_n$ 刚好大于或等于 $q$ 为止，其中， $q$ 为大于 $0$ 的整数，其值通过键盘输入。

   $$ S_n=\frac{2}{1}+\frac{3}{2}+\frac{4}{3}+\cdots+\frac{n+1}{n} $$

   &emsp;&emsp;例如，若 $q$ 的值为 $50.0$ ，则输出应为： $S_n=50.416695$ 。请将源文件保存为 `excercise2-1.scala` ，在 `REPL` 模式下测试运行，测试样例： $q=1$ 时，$S_n=2$ ； $q=30$ 时， $S_n=30.891459$ ； $q=50$ 时， $S_n=50.416695$ 。

   ```scala
   /**
    * excercise2-1.scala
    *
    * @author Dragon1573
    */
   import scala.io.StdIn._

   // 从键盘读入数据
   val q: Double = readDouble();

   var n: Double = 1.0;
   var S_n: Double = 0.0;
   while (S_n < q) {
     S_n += (n + 1.0) / n;
     n += 1;
   }
   printf("当 q = %f 时， S_n = %f\n", q, S_n);
   ```

   ```scala
   scala> :load /home/dragon1573/Code/excercise2-1.scala
   Loading /home/dragon1573/Code/excercise2-1.scala...
   import scala.io.StdIn._
   q: Double = 1.0
   n: Double = 1.0
   S_n: Double = 0.0
   当 q = 1.000000 时， S_n = 2.000000

   scala> :load /home/dragon1573/Code/excercise2-1.scala
   Loading /home/dragon1573/Code/excercise2-1.scala...
   import scala.io.StdIn._
   q: Double = 30.0
   n: Double = 1.0
   S_n: Double = 0.0
   当 q = 30.000000 时， S_n = 30.891457

   scala> :load /home/dragon1573/Code/excercise2-1.scala
   Loading /home/dragon1573/Code/excercise2-1.scala...
   import scala.io.StdIn._
   q: Double = 50.0
   n: Double = 1.0
   S_n: Double = 0.0
   当 q = 50.000000 时， S_n = 50.416687
   ```

2. 模拟图形绘制

   &emsp;&emsp;对于一个图形绘制程序，用下面的层次对各实体进行抽象。定义一个 `Drawable` 的特质，包括一个 `draw` 方法，默认实现为输出对象的字符串表示。定义一个 `Point` 类表示点，混入了 `Drawable` 特质，并包含一个 `shift` 方法，用于移动点。所有图形实体的抽象类为 `Shape` ，其构造函数包括一个 `Point` 类型，表示图形的具体位置（具体意义对不同的具体图形不一样）。 `Shape` 类有一个具体方法 `moveTo` 和一个抽象方法 `zoom` ，其中， `moveTo` 将图形从当前位置移动到新的位置，各种具体图形的 `moveTo` 可能会有不一样的地方。 `zoom` 方法实现对图形的放缩，接受一个浮点型的放缩倍数参数，不同具体图形放缩实现不一样。继承 `Shape` 类的具体图形类型包括直线类 `Line` 和圆类 `Circle` 。 `Line` 类的第一个参数表示其位置，第二个参数表示另一个端点， `Line` 在缩放的时候，其中，点位置不变，长度按倍数放缩（注意，缩放时，两个端点信息也改变了），另外， `Line` 的 `move` 行为影响了另一个端点，需要对 `move` 方法进行重载。 `Circle` 类第一个参数表示其圆心，也是其位置，另一个参数表示半径， `Circle` 缩放的时候，位置参数不变，半径按倍数缩放。另外，直线类 `Line` 和圆类 `Circle` 都混入了 `Drawable` 特质，要求对 `draw` 进行重载实现，其中，类 `Line` 的 `draw` 输出的信息样式为“Line: (第一个端点的坐标--第二个端点的坐标)”，类 `Circle` 的 `draw` 输出的信息样式为“Circle center: 圆心坐标，R = 半径”。如下的代码已经给出了 `Drawable` 和 `Point` 的定义，同时也给出了程序入口 `main` 函数的实现，请完成 `Shape` 类、 `Line` 类、 `Circle` 类的定义。

   ```scala
   // MyDraw.scala

   trait Drawable {
      def draw() {
         println(this.toString)
      }
   }

   case class Point(var x: Double, var y: Double) extends Drawable {
      def shift(deltaX: Double, deltaY: Double) {
         x += deltaX
         y += deltaY
      }
   }

   abstract class Shape(var location: Point) {
      def moveTo(newLocation: Point) {
         location = newLocation
      }

      def zoom(scale: Double)
      }

      class Line(beginPoint: Point, var endPoint: Point) extends Shape(beginPoint)
      with Drawable {
      override def draw() {
         printf(
            "Line: (%f, %f) - (%f, %f)\n",
            location.x, location.y, endPoint.x, endPoint.y
         )
      }

      override def moveTo(newLocation: Point) {
         endPoint.shift(newLocation.x - location.x, newLocation.y - location.y)
         location = newLocation
      }

      override def zoom(scale: Double) {
         val midPoint = Point(
            (endPoint.x + location.x) / 2,
            (endPoint.y + location.y) / 2
         )
         location.x = midPoint.x + scale * (location.x - midPoint.x)
         location.y = midPoint.y + scale * (location.y -midPoint.y)
         endPoint.x = midPoint.x + scale * (endPoint.x - midPoint.x)
         endPoint.y = midPoint.y + scale * (endPoint.y -midPoint.y)
      }
   }

   class Circle(center: Point, var radius: Double) extends Shape(center) with
   Drawable {
      override def draw() {
         printf(
            "Circle Center: (%f, %f), R = %f\n",
            location.x, location.y, radius
         )
      }

      override def zoom(scale: Double) {
         radius = radius * scale
      }
   }

   object MyDraw {
      def main(args: Array[String]) {
         val p = new Point(10, 30)
         p.draw
         val line1 = new Line(Point(0, 0), Point(20, 20))
         line1.draw
         line1.moveTo(Point(5, 5))
         line1.draw
         line1.zoom(2)
         line1.draw
         val cir = new Circle(Point(10, 10), 5)
         cir.draw
         cir.moveTo(Point(30, 20))
         cir.draw
         cir.zoom(0.5)
         cir.draw
      }
   }
   ```

   ```text
   root@Huawei-ECS:~/文档 # scalac MyDraw.scala && scala -classpath ./ MyDraw
   Point(10.0,30.0)
   Line: (0.0, 0.0) - (20.0, 20.0)
   Line: (5.0, 5.0) - (25.0, 25.0)
   Line: (-5.0, -5.0) - (35.0, 35.0)
   Circle Center: (10.0, 10.0), R = 5.0
   Circle Center: (30.0, 20.0), R = 5.0
   Circle Center: (30.0, 20.0), R = 2.5
   ```

3. 统计学生成绩

   &emsp;&emsp;学生的成绩清单格式如下所示，第一行为表头，各字段意思分别为 `学号` 、 `性别` 、 `课程名1` 、 `课程名2` 等，后面每一行表示一个学生的信息，各字段之间用空白符隔开。

   &emsp;&emsp;给定任何一个如上格式的清单（不同清单里课程数量可能不一样），要求尽可能采用函数式编程，统计出各门课程的平均成绩、最低成绩和最高成绩；另外，还需按男女同学分开，分别统计各门课程的平均成绩、最低成绩和最高成绩。

   &emsp;&emsp;测试样例1如下：

   ```text
   Id      gender  Math  English   Physics
   301610  male    80    64        78
   301611  female  65    87        58
   301612  female  44    71        77
   301613  female  66    71        91
   301614  female  70    71        100
   301615  male    72    77        72
   301616  female  73    81        75
   301617  female  69    77        75
   301618  male    73    61        65
   301619  male    74    69        68
   301620  male    76    62        76
   301621  male    73    69        91
   301622  male    55    69        61
   301623  male    50    58        75
   301624  female  63    83        93
   301625  male    72    54        100
   301626  male    76    66        73
   301627  male    82    87        79
   301628  female  62    80        54
   301629  male    89    77        72
   ```

   &emsp;&emsp;样例1期望输出为：

   ```text
   Course    Average   Min       Max
   Math:     69.20     44.00     89.00
   English:  71.70     54.00     87.00
   Physics:  76.65     54.00     100.00
   Course    Average   Min       Max
   Math:     72.67     50.00     89.00
   English:  67.75     54.00     87.00
   Physics:  75.83     61.00     100.00
   Course    Average   Min       Max
   Math:     64.00     44.00     73.00
   English:  77.63     71.00     87.00
   Physics:  77.88     54.00     100.00
   ```

   &emsp;&emsp;测试样例2如下：

   ```text
   Id      gender  Math  English  Physics  Science
   301610  male    72    39       74        93
   301611  male    75    85       93        26
   301612  female  85    79       91        57
   301613  female  63    89       61        62
   301614  male    72    63       58        64
   301615  male    99    82       70        31
   301616  female  100   81       63        72
   301617  male    74    100      81        59
   301618  female  68    72       63        100
   301619  male    63    39       59        87
   301620  female  84    88       48        48
   301621  male    71    88       92        46
   301622  male    82    49       66        78
   301623  male    63    80       83        88
   301624  female  86    80       56        69
   301625  male    76    69       86        49
   301626  male    91    59       93        51
   301627  female  92    76       79        100
   301628  male    79    89       78        57
   301629  male    85    74       78        80
   ```

   &emsp;&emsp;样例2期望输出为：

   ```text
   Course    Average   Min       Max
   Math:     79.00     63.00     100.00
   English:  74.05     39.00     100.00
   Physics:  73.60     48.00     93.00
   Science:  65.85     26.00     100.00
   Course    Average   Min       Max
   Math:     77.08     63.00     99.00
   English:  70.46     39.00     100.00
   Physics:  77.77     58.00     93.00
   Science:  62.23     26.00     93.00
   Course    Average   Min       Max
   Math:     82.57     63.00     100.00
   English:  80.71     72.00     89.00
   Physics:  65.86     48.00     91.00
   Science:  72.57     48.00     100.00
   ```

   ```scala
   // ScoreReporter.scala
   import scala.io.Source

   object ScoreReporter {
      def main(args: Array[String]) {
         // 测试样例位于当前目录下
         val inputFile = Source.fromFile("sample.txt")
         // 正则表达式分割，容器转换用于多次遍历
         val originalData = inputFile.getLines.map(_.split("\\s+")).toList

         // 获取首行的课程名
         val courseNames = originalData.head.drop(2)
         // 剔除首行
         val allStudents = originalData.tail
         // 统计课程数量
         val courseNum = courseNames.length

         // 闭包函数，进行成绩统计
         def statistics(lines: List[Array[String]]) = {
            // for推导式生成三元组
            val tuple = (
               for (i <- 2 to courseNum + 1) yield {
                  // 提取列
                  val temp = lines map {elem => elem(i).toDouble}
                  (temp.sum, temp.min, temp.max)
               }
            )
            // 将总分转换为平均分
            tuple map {
               case (total, min, max) => (total / lines.length, min, max)
            }
         }

         // 格式化输出
         def show(results: Seq[(Double, Double, Double)]) {
            // 合并课程名与统计结果
            (courseNames zip results) foreach {
               case (course, result) => println(
                  f"${course + ":"}%-10s${result._1}%-10.2f${result._2}%-10.2f${result._3}%-10.2f"
               )
            }
         }

         // 全体学生
         val allResults = statistics(allStudents)
         printf("%-10s%-10s%-10s%-10s\n", "Course", "Average", "Min", "Max")
         show(allResults)

         // 性别划分
         val (maleStudents, femaleStudents) = allStudents partition (_(1) == "male")

         // 男生
         val maleResults = statistics(maleStudents)
         printf("%-10s%-10s%-10s%-10s\n", "Course", "Average", "Min", "Max")
         show(maleResults)

         // 女生
         val femaleResults = statistics(femaleStudents)
         printf("%-10s%-10s%-10s%-10s\n", "Course", "Average", "Min", "Max")
         show(femaleResults)
      }
   }
   ```

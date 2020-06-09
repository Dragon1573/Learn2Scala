# 第2章 Scala语言基础

<!-- omit in toc -->
## 目录

- [使用 Git Bash 登录 VMWare 虚拟机，并切换至相应目录下](#使用-git-bash-登录-vmware-虚拟机并切换至相应目录下)
- [2.1 Scala语言概述](#21-scala语言概述)
  - [2.1.5 HelloWorld](#215-helloworld)
- [2.2 Scala基础知识](#22-scala基础知识)
  - [2.2.1 基本数据类型和变量](#221-基本数据类型和变量)
  - [2.2.2 输入/输出](#222-输入输出)
  - [2.2.3 控制结构](#223-控制结构)
  - [2.2.4 数据结构](#224-数据结构)
- [2.3 面向对象基础编程](#23-面向对象基础编程)
  - [2.3.1 类](#231-类)
  - [2.3.2 对象](#232-对象)
  - [2.3.3 继承](#233-继承)
  - [2.3.4 参数化类型](#234-参数化类型)
  - [2.3.5 特质](#235-特质)
  - [2.3.6 模式匹配](#236-模式匹配)
- [2.4 函数式编程基础](#24-函数式编程基础)
  - [2.4.1 函数的定义与使用](#241-函数的定义与使用)
  - [2.4.2 高阶函数](#242-高阶函数)
  - [2.4.3 闭包](#243-闭包)
  - [2.4.4 偏应用函数和 `Curry` 化](#244-偏应用函数和-curry-化)
  - [2.4.5 针对容器的操作](#245-针对容器的操作)
  - [2.4.6 函数式编程实例](#246-函数式编程实例)

## 使用 Git Bash 登录 VMWare 虚拟机，并切换至相应目录下

```shell
legen@Legend1949 MINGW64 ~
$ ssh dragon1573@UKUI
Welcome to Ubuntu 19.10 (GNU/Linux 5.3.0-42-generic x86_64)

* Documentation:  https://help.ubuntu.com
* Management:     https://landscape.canonical.com
* Support:        https://ubuntu.com/advantage


0 updates can be installed immediately.
0 of these updates are security updates.


5 updates could not be installed automatically. For more details,
see /var/log/unattended-upgrades/unattended-upgrades.log
Last login: Mon Mar  9 23:04:25 2020 from fe80::4124:4643:6780:f001%ens33
dragon1573:~/ $ cd Code/
dragon1573:Code/ $
```

## 2.1 Scala语言概述

### 2.1.5 HelloWorld

#### Scala 交互式环境

```shell
dragon1573:Code/ $ scala
Welcome to Scala 2.11.8 (OpenJDK 64-Bit Server VM, Java 1.8.0_242).
Type in expressions for evaluation. Or try :help.

scala> :quit
```

#### 编写脚本文件 `Test.scala`

```scala
// Test.scala

println("This is the first line.")
println("This is the second line.")
println("This is the third line.")
```

#### 执行脚本

```scala
scala> :load /home/dragon1573/Code/Test.scala
Loading /home/dragon1573/Code/Test.scala...
This is the first line.
This is the second line.
This is the third line.

scala> :quit
dragon1573:Code/ $
```

#### 编写脚本文件 `HelloWorld.scala`

```scala
// HelloWorld.scala

object HelloWorld {
   def main(args: Array[String]) {
      println("Hello, world!");
   }
}
```

#### 编译并执行

```shell
dragon1573:Code/ $ scalac  HelloWorld.scala
dragon1573:Code/ $ scala -classpath ./ HelloWorld
Hello, world!
dragon1573:Code/ $ java -classpath .:/usr/share/scala/lib/scala-library.jar HelloWorld
Hello, world!
```

## 2.2 Scala基础知识

### 2.2.1 基本数据类型和变量

#### 字面量

```scala
scala> val c = 'A'
c: Char = A

scala> var c1 = '\u0045'
c1: Char = E

scala> c1 = '\''
c1: Char = '

scala> val s = "hello world"
s: String = hello world

scala> val ss = """ The first line.
     | The second line.
     | The third line. """
ss: String =
" The first line.
The second line.
The third line. "
```

#### 变量

```scala
scala> val a = "Xiamen University"
a: String = Xiamen University

scala> var a = 50
a: Int = 50
```

### 2.2.2 输入/输出

&emsp;&emsp;**备注：在我的设备安装完成并使用 Git Bash 远程连接后，Scala 输入没有回显效果**

#### 控制台输入输出语句

```scala
scala> import io.StdIn._
import io.StdIn._

scala> var i = readInt()
i: Int = 54

scala> var f = readFloat
f: Float = 1.618

scala> var b = readBoolean
b: Boolean = false

scala> var str = readLine("please input your name:")
please input your name:str: String = Li Lei

scala> val i = 345
i: Int = 345

scala> print(" i = "); print(i)
i = 345
scala> println("Hello"); println("world")
Hello
world

scala> val i = 34
i: Int = 34

scala> val f = 56.5
f: Double = 56.5

scala> printf("I am %d years old and weight %.1f kg. \n", i, f)
I am 34 years old and weight 56.5 kg.

scala> val i = 10
i: Int = 10

scala> val f = 3.5
f: Double = 3.5

scala> val s = "Hello"
s: String = Hello

scala> println(s"$s: i = $i, f = $f")           // s插值字符串
Hello: i = 10, f = 3.5

scala> println(f"$s: i = $i%-4d, f = $f%.1f")   // f插值字符串
Hello: i = 10  , f = 3.5
```

#### 读写文件

```scala
scala> import java.io.PrintWriter
import java.io.PrintWriter

scala> val outputFile = new PrintWriter("test.txt")
outputFile: java.io.PrintWriter = java.io.PrintWriter@79a04e5f

scala> outputFile.println("Hello World")

scala> outputFile.print("Spark is good")

scala> outputFile.close()
```

```shell
dragon1573:Code/ $ cat test.txt
Hello World
Spark is good%
```

```scala
scala> import java.io.PrintWriter
import java.io.PrintWriter

scala> val outputFile = new PrintWriter("test.txt")
outputFile: java.io.PrintWriter = java.io.PrintWriter@e73f9ac

scala> val i = 9
i: Int = 9

scala> outputFile.print("%3d --> %d\n".format(i, i * i))

scala> outputFile.println(f"$i%3d --> ${i * i}%d")         // 与上一句等效

scala> outputFile.close()

scala> import scala.io.Source
import scala.io.Source

scala> val inputFile = Source.fromFile("test.txt")
inputFile: scala.io.BufferedSource = non-empty iterator

scala> for (line <#### inputFile.getLines()) println(line)
9 --> 81
9 --> 81

scala> inputFile.close()
```

### 2.2.3 控制结构

#### `if` 条件表达式

```scala
scala> val x = 6
x: Int = 6

scala> if (x > 0) {
     |   println("This is a positive number.")
     | } else {
     |   println("This is not a positive number.")
     | }
This is a positive number.

scala> val x = 3
x: Int = 3

scala> if (x > 0) {
     |   println("This is a positive number.")
     | } else if (x == 0) {
     |   println("This is a zero.")
     | } else {
     |   println("This is a negative number.")
     | }
This is a positive number.

scala> val a = if (6 > 0) 1 else -1
a: Int = 1
```

#### `while` 循环

```scala
scala> var i = 0
i: Int = 0

scala> while (i < 3) {
     |   print("\u0046")
     |   i += 1
     | }
FFF

scala> var string: String = null
string: String = null

scala> do {
     |   string = readLine("interact> ")
     |   println(string)
     | } while (string != "exit")
warning: there was one deprecation warning; re-run with -deprecation for details
interact> Hello
interact> world
interact> exit
```

#### `for` 循环表达式

```scala
scala> for (i <#### 1 to 3) println(i)
1
2
3

scala> for (i <#### Array(3, 5, 6)) println(i)
3
5
6

scala> for (i <#### 1 to 5 if i % 2 == 0) println(i)
2
4

scala> for (i <#### 1 to 5) {
     |   if (i % 2 == 0) println(i)
     | }
2
4

scala> for (i <#### 1 to 5; j <#### 1 to 3) println(i * j)
1
2
3
2
4
6
3
6
9
4
8
12
5
10
15

scala> val r = for (i <#### Array(1, 2, 3, 4, 5) if i % 2 == 0) yield {println(i); i}
2
4
r: Array[Int] = Array(2, 4)
```

#### 对循环的控制

```scala
// TestBreak.scala

import util.control.Breaks._        // 导入Breaks类的所有方法

val array = Array(1, 3, 10, 5, 4)
breakable {
  for (i <#### array) {
    if (i > 5) break                // 跳出breakable，终止for循环，相当于Java中的break
    println(i)
  }
}

for (i <#### array) {
  breakable {
    if (i > 5) break            //跳出breakable，终止当次循环，相当于Java的continue
    println(i)
  }
}
```

```scala
scala> :load /home/dragon1573/Code/TestBreak.scala
Loading /home/dragon1573/Code/TestBreak.scala...
import util.control.Breaks._
array: Array[Int] = Array(1, 3, 10, 5, 4)
1
3
1
3
5
4
```

### 2.2.4 数据结构

#### 数组

```scala
scala> val intValueArr = new Array[Int](3)
intValueArr: Array[Int] = Array(0, 0, 0)

scala> val myStrArr = Array("BigData", "Hadoop", "Spark")
myStrArr: Array[String] = Array(BigData, Hadoop, Spark)

scala> val myMatrix = Array.ofDim[Int](3, 4)
myMatrix: Array[Array[Int]] = Array(Array(0, 0, 0, 0), Array(0, 0, 0, 0), Array(0, 0, 0, 0))

scala> val myCube = Array.ofDim[String](3, 2, 4)
myCube: Array[Array[Array[String]]] = Array(Array(Array(null, null, null, null), Array(null, null, null, null)), Array(Array(null, null, null, null), Array(null, null, null, null)), Array(Array(null, null, null, null), Array(null, null, null, null)))
```

#### 元组

```scala
scala> val tuple = ("BigData", 2015, 45.0)
tuple: (String, Int, Double) = (BigData,2015,45.0)

scala> val (t1, t2, t3) = tuple
t1: String = BigData
t2: Int = 2015
t3: Double = 45.0
```

#### 序列

##### 列表

```scala
scala> var strList = List("BigData", "Hadoop", "Spark")
strList: List[String] = List(BigData, Hadoop, Spark)

scala> val l = List[Double](1, 3.4)
l: List[Double] = List(1.0, 3.4)

scala> val x = List(1, 3.4, "Spark")
x: List[Any] = List(1, 3.4, Spark)

scala> val otherList = "Apache" :: strList
otherList: List[String] = List(Apache, BigData, Hadoop, Spark)

scala> val intList = 1 :: 2 :: 3 :: Nil
intList: List[Int] = List(1, 2, 3)

scala> val vec1 = Vector(1, 2)
vec1: scala.collection.immutable.Vector[Int] = Vector(1, 2)

scala> val vec2 = 3 +: 4 +: vec1
vec2: scala.collection.immutable.Vector[Int] = Vector(3, 4, 1, 2)

scala> val vec3 = vec2 :+ 5
vec3: scala.collection.immutable.Vector[Int] = Vector(3, 4, 1, 2, 5)

scala> vec3(3)
res0: Int = 2

scala> import scala.collection.mutable.ListBuffer
import scala.collection.mutable.ListBuffer

scala> val mutableL1 = ListBuffer(10, 20, 30)    // 初始长度为3的变长列表
mutableL1: scala.collection.mutable.ListBuffer[Int] = ListBuffer(10, 20, 30)

scala> mutableL1 += 40                           // 在列表尾部增加一个元素40
res1: mutableL1.type = ListBuffer(10, 20, 30, 40)

scala> val mutableL2 = mutableL1 :+ 50           // 在列表尾部增加一个元素50，返回新列表，无副作用
mutableL2: scala.collection.mutable.ListBuffer[Int] = ListBuffer(10, 20, 30, 40, 50)

scala> mutableL1.insert(2, 60, 40)               // 从第2个索引位置开始，插入60和40

scala> mutableL1
res3: scala.collection.mutable.ListBuffer[Int] = ListBuffer(10, 20, 60, 40, 30, 40)

scala> mutableL1 -= 40                           // 移除首个值为40的元素
res4: mutableL1.type = ListBuffer(10, 20, 60, 30, 40)

scala> var temp = mutableL1.remove(2)            // 移除索引为2的元素并返回副本，有副作用
temp: Int = 60

scala> mutableL1
res5: scala.collection.mutable.ListBuffer[Int] = ListBuffer(10, 20, 30, 40)
```

##### Range（范围）

```scala
scala> val r = new Range(1, 5, 1)
r: scala.collection.immutable.Range = Range(1, 2, 3, 4)

scala> val r = 1 until 5 by 1
r: scala.collection.immutable.Range = Range(1, 2, 3, 4)

scala> val r = 1 to 5 by 2
r: scala.collection.immutable.Range = Range(1, 3, 5)
```

##### 集合

```scala
scala> var mySet = Set("Hadoop", "Spark")
mySet: scala.collection.immutable.Set[String] = Set(Hadoop, Spark)

scala> mySet += "Scala"

scala> mySet
res7: scala.collection.immutable.Set[String] = Set(Hadoop, Spark, Scala)

scala> import scala.collection.mutable.Set
import scala.collection.mutable.Set

scala> val myMutableSet = Set("Database", "BigData")
myMutableSet: scala.collection.mutable.Set[String] = Set(BigData, Database)

scala> myMutableSet += "Cloud Computing"
res8: myMutableSet.type = Set(BigData, Cloud Computing, Database)
```

##### 映射

```scala
scala> val university = Map(
     |   "XMU" -> "Xiamen University",
     |   "THU" -> "Tsinghua University",
     |   "PKU" -> "Peking University"
     | )
university: scala.collection.immutable.Map[String,String] = Map(XMU -> Xiamen University, THU -> Tsinghua University, PKU -> Peking University)

scala> import scala.collection.mutable.Map
import scala.collection.mutable.Map

scala> val university2 = Map(
     |   "XMU" -> "Xiamen University",
     |   "THU" -> "Tsinghua University",
     |   "PKU" -> "Peking University"
     | )
university2: scala.collection.mutable.Map[String,String] = Map(XMU -> Xiamen University, THU -> Tsinghua University, PKU -> Peking University)

scala> university2("XMU") = "Ximan University"

scala> university2("FZU") = "Fuzhou University"

scala> university2 += ("TJU" -> "Tianjin University")
res11: university2.type = Map(XMU -> Ximan University, THU -> Tsinghua University, FZU -> Fuzhou University, TJU -> Tianjin University, PKU -> Peking University)
```

##### 迭代器

```scala
scala> val iter = Iterator("Hadoop", "Spark", "Scala")
iter: Iterator[String] = non-empty iterator

scala> while (iter.hasNext) {
     |   println(iter.next())
     | }
Hadoop
Spark
Scala
```

## 2.3 面向对象基础编程

### 2.3.1 类

#### 1. 类的定义

```scala
scala> class Counter {
     |   var value = 0
     |   def increment(step: Int): Unit = {
     |     value += step
     |   }
     |   def current(): Int = {
     |     value
     |   }
     | }
defined class Counter

scala> val myCounter = new Counter
myCounter: Counter = Counter@4b51880b

scala> myCounter.value = 5             // 访问字段
myCounter.value: Int = 5

scala> myCounter.increment(3)          // 调用方法

scala> println(myCounter.current)      // 调用无参数方法时，可以省略方法名后的括号
8
```

```shell
dragon1573:Code/ $ vim Top.scala
```

```scala
// Top.scala

class Top(name: String, subname: String) {    // 顶层类
  case class Nested(name: String) {}          // 嵌套类
  def show {
    val c = new Nested(subname)
    printf("Top %s includes a Nested %s\n", name, c.name)
  }
}


val t = new Top("A", "B")
t.show
```

```scala
scala> :load /home/dragon1573/Code/Top.scala
Loading /home/dragon1573/Code/Top.scala...
defined class Top
t: Top = Top@2c1b194a
Top A includes a Nested B
```

#### 2. 类成员可见性

```scala
// Counter.scala

class Counter {
  private var privateValue = 0

  def value = privateValue
  def value_=(newValue: Int) {
    if (newValue > 0) privateValue = newValue
  }
  def increment(step: Int): Unit = {
    value += step
  }
  def current(): Int = {
    value
  }
}
```

```scala
scala> :load /home/dragon1573/Code/Counter.scala
Loading /home/dragon1573/Code/Counter.scala...
defined class Counter

scala> val myCounter = new Counter
myCounter: Counter = Counter@1e67b872

scala> myCounter.value_=(3)         // 为privateValue设置新的值

scala> println(myCounter.value)     // 访问privateValue的当前值
3

scala> myCounter.value = 3          // 等效于myCounter.value_=(3)
myCounter.value: Int = 3
```

#### 3. 方法的定义方式

```scala
// Counter1.scala

class Counter {
  var value = 0

  def increment(step: Int): Unit = {
    value += step
  }
  def current: Int = value
  def getValue(): Int = value
}
```

```scala
scala> :load /home/dragon1573/Code/Counter1.scala
Loading /home/dragon1573/Code/Counter1.scala...
defined class Counter

scala> val c = new Counter
c: Counter = Counter@246ae04d

scala> c increment 5    // 中缀调用法

scala> c.getValue()     // getValue()定义中有括号，可以带括号调用
res1: Int = 5

scala> c.getValue       // 也可以不带括号调用
res2: Int = 5

scala> c.current()      // current定义中没有括号，不可带括号调用
<console>:14: error: Int does not take parameters
       c.current()
                ^

scala> c.current        // current定义中没有括号，只能不带括号调用
res4: Int = 5
```

```scala
// Position.scala

class Position(var x: Double = 0, var y: Double = 0) {
  def move(deltaX: Double = 0, deltaY: Double = 0) {
    x += deltaX
    y += deltaY
  }
}


val p = new Position()    // 省略所有参数，全部默认
p.move(deltaY = 5)        // 沿y轴移动5个单位，其余默认
```

#### 4. 构造器

```scala
// Counter2.scala

class Counter {
  private var value = 0
  private var name = ""
  private var step = 1                    // 计算器的默认递进步长

  println("The main constructor.")

  def this(name: String) {                // 第一个辅助构造器
    this()                                // 调用主构造器
    this.name = name
    printf("The first auxiliary constructor, name: %s\n", name)
  }
  def this (name: String, step: Int) {    // 第二个辅助构造器
    this(name)                            // 调用前一个辅助构造器
    this.step = step
    printf("The second auxiliary constructor, name: %s, step: %d\n", name, step)
  }
  def increment(step: Int): Unit = {value += step}
  def current(): Int = value
}
```

```scala
scala> :load /home/dragon1573/Code/Counter2.scala
Loading /home/dragon1573/Code/Counter2.scala...
defined class Counter

scala> val c1 = new Counter
The main constructor.
c1: Counter = Counter@a2431d0

scala> val c2 = new Counter("The 2nd counter.")
The main constructor.
The first auxiliary constructor, name: The 2nd counter.
c2: Counter = Counter@32b260fa

scala> val c3 = new Counter("The 3nd counter", 2)
The main constructor.
The first auxiliary constructor, name: The 3nd counter
The second auxiliary constructor, name: The 3nd counter, step: 2
c3: Counter = Counter@4a883b15

scala> class Counter(var name: String)
defined class Counter

scala> var mycounter = new Counter("Runner")
mycounter: Counter = Counter@7f485fda

scala> println(mycounter.name)
Runner

scala> mycounter.name_=("Timer")

scala> mycounter.name = "Timer"
mycounter.name: String = Timer
```

### 2.3.2 对象

#### 1. 单例对象

```scala
// Person.scala

object Person {
  private var lastId = 0    // 一个人的身份编号
  def newPersonId() = {
    lastId += 1
    lastId
  }
}
```

```scala
scala> :load /home/dragon1573/Code/Person.scala
Loading /home/dragon1573/Code/Person.scala...
defined object Person

scala> printf("The first person id: %d.\n", Person.newPersonId())
The first person id: 1.

scala> printf("The second person id: %d.\n", Person.newPersonId())
The second person id: 2.

scala> printf("The third person id: %d.\n", Person.newPersonId())
The third person id: 3.
```

```scala
// Person1.scala

class Person(val name: String) {
  private val id = Person.newPersonId()   // 调用了伴生对象中的方法

  def info() {
    printf("The id of %s is %d.\n", name, id)
  }
}

object Person {
  private var lastId = 0                  // 一个人的身份编号

  def newPersonId() = {
    lastId += 1
    lastId
  }

  def main(args: Array[String]) {
    val person1 = new Person("Lilei")
    val person2 = new Person("Hanmei")
    person1.info()
    person2.info()
  }
}
```

```shell
dragon1573:Code/ $ scalac Person1.scala
dragon1573:Code/ $ scala -classpath ./ Person
The id of Lilei is 1.
The id of Hanmei is 2.
```

#### 2. `apply()` 方法

```scala
// TestApplyClass.scala

class TestApplyClass {
  def apply(param: String) {
    println("apply method called: " + param)
  }
}
```

```scala
scala> :load /home/dragon1573/Code/TestApplyClass.scala
Loading /home/dragon1573/Code/TestApplyClass.scala...
defined class TestApplyClass

scala> val myObject = new TestApplyClass
myObject: TestApplyClass = TestApplyClass@2aae9190

scala> myObject("Hello Apply")            // 自动调用类中定义的apply方法，等同于下句
apply method called: Hello Apply

scala> myObject.apply("Hello Apply")      // 手动调用apply方法
apply method called: Hello Apply
```

```scala
// MyTestApply.scala

class Car(name: String) {
  def info() {
    println("Car name is " + name)
  }
}

object Car {
  def apply(name: String) = new Car(name)   // 调用伴生类Car的构造方法
}

object MyTestApply{
  def main (args: Array[String]) {
    val mycar = Car("BMW")                  // 调用伴生对象中的apply方法
    mycar.info()
  }
}
```

```shell
dragon1573:Code/ $ scalac MyTestApply.scala && scala -classpath ./ MyTestApply
Car name is BMW
```

```scala
scala> def add = (x: Int, y: Int) => x + y
add: (Int, Int) => Int

scala> add(4, 5)
res0: Int = 9

scala> add.apply(4, 5)
res1: Int = 9

scala> import scala.collection.mutable.Map                  // 导入可变Map类
import scala.collection.mutable.Map

scala> val persons = Map("LiLei" -> 24, "HanMei" -> 21)
persons: scala.collection.mutable.Map[String,Int] = Map(HanMei -> 21, LiLei -> 24)

scala> persons("LiLei") = 28

scala> persons.update("LiLei", 28)

scala> persons("LiLei")
res4: Int = 28
```

#### 3. `unapply()` 方法

```scala
// TestUnapply.scala

class Car(val brand: String, val price: Int) {
  def info() {
    println("Car brand is " + brand + " and price is " + price + ".")
  }
}

object Car {
  def apply(brand: String, price: Int) = {
    println("[DEBUG] Calling apply ...")
    new Car(brand, price)
  }

  def unapply(c: Car): Option[(String, Int)] = {
    println("[DEBUG] Calling unapply ...")
    Some((c.brand, c.price))
  }
}

object TestUnapply {
  def main(args: Array[String]) {
    var Car(carbrand, carprice) = Car("BMW", 800000)
    println("Brand: " + carbrand + " and carprice: " + carprice + ".")
  }
}
```

```shell
dragon1573:Code/ $ scalac TestUnapply.scala && scala -classpath . TestUnapply
[DEBUG] Calling apply ...
[DEBUG] Calling unapply ...
Brand: BMW and carprice: 800000.
```

### 2.3.3 继承

#### 2. 类的继承

```scala
// MyCar.scala

abstract class Car(val name: String) {
  val carBrand: String    // 一个抽象字段
  var age: Int = 0

  def info()              // 抽象方法

  def greeting() {
    println("Welcome to my car!")
  }

  def this(name: String, age: Int) {
    this(name)
    this.age = age
  }
}

// 派生类，其主构造函数调用了父类的主构造函数
// 由于name是父类主构造器的参数，因此也必须override
class BMWCar(override val name: String) extends Car(name) {
  override val carBrand = "BMW"     // 重载父类抽象字段，override关键字可选

  def info() {                      // 重载父类抽象方法，override关键字可选
    printf("This is a %s car. It has been used for %d year.\n", carBrand, age)
  }

  override def greeting() {         // 重载父类非抽象方法，override关键字必选
    println("Welcome to my BMW car!")
  }
}

// 派生类，其主构造函数调用了父类的辅助构造函数
class BYDCar(name: String, age: Int) extends Car(name, age) {
  val carBrand = "BYD"              // 重载父类抽象字段，override可选
  override def info() {             // 重载父类抽象方法，override关键字可选
    printf("This is a %s car. It has been used for %d year.\n", carBrand, age)
  }
}

object MyCar {
  def main(args: Array[String]) {
    val car1 = new BMWCar("Bob's Car")
    val car2 = new BYDCar("Tom's Car", 3)
    show(car1)
    show(car2)
  }

  // 将参数设为父类类型，根据传入参数的具体子类类型，调用相应方法，实现多态
  def show(thecar: Car) = {
    thecar.greeting
    thecar.info()
  }
```

```shell
dragon1573:Code/ $ scalac MyCar.scala && scala -classpath . MyCar
Welcome to my BMW car!
This is a BMW car. It has been used for 0 year.
Welcome to my car!
This is a BYD car. It has been used for 3 year.
```

#### 3. Scala的类层次结构

```scala
scala> def error(message: String): Nothing = throw new RuntimeException(message)
error: (message: String)Nothing

scala> def divide(x: Int, y: Int): Int = {
     |   if (y != 0) x / y else error("can't divide by zero")
     | }
divide: (x: Int, y: Int)Int

scala> divide(0, 0)
java.lang.RuntimeException: can't divide by zero
  at .error(<console>:11)
  at .divide(<console>:13)
  ... 32 elided
```

#### 4. `Option` 类

```scala
scala> case class Book(val name: String, val price: Double)
defined class Book

scala> val books = Map(
     |   "hadoop" -> Book("Hadoop", 35.5),
     |   "spark" -> Book("Spark", 55.5),
     |   "hbase" -> Book("Hbase", 26.0)
     | )
books: scala.collection.immutable.Map[String,Book] = Map(hadoop -> Book(Hadoop,35.5), spark -> Book(Spark,55.5), hbase -> Book(Hbase,26.0))

scala> books.get("hadoop")
res1: Option[Book] = Some(Book(Hadoop,35.5))

scala> books.get("hive")
res2: Option[Book] = None

scala> books.get("hadoop").get
res3: Book = Book(Hadoop,35.5)

scala> books.get("hive").get
java.util.NoSuchElementException: None.get
  at scala.None$.get(Option.scala:347)
  at scala.None$.get(Option.scala:345)
  ... 32 elided

scala> books.get("hive").getOrElse(Book("Unknown name", 0))
res5: Book = Book(Unknown name,0.0)
```

### 2.3.4 参数化类型

```scala
// Box.scala

import scala.collection.mutable.Stack

class Box[T] {
  val elems: Stack[T] = Stack()

  def remove: Option[T] = {   // 返回的对象采用了Option类型进行包装
    if (elems.isEmpty) None else Some(elems.pop)
  }

  def append(a1: T) {
    elems.push(a1)
  }
}
```

```scala
scala> :load /home/dragon1573/Code/Box.scala
Loading /home/dragon1573/Code/Box.scala...
import scala.collection.mutable.Stack
defined class Box

scala> case class Book(name: String)    // 快速定义一个Book类
defined class Book

scala> val a = new Box[Book]            // 实例化一个元素为Book类型的Box实例并赋值给a
a: Box[Book] = Box@2c78324b

scala> a.append(Book("Hadoop"))         // 调用Box的append方法增加一个元素

scala> a.append(Book("Spark"))

scala> a.remove                         // 调用Box的remove方法取出一个元素
res2: Option[Book] = Some(Book(Spark))
```

```scala
// Element.scala

abstract class Element {
  type T            // 抽象的类型成员
  var value: T      // 抽象的字段，类型为T
  def show: Unit    // 抽象方法，需要根据具体的类型T进行实现
}

class IntElement(var value: Int) extends Element {
  type T = Int

  def show {        // T是Int型时的输出
    printf("My value is %d.\n", value)
  }
}

class StringElement(var value: String) extends Element {
  type T = String
  def show {        // T是String型时的输出
    printf("My value is %s.\n", value)
  }
}
```

```scala
scala> :load Element.scala
Loading Element.scala...
defined class Element
defined class IntElement
defined class StringElement

scala> val a = new IntElement(56)
a: IntElement = IntElement@30f5a68a

scala> a.show
My value is 56.

scala> val b = new StringElement("hello")
b: StringElement = StringElement@277f7dd3

scala> b.show
My value is hello.
```

```scala
// Element1.scala

abstract class Element[T] {
  var value: T
  def show: Unit
}

class IntElement(var value: Int) extends Element[Int] {
  def show {
    printf("My value is %d.\n", value)
  }
}

class StringElement(var value: String) extends Element[String] {
  def show {
    printf("My value is %s.\n", value)
  }
}
```

```scala
scala> :load Element1.scala
Loading Element1.scala...
defined class Element
defined class IntElement
defined class StringElement

scala> val a = new IntElement(56)
a: IntElement = IntElement@1e4f4a5c

scala> a.show
My value is 56.

scala> val b = new StringElement("hello")
b: StringElement = StringElement@536dbea0

scala> b.show
My value is hello.
```

### 2.3.5 特质

```scala
// Bird.scala

trait Flyable {
  var maxFlyHeight: Int     // 抽象字段

  def fly()                 // 抽象方法

  def breathe() {           // 具体的方法
    println("I can breathe.")
  }
}

class Bird(flyHeight: Int) extends Flyable {
  var maxFlyHeight: Int = flyHeight       // 重载特质的抽象字段

  def fly() {               // 重载特质的抽象方法
    printf("I can fly at the height of %d.", maxFlyHeight)
  }
}
```

```scala
scala> :load Bird.scala
Loading Bird.scala...
defined trait Flyable
defined class Bird

scala> val b = new Bird(100)
b: Bird = Bird@f79e

scala> b.fly()
I can fly at the height of 100.
scala> b.breathe()
I can breathe.
```

```scala
scala> val t: Flyable = new Bird(50)
t: Flyable = Bird@7690781

scala> t.fly      // 调用了Bird类的方法
I can fly at the height of 50.
scala> t.breathe
I can breathe.
```

```scala
// Bird1.scala

trait Flyable {
  var maxFlyHeight: Int       // 抽象字段

  def fly()                   // 抽象方法

  def breathe() {             // 具体的方法
    println("I can breathe.")
  }
}

class Animal(val category: String) {
  def info() {
    println("This is a " + category)
  }
}

class Bird(flyHeight: Int) extends Animal("Bird") with Flyable {
  var maxFlyHeight: Int = flyHeight       // 重载特质的抽象字段
  def fly() {                             // 重载特质的抽象方法
    printf("I can fly at the height of %d.\n", maxFlyHeight)
  }
}
```

```scala
scala> :load Bird1.scala
Loading Bird1.scala...
defined trait Flyable
defined class Animal
defined class Bird

scala> val b = new Bird(50)
b: Bird = Bird@623a8092

scala> b.info
This is a Bird

scala> b.fly
I can fly at the height of 50.

scala> b.breathe
I can breathe.
```

```scala
// Bird2.scala

trait Flyable {
  var maxFlyHeight: Int       // 抽象字段

  def fly()                   // 抽象方法

  def breathe() {             // 具体的方法
    println("I can breathe.")
  }
}

trait HasLegs {
  val legs: Int               // 抽象字段
  def move() {
    printf("I can walk with %d legs.\n", legs)
  }
}

class Animal(val category: String) {
  def info() {
    println("This is a " + category + ".")
  }
}

class Bird(flyHeight: Int) extends Animal("Bird") with Flyable with HasLegs {
  var maxFlyHeight: Int = flyHeight       // 重载特质的抽象字段
  val legs = 2                            // 重载特质的抽象字段

  def fly() {                             // 重载特质的抽象方法
    printf("I can fly at the height of %d.\n", maxFlyHeight)
  }
}
```

```scala
scala> :load Bird2.scala
Loading Bird2.scala...
defined trait Flyable
defined trait HasLegs
defined class Animal
defined class Bird

scala> val b = new Bird(108)
b: Bird = Bird@e3b3b2f

scala> b.info
This is a Bird.

scala> b.fly
I can fly at the height of 108.

scala> b.move
I can walk with 2 legs.
```

```scala
// Bird3.scala

class Animal(val category: String) {
  def info() {
    println("This is a " + category + ".")
  }
}

trait HasLegs {
  val legs: Int       // 抽象字段

  def move() {
    printf("I can walk with %d legs.\n", legs)
  }
}
```

```scala
scala> :load Bird3.scala
Loading Bird3.scala...
defined class Animal
defined trait HasLegs

scala> var a = new Animal("dog") with HasLegs {
     |   val legs = 4
     | }
a: Animal with HasLegs = $anon$1@445b295b

scala> a.info
This is a dog.

scala> a.legs
res1: Int = 4

scala> a.move
I can walk with 4 legs.
```

### 2.3.6 模式匹配

#### 1. `match` 子句

```scala
// TestMatch.scala

import scala.io.StdIn._

println("Please input the score:")
val grade = readChar()
grade match {
  case 'A' => println("85 - 100")
  case 'B' => println("70 - 84")
  case 'C' => println("60 - 69")
  case 'D' => println("   < 60")
  case _   => println("error input!")
}
```

```scala
scala> :load TestMatch.scala
Loading TestMatch.scala...
import scala.io.StdIn._
Please input the score:
grade: Char = A
85 - 100
```

```scala
// TestMatch1.scala

import scala.io.StdIn._

println("Please input a country:")
val country = readLine()
country match {
  case "China"    => println("中国")
  case "America"  => println("美国")
  case "Japan"    => println("日本")
  case _          => println("我不认识！")
}
```

```scala
scala> :load TestMatch1.scala
Loading TestMatch1.scala...
import scala.io.StdIn._
Please input a country:
country: String = France
我不认识！
```

```scala
// TestMatch2.scala

for (elem <- List(6, 9, 0.618, "Spark", "Hadoop", "Hello")) {
  val str = elem match {
    case i: Int => i + " is an int value."            // 匹配整型的值，并赋值给i
    case d: Double => d + " is a double value."       // 匹配浮点型的值
    case "Spark" => "Spark is found."                 // 匹配特定的字符串
    case s: String => s + " is a string value."       // 匹配其它字符串
    case _ => "unexpected value：" + elem             // 与以上都不匹配
  }
  println(str)
}
```

```scala
scala> :load TestMatch2.scala
Loading TestMatch2.scala...
6 is an int value.
9 is an int value.
0.618 is a double value.
Spark is found.
Hadoop is a string value.
Hello is a string value.
```

```scala
// TestMatch3.scala

for (elem <- List(1, 2, 3, 4)) {
  elem match {
    case _ if (elem%2 == 0) => println(elem + " is even.")
    case _ => println(elem + " is odd.")
  }
}
```

```scala
scala> :load TestMatch3.scala
Loading TestMatch3.scala...
1 is odd.
2 is even.
3 is odd.
4 is even.
```

#### 2. `case` 类

```scala
// TestCase.scala

case class Car(brand: String, price: Int)

val myBYDCar = new Car("BYD", 89000)
val myBMWCar = new Car("BMW", 1200000)
val myBenzCar = new Car("Benz", 1500000)
for (car <- List(myBYDCar, myBMWCar, myBenzCar)) {
  car match {
    case Car("BYD", 89000) => println("Hello, BYD!")
    case Car("BMW", 1200000) => println("Hello, BMW!")
    case Car(brand, price) => println(
      "Brand: " + brand + ", Price: " + price + " , do you want it?"
    )
  }
}
```

```scala
scala> :load TestCase.scala
Loading TestCase.scala...
defined class Car
myBYDCar: Car = Car(BYD,89000)
myBMWCar: Car = Car(BMW,1200000)
myBenzCar: Car = Car(Benz,1500000)
Hello, BYD!
Hello, BMW!
Brand: Benz, Price: 1500000 , do you want it?

scala> val Car(brand, price) = myBYDCar
brand: String = BYD
price: Int = 89000

scala> val Car(_, price) = myBYDCar
price: Int = 89000
```

## 2.4 函数式编程基础

### 2.4.1 函数的定义与使用

```scala
scala> val counter: (Int) => Int = { value => value + 1 }
counter: Int => Int = <function1>

scala> val counter: (Int) => Int = { value => value + 1 }
counter: Int => Int = <function1>

scala> counter(5)
res0: Int = 6

scala> val counter = (value: Int) => value + 1
counter: Int => Int = <function1>

scala> counter(10)
res1: Int = 11

scala> val add = (a: Int, b: Int) => a + b      // 函数类型为两个Int型参数，返回Int
add: (Int, Int) => Int = <function2>

scala> add(3, 5)
res2: Int = 8

scala> val show = (s: String) => println(s)     // 函数类型为一个String参数，返回Unit
show: String => Unit = <function1>

scala> show("Hello, Scala!")
Hello, Scala!

scala> val javaHome = () => System.getProperty("java.home")
javaHome: () => String = <function0>            // 函数类型为无参数，返回String

scala> println(javaHome())
/usr/lib/jvm/java-8-openjdk-amd64/jre

scala> val counter = (_: Int) + 1         // 有类型时括号不能省略，等效于 “x:Int=>x+1”
counter: Int => Int = <function1>

scala> val add = (_: Int) + (_: Int)      // 等效于“(a:Int,b:Int)=>a+b”
add: (Int, Int) => Int = <function2>

scala> val m1 = List(1, 2, 3)
m1: List[Int] = List(1, 2, 3)

scala> val m2 = m1.map(_ * 2)             // map接受一个函数作为参数，相当于“m1.map(x=>x*2)”
m2: List[Int] = List(2, 4, 6)             // 参数的类型可以根据m1的元素类型推断出，所以可以省略

scala> def multiplier(factor: Int)(x: Int) = x * factor
multiplier: (factor: Int)(x: Int)Int      // 带有两个参数列表的函数

scala> multiplier(2)(5)
res5: Int = 10
```

### 2.4.2 高阶函数

```scala
scala> def powerOfTwo(x: Int): Int = {
     |   if (x == 0) 1 else 2 * powerOfTwo(x - 1)
     | }
powerOfTwo: (x: Int)Int

scala> def sumInts(a: Int, b: Int): Int = {
     |   if (a > b) 0 else a + sumInts(a + 1, b)
     | }
sumInts: (a: Int, b: Int)Int

scala> def sumSquares(a: Int, b: Int): Int = {
     |   if (a > b) 0 else a * a + sumSquares(a + 1, b)
     | }
sumSquares: (a: Int, b: Int)Int

scala> def sumPowersOfTwo(a: Int, b: Int): Int = {
     |   if (a > b) 0 else powerOfTwo(a) + sumPowersOfTwo(a + 1, b)
     | }
sumPowersOfTwo: (a: Int, b: Int)Int

scala> sumInts(1, 5)
res7: Int = 15

scala> sumSquares(1, 5)
res8: Int = 55

scala> sumPowersOfTwo(1, 5)
res9: Int = 62

scala> def sum(f: Int => Int, a: Int, b: Int): Int = {
     |   if (a > b) 0 else f(a) + sum(f, a + 1, b)
     | }
sum: (f: Int => Int, a: Int, b: Int)Int

scala> sum(x => x, 1, 5)          // 直接传入一个匿名函数
res10: Int = 15                   // 省略了参数x的类型，因为可以由sum的参数类型推断出来

scala> sum(x => x * x, 1, 5)      // 直接传入另一个匿名函数
res11: Int = 55

scala> sum(powerOfTwo, 1, 5)      // 传入一个已经定义好的方法
res12: Int = 62
```

### 2.4.3 闭包

```scala
scala> var more = 10
more: Int = 10

scala> val addMore = (x: Int) => x + more
addMore: Int => Int = <function1>

scala> addMore(5)       // more的值被绑定为10
res0: Int = 15

scala> more = 20
more: Int = 20

scala> addMore(5)       // more的值被绑定为20
res1: Int = 25

scala> var sum = 0
sum: Int = 0

scala> val accumulator = (x: Int) => sum += x       // 包含外部变量sum的闭包
accumulator: Int => Unit = <function1>

scala> accumulator(5)

scala> sum
res3: Int = 5

scala> accumulator(10)

scala> sum
res5: Int = 15
```

### 2.4.4 偏应用函数和 `Curry` 化

#### 1. 偏应用函数

```scala
scala> def sum(a: Int, b: Int, c: Int) = a + b + c
sum: (a: Int, b: Int, c: Int)Int

scala> val a = sum(1, _: Int, _: Int)       // 只保留了sum的后两个参数
a: (Int, Int) => Int = <function2>

scala> a(2, 3)                              // 等效于调用sum(1, 2, 3)
res6: Int = 6

scala> val b = sum _      // 注意sum后有一个空格
b: (Int, Int, Int) => Int = <function3>

scala> b(1, 2, 3)
res7: Int = 6
```

#### 2. `Curry` 化

```scala
scala> def multiplier(factor: Int)(x: Int) = x * factor
multiplier: (factor: Int)(x: Int)Int      // 带有两个参数列表的函数

scala> val byTwo = multiplier(2)_         // 保留multiplier第二个参数的偏应用函数，
byTwo: Int => Int = <function1>           // 第一个参数值固定为2

scala> multiplier(2)(5)
res8: Int = 10

scala> byTwo(5)
res9: Int = 10

scala> def plainMultiplier(x: Int, y: Int) = x * y
plainMultiplier: (x: Int, y: Int)Int        // 带有两个参数的普通函数

scala> val curriedMultiplier = (plainMultiplier _).curried
curriedMultiplier: Int => (Int => Int) = <function1>

scala> plainMultiplier(2, 5)
res10: Int = 10

scala> curriedMultiplier(2)(5)
res11: Int = 10
```

### 2.4.5 针对容器的操作

#### 1. 遍历操作

```scala
scala> val list = List(1, 2, 3)
list: List[Int] = List(1, 2, 3)

scala> val f = (i: Int) => println(i)
f: Int => Unit = <function1>

scala> list.foreach(f)
1
2
3

scala> val university = Map(
     |   "XMU" -> "Xiamen University",
     |   "THU" -> "Tsinghua University",
     |   "PKU" -> "Peking University"
     | )
university: scala.collection.immutable.Map[String,String] = Map(XMU -> Xiamen University, THU -> Tsinghua University, PKU -> Peking University)

scala> university foreach {
     |   kv => println(kv._1 + ": " + kv._2)
     | }
XMU: Xiamen University
THU: Tsinghua University
PKU: Peking University

scala> university foreach {
     |   case (k,v) => println(k + ": " + v)
     | }
XMU: Xiamen University
THU: Tsinghua University
PKU: Peking University

scala> university foreach {
     |   x => x match {
     |     case (k,v) => println(k + ": " + v)
     |   }
     | }
XMU: Xiamen University
THU: Tsinghua University
PKU: Peking University

scala> for(i <- list) println(i)
1
2
3

scala> for(kv <- university) println(kv._1 + ": " + kv._2)
XMU: Xiamen University
THU: Tsinghua University
PKU: Peking University

scala> for((k, v) <- university) println(k + ": " + v)
XMU: Xiamen University
THU: Tsinghua University
PKU: Peking University
```

#### 2. 映射操作

```scala
scala> val books = List("Hadoop", "Hive", "HDFS")
books: List[String] = List(Hadoop, Hive, HDFS)

scala> books.map(s => s.toUpperCase)
res0: List[String] = List(HADOOP, HIVE, HDFS)

scala> books.map(s => s.length)
res1: List[Int] = List(6, 4, 4)

scala> books flatMap (s => s.toList)
res3: List[Char] = List(H, a, d, o, o, p, H, i, v, e, H, D, F, S)
```

#### 3. 过滤操作

```scala
scala> val university = Map(
     |   "XMU" -> "Xiamen University",
     |   "THU" -> "Tsinghua University",
     |   "PKU" -> "Peking University",
     |   "XMUT" -> "Xiamen University of Technology"
     | )
university: scala.collection.immutable.Map[String,String] = Map(XMU -> Xiamen University, THU -> Tsinghua University, PKU -> Peking University, XMUT -> Xiamen University of Technology)

scala> val xmus = university filter {
     |   kv => kv._2 contains "Xiamen"
     | }
xmus: scala.collection.immutable.Map[String,String] = Map(XMU -> Xiamen University, XMUT -> Xiamen University of Technology)

scala> val l = List(1, 2, 3, 4, 5, 6) filter {_ % 2 == 0}
l: List[Int] = List(2, 4, 6)

scala> val t = List("Spark", "Hadoop", "Hbase")
t: List[String] = List(Spark, Hadoop, Hbase)

scala> t exists {_ startsWith "H"}
res7: Boolean = true

scala> t find {_ startsWith "Hb"}
res8: Option[String] = Some(Hbase)

scala> t find {_ startsWith "Hp"}
res9: Option[String] = None
```

#### 4. 规约操作

```scala
scala> val list = List(1, 2, 3, 4, 5)
list: List[Int] = List(1, 2, 3, 4, 5)

scala> list.reduce(_ + _)                                         // 将列表元素累加，使用了占位符语法
res0: Int = 15

scala> list.reduce(_ * _)                                         // 将列表元素连乘
res1: Int = 120

scala> list map (_.toString) reduce ((x, y) => s"f($x, $y)")      // f表示传入reduce的二元函数
res2: String = f(f(f(f(1, 2), 3), 4), 5)

scala> val s1 = Set(1, 2, 3)
s1: scala.collection.immutable.Set[Int] = Set(1, 2, 3)

scala> val s2 = util.Random.shuffle(s1)       // 打乱集合的顺序生成一个新集合
s2: scala.collection.immutable.Set[Int] = Set(1, 2, 3)

scala> s1 == s2                               // s1和s2只是元素顺序不一样，但从集合的角度是完全相等的
res3: Boolean = true

scala> s1.reduce(_ + _)                       // 加法操作满足结合律和交换律，所以结果与遍历顺序无关
res4: Int = 6

scala> s2.reduce(_ + _)
res5: Int = 6

scala> s1.reduce(_ - _)                       // 减法不满足结合律和交换律，与遍历顺序有关
res6: Int = -4

scala> s2.reduce(_ - _)
res7: Int = -4

scala> val list = List(1, 2, 3, 4, 5)
list: List[Int] = List(1, 2, 3, 4, 5)

scala> list reduceLeft {_ - _}
res8: Int = -13

scala> list reduceRight {_ - _}
res9: Int = 3

scala> val s = list map (_.toString)                      // 将整型列表转换成字符串列表
s: List[String] = List(1, 2, 3, 4, 5)

scala> s reduceLeft {(accu, x) => s"($accu - $x)"}        // list reduceLeft {_ - _} 的计算过程
res10: String = ((((1 - 2) - 3) - 4) - 5)

scala> s reduceRight {(x, accu) => s"($x - $accu)"}       // list reduceRight {_ - _} 的计算过程
res11: String = (1 - (2 - (3 - (4 - 5))))

scala> val list = List(1, 2, 3, 4, 5)
list: List[Int] = List(1, 2, 3, 4, 5)

scala> list.fold(10)(_ * _)
res12: Int = 1200

scala> (list fold 10)(_ * _)            // fold的中缀调用写法
res13: Int = 1200

scala> (list foldLeft 10)(_ - _)        // 计算顺序(((((10 - 1) - 2) - 3) - 4) - 5)
res14: Int = -5

scala> (list foldRight 10)(_ - _)       // 计算顺序(1 - (2 - (3 - (4 - (5 - 10)))))
res15: Int = -7

scala> val em = List.empty
em: List[Nothing] = List()

scala> em.fold(10)(_ - _)               // 对空容器fold的结果为初始值
res16: Int = 10

scala> em.reduce(_ - _)                 // 对空容器调用reduce会报错
<console>:13: error: missing parameter type for expanded function ((x$1, x$2) => x$1.$minus(x$2))
       em.reduce(_ - _)
                 ^
<console>:13: error: missing parameter type for expanded function ((x$1: <error>, x$2) => x$1.$minus(x$2))
       em.reduce(_ - _)
                     ^

scala> val list = List(1, 2, 3, 4, 5)
list: List[Int] = List(1, 2, 3, 4, 5)

scala> (list foldRight List.empty[Int]){(x, accu) => x * 2 :: accu}       // 与map操作结果一样
res19: List[Int] = List(2, 4, 6, 8, 10)

scala> list map {_ * 2}
res20: List[Int] = List(2, 4, 6, 8, 10)
```

#### 5. 拆分操作

```scala
scala> val xs = List(1, 2, 3, 4, 5)
xs: List[Int] = List(1, 2, 3, 4, 5)

scala> val part = xs.partition(_ < 3)
part: (List[Int], List[Int]) = (List(1, 2),List(3, 4, 5))

scala> val gby = xs.groupBy(x => x % 3)       // 按被3整除的余数进行划分
gby: scala.collection.immutable.Map[Int,List[Int]] = Map(2 -> List(2, 5), 1 -> List(1, 4), 0 -> List(3))

scala> gby(2)                                 // 获取键值为2（余数为2）的子容器
res0: List[Int] = List(2, 5)

scala> val ged = xs.grouped(3)                // 拆分为大小为3个子容器
ged: Iterator[List[Int]] = non-empty iterator

scala> ged.next                               // 第一个子容器
res1: List[Int] = List(1, 2, 3)

scala> ged.next                               // 第二个子容器，里面只剩下两个元素
res2: List[Int] = List(4, 5)

scala> ged.hasNext                            // 迭代器已经遍历完了
res3: Boolean = false

scala> val sl = xs.sliding(3)                 // 滑动拆分为大小为3个子容器
sl: Iterator[List[Int]] = non-empty iterator

scala> sl.next                                // 第一个子容器
res4: List[Int] = List(1, 2, 3)

scala> sl.next                                // 第二个子容器
res5: List[Int] = List(2, 3, 4)

scala> sl.next                                // 第三个子容器
res6: List[Int] = List(3, 4, 5)

scala> sl.hasNext                             // 迭代器已经遍历完了
res7: Boolean = false
```

### 2.4.6 函数式编程实例

```scala
// WordCount.scala

// 导入需要的类
import java.io.File
import scala.io.Source
import collection.mutable.Map

object WordCount {
  def main(args: Array[String]) {
    // 建立一个 File 对象，设 ~/Code/ 下有目录 Books/ ，其中包含若干英文小说
    val dirfile = new File("~/Code/Books/")
    // 调用 File 对象的 listFile() 方法，得到其中所有文件对象构成的数组
    // files 类型为 Array[java.io.File]
    val files = dirfile.listFiles
    // 建立一个可变的空的映射（Map）对象 results ，保存统计结果
    val results = Map.empty[String, Int]
    // 通过 for 循环对文件对象进行循环，分别处理各个文件
    for(file <- files) {
      // 从 File 对象建立 Source 对象，方便文件的读取
      val data = Source.fromFile(file)
        // getLines() 方法返回文件隔行构成的迭代器对象，类型为 Iterator[String]
        val strs = data.getLines.flatMap{s => s.split(" ")}
        // 对上述的字符串迭代器进行遍历
        strs foreach { word =>
          // 如果这个单词之前统计过，则计数器自增
          if (results.contains(word))
            results(word) += 1
          else
            // 以前没有统计过，则创建新计数器
            results(word) = 1
        }
    }
    // 对 Map 对象 results 进行遍历，输出统计结果
    results foreach{
      case (k,v) => println(s"$k: $v")
    }
  }
}
```

```shell
dragon1573:Code/ $ mkdir -v Books/
mkdir: 已创建目录 'Books/'
dragon1573:Code/ $ cd Books/
dragon1573:Books/ $ ll
总用量 564K
-rw-rw-r-- 1 dragon1573 dragon1573 562K 2月  18  2012 'The Poems of Goethe - Johann Wolfgang Von Goethe.txt'
dragon1573:Books/ $ mv -v The\ Poems\ of\ Goethe\ -\ Johann\ Wolfgang\ Von\ Goethe.txt The_Poems_of_Goethe.txt
renamed 'The Poems of Goethe - Johann Wolfgang Von Goethe.txt' -> 'The_Poems_of_Goethe.txt'

dragon1573:Code/ $ scalac WordCount.scala && scala -classpath . WordCount | head -n 10
save!: 1
passion,: 1
1767.-----THIRD: 1
arts: 1
peace!My: 1
easilyBlooming: 1
MILL'S: 2
sounding: 2
pool,And: 1
actions.Nothing: 1
```

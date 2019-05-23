+++
title = "Javascript Date 对象"
description = "JavaScript Date 对象的常用功能及get到的小技巧。"
tags = ["前端", "Javascript"]
date = "2019-05-23"
location = "JiNan, CN"
type = "post"
+++

参考文献：[MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Date)

> 常用方法

#### 语法

**new Date()：** 返回一个 Date 对象<br>
**new Date(value)：**<br>
**new Date(dateString)：**<br>
**new Date(year, monthIndex [, day [, hours [, minutes [, seconds [, milliseconds]]]]])：**<br>

**Date() :** 以函数形式直接调用 Date()，返回一个字符串

![调用图片](/img/0522-ss-func1.png)

##### new Date() 参数

**(value)：** 一个整数值，表示自1970年1月1日00:00:00 UTC（the Unix epoch）以来的毫秒数。<br>

**(dateString)：** 表示日期的字符串值。<br>

**(year, monthIndex [, day [, hours [, minutes [, seconds [, milliseconds]]]]])：**<br>

year：表示年份的整数值。

monthIndex：表示月份的整数值，从 0（1月）到 11（12月）。

day：表示一个月中的第几天的整数值，从1开始。

hours：小时数的整数值 (24小时制)。

minutes：时间中分钟部分的整数值。

seconds：时间中的秒部分的整数值。

milliseconds：时间的毫秒部分的整数值。

#### 方法

**Date.now()：** 返回自 1970-1-1 00:00:00  UTC（世界标准时间）至今所经过的毫秒数。

**Date.parse()：** 解析一个表示日期的字符串，并返回从 1970-1-1 00:00:00 所经过的毫秒数。

**Date.UTC()：** 接受和构造函数最长形式的参数相同的参数（从2到7），并返回从 1970-01-01 00:00:00 UTC 开始所经过的毫秒数。

> 使用场景

[示例1原文](http://www.alloyteam.com/2016/05/date-object/)
[示例2原文](https://www.jianshu.com/p/b4d058518575)

* 如果提供了至少两个参数，其余的参数均会默认设置为 1 或者 0。

* 如果参数是负数，则向前推进相应的时间。

* new Date(year, month, 0) 可以获取到上个月最后一天。

获取一个月有多少天

1. Date 传参下一个月的数字，第三个参数传 0。 ❤️

```javascript
var date = new Date(2019, 5, 0)
console.log(data.getDate())
```

2. Date 传参下一个月的数字，第三个参数传 1，减去 1 小时再获取日期。

```javascript
const date = new Date(2019, month + 1, 1)
console(date.setHours(date.getHours() - 1).getDate())
```

第一种相对来说比较简单。😆

![调用图片](/img/0522-ss-tip1.jpg)

> 感谢各位大佬的分享🤣
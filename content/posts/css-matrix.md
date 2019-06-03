+++
title = "CSS Tranform 的 Matrix函数"
description = "CSS Tranform 的 Matrix函数"
tags = ["前端", "CSS"]
date = "2019-05-29"
location = "JiNan, CN"
type = "post"
+++

插播一句：`translate` 的百分比是相对于自身的宽高计算的。

插播2：计算角度值 eg：已知 sin(a) = 1，求 a？。 a = Math.asin(1) * 180 / Math.PI



这也是关于优化 js 代码衍生出来的内容，过程是这样的。

1. 文章里说 Array.from 代替 Array.prototype.slice.call(arrayLike)，😳Array.prototype.slice.call(arrayLike) 是不是截取数组的嘛，查了一下文档 [MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/slice#Array-like) ，原来将这个方法绑定到类数组对象/集合上，就可以转化为一个数组。过程中，看到了这篇[博客](https://www.cnblogs.com/ariel-zhang/p/7288455.html)，大佬是真的🐂🍺，里边就写到了计算用 window.getComputedStyle(dom, 伪类) 获取值，本来我是忽略过去的，但是，好奇心让我测试了一下。。得到了一个这个东西。

![返回值图片](/img/0529-cm-eg1.jpg)

这是啥？我不认识啊？？还是乖乖的学一下吧。

于是学习了 [张鑫旭前辈的文章](https://www.zhangxinxu.com/wordpress/2012/06/css3-transform-matrix-%E7%9F%A9%E9%98%B5/)，这是一个矩阵，是transform变换的基础。我们可以根据这个矩阵里面的值推算出，transform 属性的值。

其格式为：Matrix(a, b, c, d, e, f) 具体的介绍请直接看前辈文章的第五节。

借前辈图，translate & scale 的转换公式如下。 ：

![转换公式图片](http://image.zhangxinxu.com/image/blog/201206/css-transforms-matrix5.gif)

* translate 值的计算。
    
  + x, y ：表示转换元素的所有坐标（变量）矩阵偏移元素的中心点。
  + ax+cy+e ：变换后的x坐标
  + bx+dy+f ：变换后的y坐标

2. scale 值的计算。

`matrix(s, 0, 0, s, 0, 0);` s 即为 scale 的值。

3. rotate 值的计算。

方法及参数

`matrix(cosθ,sinθ,-sinθ,cosθ,0,0)`

对应公式

```js
x' = x * cosθ - y * sinθ + 0 = x * cosθ - y * sinθ
y' = x * sinθ + y * cosθ + 0 = x * sinθ + y * cosθ
```

4. skew 值的计算。

方法及参数

`matrix(1,tan(θy),tan(θx),1,0,0)`

对应公式

```js
x' = x + y * tan(θx) + 0 = x + y * tan(θx) 
y' = x * tan(θy) + y + 0 = x * tan(θy) + y
```

目前看到第七部分，关于 `Matrix` 的使用，内容镜像。莫的全看完。 --20190529

时光匆匆如流水，太快了，五月快结束了。

> 感谢前辈👏🏻
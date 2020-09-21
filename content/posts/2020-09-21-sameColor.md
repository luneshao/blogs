---
title: "用数学计算同色系配色"
description: "分享同色系配色文章。"
tags: [颜色]
date: 2020-09-21T09:24:34+08:00
type: "post"
author: "luneShao"
featured_image: "/img/cover.jpg"
draft: false
---
本片重点是安利一篇文章，用数学计算出同色系的配色，巨赞！

先敬出地址 [用理性与数学，推导产品色彩系统](http://www.woshipm.com/pd/3460402.html)

#### 原由
最近用 uniapp 在做小程序项目，emmm，我以前从来没用过啊喂 #-# 总之，就那么上手了，然后还做到第一个版本已经可以跑通流程了，虽然很粗制滥造。

项目要同时复用给b端和c端，给的时间短，第一版没有考虑周全。现在已经重构了，用 cli 重新修改框架，为了以后版本更新。考虑用 nodejs 写 `pages.json` 文件，节省人力。api区分就用 `.env` 文件，不同的配置，运行不同的配置文件。

项目用的 uview 框架，也有设计图，也只有设计图。emmm，没有给出一套色卡。我们改了 uview 的主色，但是主色对应的邻近色不是自动计算，而是死值，所以紫色按钮点击下去的颜色是深蓝色。啊。。。我忍不了。就搜了一下相关文章，就是上面的那篇文章，把对应的颜色修改了。

还参考了阿里的计算方法。 [antv--colorPalette.less](https://github.com/vueComponent/ant-design-vue/blob/master/components/style/color/colorPalette.less)

以上。

如果不对，请多指教，十分感谢。

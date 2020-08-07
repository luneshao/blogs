---
title: "网页的 Copyright 及备案信息该如何书写"
description: "网页的 Copyright 及备案信息书写标准。"
tags: ['前端']
date: 2020-07-16T12:16:22+08:00
type: "post"
author: "luneShao"
draft: false
---
## copyright 格式

[symbol] [date] [author's name] [statement of rights]

### Copyright - 标记

> The universally accepted symbol for a copyright is the letter C in a circle: ©. You can also use the word "copyright". 

版权的通用符号是一个圆圈中的字母C：©。 您也可以使用“copyright”一词。这个标记需要放在版权标识的最前方。

### copyright - 日期

> For the copyright date, you'll want to use only a year or years. Months or days are not used.

您只需要写一年或年份范围，不需要写月、日。

#### 一年或年份范围

> If you keep a mix of old and new content in your copyrighted medium, your copyright date may be a range rather than a single year. 

>  Say, for example, you create a website and the overall content is from 2015 and unchanged. You also may have a blog post or image from an earlier year that you keep up on your website. Your copyright date will be 2015 - "current year."

> However, when emails are sent out, they only have one date - the year they're sent during. That's because the email itself and the information in it is put together and sent out in that year:

> Depending on the nature of your material, your date can be a range or a single year.

如果您在受版权保护的介质中混合了新旧内容，则您的版权日期可能是一个范围，而不是一年。

例如，您创建了一个网站，其总体内容是从2015年开始的并且未改动。可能还有一些博客或图片在您的网站上，您的版权日期为 2015-“当前年份”

发送邮件时，只有一个日期-当前日期。因为邮件及其发送内容在当年一起发送。

根据内容的性质，您的日期可以是一年或范围。

作品**初次公开发表的年份**；年份位置写网站**创建至今的年份**。

### copyright - 作者名称

> The copyright author's name can be the name of an individual, multiple individuals, an organization's name, or a business/corporate name, so long as it identifies who holds the copyright on the material.

> This helps people identify you or your business and shows clear and specific ownership of the material:

版权作者的名字可以是一个人，多个人的名字，一个组织的名字或一个企业/公司的名字，只要它能标识谁拥有该内容的版权。

这可以帮助人们识别您或您的公司，并清楚明确地说明的内容所有权

如果是个人网站，也可以用你自己的名称。拼音的写法是你的名字的首字母，后面跟你的姓的全拼，首字母大写。

### copyright - 权利声明

> The "statement of rights" is where you can let people know what rights you're holding onto with your copyright.

> There are 3 main types of rights most copyright notices will maintain:

> 1.All Rights Reserved. You keep all rights to your material.

> This is by far the most commonly used and seen statement of rights in copyrighted materials.

> 2.Some Rights Reserved. Seen in Creative Commons licensing.

> may allow use of your materials under certain circumstances, like only with full attribute to you, and no alteration can be done to your original material.

> 3.No Rights Reserved. Sometimes you'll want to declare ownership of something, but not make that restrictive for the rest of the world.

> erestingly, the famous "I <3 NY" logo was designed by Milton Glaser in 1977 and he kept no personal copyright on the design.

在“权利声明”中，您可以让人们知道您所拥有的版权拥有什么权利。

大多数版权声明将保留3种主要权利：

1.**All Rights Reserved.**您将保留内容的所有权限。

这是迄今为止版权材料中最常用和最常见的权利声明。

2.**Some Rights Reserved.**在Creative Commons许可中查看

库存照片是这种权利保留的常见示例。

3.**No Rights Reserved.**有时，您可能想声明某物的所有权，但不希望对世界其他地区构成限制。

令人着迷的是，著名的“I <3 NY”徽标是由Milton Glaser在1977年设计的，他对该设计没有任何个人版权。

可能会允许在某些情况下使用您的资料，例如仅具有您的全部财产，并且不能对原始资料进行任何更改。

库存照片是这种权利保留的常见示例。

[以上内容摘自此文](https://www.termsfeed.com/blog/sample-copyright-notices/)

设公司名称是Apple Inc.

#### 示例1：年份位置一直显示当前年份（假设当前年份是2018）
- Copyright © 2018 Apple Inc. All rights reserved.

- © 2018 Apple Inc. All rights reserved.

- © 2018 Apple Inc. 版权所有

- Copyright © 2018 Apple Inc.

- © 2018 Apple Inc.

- Apple Inc. © 2018

#### 示例2：年份位置显示网站创建至今的年份（假设当前年份是2018）
- Copyright © 1996-2018 Apple Inc. All rights reserved.

- © 1996-2018 Apple Inc. 拥有所有版权

#### 示例3：当然也有一些特殊的版权声明
- 版权所有：中华人民共和国中央人民政府

- 工业和信息化部 版权所有

- （没有版权信息。例如：FBI CIA）

- （也有一些内容比较杂的网站，版权信息会以其它形式展示）

[示例内容摘自此文](https://blog.csdn.net/weixin_42570427/article/details/85265589)

#### ©符号的显示
```html
&#169;
<!-- 或 -->
&copy;
```

#### javascript方法输出当前年份
```js
<script type="text/javascript">
var d = new Date()
document.write(d.getFullYear())
</script>
```

[代码内容摘自此文](https://10.1pxeye.com/footer-copyright/)

## 备案相关

> 根据工信部要求：已通过备案的用户，在网站开通时应在网站首页底部放置正确的备案号，并链接到工信部网址：[http://beian.miit.gov.cn/](http://beian.miit.gov.cn/)，供公众查询核对。

### 一.相关法律法规：

  1.根据《非经营性互联网信息服务备案管理办法》第十三条规定：非经营性互联网信息服务提供者应当在其网站开通时在主页底部的中央位置标明其备案编号，并在备案编号下方按要求链接信息产业部备案管理系统网址，供公众查询核对。

  2.根据《非经营性互联网信息服务备案管理办法》第二十五条规定：违反本办法第十三条的规定的，由住所所在地省通信管理局责令改正，并处5千元以上1万元以下罚款；

### 二、如何在网页上放置备案号：
该操作一般情况下需要您网站制作人员协助您操作。

请使用编辑器在网站首页文件的底部加入这样的html代码：

```html
<a href="http://beian.miit.gov.cn/" target="_blank">蜀ICP备XXXXX号</a> 
<!-- 请将 【 蜀ICP备XXXXX号 】 替换为您自己的备案号 -->
```

一般常见的首页文件有：
```txt
index.htm；index.html；index.asp；default.asp；index.php等
```

[如何在网页上放置备案号摘自此文](https://beian.vhostgo.com/faq/show.asp?c3lzaWQ9OTQ=)

### 三、两个网站怎么公用一个备案号

一个备案号能同时分配两个网站吗？不能，一个网站是一个备案号，每个网站的网页下方都应展示其在工信部取得的备案号。**如果一家公司旗下有多个网站，可使用同一个备案号的不同编号，但不能完全一样。**

比如说，一个公司主体获得的备案号是“京ICP备18008018号”，他们公司拥有多个网站A、B、C、D等等，那么不同的网站就可以使用同一备案号的不同编号。比如，A网站使用 __*京ICP备18008018号-1*__，B网站使用 京ICP备18008018号-2，C网站使用 京ICP备18008018号-3等等，依次类推。

后边的数字编号 1、2、3、4 等分别代表了同一公司主体下的几个不同的网站。几个网站分别对应几个不同的域名。两个网站的备案号不会完全相同。

[两个网站怎么公用一个备案号内容摘自此文](http://www.west.cn/docs/62651.html)

## 相关内容扩展

[备案查询工具](http://icp.chinaz.com/)
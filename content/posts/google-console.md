---
title: "如何让自己网站被google收录？"
author: "luneshao"
cover: "/img/cover.jpg"
tags: ["seo", "前端"]
date: 2019-06-13T10:12:32+08:00
description: "介绍了如何让谷歌收录网站，以及网站seo的方法。（附google的原文链接）"
draft: false
---
> 引言

最近两个月一直在鼓捣这个博客，一直也只是用网址访问。最近，尝试在搜索引擎上搜索我博客的url、内容、标题，通通搜不到？？？然后，看了[搜索引擎优化 (SEO) 新手指南](https://support.google.com/webmasters/answer/7451184)。在 google console 上配置了站点地图并进行[网址检查](https://support.google.com/webmasters/answer/9012289#url_can_be_on_google_issues)（查看资源中某个网址的 Google 索引信息）。

* 我的检查结果： _此网址未显示在 Google 搜索结果中_ 。（此时已经可以在 google 中检索到 url 了。）

* 点击查看详情 => return ( 已抓取 - 尚未编入索引, 状态：已排除。 ) 查看[状态报告指南](https://support.google.com/webmasters/answer/7440203#discovered__unclear_status)去一条一条的排查。我的结果对应的解释：`Google 已抓取相应网页，但尚未将其编入索引。日后，该网页可能会被编入索引，也可能不会被编入索引；无论如何，您都无需重新提交该网址以供抓取。` 那就只能静静的等待了。（目前已经搜到了。）

下面主要是摘要梳理了搜索引擎优化 (SEO) 新手指南一些相关知识点，帮助理解。

官方文档先祭一下 [搜索引擎优化 (SEO) 新手指南](https://support.google.com/webmasters/answer/7451184)

## 1.术语

> [Google 搜索的工作方式](https://support.google.com/webmasters/answer/70897)

  Google 按照以下三个基本步骤来生成基于网页的结果：

  * 抓取
  * 编入索引
  * 呈现（和排名）

* **索引** - Google 会将所知道的全部网页存储在其“索引”中。每个网页的索引条目都会描述该网页的内容和位置（网址）。编入索引是指当 Google 抓取、读取网页并将其添加到索引的过程。例如：Google 今天已将我网站上的几个网页编入索引。

* **抓取** - 寻找新网页或更新后的网页的过程。Google 会通过跟踪链接、读取站点地图或其他各种方式来发现网址。Google 通过抓取网页来寻找新增网页，然后（在适当的时候）将网页编入索引。

* **抓取工具** - 从网络中抓取（提取）网页并将网页编入索引的自动化软件。

* **Googlebot** - Google 抓取工具的通用名称。Googlebot 会持续不断地抓取网页。

* **SEO** - 搜索引擎优化：使您的网站更易于搜索引擎抓取和编入索引的过程；也可指从事搜索引擎优化的人员的职位名称，例如：我们刚刚聘请了新的 SEO 来提升我们在网络上的曝光度。

## 2.测试搜索结果

在 google 中搜索 `site:example.com`，尝试是否可以搜索到结果。如果可以搜索到，表明你的网站已经在索引中。搜不到，就继续向下看吧:)

## 3.如何让 Google 收录您的内容

最好的办法是提交[站点地图](https://support.google.com/webmasters/answer/156184?hl=zh-Hans&ref_topic=4581190) 。站点地图是网站上的一种文件，可告知搜索引擎网站上新增了网页或有更新的网页。

* 这里，我的博客本来是在 google 搜索不到的，hugo 会在 public 文件夹自动生成站点地图。（如果没有使用hugo，[文章](https://support.google.com/webmasters/answer/183668?hl=zh-Hans&ref_topic=4581190)中也提供了一些在线生成站点地图的网址和工具，可以自行生成哟～）此时，需要我们做的就是在 Search Console 工具中，自行配置站点地图的 url，或者将其添加到您的 robots.txt 文件中。然后，在 google 输入 site:luneshao.github.io 就可以搜索到了。一小步进步啊！

## 4.告诉 Google 不应抓取哪些页面

若为非敏感信息，则可以使用 robots.txt 阻止不必要的抓取。

## 5.帮助 Google（和用户）了解您的内容

诸位可以使用这个[免费网站分析工具](http://analyzer.metatags.org/)，分析一下自己的网站 seo 方面是否存在不足。

### 5.1 创建唯一且准确的网页标题

`<title>` 标记可告诉用户和搜索引擎特定网页的主题是什么。

```html
<title>unique title</title>
```

### 5.2 创建恰当的标题和摘要以在搜索结果中显示

如果您的文档会显示在搜索结果页中，则 title 标记的内容可能会显示在相应结果的第一行

### 5.3 使用“description”元标记

网页的说明元标记可让 Google 和其他搜索引擎了解该网页的大致内容。网页的标题可以是几个词或一个短语，而网页的说明元标记则可以是一两个句子或是一小段话。

#### 说明元标记有哪些好处？

说明元标记很重要，因为 Google 可能会将其用作您网页的摘要。为每个网页添加说明元标记从来都是非常好的做法，以防 Google 找不到要在摘要中使用的恰当文字。

### 5.4 使用标题标记强调重要文字

按顺序使用多种大小的标题可为您的内容创建层次结构，便于用户浏览文档。

### 5.5 添加结构化数据标记

结构化数据21是可添加到网站页面中的代码，用于向搜索引擎描述内容，以便搜索引擎更好地了解网页上的信息。搜索引擎可以利用这类信息在搜索结果中以有用的（且吸引用户的）方式显示您的内容。这也有助于您吸引到适合您业务的客户。

例如，如果您有一个网店并且标记了一个单独的产品页面，这将帮助我们了解该页面主要显示自行车、自行车价格以及客户评价。我们可能会在相关查询的搜索结果的摘要中显示这些信息。我们将其称之为“富媒体搜索结果”。

* 富媒体搜索结果：Google 搜索结果中的增强型结果，具有额外的视觉效果或互动功能。

<!--more-->

> 相关名词及内容介绍

[meta 标签 robot](https://www.metatags.org/meta_name_robots) ：配置全站或仅首页可以被搜索引擎抓取。

[网络爬虫](https://zh.wikipedia.org/wiki/%E7%B6%B2%E8%B7%AF%E7%88%AC%E8%9F%B2)

> 以上。🕸
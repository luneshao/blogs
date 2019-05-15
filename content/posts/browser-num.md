+++
title = "浏览器易混淆名词整理"
description = "浏览器易混淆名词整理，比如 host、origin、url、uri"
tags = [ "luneS", "web前端" ]
date = "2019-05-13"
location = "JiNan, CN"
type = "post"
+++

> 01\. JS 的 window.location 对象

包含有关文档及当前位置的信息。

[MDN文档地址](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/location)

* `location.origin`: 包含页面来源的域名的标准形式，当前页面的域名 + 端口。
<br>eg: `https://www.baidu.com`

* `location.host`: 当前页面的域名，可能最后带有一个“：”和端口。
<br>eg: www.baidu.com

* `location.hostname`: 当前页面的域名。
<br>eg: www.baidu.com

* `location.protocol`: 当前页面的协议。
<br>eg: https

* `location.assign()`: 加载给定 URL 的内容到这个 Location对象所关联的对象上。

* `location.reload(params)`: 重新加载当前页。params: t/f => 服务器请求资源/缓存。

* `location.replace()`: 用给定的URL替换当前的资源，不会被保存历史。

> 10\. ajax 请求头中的属性

[MDN文档地址](https://developer.mozilla.org/zh-CN/docs/Web/HTTP)

* `Host`: 服务器的域名（对于虚拟主机来说），以及（可选的）服务器监听的TCP端口号。
[相关文章](https://blog.csdn.net/netdxy/article/details/51195560)一个IP可以部署众多网站，分别解析不同的域名，host 指示访问哪个虚拟主机。 

* `Origin`: 请求来自于哪个站点，该字段仅指示服务器名称，并不包含任何路径信息。

* `Referer`: 当前请求页面的来源页面的地址。B -> A, Referer: B.URL
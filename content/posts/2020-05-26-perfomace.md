---
title: '网页加载相关事件梳理'
description: ''
author: 'luneShao'
featured_image: '/img/cover.jpg'
tags: [前端优化]
date: 2020-05-26T09:36:26+08:00
draft: true
---

## 名词解释

- **DOMContentLoaded**
  当初始的 HTML 文档被完全加载和解析完成之后，DOMContentLoaded 事件被触发，而无需等待样式表、图像和子框架的完全加载。另一个不同的事件 load 应该仅用于检测一个完全加载的页面。 这里有一个常见的错误，就是在本应使用 DOMContentLoaded 会更加合适的情况下，却选择使用 load，所以要谨慎。注意：DOMContentLoaded 事件必须等待其所属 script 之前的样式表加载解析完成才会触发。 [from [MDN](https://developer.mozilla.org/zh-CN/docs/Web/Events/DOMContentLoaded)]

- **load**
  当一个资源及其依赖资源已完成加载时，将触发 load 事件。

- **unload**
  当文档或一个子资源正在被卸载时, 触发 unload 事件。
  它在下面两个事件后被触发:
   - 1. beforeunload (可取消默认行为的事件)
   - 2. pagehide

## 参考文献

[Chrome 的 First Paint](http://eux.baidu.com/blog/fe/Chrome%E7%9A%84First%20Paint)
[window.onload 和 DOMContentLoaded 的区别](https://www.jianshu.com/p/1a8a7e698447)

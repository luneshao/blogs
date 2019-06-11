+++
title = "=8 element 对象的拓展"
description = "element 对象的拓展"
tags = ["前端"]
date = "2019-05-28"
location = "JiNan, CN"
type = "post"
+++

### 1. 获取元素的css

* 1.1 `Element.getBoundingClientRect()`

[MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Element/getBoundingClientRect)

返回元素的大小及其相对于视口的位置。

如果你需要获得相对于整个网页左上角定位的属性值，那么只要给top、left属性值加上当前的滚动位置

（通过window.scrollX和window.scrollY），这样就可以获取与当前的滚动位置无关的值。

![getBoundingClientRect图片](/img/0528-ee-gb1.jpg)

* 1.2 `window.getComputedStyle()`

返回另一个包含所有 `css` 属性的对象，该对象应用了样式表并解析了基础计算（只读）。

```js
window.getComputedStyle().getPropertyValue('font') // 获取属性 font 值
```

[MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/getComputedStyle)  [张鑫旭前辈的文章](https://www.zhangxinxu.com/wordpress/2012/05/getcomputedstyle-js-getpropertyvalue-currentstyle/)

_css 安全_([blog](https://blog.mozilla.org/security/2010/03/31/plugging-the-css-history-leak/))

* 1.3 `document.defaultView`

[MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/getComputedStyle#defaultView)

该属性返回当前 `document` 对象所关联的 `window` 对象，如果没有，会返回 `null`。

在许多在线的演示代码中，`getComputedStyle`是通过 `document.defaultView` 对象来调用的。大部分情况下，这是不需要的，因为可以直接通过window对象调用。但有一种情况，你必需要使用 `defaultView`,  那是在firefox3.6上访问子框架内的样式。
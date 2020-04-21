+++
title = "前端属性兼容性整理"
description = "浏览器css、js属性兼容性整理及处理方法。"
tags = [ "luneS", "web前端" ]
date = "2019-05-09"
location = "JiNan, CN"
type = "post"
keywords = "前端,兼容性"
+++

## 1.document 相关

1.1 addEventListen

**兼容写法**：

```javascript
function addEvt(eTarget, eType, eHandle) {
  if (eTarget.addEventListen) {
    eTarget.addEventListen(eType, eHandle)
  } else {
    // ie 浏览器
    if (eTarget.attachEvent) {
      eType = 'on' + eType
      eTarget.attachEvent(eType, eHandle)
    } else {
      eventTarget['on' + eventType] = eventHandler
    }
  }
}
```

1.2 scrollTop()

**兼容写法**：

```javascript
// 因为 0 || undefine => undefined
const st =
  document.pageYOffset.scrollTop ||
  document.documentElement.scrollTop ||
  document.body.scrollTop ||
  0
```

```javascript
// ie6/7/8
1. 没有 doctype 声明的页面：
const st = document.body.scrollTop;

2. 声明 doctype 的页面：
const st = document.documentElement.scrollTop;

// safari
const st = document.pageYOffset;

// chrome、firefox
const st = document.documentElement.scrollTop;
```

## 2.window相关

2.1 window.scrollY

**兼容写法**：

```js
var supportPageOffset = window.pageXOffset !== undefined;
var isCSS1Compat = 
    ((document.compatMode 
    || "") === "CSS1Compat"); 

var x = 
  supportPageOffset ? window.pageXOffset :
  isCSS1Compat ? document.documentElement.scrollLeft :
  document.body.scrollLeft;
var y = 
  supportPageOffset ? window.pageYOffset : 
  isCSS1Compat ? document.documentElement.scrollTop : 
  document.body.scrollTop;
```

为了跨浏览器兼容，请使用 `window.pageYOffset` 代替 `window.scrollY`。另外，旧版本IE（<9）两个属性都不支持，必须使用其他的非标准属性。

> 延伸：

(1) document.compatMode [document.compatMode 博客园](https://www.cnblogs.com/fullhouse/archive/2012/01/17/2324706.html)  [标准模式和非标准模式 简书](https://www.jianshu.com/p/dcab7cde8c04)

我们可以根据 `document.compatMode` 的值来判断文档是否加了标准声明。

![chrome截图](http://ww4.sinaimg.cn/large/006tNc79ly1g3y3jkbsa8j30jm05kq2v.jpg)

`IE` 对盒模型的渲染在 `Standards Mode` 和 `Quirks Mode` 是有很大差别的，在 `Standards Mode` 下对于盒模型的解释和其他的标准浏览器是一样，但在 `Quirks Mode` 模式下则有很大差别，而在不声明 `Doctype`的情况下，`IE `默认又是 `Quirks Mode`。所以为兼容性考虑，我们可能需要获取当前的文档渲染方式。

`document.compatMode` 有两种可能的返回值：

`BackCompat`： 页面不具有 DTD，标准兼容模式关闭，对应非标准模式。

`CSS1Compat`： 页面具有 DTD，标准兼容模式开启，对应标准模式。

(2) document.body & document.documentElement [原文链接 博客园](https://blog.csdn.net/zxf13598202302/article/details/51162637)

页面具有 `DTD`，或者说指定了 `DOCTYPE` 时，使用 `document.documentElement`。

页面不具有 `DTD`，或者说没有指定了 `DOCTYPE`，时，使用 `document.body`。

document.documentElement: 返回文档对象（document）的根元素的只读属性（如HTML文档的 `<html>` 元素）。

document.body：返回当前文档中的 `<body>` 元素或者 `<frameset>` 元素。

## 3.CSS3相关

+++
title = "浏览器属性兼容性整理"
description = "浏览器css、js属性兼容性整理及处理方法。"
tags = [ "luneS", "web前端" ]
date = "2019-05-09"
location = "JiNan, CN"
type = "post"
+++

### Javascript 相关

> 1\. addEventListen

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

> 2\. scrollTop()

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

**兼容写法**：

```javascript
// 因为 0 || undefine => undefined
const st =
  document.pageYOffset.scrollTop ||
  document.documentElement.scrollTop ||
  document.body.scrollTop ||
  0
```

### CSS3

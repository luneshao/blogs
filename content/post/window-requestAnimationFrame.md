+++
title = "window requestAnimationFrame 方法"
description = "window 拓展"
tags = ["前端"]
date = "2019-05-30"
location = "JiNan, CN"
type = "post"
+++
[原文链接 伯乐](http://web.jobbole.com/91578/)  [MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/requestAnimationFrame)

> 概念

告诉浏览器——你希望执行一个动画，并且要求浏览器在下次重绘之前调用指定的回调函数更新动画。该方法需要传入一个**回调函数**作为参数，该回调函数会在浏览器下一次重绘之前执行。

个人理解：**raf** 这个函数可以用来做动画，它需要一个参数，参数的形式是一个**回调函数**，在回调函数里可以写需要执行的动画。

这个回调函数会默认接收一个参数，即执行回调函数时的**时间戳**，回调函数，会在每次浏览器在下次重绘前执行回调函数更新动画，个人认为这样来保证动画的帧率和稳定性。大多数电脑显示器的刷新频率是60Hz，大概相当于每秒钟重绘60次，相当于每帧的执行时间为 16.67ms。

> 特性

* 参数中的回调函数执行次数通常是每秒60次，速度大约为 16.67ms 每帧。

* 当`requestAnimationFrame()`运行在后台标签页或者隐藏的`<iframe>` 里时，requestAnimationFrame() 会被暂停调用。对比 setTimeout ，离开页面依旧会计时，raf 更加节省性能。

* **DOMHighResTimeStamp**指示由 `RequestAnimationFrame()` 排队的回调开始触发的时间。

* 它返回一个整数，表示定时器的编号，这个值可以传递给 `cancelAnimationFrame` 用于取消这个函数的执行。

> 使用方法

```js
window.requestAnimationFrame(callback)

function callback (timeStamp) {
  // 默认接收参数 timeStamp，表示开始执行回调函数的时刻

  // 若你想在浏览器下次重绘之前继续更新下一帧动画，那么回调函数自身必须再次调用window.requestAnimationFrame()
  window.requestAnimationFrame(callback)
}
```

> 避免一帧多次调用

```js
  let ifCurFra = false // 当前帧是否执行
  function cb (timeStamp) {
    if (ifCurFra) return 
    ifCurFra = true
    window.requestAnimationFrame(timeStamp => {
      ifCurFra = false
    })
  }

  window.addEventListener('scroll', cb)
```

> 兼容

[兼容代码](https://www.cnblogs.com/xiaohuochai/p/5777186.html)

```js
if(!window.requestAnimationFrame){
  var lastTime = 0;
  window.requestAnimationFrame = function(callback){
      var currTime = new Date().getTime();
      var timeToCall = Math.max(0,16.7-(currTime - lastTime));
      var id  = window.setTimeout(function(){
          callback(currTime + timeToCall);
      },timeToCall);
      lastTime = currTime + timeToCall;
      return id;
  }
}
```

> example

我测试了一下两种方法实现动画，认为 setTimeout() 和 window.requestAnimationFrame ()， raf 的动画更稳定一些,sto 有时平稳有时抖动。

sto 抖动的原因：假设屏幕每隔16.7ms刷新一次，而setTimeout每隔10ms设置图像向左移动1px， 就会引起动画卡顿。

```js
// 测试文件相关部分代码
  const el = document.querySelector('.box1')
  let start = null
  let ml = 0
  const totalTime = 2000
  
  function ani (timeStamp) {
    if (!start) {
      start = timeStamp
    }

    const progress = timeStamp - start
    // 判断时间差（时间间隔），是否是规定时间
    if (progress < totalTime) {
      el.style.left = `${ml++}px`
      window.requestAnimationFrame(ani)
    }
  }

  window.requestAnimationFrame(ani)
```

附上我的[测试文件](https://codepen.io/LuneShao/project/editor/XMbnnx)

文件中存在一个问题，我的定时器是2s，结束时的时间大部分是 1985ms, 可能因为函数执行的速度是每帧 16.7ms，1985 + 16.7 > 2000 最后一次的判断就是 false 了，就没有执行2000ms，在我的例子中实际上就少加了 1px。还请各位大佬多多指教。

> 以上。🧐
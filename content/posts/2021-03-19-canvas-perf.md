---
title: "canvas优化"
description: ""
tags: ['canvas', 'perf']
date: 2021-03-19T15:52:01+08:00
type: "post"
author: "luneShao"
featured_image: "/img/cover.jpg"
draft: false
---

## 写在前头
首先迫于 GitHub 突然就推不上去了，然后给电脑装了一只小猫，就开始呼吸自由的空气了。搜问题的时候发现了一个不错的网站，看到一篇canvas优化的文章，我最近也有写一个canvas的动画，一直觉得需要优化，就看了下文章今天优化了下。怕以后忘了（一定会忘的）就记录下来。

## 正文
我在文章里主要学到的就是缓存。

我的设计图是两个圆环向不同方向转，还有一些不动的圆环。

之前已经把不动的圆环和动的圆环分别放到两个画布里分开绘制了。转动的地方我每次计算一个旋转角度，重新绘制圆环。😳 （我觉得这个地方处理的不好）看文章中优化的思路是 __内容只绘制一次，利用另一个画布 drawImage() 这个 API 在不同的位置用多次绘制__。

我就改了之前每次动画都重新绘制的这个地方，改为只绘制一次，然后加一层中间画布，旋转中间画布，把内容画到中间画布上之后，再把中间画布画到目标画布中。

表达能力欠缺，每讲明白还请见谅。

## 代码
```html
<!-- index.html -->
<!-- ... -->
<canvas width="236px" height="236px" id="feverMonth"></canvas>
<!-- ... -->
```
```js
// index.js
const lineCounts = 120 // 外层圆环线的个数
const _canvas = document.querySelector('#feverMonth')
const _ctx = _canvas.getContext('2d')
const center = _canvas.height / 2 // 中心
const height = _canvas.height
const width = _canvas.width
let rotate = 0 // 旋转角度

const RotateCircle = function () {
  this.rotateDeg = 0
  this.center = center
  // 内容缓存画布
  this.cacheCanvas = document.createElement('canvas')
  this.cacheCanvas.width = width
  this.cacheCanvas.height = height
  this.cacheCtx = this.cacheCanvas.getContext('2d')
  
  // 中间画布
  this.cachePaintCanvas = document.createElement('canvas')
  this.cachePaintCanvas.width = width
  this.cachePaintCanvas.height = height
  this.cachePaintCtx = this.cachePaintCanvas.getContext('2d')
  this.cachePaintCtx.translate(center, center)
}

RotateCircle.prototype = {
  // 绘制外圆
  outCircleShow () {
    this.cacheCtx.strokeStyle = '#4ea5ff'
    for (let i = 0; i < lineCounts; ++i) {
      this.cacheCtx.save()
      this.cacheCtx.beginPath()
      this.cacheCtx.translate(center, center)
      this.cacheCtx.lineWidth = 1

      this.cacheCtx.rotate(+((Math.PI * 2) / lineCounts * i + rotate).toFixed(2))
      this.cacheCtx.moveTo(center, 0)
      this.cacheCtx.lineTo(100, 0)

      this.cacheCtx.rotate((Math.PI * 2) / lineCounts * i + rotate)
      this.cacheCtx.closePath()
      this.cacheCtx.stroke()
      this.cacheCtx.restore()
    }
  },
  // 绘制半圆
  simicircleShow () {
    this.cacheCtx.beginPath()
    this.cacheCtx.strokeStyle = '#71b8ff'
    this.cacheCtx.lineWidth = 20
    this.cacheCtx.arc(center, center, 60, -rotate, Math.PI - rotate)
    this.cacheCtx.stroke()
    this.cacheCtx.closePath()
  },
  // 旋转
  rotate (_rotate) {
    this.rotateDeg = _rotate
    this.cachePaintCtx.clearRect(-_canvas.height, -_canvas.height, _canvas.height * 2, _canvas.height * 2)
    this.cachePaintCtx.save()
    this.cachePaintCtx.rotate(this.rotateDeg)
    this.cachePaintCtx.drawImage(this.cacheCanvas, -center, -center)
    this.cachePaintCtx.restore()
    this.paint()
  },
  // 绘制
  paint () {
    _ctx.drawImage(this.cachePaintCanvas, 0, 0)
  }
}

// 外圆初始化
const outCircle = new RotateCircle()
outCircle.outCircleShow()

// 半圆初始化
const simicircle = new RotateCircle()
simicircle.simicircleShow()

// 动画
function draw() {
  if (rotate >= 360) {
    rotate = 0
  }
  rotate = +(rotate + 0.01).toFixed(2)
  _ctx.clearRect(0, 0, _canvas.height + 2, _canvas.height + 2)
  // 旋转
  outCircle.rotate(rotate)
  simicircle.rotate(-rotate)
  window.requestAnimationFrame(draw)
}
draw()
```

## 参考文章
[原文链接](https://chinese.freecodecamp.org/news/canvas-animation-performance-optimization-practice/)

## 源码
[GitHub](https://github.com/luneShaoGM/Train/blob/main/rotateCircle.html)


以上，感谢。 ^_^
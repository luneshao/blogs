---
title: "边框追随鼠标"
description: "写了一个简单的demo,实现背景及边框的样式随鼠标的移动改变。"
author: "luneShao"
cover: "/img/cover.jpg"
tags: ["js"]
date: 2020-03-19T10:36:26+08:00
draft: false
---

### feature

- 给盒子设置了图片边框
- 实现背景色角度追随鼠标移动改变

### css 属性
- border-image-slice：通过 border-image-source 引用边框图片后，border-image-slice属性会将图片分割为9个区域：四个角，四个边（edges）以及中心区域。四条切片线，从它们各自的侧面设置给定距离，控制区域的大小。

<div class="test"></div>
<script>
  var t = document.querySelector('.test')
  t.onmousemove = function (e) {
    let r = (e.screenX + e.screenY) % 360
    
    <!-- t.style.borderImage = `linear-gradient(${r}deg, #ffeead, #96ceb4) 2` -->
    t.style.backgroundImage = `linear-gradient(${360 - r}deg, #ffeead, #96ceb4)`
  }
</script>

### code
```html
<!-- ... -->

<style>
.test {
  width: 100px;
  height: 100px;
  padding: 20px;
  border: dashed 70px;
  border-image: url(https://tse3-mm.cn.bing.net/th/id/OIP.GL_hNcihF8Q0N-HDKWzBngHaFj?w=288&h=216&c=7&o=5&dpr=2&pid=1.7);
  border-image-slice: 33% 33%; // 修改试试
  border-radius: 50%;
  border-image-width: 90px; // 修改试试
  background: linear-gradient(45deg, transparent, rgb(150, 206, 180)) repeat center
    center / 50px 50px;
}
</style>

<!-- ... -->

<div class="test"></div>
<script>
  var t = document.querySelector('.test')
  t.onmousemove = function(e) {
    let r = ((e.screenX + e.screenY) % 360 <
    !--t.style.borderImage = `linear-gradient(${r}deg, #ffeead, #96ceb4) 2`-- >
    t.style.backgroundImage = `linear-gradient(${360 -
      r}deg, #ffeead, #96ceb4)`)
  }
</script>
```

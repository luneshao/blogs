+++
title = "CSS 的 clip 属性"
description = "介绍CSS的clip属性，以及使用案例。"
tags = ["前端", "CSS"]
date = "2019-05-23"
location = "JiNan, CN"
type = "post"
+++

参考文献：[MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/clip)&emsp;
[张鑫旭前辈的文章](https://www.zhangxinxu.com/wordpress/2012/07/codepen-jsfiddle/)

> 介绍

#### 定义

clip 属性剪裁元素，属性仅应用于**绝对定位**元素，例如 `position: absolute` 或 `position: fixed`。

#### 属性值

* auto：不剪裁。

* `<shape>`：截取的形状，值的表示方式 `rect(<top>, <right>, <bottom>, <left>) 或 rect(<top> <right> <bottom> <left>)`。

top & bottom 设置的是距离元素上边距的距离。left & right 设置的是距离元素左边距的距离。

##### 左侧使用了clip属性，左右容器和图片的尺寸都是200 * 200。

<p style="text-align: center">
<img src="/img/0522-css-clip1.png" style="height: 200px; width: 400px" />
</p>

top、right、bottom、left 的值可以是 *数值* 或 *auto* 。

tips：**auto**表示 *If any side's value is auto, the element is clipped to that side's inside border edge.* （文档）
截取到元素该边的内边界。

* inherit：从父元素继承 clip 属性的值，不兼容 IE6。

> 实例

看到 [immutable官网](https://immutable-js.github.io/immutable-js/) header 部分的划动效果很棒，有一种拉开序幕的感jio。

然后，研究了一下这个属性。这个功能的实现就是依赖的 clip 属性，使得可以剪裁 `position： fixed` 的子元素。

[神秘链接🤪](https://codepen.io/LuneShao/project/editor/XMbnnx)

下面还是祭一下自己demo相关实现代码，去掉了一些修饰的属性。

```html
<!-- html部分 -->
<div class="greet">基础内容</div>
<div class="top-wrap1">
  <div class="top-wrap2">
    <div class="top">滚动后会消失的内容</div>
  </div>
</div>
```

```css
/* css部分 */
.greet {
  position: fixed;
  top: 0;
  width: 100%;
}
.top-wrap1{
  position: relative;
  top: 0;
  width: 100%;
  background-color: #F6B352;
  overflow: hidden;
  z-index: 1; /* 这个元素的堆叠顺序高于另一个，向上滚动的时候，默认的header就娓娓道来。 */
}
.top-wrap2{
  position: absolute;
  top: 0;
  width: 100%;
  clip: rect(0, auto, auto, 0); /* 这里的 auto 是指截取到边的内边界位置。 */
}
.top {
  position: fixed;
  top: 0;
  width: 100%;
  background-color: #fc6;
}
```

> 以上。感谢大佬的分享。🤣
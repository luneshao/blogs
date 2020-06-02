---
title: '网页加载相关事件梳理'
description: '网页加载相关事件梳理相关名词解释'
author: 'luneShao'
tags: [前端优化]
# featured_image: /img/cover.jpg
date: 2020-05-26T09:36:26+08:00
type: 'posts'
draft: false
---
## 浏览器的页面的加载流程 [from [Chrome的First Paint](http://eux.baidu.com/blog/fe/Chrome%E7%9A%84First%20Paint)]

1. 浏览器输入 url，浏览器发送请求到服务器，服务器将请求的HTML返回给浏览器。
2. 浏览器下载完成 HTML(Finish Loading HTML) 之后，便开始从上到下解析。
3. 解析的过程中碰到 css 和 js 外链（其实 HTML 的下载也是这个流程）都会执行以下过程：
  1. Send Request: 表示给这个外链对应的服务器发送请求
  2. Receive Response: 表示接收响应，这里是表示告诉浏览器可以开始从网络接收数据了
  3. Receive Data: 表示开始接收数据
  4. Finish Loading: 表示已经完成下载数据。
  5. Parse Stylesheet/Evaluate（默认情况下 js 下载完成之后执行 Evaluate，css 下载完成后会进行Parse Stylesheet）
4. 所有的 css 下载完成后 Parse Stylesheet 然后开始构建 CSSOM
5. DOM（文档对象模型）和 CSSOM（CSS对象模型）会合并生成一个渲染树(Render Tree)
6. 根据渲染树的内容计算出各个节点在网页中的大小和位置（Layout，可以理解为“刻章”）
7. 根据 Layout 绘制内容在浏览器上（Paint，可以理解为“盖章”）。

![浏览器的页面的加载流程](/img/20200527-perfomance-fp.jpg)


## 页面加载相关事件名词解释
![页面加载相关事件](/img/2020-05-26-performance-load.jpg)[图片 from [Chrome的First Paint](http://eux.baidu.com/blog/fe/Chrome%E7%9A%84First%20Paint)]

- **FP(First Paint)**

First paint，直译过来的意思就是浏览器第一次渲染(paint)，在 First paint 之前是白屏，在这个时间点之后用户就能看到（部分）页面内容。[from [Chrome的First Paint](http://eux.baidu.com/blog/fe/Chrome%E7%9A%84First%20Paint)]

First Paint，是 Paint Timing API 的一部分，是页面导航与浏览器将该网页的第一个像素渲染到屏幕上所用的中间时，渲染是任何与输入网页导航前的屏幕上的内容不同的内容。[from [MDN](https://developer.mozilla.org/zh-CN/docs/Glossary/First_paint)]

浏览器会提前渲染 body 中第一个脚本前的内容（我们就把body中的第一个外链脚本叫做【第一脚本】吧），并且**第一脚本**还会在FP之后才执行。即在 CSSOM 准备就绪之后，浏览器会提前渲染第一脚本前的内容。

### First Paint 的加载流程
1. 所有的CSS加载完成
2. Parse Stylesheet：构建出 CSSOM
3. Recalculate Style：重新计算样式，确定 DOM 元素的样式规则（定规则）
4. Layout：根据计算结果进行布局，确定元素的大小和位置（刻章）
5. Update Layer Tree：更新渲染层树
6. Paint：绘制，根据前面的 Layer Tree 绘制页面（位置、大小、颜色、边框、阴影等）（盖章）
7. Composite Layers：形成层，浏览器按照合理的顺序合并成一个图层然后输出到屏幕（给别人看）

### First Paint 小结
FP发生在 body 中第一个 script 脚本之前的 CSS 解析和 JS 执行完成之后。换句话说就是第一脚本之前的 DOM 和 CSSOM 准备就绪之后，便会着手渲染第一脚本前的内容。

如果第一脚本前的 JS 和 CSS 加载完了，body 中的脚本还未下载完成，那么浏览器就会利用构建好的局部 CSSOM 和 DOM 提前渲染第一脚本前的内容（触发FP）；如果第一脚本前的 JS 和 CSS 都还没下载完成，body中的脚本就已经下载完了，那么浏览器就会在所有 JS 脚本都执行完之后才触发FP。

### 建议
1. CSS放在head中，JS放在</body>前（如果在head必须放JS，也尽量减少他的大小，把大JS文件放</body>前）。
2. 减小head中CSS和JS大小（gzip了解一下？)
3. 优化head中的JS和CSS外链的网络情况，减少Stalled、TTFB和Content Download的时间。
4. 在第一脚本前使用骨架图，可以减少用户的白屏感知时间（对于使用JS插入模板来渲染的框架，建议将骨架图的路由生成逻辑单独提出来）

- **DOMContentLoaded**

  当初始的 HTML 文档（包括CSS、JS）被完全加载和解析完成之后，DOMContentLoaded 事件被触发，而无需等待样式表、图像和子框架的完全加载。（即 HTML -> DOM的过程完成 ）
  另一个不同的事件 load 应该仅用于检测一个完全加载的页面。 这里有一个常见的错误，就是在本应使用 DOMContentLoaded 会更加合适的情况下，却选择使用 load，所以要谨慎。注意：DOMContentLoaded 事件必须等待其所属 script 之前的样式表加载解析完成才会触发。 [from [MDN](https://developer.mozilla.org/zh-CN/docs/Web/Events/DOMContentLoaded)]

- **load**

  当一个资源及其依赖资源已完成加载时，将触发 load 事件。[from [MDN](https://developer.mozilla.org/zh-CN/docs/Web/Events/load)]

### DOMContentLoaded 与 load 对比小结

简而言之，二者触发时间的区别在于：DOMContentLoaded 在 HTML 文档被解析完成之后触发，而 load 是在 HTML 所有相关资源被加载完成后触发。[from [load/domContentLoaded 事件、异步/延迟 Js 与 DOM 解析](https://www.cnblogs.com/Bonnie3449/p/8419609.html)]

- **script 标签 sync 属性**
  
  HTML 文档被解析时如果遇见（同步）脚本，则停止解析，先去加载脚本，然后执行，执行结束后继续解析 HTML 文档。HTML 文档解析完毕后触发 DOMContentLoaded。[from [load/domContentLoaded 事件、异步/延迟 Js 与 DOM 解析](https://www.cnblogs.com/Bonnie3449/p/8419609.html)]

- **script 标签 async 属性**

  HTML5新增属性，用于异步下载脚本文件，下载完毕立即解释执行代码。

  对此，《JavaScript 高级程序设计》一书的解释是：带 async 的脚本一定会在 load 事件之前执行，可能会在 DOMContentLoaded 之前或之后执行。[from [load/domContentLoaded 事件、异步/延迟 Js 与 DOM 解析](https://www.cnblogs.com/Bonnie3449/p/8419609.html)]
  
  DomContentLoaded 事件只关注 HTML 是否被解析完，而不关注 async 脚本。

- **script 标签 defer 属性**

  用于开启新的线程下载脚本文件，并使脚本在文档解析完成后执行。

  如果 script 标签中包含 defer，那么这一块脚本将不会影响 HTML 文档的解析，而是等到 HTML 解析完成后才会执行。无论 HTML 解析完毕前 script 脚本是否加载完成，都会在 HTML 解析完毕后再执行 script。而 DOMContentLoaded 只有在 defer 脚本执行结束后才会被触发。[from [load/domContentLoaded 事件、异步/延迟 Js 与 DOM 解析](https://www.cnblogs.com/Bonnie3449/p/8419609.html)]

![script 加载与执行](/img/2020-05-26-performance-script-sync.webp) [图片 from [defer和async的区别](https://www.jianshu.com/p/c7c331ea4fe8)]

### async 与 defer 对比小结

DomContentLoaded 事件关注添加 defer 属性的脚本，脚本加载完毕并解析后触发 DomContentLoaded 事件；DomContentLoaded 事件不关注 asnyc 脚本，HTML 解析完毕即触发。

- **unload**

  当文档或一个子资源正在被卸载时, 触发 unload 事件。
  它在下面两个事件后被触发:

  1.  beforeunload (可取消默认行为的事件)
  2.  pagehide

- **[DOM](https://zh.javascript.info/browser-environment#wen-dang-dui-xiang-mo-xing-dom)**

  文档对象模型（Document Object Model），简称 DOM，将所有页面内容表示为可以修改的对象。DOM 规范解释了文档的结构，并提供了操作文档的对象。有的非浏览器设备也使用 DOM。

- **[CSSOM](https://zh.javascript.info/browser-environment#wen-dang-dui-xiang-mo-xing-dom)**

  CSS 规则和样式表的结构与 HTML 不同。有一个单独的规范 CSS Object Model (CSSOM)，它解释了如何将 CSS 表示为对象，以及如何读写它们。

- **[浏览器对象模型（BOM）](https://zh.javascript.info/browser-environment#liu-lan-qi-dui-xiang-mo-xing-bom)**

  浏览器对象模型（Browser Object Model），简称 BOM，表示由浏览器（主机环境）提供的用于处理文档（document）之外的所有内容的其他对象。

  函数 alert/confirm/prompt 也是 BOM 的一部分：它们与文档（document）没有直接关系，但它代表了与用户通信的纯浏览器方法。

## 参考文献

- [Chrome 的 First Paint](http://eux.baidu.com/blog/fe/Chrome%E7%9A%84First%20Paint)
- [window.onload 和 DOMContentLoaded 的区别](https://www.jianshu.com/p/1a8a7e698447)
- [load/domContentLoaded 事件、异步/延迟 Js 与 DOM 解析](https://www.cnblogs.com/Bonnie3449/p/8419609.html)
- [从页面加载到首屏渲染时机](https://www.cnblogs.com/dahe1989/p/11765066.html)
- [defer和async的区别](https://www.jianshu.com/p/c7c331ea4fe8)
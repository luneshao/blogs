+++
title = "强大的css filter属性及色彩名词（附 opacity 属性的兼容写法）"
description = "css filter属性太强大了，可以给图片加滤镜！我又震惊了。。。🤯文末附了一些色彩相关的名词解释，毕竟不做设计，有些常见的词了解不是很深。"
tags = ["前端", "CSS"]
date = "2019-05-31"
location = "JiNan, CN"
type = "post"
cover = "/img/cover.jpg"
keywords = "前端,css,fliter,对比度,色相,饱和度"
+++

> 引言

最近公司需要找一个管理项目的工具，然后被推荐了 coding.net，我就看了一下官网的功能介绍。看到合作伙伴那里，hover 之后，图片变了颜色。然后，职业病就犯了，就看了一下人家是怎么实现的。

<img src="/img/0531-cf-hezuohuoban.jpg" alt="合作伙伴的css样式" style="width: 100%" />

讲道理，我找了半天是怎么换的颜色。**filter** 这个属性之前看到是用来兼容 ie 的 opacity 属性的，我也一直没有用过，就以为它就是透明度的属性，我就没勾掉试一试。。。有点愚蠢。我就以为是换了图片的 URL，结果图片的 URL 并没有变化。我查看了图片，它本来的颜色就是彩色的。然后猜测，难道是利用 css 改变了图片的颜色？？？我就挨个属性勾了勾，果然是 filter 的原因。。

默认的 css 属性中，有这么一句 `filter: grayscale(100%);` ，这就是让图片变灰的属性。然后，就滚去 [MDN](https://developer.mozilla.org/zh-CN/docs/Web/CSS/filter) 了。首屏就是几个例子，我又震惊了！这个属性可以做这么多事！！上一次震惊是在发现了 [object-fit](https://developer.mozilla.org/zh-CN/docs/Web/CSS/object-fit) 属性，竟然可以改变图片内容的尺寸！

（文档真的要认真看，仔细看，可能某个小括号里边就提供了一种简便方法或者功能介绍。）

本篇主要是摘要了 MDN 的 filter 属性、取值及示例图以及关于色相、饱和度、灰度的概念。末尾附上了一份 opacity 的兼容性写法。

## 定义

filter：滤镜。

`filter` CSS属性将模糊或颜色偏移等 _图形效果应用于元素_ 。滤镜通常用于调整图像，背景和边框的渲染。
CSS标准里包含了一些已实现预定义效果的函数。你也可以参考一个SVG滤镜，通过一个URL链接到SVG滤镜元素(SVG filter element)。

## 语法

共分为四类。具体的我就不搬运了，下面具体介绍。[形式语法](https://developer.mozilla.org/zh-CN/docs/Web/CSS/filter#%E5%BD%A2%E5%BC%8F%E8%AF%AD%E6%B3%95)

```css
/* 自定义的 SVG 滤镜 */
.filter: url("filters.svg#filter-id")

/* 滤镜函数 */
blur、brightness、contrast、drop-shadow、grayscale、hue-rotate
invert、opacity、saturate、sepia
.filter: blur(5px);

/* 混合滤镜 */
filter: contrast(175%) brightness(3%);

/* Global values */
filter: inherit;
filter: initial;
filter: unset;
```

## 函数

**url**: URL函数接受一个XML文件，该文件设置了一个 _SVG滤镜_ ，且可以包含一个锚点来指定一个具体的滤镜元素.
```html
url()
```

**blur**（模糊）: 给图像设置高斯 _模糊_ 。这个参数可设置css长度值，但不接受百分比值。
```html
<blur()> = blur( <length> )
```

**brightness**（亮度）: 给图片应用一种线性乘法，使其看起来 _更亮或更暗_ 。
```html
<brightness()> = brightness( <number-percentage> )
```

**contrast**（对比度）: 调整图像的 _对比度_ 。值是0%的话，图像会全黑。值是100%，图像不变。值可以超过100%，意味着会运用更低的对比。
```html
<contrast()> = contrast( [ <number-percentage> ] )
```

**drop-shadow**（阴影）: 给图像设置一个 _阴影效果_ 。阴影是合成在图像下面，函数接受`<shadow>`（在CSS3背景中定义）类型的值，除了“inset”关键字是不允许的。该函数与已有的box-shadow box-shadow属性很相似；不同之处在于，通过滤镜，一些浏览器为了更好的性能会提供硬件加速。
```html
<drop-shadow()> = drop-shadow( <length>{2,3} <color>? )
```

<img src="/img/0531-eg-ds.jpg" alt="drop-shadow示例图片" style="width: 100%" />

⚠️注意：这里使用**png**格式的图片，才可以给图像边缘设置阴影。私以为这个属性是真的强大。请忽略我的龙鸣抠图

**grayscale**（灰度）: 将图像转换为 _灰度_ 图像。值定义转换的比例。值为100%则完全转为灰度图像，值为0%图像无变化。值默认是0。
```html
<grayscale()> = grayscale( <number-percentage> )
```

**hue-rotate**（色相）: 给图像应用色相旋转。[张鑫旭前辈的文章](https://www.zhangxinxu.com/wordpress/2018/11/css-filter-hue-rotate-button/) (ps：这里对于我这种不懂设计的人来说，确实难理解。)
```html
<hue-rotate()> = hue-rotate( <angle> )
```

**invert**（反转）: _反转_ 输入图像。或许，你可以尝试一下把值设置为 50%、 40%、 60%，看看会发生什么😆。
```html
<invert()> = invert( <number-percentage> )
```

<img src="/img/0531-eg-iv.jpg" alt="反转示例图片" style="width: 100%" />

（这还是公主殿下对吧😸）

**opacity**（透明度）: 转化图像的 _透明_ 程度。 
```html
<opacity()> = opacity( [ <number-percentage> ] )
```

**saturate**: 转换图像 _饱和度_ 。
```html
<saturate()> = saturate( <number-percentage> )
```
<img src="/img/0531-eg-sa.jpg" alt="饱和度示例图片" style="width: 100%" />

**sepia**: 将图像转换为 _深褐色_ 。
```html
<sepia()> = sepia( <number-percentage> )
```
<img src="/img/0531-eg-se.jpg" alt="饱和度示例图片" style="width: 100%" />

## 兼容性

让我们再来看一看 filter 属性的兼容性。

<img src="/img/0531-jianrongxing.jpg" alt="饱和度示例图片" style="width: 100%" />

OMG！IE 不支持 filter 属性！那他是怎么处理 opacity 属性兼容的呢？？？于是乎，bing，没找到。就去 MDN 看了[opacity 兼容性](https://developer.mozilla.org/zh-CN/docs/Web/CSS/opacity#Browser_compatibility)。

* 在9.0版本之前，Internet Explore浏览器不支持opacity属性, 它宁愿使用私有滤镜代替。（这就是原因）

* IE4 —IE9 支持下面的扩展形式： progid:DXImageTransform.Microsoft.Alpha(Opacity=xx)

* IE8引入了与“fliter滤镜”同义的"-ms-filter" 属性。在IE10中不再支持这两个属性。

* 在 Mozilla 1.7 (Firefox 0.9)版本 之前，“-moz-opacity” 属性一直以一种非标准的方式在使用。在Firefox 0.9版本中 ，这种行为得到了改变，这个属性被重命名为opacity。从那以后，-moz-opacity属性仅作为opacity属性的别名而存在。

## 相关名词

这里因为 bing 了一下，感觉没有可靠的文献，比较靠谱的还是博客里的，又怕被吐槽转载，所以就搬运了维基百科。一些伙伴可能没有科学上网，相关解释我就全部搬运了。

* [亮度](https://zh.wikipedia.org/wiki/%E4%BA%AE%E5%BA%A6)：又称辉度（luminance）是表示人眼对发光体或被照射物体表面的发光或反射光强度实际感受的物理量，亮度和光强这两个量在一般的日常用语中往往被混淆使用。

* [色相](https://zh.wikipedia.org/wiki/%E8%89%B2%E7%9B%B8)：指的是色彩的外相，是在不同波长的光照射下，人眼所感觉不同的颜色，如红色、黄色、蓝色等。我测试了一下，hue-rotate 属性值是在色相环上逆时针旋转 `${n}deg`。[如何计算 (stackoverflow)](https://stackoverflow.com/questions/29037023/how-to-calculate-required-hue-rotate-to-generate-specific-colour) 这个我还是没看明白..

<img src="/img/0531-eg-hu.svg" alt="色环图" style="height: 200px; width: 200px" />
(伊登十二色相环 from: wiki)

* <a href="https://zh.wikipedia.org/wiki/%E8%89%B2%E5%BA%A6_(%E8%89%B2%E5%BD%A9%E5%AD%A6)">饱和度</a>：指得是色彩的纯度，也叫色度或彩度，是“色彩三属性”之一。如大红就比玫红更红，这就是说大红的色度要高。它是HSV色彩属性模式、孟塞尔颜色系统等的描述色彩变量。
从广义上说，黑色、白色以及灰色是“色度=0”的颜色。在各种色彩模型中，对色度有不同的量化模式。
色度由光线强弱和在不同波长的强度分布有关。最高的色度一般由单波长的强光（例如激光）达到，在波长分布不变的情况下，光强度越弱则色度越低。

* [对比度](https://zh.wikipedia.org/wiki/%E5%B0%8D%E6%AF%94%E5%BA%A6)：对比度是画面黑与白的比值，也就是从黑到白的渐变层次。比值越大，从黑到白的渐变层次就越多，从而色彩表现越丰富。对比度对视觉效果的影响非常关键，一般来说对比度越大，图像越清晰醒目，色彩也越鲜明艳丽；而对比度小，则会让整个画面都灰蒙蒙的。
高对比度对于图像的清晰度、细节表现、灰度层次表现都有很大帮助。在一些黑白反差较大的文本显示、CAD显示和黑白照片显示等方面，高对比度产品在黑白反差、清晰度、完整性等方面都具有优势。相对而言，在色彩层次方面，高对比度对图像的影响并不明显。
对比度对于动态视频显示效果影响要更大一些，由于动态图像中明暗转换比较快，对比度越高，人的眼睛越容易分辨出这样的转换过程。对比度高的产品在一些暗部场景中的细节表现、清晰度和高速运动物体表现上优势更加明显。

## 附录

下面献上 opacity 属性的兼容写法

[from here](https://css-tricks.com/snippets/css/cross-browser-opacity/)

```css
.transparent_class {
  /* IE 8 */
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";

  /* IE 5-7 */
  filter: alpha(opacity=50);

  /* Netscape */
  -moz-opacity: 0.5;

  /* Safari 1.x */
  -khtml-opacity: 0.5;

  /* Good browsers */
  opacity: 0.5;
}
```

> 以上。🧐

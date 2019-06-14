+++
title = "小程序云开发"
description = "小程序云开发"
tags = ["小程序"]
date = "2019-06-10"
location = "JiNan, CN"
type = "post"
cover="/img/0610-mini-cover.jpg"
+++

> 引言

  最近和一个小姐姐在互相监督学习，所以想找一个工具打卡使用。没有找到那种到手即用的，就自己做一个了。结果，审核未通过。为啥呢，因为没好好看限制内容，个人的账号可以做的东西很少，[文档](https://developers.weixin.qq.com/miniprogram/product/material/#%E4%B8%AA%E4%BA%BA%E4%B8%BB%E4%BD%93%E5%B0%8F%E7%A8%8B%E5%BA%8F%E5%BC%80%E6%94%BE%E7%9A%84%E6%9C%8D%E5%8A%A1%E7%B1%BB%E7%9B%AE)敬上。

  不过过程中遇到的一些问题，打算记录下来。希望能帮助看到这篇文章的你避免一些坑吧。

  文章目录：
  
  * 页面开发
  * 组件开发
  * 字体图标
  * 云函数

  —————————— 一个渣渣前端的独白

## 1.页面开发

  * 1.使用 `this.setData({})` 赋值。

  * 2.页面向函数传参使用 `dataset`。[请戳官方文档](https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxml/event.html#dataset)

```html
<!-- page.html -->
<view 
  data-index='{{index}}'
  bindtap="handelItemDel">
  {{ item }}
</view>
```

```js
// page.js
handelItemDel(e) {
  let { selArr } = this.data
  const index = e.target.dataset.index
  selArr.splice(index, 1)

  this.setData({
    selArr: selArr
  })
},
```

  * 3.在 `app.json` 中，`page` 项数组的第一个页面是小程序的主页（即第一个跳转到的页面）。

## 2.组件开发

在 miniprogram 的目录下新建一个 components 文件夹，在文件夹内创建 **组件**。在页面中引用时，需要在页面的 json 文件中引入组件。key 值就是在页面中引入的标签名。

```js
// page.json
"usingComponents": {
  "calendar": "../../components/calendar/calendar",
  "record-list": "../../components/recordList/recordList"
}
```

```html
<!-- page.wxml -->
<view>
  <!-- 日历容器 -->
  <calendar />
  <!-- 记录列表 -->
  <record-list  wx:if="{{showCom}}"></record-list>
</view>
```

## 3.字体图标 （阿里 iconfont）

在 miniprogram 的目录下新建一个 lib 文件夹（文件名可自定义）。将在阿里图标库下载下来的文件解压，放到 lib 文件夹中，新建一个 icon.wxss （文件名自定义），在 app.wxss 中 `@import './lib/icon.wxss';` 导入到公共样式表。在页面中使用就可以了。

```html
<!-- comp.wxml -->
<text class="iconfont iconfenye-shangyiye" bindtap='lastMonth'></text>
```

_提示_：如果要在组件中使用全局样式，需要在组件的 js 文件中配置 `addGlobalClass: true`。

```js
// comp.js
options: {
  addGlobalClass: true,
}
```

## 4.云函数

* 1.npm 安装 wx-server-sdk

云函数中使用 `wx-server-sdk` 需在对应云函数目录下安装 `wx-server-sdk` 依赖，如果不安装，云函数就会运行失败。本地调试会不可用。 [文档](https://developers.weixin.qq.com/miniprogram/dev/wxcloud/guide/functions/wx-server-sdk.html)

* 2.云函数初始化，注意初始化时，env 字段传入环境配置，这里传入的不是环境名称，而是**环境ID**。在云开发平台的环境下拉菜单中可以找到。 [文档](https://developers.weixin.qq.com/miniprogram/dev/wxcloud/reference-client-api/init.html)

```js
// cloudFunc.js

const cloud = require('wx-server-sdk')
// 默认配置
cloud.init()
// 或者传入自定义配置
cloud.init({
  env: 'some-env-id'
})
```

* 3.上传小程序代码在真机调试时，需要上传云函数代码，否则也会不生效。方法：在云函数右键上传并部署。

> 以上。
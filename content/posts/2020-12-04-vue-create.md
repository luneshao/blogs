---
title: "vue创建项目流程记录"
description: "从脚手架创建一个项目开始，到初步开发的配置。"
tags: ['vue']
date: 2020-12-04T09:46:14+08:00
type: "post"
author: "luneShao"
featured_image: "/img/cover.jpeg"
draft: false
---

## step1、创建
```cmd
$ vue create testProject // 【说明】testProject 是自己的项目名，可自定义。
```

## step2、安装 less、less-loader
```cmd
yarn add less less-loader --dev
```

## step3、配置 vue.config.js
```js
// vue.config.js
module.exports = {
  // 这里的配置，就可以部署在服务器非根目录下了
  publicPuth: '',
  chainWebpack: config => {
    // 配置 eslint 保存时自动修复
    config.module
    .rule('eslint')
    .use('eslink-loader')
    .tap(options => {
      // 修改它的选项...
      options.fix = true

      return options
    })

    // 配置 html 文件 title
    config
    .plugin('html')
    .tap(args => {
      args[0].title = process.env.VUE_APP_TITLE
    })
  }
}
```

以上这样就完成了我日常需要的简单配置了。 o^o

有什么意见或建议欢迎一起讨论。

以上。
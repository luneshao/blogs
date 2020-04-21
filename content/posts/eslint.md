---
title: "深入理解eslint"
description: "读懂eslint的配置项，以及开发自己eslint插件"
author: "luneShao"
cover: "/img/cover.jpg"
tags: ["eslint"]
date: 2019-08-02T10:36:26+08:00
draft: false
---

> 引言

> 参考文献：[转载微信公众号的正文](https://mp.weixin.qq.com/s/X2gShxrCw0ukZigjE_45kA)

> 文章结构：注释了一下 eslint.js 的各个配置项是什么意思，再也不会觉得像天书了（狗头

```js
// eslint.js
module.exports = {
  root: true, // 如果root设置为true，那么 ESLint 就会认为当前目录为根目录，不再向上查找配置。
  
  parser: 'babel-eslint', // 解析器类型：espima(默认), babel-eslint, @typescript-eslint/parse

  parserOptions: { // 解析器配置参数
    sourceType: 'module' // 代码类型：script(默认), module
  },

  // https://github.com/feross/standard/blob/master/RULES.md#javascript-standard-style
  /**
  * "eslint:recommended", // 一共有两个：eslint:recommended 、eslint:all
  * "plugin:react/recommended", // 扩展是插件类型，也可以直接在 plugins 属性中进行设置 => extPlugin = `plugin:${pluginName}/${configName}`
  * "eslint-config-standard", // 扩展来自 npm 包，官方规定 npm 包的扩展必须以 eslint-config- 开头，使用时可以省略这个头
  */
  extends: 'standard', // 扩展就是直接使用别人已经写好的 lint 规则，方便快捷

  // required to lint *.vue files
  plugins: [ // 以 eslint-plugin- 开头，使用的时候也可以省略这个头
    'vue'
  ],

  /**
   * “off” 或 0：关闭规则
   * “warn” 或 1：开启规则，warn 级别的错误 (不会导致程序退出)
   * “error” 或 2：开启规则，error级别的错误(当被触发的时候，程序会退出)
   * {
   * "rules": {
    // 使用数组形式，对规则进行配置
    // 第一个参数为是否启用规则
    // 后面的参数才是规则的配置项
   * "quotes": [
   *  "error",
   *  "single",
   *  {
   *    "avoidEscape": true 
   *  }
   * ]
  }}
   */
  'rules': { // 可以在配置文件的 rules 属性中配置你想要的规则
    // allow paren-less arrow functions
    'arrow-parens': 0,
    // allow async-await
    'generator-star-spacing': 0,
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 2 : 0
  }
}

```

> 以上。🥳

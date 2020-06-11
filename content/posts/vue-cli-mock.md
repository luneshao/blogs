---
title: "Vue CLI中配置使用Mock数据"
description: "使用Vue CLI搭建项目，在项目使用Mock数据。本文介绍了项目中如何配置webpack的配置文件。"
author: "luneshao"
cover: "/img/cover.jpg"
tags: ["Vue", "Mock", "webpack"]
date: 2019-07-09T16:27:20+08:00
draft: false
---

> 引言

鉴于对 Vue CLI 中 webpack 的链式配置一直不熟悉，mock 也没有用过。最近项目需要 mock 数据，所以新建了一个测试项目配置了一下。下面我会介绍配置流程。👇👇👇 (webpack 没理解透彻T_T)

参考文献：

+ [Vue CLI 文档](https://cli.vuejs.org/zh/guide/webpack.html)
+ [webpack-chain 文档](https://github.com/neutrinojs/webpack-chain)
+ [webpack 配置文档](https://webpack.js.org/configuration/dev-server/#devserverproxy)
+ [http-proxy-middleware 文档](https://github.com/chimurai/http-proxy-middleware#options)
+ [mockjs-webpack-plugin 文档](https://github.com/soon08/mockjs-webpack-plugin/blob/HEAD/readme-zh.md)

文章结构：

```
+ 配置流程
  + Step 1. 安装插件 mockjs-webpack-plugin
  + Step 2. 配置 webpack 配置项
  + Step 3. Mock 数据
```

## 配置流程

这里我就默认民那桑已经用 Vue CLI 安装了一个项目。我使用的 Vue CLI 3。

### Step 1. 安装插件 mockjs-webpack-plugin

1. 这个插件通过 webpack 插件的方式，快速搭建项目的 mock 服务，用于前后端分离模式下的并行开发。emmm，是公司大佬用的这个，至于为什么我还没敢问 -_-

    ```
    yarn add mockjs-webpack-plugin --dev 或 cnpm install --save-dev mockjs-webpack-plugin
    ```

2. 安装完成后，新建存放 mock 数据的文件夹及文件。[文档](https://github.com/soon08/mockjs-webpack-plugin/blob/HEAD/readme-zh.md)

    ```
    .
    ├── app         //工程目录
        ├── dist
        ├── config
        ├── src
        ├── mock    //mock数据目录
        |   ├── data.js
        |   ├── data.json
            ...
    ```

### Step 2. 配置 webpack 配置项

⚠️ 每次更新配置文件都需要重启项目

可以参考 [Vue CLI文档](https://cli.vuejs.org/zh/guide/webpack.html#%E7%AE%80%E5%8D%95%E7%9A%84%E9%85%8D%E7%BD%AE%E6%96%B9%E5%BC%8F) 中介绍，关于 webpack 的配置需要新建一个 `vue.config.js` 文件。由于本文是为了学习 webpack-chian，所以就直接使用链式配置方式。

这里一共需要配置两项，添加 mock 插件和配置代理服务。

1. mock 插件

    ```js
    // webpack-chain 添加插件格式，注意不要使用 new 创建一个插件对象，因为它会自动完成。
    config
      .plugin(name) // name: 插件自定义名称
      .use(WebpackPlugin, args) // WebpackPlugin: 引入的插件， args: 配置项
    ```

2. 服务代理

    ```js
    // webpack devSever 格式
    config
      .devServe
        .port('port | Number') // 用于侦听请求的端口号
        .proxy({ // proxy 的参数说明见下👇👇👇
          '/path': { // 侦听代理的路径名称，这里将侦听 /path 的请求到代理主机的 www.topath.com/path
            target: 'www.topath.com', // 指向代理主机
            pathRewrite: {'^/path' : '/new/path'} // 重写目标路径，即请求 /path 时将代理到 www.topath.com/new/path
          }
        })

    // proxy 的参数说明 👇👇👇
    // 因为这里 webpack 用的 http-proxy-middleware 这个插件，所以就搬了插件的例子解释。
    var apiProxy = proxy('/api', { target: 'http://www.example.org' });
    //                   \____/   \_____________________________/
    //                     |                    |
    //                   context             options
    ```
    下面我只介绍了我用到的，详细说明见[详细说明](https://github.com/chimurai/http-proxy-middleware#options)。

    * context：确定哪些请求会被代理到目标主机。 例如，这里会将 `/api` 的请求代理到 `http://www.example.org/api` 这里。
    * options：配置项。
    * options.target：目标主机。
    * options.pathRewrite：(object/function)重写目标url路径。 对象键将用作RegEx以匹配路径。

    ```js
    // 例如，我希望请求 `/path`时，代理到主机的 `http://www.example.org/hostPath`
    pathRewrite: {'^/path' : '/hostPath'}
    ```
    * options.router：针对特定请求重新定位option.target。我觉得这个可以用来在调试 mock 和真实接口时填写代理主机，不用来回修改了。

    ```js
    // Use `host` and/or `path` to match requests. First match will be used.
    // The order of the configuration matters.
    router: {
        'integration.localhost:3000' : 'http://localhost:8001',  // host only
        'staging.localhost:3000'     : 'http://localhost:8002',  // host only
        'localhost:3000/api'         : 'http://localhost:8003',  // host + path
        '/rest'                      : 'http://localhost:8004'   // path only
    }

    // Custom router function
    router: function(req) {
        return 'http://localhost:8004';
    }
    ```

下面补充完整的配置文件代码。

```js
// vue.config.js 完整配置

const path = require('path');
const MockjsWebpackPlugin = require('mockjs-webpack-plugin')

module.exports = {
  chainWebpack: config => {
    config
      .plugin('mock')
        .use(MockjsWebpackPlugin, [{
          path: path.join(__dirname, './mock'),
          // 配置mock服务的端口，避免与应用端口冲突
          port: 3001
        }])

    config
      .devServer
        .port(5001)
        .proxy({
          '/api': {
            target: 'http://localhost:3001', //对应自己的接口
            pathRewrite: {'^/api' : '/json'}
          }
        })
  }
}
```

配置好了之后，就完成了一大大大半的工作了。

### Step 3. Mock 数据

参考[插件 Mock 数据](https://github.com/soon08/mockjs-webpack-plugin/blob/HEAD/readme-zh.md#mock-%E6%95%B0%E6%8D%AE)填充 js 和 json 文件。

```js
// data.js
/**
 * JS data file
 *
 * @url /js/js-data-file
 *
 * Export data by using the JS file directly.
 */

module.exports = {
    "code": function () { // simulation error code, 1/10 probability of error code 1.
        return Math.random() < 0.1 ? 1 : 0;
    },
    "list|5-10": [
        {"title": "@title", "link": "@url"}
    ]
};
```

```js
// 对应的内容
文件标题： Json data file
访问路径： /js/js-data-file
描述：
```

访问 `http://localhost:3001` 就可以查看接口列表了，按照自定义的接口路径及代理就可以访问接口啦。

```js
Axios.get('/api/data')
  .then(res => {
    console.log(res)
  })
```

## 2020-06-03 更新
或者可以安装 `mockjs2`

```
yarn add mockjs2
```

然后创建 `mock/test.js` 文件

查看官方 [api](https://github.com/nuysoft/Mock/wiki) 直接生成mock数据，可以参考[官方示例](http://mockjs.com/examples.html)。

然后在需要的地方调用就可以了。

### 代码
```js
// mock/test.js
import Mock from 'mockjs2'
import { mapCompanys } from '@/data'
/**
 * 魔力象限数据
 * @returns
 * {
 *  series: [ {data: [integer, integer, integer, integer, company, year-mm-dd]}, [] ... ]
 * }
 */
function getMagic () {
  const companys = Object.keys(mapCompanys)

  return {
    'series|24': [{ 'data|10-14': [['@integer(0, 100)', '@integer(0, 100)', '@integer(1, 4)', '@integer(1, 4)', `@pick(${companys})`, '@pick([2018, 2019, 2020])' + '-' + '@date(MM-dd)']] }]
  }
}

Mock.mock('/api/getMagic', 'get', getMagic())

export default Mock
```

```js
// main.js
import '@/mock'
```

```vue
// test.vue
<template>
...
</template>

<script>
import Axios from 'axios'

export default {
  mounted () {
    axios.get('/api/getMagic')
      .then(res => {
        console.log('mock res:', res)
      })
  }
}
</script>
```

以上。🐵

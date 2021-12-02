---
title: "vue-router在history模式下的相关配置"
description: "解决vue-router在history模式下，部署到二级目录，nginx以及vue的配置"
tags: [vue]
date: 2021-12-02T10:52:26+08:00
type: "post"
author: "luneShao"
featured_image: "/img/cover.jpg"
draft: false
---
## Step1 nginx配置
众所周知，`vue-router` 在使用  `history` 模式时如果服务器没有相关的配置，刷新会404.文档有给出[解决方案](https://router.vuejs.org/zh/guide/essentials/history-mode.html#%E5%90%8E%E7%AB%AF%E9%85%8D%E7%BD%AE%E4%BE%8B%E5%AD%90)。文档中给出的是打包文件在根目录的配置，如果在二级目录下需要做一些修改。

```nginx
# 例如我的打包文件要放在test目录下，配置如下

server {
    listen       80;
    server_name testhistory.com;
   
    location /test {
      try_files $uri $uri/ /test/index.html;
    }
}
```

我是在这篇文章找到的解决方案[【nginx】History模式的配置细节](https://juejin.cn/post/6926785971287490573)

修改后运行 `nginx -t` 检查配置是否正确后运行 `nginx -s reload` 重启。

## Step2 vue.config.js 配置

> 在 vue.config.js 中配置上公共资源目录

```js
module.exports = {
    publicPath: process.env.NODE_ENV === 'production'
    ? '/test/'
    : '/',
    outputDir: 'test', // 加上这个配置，让打包出来的目录由默认的dist改为h5，方便写部署脚本
    ...
}
```

## Step3 vue-router 配置

> 除了 js、css 公共资源目录，还有路由配置也要增加基本前缀，为了保证前端路由和服务器的一致

```js
const router = new VueRouter({
  mode: 'history',
  base: '/test/', // 目标目录
  routes
})
```


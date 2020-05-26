---
title: nodejs、Nginx 处理跨域
author: luneShao
cover: "/img/cover.jpg"
tags: ["前端", "跨域", "nginx"]
date: 2020-04-20T10:36:26+08:00
draft: false
---
## http-proxy
- 安装包 http-proxy
- 全局安装 pm2 包
- 创建 src/server/index.js
  ```js
  const url = require('url')
  const http = require('http')
  const axios = require('axios')
  const qs = require('qs')
  const httpProxy = require('http-proxy')
  const proxy = httpProxy.createProxyServer((options = { changeOrigin: true, target: 'https://api.mysubmail.com' }))

  proxy.on('proxyRes', (proxyRes, req, res, options) => {
    let body = []
    proxyRes.on('data', function(chunk) {
      body.push(chunk)
    })
    proxyRes.on('end', function() {
      body = Buffer.concat(body).toString()
      res.end('my response to cli')
    })
  })

  proxy.on('error', function(err, req, res) {
    res.writeHead(500, {
      'content-type': 'text/plain'
    })
    res.end('Something went wrong. And we are reporting a custom error message.')
  })

  http
    .createServer(function(req, response) {
      const path = url.parse(req.url).path.slice(1)

      if (path === 'mail/send.json') {
        res.setHeader('Access-Control-Allow-Origin', '*')
        res.setHeader('Access-Control-Allow-Headers', 'content-type')
        res.setHeader('Access-Control-Allow-Methods', 'DELETE,PUT,POST,GET,OPTIONS')
        proxy.web(req, res)
      }
    })
    .listen(9000)
  ```
- 运行 pm2 start src/server/index.js (pm2 会创建一个进程，不会像node启动后一样不能做别的事)

调用方式如下，将 host 替换为 http://localhost:8899 使用

```js
// 前端
const mailValue = {test: 'a'}
axios.post('http://localhost:9000/mail/send.json',qs.stringify(mailValue)).then((res) => {
  console.log(res)
})
```
## nginx 代理
[代理配置](https://www.cnblogs.com/kevingrace/p/6566119.html)
eg:
```txt
# nginx 配置
server {
  listen       80;                                                         
  server_name  localhost;                                               
  client_max_body_size 1024M;

  location /mail {
    proxy_pass http://www.test.com/mail;
    # 解决跨域
    add_header Access-Control-Allow-Origin *;
    add_header Access-Control-Allow-Methods "POST, GET, OPTIONS";
    add_header Access-Control-Allow-Headers "Origin, Authorization, Accept";
    add_header Access-Control-Allow-Credentials true;
  }
}
```

配置完后重启nginx。

```js
// 前端
const mailValue = {test: 'a'}
axios.post('http://localhost:80/mail/send.json',qs.stringify(mailValue)).then((res) => {
  console.log(res)
})
```

---
title: "手摸手带你搭建自己的博客"
description: "带你创建自己的blog。"
author: "luneShao"
cover: "/img/cover.jpg"
tags: ["jekyll"]
date: 2020-03-15T10:36:26+08:00
draft: true
---

<!-- # 手摸手带你搭建自己的博客 -->
## 前言

本次搭建博客使用 [Github Pages](https://pages.github.com/) 、Jekyll 框架。

- 选择 `Github Pages` 的原因：不用自己买服务器了，之前一直用的这个，就继续用了。（也可以使用 gitee，也有 Gitee Pages 这个功能。）
- 选择 Jekyll 的原因：Github Pages 首页下边推荐就用了。之前还用过 [Hugo](https://www.gohugo.org/)（go环境），Hugo 有很多好看的主题，也推荐。不过，之前那个被我搞坏了，而且时间久远我就不想去修理，打算重新弄一个，这次就用 Jekyll（ruby环境）。最近看了一下 Jekyll 的文档，样式啥的后期都可以根据自己的喜好添加，很简单。这次，先搭建一个基础的，想玩就后期优化一下。:D

为了更直接的看操作内容，下边我就只说如何操作，不瞎bb了。

---
## 搭建步骤

### 第一步、配置环境

- 注册一个 [Github](https://github.com/join?source=header-home) 账号。
- 安装 [Git](https://git-scm.com/downloads)。（win用户可以参考[Windows安装 Git 教程](https://www.jianshu.com/p/414ccd423efc)，macOS 用户可以安装 [homebrew](https://brew.sh/index_zh-cn)，然后通过 homebrew 安装Git。）
- 安装 [Ruby](https://jekyllrb.com/docs/installation/) 开发环境。
- 安装一个自己喜欢的编辑器，我使用的 [VS Code](https://code.visualstudio.com/Download)。

### 第二步、创建博客项目
- 1、安装 Jekyll 和 bundler gems，在命令行输入如下指令：
  ```
  gem install jekyll bundler
  ```

- 2、创建 Jekyll 站点。首先，在命令行中进入你要保存博客项目的目录下。输入如下指令：（note：`cd` 是进入目录的指令；这里 myblog 是项目名字，可以自己任意起。）
  ```
  jekyll new myblog
  ```
- 3、进入博客目录
  ```
  cd myblog
  ```
- 4、构建站点，使它在本地服务器上可用。
  ```
  bundle exec jekyll serve
  ```
- 5、在浏览器打开 http://localhost:4000

此时，就拥有了一个基础的网站啦～～
## 未完待续。。。
---
title: "配置多个GitHub账号的ssh"
description: "如题"
tags: [github, ssh]
date: 2021-07-01T10:25:21+08:00
type: "post"
author: "luneShao"
featured_image: "/img/cover.jpg"
draft: false
---

### 前言
“多年前”需要用两个 github 账号，就查了怎么配置两个ssh，配置好了之后，一直不好用，克隆私有库也克隆不下来，后来百度到用https的地址，也就是[这篇文章](https://luneshao.github.io/2020/2020-11-04-how-push-to-github-private-rep/)的方法，就一直这么用着😁
一切都很顺利，最近不是GitHub推不上去，然后就***，昨天就一直报403，错误如下：
```
remote: Password authentication is temporarily disabled as part of a brownout. Please use a personal access token instead.
remote: Please see https://github.blog/2020-07-30-token-authentication-requirements-for-api-and-git-operations/ for more information.
fatal: unable to access 'https://github.com/chainland/qlchain.cn.git/': The requested URL returned error: 403
```
这就很尴尬，我就开始百度怎么整（ps：昨天什么也没动今天就推上去了。。。。）然后，我今天就想着一定要把ssh给配好，遂又百度了一番，终于。。。

### 正文
我的问题是，配置两个ssh，但是执行测试句：`ssh -T git@**.github.com` 和 `ssh -T git@github.com`出来打招呼的都是同一个名字，就很不对劲。翻到了[这篇文章](https://www.huaweicloud.com/articles/5e1b8d3cb0b673fae499eaa34a94205c.html)，发现是因为我缺了【密钥添加到SSH agent中】这一步，执行完之后，神清气爽。ssh终于能用了，尴尬 (~_~;)

> 引用一下解决方法

  因为默认只读取id_rsa，为了让SSH识别新的私钥，需将其添加到SSH agent中：

  ```
  ssh-add  ~/.ssh/id_rsa_user2
  ```

  如果出现Could not open a connection to your authentication agent的错误，就试着用以下命令：

  ```
  ssh-agent  bash
  ssh-add  ~/.ssh/id_rsa_user2
  ```

### 补充
[一篇写的很好的配置多个ssh密钥的文章](https://kangzhiheng.top/post/11-more-ssh-in-one-laptop/)

以上😁

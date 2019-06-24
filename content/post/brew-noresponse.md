---
title: "brew update 无响应"
author: "lune"
cover: "/img/cover.jpg"
tags: ["brew", "Mac"]
date: 2019-06-24T09:24:54+08:00
description: "修改镜像的方式解决 brew update 操作无响应，附详细代码及原文链接。"
draft: false
---

内容摘自 [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)

## 替换现有上游

```
cd "$(brew --repo)"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

brew update
```



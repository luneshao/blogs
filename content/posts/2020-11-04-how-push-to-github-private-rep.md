---
title: "如何推送到github私有仓库"
description: "做记录用。"
tags: ['github']
date: 2020-11-04T16:50:54+08:00
type: "post"
author: "luneShao"
featured_image: "/img/cover.jpg"
draft: false
---

if you add origin remote,please remove it first:

```
git remote rm origin
```

ant then:

```
git remote add origin  https://USERNAME:PASSWORD@github.com/username/reponame.git
```

from: [stackoverflow](https://stackoverflow.com/questions/10116373/git-push-error-repository-not-found)
---
title: "windows 添加自定义协议，实现浏览器打开软件"
author: "Author Name"
cover: "/img/cover.jpg"
tags: ["URL Protocol", "Costom"]
date: 2019-06-20T14:43:42+08:00
description: "实现在浏览器中点击一个链接，打开另一个软件的功能。"
draft: false
---

我参考了这篇[博客](http://baimoz.me/1429/)，我使用了原博中 windows 系统的方式，亲测有效。下面贴一下操作步骤：

### 操作步骤

1. 添加注册表

（1）新建一个 `.reg` 的文件，填充如下内容。例如我新建一个自定义协议，名称为 lune。请注意，将下面所有的路径（也就是方括号内的内容）中的名称要 **全部替换为自定义的名称** ，且名称一定要 **全部是小写字母** 。

```
Windows Registry Editor Version 5.00
[HKEY_CLASSES_ROOT\lune]
"URL Protocol"="C:\\WINDOWS\\system32\\calc.exe"
@="LuneProtocol"
[HKEY_CLASSES_ROOT\lune\DefaultIcon]
@="C:\\WINDOWS\\system32\\calc.exe,1"
[HKEY_CLASSES_ROOT\lune\shell]
[HKEY_CLASSES_ROOT\lune\shell\open]
[HKEY_CLASSES_ROOT\lune\shell\open\command]
@="\"C:\\WINDOWS\\system32\\calc.exe\" \"%1\""
```

（2）双击添加到注册表。

2. 调用方式

```html
<a href="lune://123">click</a>
```

#### 注意

1. `[HKEY_CLASSES_ROOT\lune\shell]`方括号内的路径（即 lune）要改成自定义的名字。

2. 自定义的key值，也就是名称，要小写。（都是血与泪...

#### mark

[实现浏览器判断本地是否安装程序，并下载与启动 Chrome,IE,360可用](https://blog.csdn.net/evanxuhe/article/details/79240051)

> 以上。🐳
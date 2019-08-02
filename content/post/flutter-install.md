---
title: "Flutter 安装 CocoaPods"
author: "lune"
cover: "/img/cover.jpg"
tags: ["flutter"]
date: 2019-06-24T16:30:36+08:00
draft: false
---

> 引言

安装 flutter 过程中，卡在 `pod setup` 这里，总是会报错，找了好多文章也没能解决。最后发现这篇博客=> [CocoaPods的安装步骤和遇见的问题](https://www.jianshu.com/p/3864b302ff90) 按照里面的步骤，一步一步来就OK了。

### 安装步骤

```
// 建议先更新下gem
sudo gem update --system

// 切换镜像
gem sources --remove https://rubygems.org/
gem sources -a https://gems.ruby-china.com/
gem sources -l


// 安装 cocoapods
sudo gem install cocoapods 应该会提示下错误
// ERROR:  While executing gem ... (Errno::EPERM)   Operation not permitted - /usr/bin/update_rubygems
试试 gem update -n /usr/local/bin --system

// 安装cocoapods （我用的这个）
sudo gem install -n /usr/local/bin cocoapods

pod repo list // 查看repo 列表
pod repo remove master   // 删除master

// 添加master库
新版的 CocoaPods 不允许用pod repo add直接添加master库了，现在一般执行完pod repo add master  *** 之后又会提示[!] To setup the master specs repo, please run pod setup.但是依然可以：
// https://mirrors.tuna.tsinghua.edu.cn/help/CocoaPods/ 清华大学的CocoaPods 镜像
git clone https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git ~/.cocoapods/repos/master
// 默认的 https://github.com/CocoaPods/Specs.git 
// 备用的 git://cocoapodscn.com/Specs.git

在自己工程的podFile第一行加上：刚刚替换的新repo
// source 'git://cocoapodscn.com/Specs.git'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

// cd ~/.cocoapods然后下面指令    
// du -sh * 查看下载进度 （此时再次运行 flutter doctor -v ，就可以了。）
// pod setup手动克隆就不要执行这个了，不然一会又要死循环了
pod --version
```

操作完以上步骤，我最后的错误也解决了。一篇绿色，舒服啊～～～

虽然目前没深入学习，不知道需不需要都装好，但是全都是绿色就是得劲😎

<img alt="flutter doctor -v 运行结果（如果你挂了代理，就看不到图片了～）" height="300" src="http://ww4.sinaimg.cn/large/006tNc79ly1g4d670u7u1j30u0119mz6.jpg" />

> 以上。🦑
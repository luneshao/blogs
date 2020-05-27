+++
title = "hugo 介绍及使用"
description = "Hugo介绍"
tags = ["hugo"]
date = "2019-05-14"
location = "JiNan, CN"
type = "post"
keywords = "hugo,githubpage,博客搭建,博客添加评论,Valine,disqus"
+++
## 引言

本篇文章简单介绍了 Hugo 的目录结构和博客内一些个性化内容(评论、音乐、google analyze)的实现。

使用 Hugo 生成博客还请大家移步至 [Hugo中文文档](https://www.gohugo.org/)，我看着挺清晰的，比英文文档好看啊...

我目前使用的是 [hugo-lamp](https://themes.gohugo.io/hugo-lamp/) 这个主题，绿绿的多好看😏。

## 1.Hugo 目录结构

[原文连接](https://hgt312.github.io/post/other_note2/)

```
├── archetypes  // 储存.md的模板文件，新建一个 .md 文件时，就会按此模版创建
├── content     // 储存网站的所有内容，写的文章存放在这里
├── data        // 储存数据文件供模板调用（目前没有用到过）
├── layouts     // 储存.html模板（也莫的用）
├── static      // 储存图片,css,js等静态文件，该目录下的文件会直接拷贝到/public
├── themes       // 储存主题
└── config.toml // 配置文件
```

### 图片的引用

Hugo 的图片可以直接放在其 `static/img` 目录里面，其路径就是 /img/image_name.png。

[2019-06-12日更新]

众所周知，安装主题是在 themes 文件夹下，根据不同的主题，都会有相应的文档介绍，告诉我们怎么去写配置文件。此主题的文档在 `/docs/guide.md`，根据这个文档可以把自己的名字、签名、地址一系列安排的妥妥当当。

看到大神们有人在博客里放了评论、音乐，还使用了图床，就也想鼓捣。还有，我的博客没有被搜索引擎收录，我还得搞一搞。目前我已经添加了评论、音乐和 google analyze的功能，记录一下过程。

## 2.hugo 添加评论功能

[20190613 更新，我已经换掉了。换成 Valine 了。]

我使用的是 [disqus](https://disqus.com/)。 [参考文章，真的是极好。](https://www.jianshu.com/p/e68fba58f75c)

hugo 文档有具体教程[文档教程](https://www.gohugo.org/doc/extras/comments/)。简述一下第二种方法的步骤：

1. 首先，在配置文件中，配置一下自己的用户名。

```toml
disqusShortname = "luneshao"
```

2. 拷贝提供的代码，到主题的 `layouts/partials` 文件夹下，新建一个 `disqus.html`，然后放到需要的地方。**这里卡住我了**，我就放到 `_default` 文件夹下了，然后就和我的主题不匹配，正文是在右侧内容区的，评论却是 100% 的。着实尴尬😅。后来，我看到了下面的 `post` 文件夹，这里大概是 `content` 文件夹下的 `post` 文件夹内依据 `.md` 生成 `.html` 的模版吧。 `{{ partial "disqus.html" . }}` 这段代码放到 themes 中 `post/single.html` 文件中你喜欢的地方就好了。音乐也同理。

* 你还没尝试吧？那段代码不生效，不知道原因，没有深入研究。后来，我找到了一篇[文章](https://blog.csdn.net/justheretobe/article/details/51622101)，他分享了一段代码，贴一下。把下面的代码替换进 `disqus.html`。大功告成。不过，需要翻墙才出现，是不是有点坑。可以用 Gitalk 代替。[百度一下，你就知道](www.baidu.com)

### Valine 评论

[Valine 官网指南](https://valine.js.org/quickstart.html)，官方写的特别清楚，一步一步的来，在对应位置将 disqus 替换为 Valine 的相关节点就可以了。然后，根据配置项，个性化一哈～

* 其中的 html 代码片断拷贝到 themes 下 `layouts/partials/head.html` 中，节点拷贝到 `post/single.html` 文件中。

### 代码献上
```js
<div id="disqus_thread"></div>
<script>
/**
* RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
* LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
*/
/*
var disqus_config = function () {
this.page.url = PAGE_URL; // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};
*/
(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');

s.src = '//wwwlearnbetterclub.disqus.com/embed.js';

s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please en
```

## 3.google analyze

步骤： [Hugo analytics文档](https://www.gohugo.org/doc/extras/analytics/)

1. 注册[google analyze](https://analytics.google.com/analytics/web/)。[详细过程](https://zh.wikihow.com/%E4%BD%BF%E7%94%A8%E8%B0%B7%E6%AD%8C%E5%88%86%E6%9E%90%E7%BD%91%E7%AB%99) 我参考的这位老哥的，很全面也很详细，约等于手把手。

2. 在左侧菜单最下边有一个 管理，然后找到 跟踪信息 -> 跟踪代码，拷贝一下 跟踪ID。写在配置文件中，大功告成。

```toml
# config.toml
googleAnalytics = "UA-XXXXXXXXX"       # Google Analytics UA number
```

## 4.添加音乐

当你会添加评论了之后，这个简直 so easy~ 主要就是当时没放对位置...

步骤： [参考文章](https://zhuanlan.zhihu.com/p/26625249)

1. 在网页版网易云找到你喜欢的曲子，点击生成外链播放器。

2. 拷贝代码，放到上面放评论的文件内，就在文章的所处的布局内了，具体位置就随你安排了。

[未完待续...还需要被搜索引擎收录]

> 以上。
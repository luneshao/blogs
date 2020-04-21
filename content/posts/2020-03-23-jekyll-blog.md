---
title: jekyll 搭建博客步骤
description: jekyll 创建及部署博客的步骤。
author: luneShao
cover: "/img/cover.jpg"
tags: ["jekyll"]
date: 2020-03-23T10:36:26+08:00
draft: false
---
# 分布教程

## 1. Setup

### installation

安装 Jekyll

```
gem install jekyll bundler
```

创建 Gemfile

```
bundle init
```

编辑 Gemfile，添加 Jekyll 作为依赖

```
gem "jekyll"
```

运行 bundle 安装 Jekyll 到项目。

```
bundle
```

现在可以在 Jekyll 的命令前加上 bundle exec，以确保使用 Gemfile 中的 Jekyll 版本。

### Create a site

为网站创建一个目录，名称可以任意起。在教程的其余部分，将称其为 root.
在 root 目录添加第一个文件 index.html。

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Home</title>
  </head>
  <body>
    <h1>Hello World!</h1>
  </body>
</html>
```

### build

Jekyll 是静态网站生成器，因此我们需要 Jekyll 构建网站才能查看。您可以在网站的根目录中运行以下两个命令来构建它：

- jekyll build：构建网站输出静态站点到名为 `_site` 的目录下。
- jekyll serve：除了在您进行更改并运行本地 Web 服务器时会重新生成之外，还会运行一个 web 服务在 http://localhost:4000

## 2. Liquid

Liquid 是一个模版语言，包含三个主要的部分：objects，tags 和 filters

### objects

objects 表示输出内容，用花括号表示。

```Liquid
{{ page.content }}
```

### tags

tags 为模板创建逻辑和控制流。用花括号和百分号表示。

```Liquid
{% if page.show_sidebar %}
  <div class="sidebar">
    sidebar content
  </div>
{% endif %}
```

### filters

过滤器更改 Liquid 对象的输出。它们在输出中使用，并用 `|` 分隔。

```Liquid
{{ "h1" | title }}
```

### use Liquid

为了让 Jekyll 处理 Liquid，我们需要在页面顶部添加 Front Matter：

```YAML
---
# front matter tells Jekyll to process Liquid
---
```

## 3. Front Matter

front matter 是 `YAML` 的一个片段，它位于文件顶部的两个三点划线之间。front matter 用于设置页面变量，例如：

```YAML
---
my_number: 5
---
```

在 Liquid 中 front matter 变量可以在 `page` 变量下使用。例如:

```YAML
{{ page.my_number }}
```

请注意，为了让 Jekyll 处理您页面上的所有 Liquid 标签，您必须在其上包含 front matter。您可以包括的最简单的 front matter 是：

```YAML
---
---
```

## 4. Layouts

提取每个页面公共的部分作为模版，作为内容的容器。他们放在 `_layouts` 目录下。在根目录创建一个 `about.md` 文件。

### create a layout

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>{{ page.title }}</title>
  </head>
  <body>
    {{ content }}
  </body>
</html>
```

使用 layout 替换 index.html 中的内容。可以在 front matter 中设置一个 layout 变量，layout 包裹着页面中的 content ，所以你只需要如下：

```html
---
layout: default
title: Home
---

<h1>{{ 'Hello world' || downcase }}</h1>
```

如上操作将和之前的输出一致。注意，你可以在 layout 中访问到页面中的 front matter。在这种情况下，title 在 index 页设置但是在 layout 中输出。

### about page

回到 `about.md` 文件，可以使用 layout。如下写入：

```md
---
layout: default
title: about
---

# about page

this page tell you a little bit about mev
```

恭喜你，现在拥有了两个页面，下面将学习如果导航跳转这两个页。

## 5. includes

这些网页聚集在一个站点上，但是却没有在他们之间进行导航，让我们来修复一下。
navigation 应该在每一个网页上，所以把它加在 layout 中是正确的地方。代替直接加入到 layout 中，借此机会学习一下 includes。

### include tag

`include` tag 允许引入来自 `_includes` 文件夹中文件的内容。Includes 对于在站点中重复一个单一来源的源代码或提升可阅读性很有用。

### include usage

创建 `_includes/navigation.html` 文件，内容如下：

```html
<nav>
  <a href="/">Home</a>
  <a href="/about.html">About</a>
</nav>
```

尝试在 `_layouts/default.html` 中添加 include tag。

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>{{ page.title }}</title>
  </head>
  <body>
    {% include navigation.html %}
    <!--  -->
    {{content}}
  </body>
</html>
```

### current page highlighting

jakyll 中的 `page.url` 变量可以获取到当前的展示的 url。 使用 `page.url` 可以检查当前页的 URL，并且标记为红色。

```html
<nav>
  <a href="/" {% if page.url == "/" %} style="color: red" {% endif %}>Home</a>
  <a href="/about" {% if page.url == "/about" %} style="color: red" {% endif %}>About</a>
</nav>
```

如果我们想添加一个新的导航选项，现在依然需要重复一写代码。下一步我们将解决这个问题。

## 6. data files

jekyll 支持从 `_data` 目录下加载 YAML、JSON 和 csv 文件的数据。data files 是一种很好的方式，可以将内容从源代码中分割出来便于维护。

### data file usage

在 Ruby 生态系统中，YAML 是一种常见的格式。
创建一个 data 文件，`_data/navigation.yml` 输入以下内容：

```yml
- name: Home
  link: /
- name: About
  link: /about.html
```

Jekyll 中可以很容易的访问到数据，使用变量 `site.data.navigation` 。之前书写每一个链接，现在可以用遍历数据代替。

```html
<nav>
  {% for item in site.data.navigation %}
    <a href="{{ item.link }}" {% if item.link == page.url %} style="color: red" {% endif %}>{{item.name}}</a>
  {% endfor %}
</nav>
```

现在输出内容会和之前一致，不同之处在于，现在可以更方便的添加一个新的导航项和改变 html 结构。

让我们看看如何处理 Jekyll 中的资源(CSS, JS and images)。

## 7. assets

Jekyll 可以直接使用 CSS, JS, images 和其他资源文件。将他们放到站点的文件夹中，他们将被复制到构建的站点。
Jekyll 常常使用如下的结构组织资源文件：

```
.
├── assets
│   ├── css
│   ├── images
│   └── js
...
```

### sass

在 `_includes/navigation.html` 中使用行内样式不是最佳实践，代替使用 class 添加样式。

```html
<nav>
  {% for item in site.data.navigation %}
    <a href="{{ item.link }}" {% if item.link == page.url %}class="current"{% endif %}>{{ item.name }}</a>
  {% endfor %}
</nav>
```

你可以使用标准的 css 设置样式，这里将使用 Sass。Sass 是对 CSS 的完美扩展，它直接传入了 Jekyll。
首先，创建一个 sass 文件，`assets/css/styles.scss`，输入以下内容：

```scss
---
---

@import 'main';
```

最上边的空的 front matter 表示告诉 Jekyll 需要处理文件。
`@import "main";` 告诉 Sass 在 `sass` 目录查找名为 `main.scss` 的文件（`_sass/`默认情况下直接位于您网站的根文件夹下）。
在这个阶段，你讲有一个主要的 css 文件。这对于大型项目来说，可以很好的组织 css。
在 `_sass/main.scss` 创建一个 sass 文件，输入以下内容：

```scss
.current {
  style: green;
}
```

现在需要在 layout 中引用样式表。
打开 `_layout/default.html`，添加样式表到 `<head>`，添加以下内容：

```html
<!DOCTYPE html>
<head>
  <meta charset="utf-8" />
  <title>{{page.title}}</title>
  <link rel="stylesheet" href="/assets/css/styles.css" />
</head>
<body>
  {% include navigation.html %}
  <!--  -->
  {{content}}
</body>
```

这里引用的 `style.css` 是 Jekyll 依据之前在 `assets/css/styles.scss` 生成的。
现在当前所在页的导航项的会变成绿色。
下面，让我们看看 Jekyll 最流行的功能，blogging。

## 8. blogging

你可能想知道怎样才能不用数据库就可以拥有一个博客。在真正的 Jekyll 风格中，博客仅由文本文件驱动。

### posts

博客的文章在 `_posts` 文件中，文章的文件名有特殊的格式：发布时间，之后是标题，然后是拓展名。
创建你的第一篇文章，输入如下内容：

```md
---
layout: post
author: jill
---

A banana is an edible fruit – botanically a berry – produced by several kinds
of large herbaceous flowering plants in the genus Musa.

In some countries, bananas used for cooking may be called "plantains",
distinguishing them from dessert bananas. The fruit is variable in size, color,
and firmness, but is usually elongated and curved, with soft flesh rich in
starch covered with a rind, which may be green, yellow, red, purple, or brown
when ripe.
```

除了 author 和 layout，它和 about.md 一样。author 是自定义的变量名称，它不是必须的也可以设置为其他的名称。

### layout

`post` 布局并不存在，所以需要创建 `_layouts/post.html`，输入如下内容：

```html
---
layout: default
---

<h1>{{ page.title }}</h1>
<p>{{ page.date | date_to_string }} - {{ page.author }}</p>

{{ content }}
```

这是一个继承布局的例子，文章的布局输出被默认布局包裹的标题、时间、作者和内容。
还要注意 date_to_string 过滤器，它将日期格式化为更好的格式。

### list posts

现在无法导航到博客文章，典型的博客有一个展示文章列表的页面，接下来我们就做一下这个页。
Jekyll 中 `site.posts` 可以访问到文章。
在根目录创建一个 `blog.html`，输入如下内容：

```html
---
layout: default
---

<ul>
  {% for post in site.posts %}
  <li>
    <a href="{{ post.url }}">{{ post.title }}</a>
    <p>{{ post.excerpt }}</p>
  </li>
  {% endfor %}
</ul>
```

- `post.url`由 Jekyll 自动设置为帖子的输出路径。
- `post.title`拉取文章的文件名，并且可以在 front matter 中的 title 重写。
- `post.excerpt`默认的是内容的第一个段落。

同样也需要通过主导航导航到当前页。打开 `_data/navigation.yml` ，为博客页添加一个条目：

```yml
- name: Home
  link: /
- name: About
  link: /about.html
- name: Blog
  link: /blog.html
```

接下来，我们将专注于为每个帖子作者创建一个页面。

## 9.collections

在作者的主页展示简介及其发布的文章。
做这些，将要用到 collections。collections 类似于帖子，只是内容不必按日期分组。

### Configuration

要建立 collections，需要告诉 Jekyll。 Jekyll 配置发生在名为 `_config.yml` 的文件中。
创建文件 `_config.yml`，输入以下内容：

```yml
collections:
  authors:
```

重启 Jekyll 服务重新载入配置。在终端键入 `ctrl + c` 停止服务，之后 `jekyll serve` 重启服务。

### add authors

collections 的文档位于根目录的 `_*collections_name*` 文件夹下。本例中，位于 `_authors` 下。
为每位作者创建一个文档：
`_authors/lune.md`

```md
---
short_name: lune
name: Lune Shao
position: Chief Editor
---

Jill is an avid fruit grower based in the south of France.
```

### staff page

添加一个列表页，展示网站上所有的作者。在 Jekyll 中，`site.authors` 可以方式 collection。
创建 `staff.html`，遍历 `site.author` 输出所有作者：

```html
---
layout: default
title: Staff
---

<h1>Staff</h1>

authors
<ul>
  {% for author in site.authors %}
  <li>
    <h2>{{ author.name }}</h2>
    <h3>{{ author.position }}</h3>
    <p>{{ author.content | markdownify }}</p>
  </li>
  {% endfor %}
</ul>
```

由于内容是 markdown，因此您需要通过 markdownify 过滤器运行它。在布局中使用 {{content}} 输出时，会自动发生这种情况。
在主导航也需要导航到当前页。打开 `_data/navigation.yml` 输入如下内容：

```yml
- name: Home
  link: /
- name: About
  link: /about.html
- name: Blog
  link: /blog.html
- name: Staff
  link: /staff.html
```

### output a page

默认情况下，集合不输出文档页面。在这种情况下，我们希望每个作者都有自己的页面，所以我们来调整集合配置。
打开 `_config.yml` 添加 `output: true` 到 author collection 的配置：

```yml
collections:
  authors:
    output: true
```

您可以使用 author.url 链接到输出页面。
将链接添加到 staff.html 页面：

```html
---
layout: default
title: Staff
---

<h1>Staff</h1>

<ul>
  {% for author in site.authors %}
  <li>
    <h2><a href="{{ author.url }}">{{ author.name }}</a></h2>
    <h3>{{ author.position }}</h3>
    <p>{{ author.content | markdownify }}</p>
  </li>
  {% endfor %}
</ul>
```

就像文章一样，您需要为作者创建布局。
创建 `_layouts/author.html` 输入以下内容:

```html
---
layout: default
---

<h1>{{ page.name }}</h1>
<h2>{{ page.position }}</h2>

{{ content }}
```

### front matter defaultsPermalink

现在需要配置作者文章使用作者布局，你可以想之前一项在 front matter 中配置。
你想让文章使用文章布局，作者使用作者布局，其他使用默认布局。
可以通过在 `_config.yml` 中使用 front matter defaults 完成。
您可以设置适用于默认设置的范围，然后设置您想要的 front matter 内容。
输入如下内容到 `_config.yml`：

```yml
collections:
  authors:
    output: true

defaults:
  - scope:
      path: ''
      type: 'authors'
    values:
      layout: 'author'
  - scope:
      path: ''
      type: 'posts'
    values:
      layout: 'post'
  - scope:
      path: ''
    values:
      layout: 'default'
```

现在可以移除每个页面 front matter 中的 layout。注意，每次更改 `_config.yml`，都要重启服务，以让配置生效。

### list author's post

让我们列出作者在其页面上发布的帖子。为此，您需要将作者 short_name 与帖子作者匹配。您可以使用它按作者过滤帖子。
遍历 `_layouts/author.html` 中的此过滤列表，以输出作者的帖子：

```html
---
layout: default
---

<h1>{{ page.name }}</h1>
<h2>{{ page.position }}</h2>

{{ content }}

<h2>Posts</h2>
<ul>
  {% assign filtered_posts = site.posts | where: 'author', page.short_name %} {%
  for post in filtered_posts %}
  <li><a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
```

### link to authors page

这些帖子引用了作者，因此我们将其链接到作者的页面。您可以使用 `_layouts/post.html` 中的类似过滤技术来执行此操作：

```html
---
layout: default
---

<h1>{{ page.title }}</h1>

<p>
  {{ page.date | date_to_string }} {% assign author = site.authors | where:
  'short_name', page.author | first %} {% if author %} -
  <a href="{{ author.url }}">{{ author.name }}</a>
  {% endif %}
</p>

{{ content }}
```

## 10. 部署

### Gemfile

最好为您的网站添加一个 Gemfile。它确保了 Jekyll 和 gems 在不同的环境的版本保持一致。
在根目录创建一个 Gemfile，输入以下内容：

```Gemfile
source 'https://rubygems.org'

gem 'jekyll'
```

在终端运行 `bundle install`，这将安装 gem 并创建 Gemfile.lock，该文件将锁定当前 gem 版本以供将来 `bundle install`。如果你想更新 gem 版本可以运行 `bundle update`。
当使用 Gemfile 时，你将在运行像 `jekyll serve` 这样的命令时,前面加上前缀 `bundle exec`。完整的命令如下：

```
bundle exec jekyll serve
```

这限制了您的 Ruby 环境只能使用 Gemfile 中设置的 gem。

### Plugins

Jekyll 插件允许你创建特定于站点的自定义生成内容。
几乎在所有 Jekyll 网站上都有三个官方插件可用：

- [jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap) 创建一个 sitemap 文件帮助搜索引擎索引内容
- [jekyll-feed](https://github.com/jekyll/jekyll-feed) 为站点文章创建一个 RSS feed
- [jekyll-seo-tag](https://github.com/jekyll/jekyll-seo-tag) 添加 meta 标签帮助 SEO

为了使用这些插件，首先需要添加他们到 Gemfile。如果你将它们放到 `jekyll_plugins` group，它们将自动的被加载到 Jekyll：

```Gemfile
source 'https://rubygems.org'

gem 'jekyll'

group :jekyll_plugins do
  gem 'jekyll-sitemap'
  gem 'jekyll-feed'
  gem 'jekyll-seo-tag'
end
```

之后添加这些行到 `_config.yml`:

```yml
plugins:
  - jekyll-feed
  - jekyll-sitemap
  - jekyll-seo-tag
```

现在运行 `bundle update` 来安装它们。（这一步安装包会比较慢，需要等一下）
`jekyll-sitemap` 不需要任何设置，它会在构建的时候自动生成。
对于 `jekyll-feed` 和 `jekyll-seo-tag`，您需要将标签添加到 `_layouts/default.html`:

```txt
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>{{ page.title }}</title>
    <link rel="stylesheet" href="/assets/css/styles.css" />
    {% feed_meta %} {% seo %}
  </head>
  <body>
    {% include navigation.html %} {{ content }}
  </body>
</html>
```

重启 Jekyll 服务，检查添加到<head>的这些标签。

### Environments

有时你可能想要在生产环境输出一些内容，开发环境不输出。分析用的脚本是最常见的示例。
实现这个你可以使用 `environments`。你可以在运行命令时，使用 `JEKYLL_ENV` 环境变量设置环境。例如：

```
JEKYLL_ENV=production bundle exec jekyll build
```

`JEKYLL_ENV` 默认是 development。您可以在 liquid 中使用 `jekyll.environment` 应用 JEKYLL_ENV。仅在生产环境输出输出分析脚本，添加如下代码：

```html
{% if jekyll.environment == "production" %}
<script src="my-analytics-script.js"></script>
{% endif %}
```

### Deployment

最后一步是将站点添加到生产服务器。最基本的方法是运行生产版本：

```
JEKYLL_ENV=production bundle exec jekyll build
```

并将`_site` 的内容复制到您的服务器。
更好的方法是使用 CI 或第三方来自动执行此过程。

参考：[使用 git hooks(post-receive)实现简单的远程自动部署](https://www.imqianduan.com/git-svn/335.html)及[官方文档](https://jekyllrb.com/docs/deployment/automated/)

- 第一步、使用 ssh 登入自己的服务器，在终端输入（登入成功后默认进入`/root` 目录）：

```
ssh user@deployer@example.com
```

- 第二步、创建一个裸仓库，仓库名可任意

```
git --bare init myblog
```

- 第三步、进入裸仓库，配置 `hooks/post-receive`:

  - 如果有 `post-receive.sample` 可以执行 `cp post-receive.sample post-receive`，键入下边的代码 (.sample 文件是一些示例文件，不起作用)
  - 如果没有上边的文件可以直接自行创建 `post-receive` 文件，键入如下代码：

  ```
  $ vi post-receive   # 进入文件，输入字母 `i` 进行输入内容。
  $ # 复制以下内容确认后，键入 `esc` => `:wq`，保存。
  ```

  ```
  #!/bin/bash -l

  # Install Ruby Gems to ~/gems
  export GEM_HOME=/usr/local/gems # gem的安装目录，自行配置（gem environment gemdir 命令可查看）
  export PATH=$GEM_HOME/bin:$PATH

  GIT_REPO=$HOME/myrepo.git # 裸仓库的地址，自行配置
  TMP_GIT_CLONE=$HOME/tmp/myrepo
  GEMFILE=$TMP_GIT_CLONE/Gemfile
  PUBLIC_WWW=/var/www/myblog # web服务的地址，自行配置（需先创建）

  git clone $GIT_REPO $TMP_GIT_CLONE
  BUNDLE_GEMFILE=$GEMFILE bundle install
  BUNDLE_GEMFILE=$GEMFILE bundle exec jekyll build -s $TMP_GIT_CLONE -d $PUBLIC_WWW
  rm -Rf $TMP_GIT_CLONE
  exit
  ```

  - 保存后，给 post-receive 文件执行权限

  ```
  $ chmod +x post-receive
  ```

- 第四步、在本地的 git 仓库添加部署的远端地址

```
$ git remote add deploy deployer@example.com:~/myrepo.git # deployer@example.com(用户名及服务器IP或域名)；~/myrepo.git（裸仓库的路径）
```

- 第五步、部署。在本地仓库执行推送，然后查看是否成功部署。

```
$ git push deploy master
```

- 常见错误：
  - 1、确认已安装`ruby`、`gem`、`jekyll`、`bundle`。并且 `ruby` 版本要高于 `2.3.`。
  - 2、记得给 post-receive 添加执行权限。
  - 3、
    ```
    remote: 正克隆到 '/root/tmp/myrepo'...
    remote: 完成。
    remote: hooks/post-receive:行13: bundle: 未找到命令
    remote: hooks/post-receive:行14: bundle: 未找到命令
    To *.*.*.*:~/myrepo.git
    f5d6969..0be15d2  master -> master
    ```
    解决办法： 安装 bundle
  - 4、
    ```
    remote: Don't run Bundler as root. Bundler can ask for sudo if it is needed, and
    remote: installing your bundle as root will break this application for all non-root
    remote: users on this machine.
    ```
    这个问题出现之后就卡住不动了，看到一个[答案](https://stackoverflow.com/questions/55909543/you-must-use-bundler-2-or-greater-with-this-lockfile-when-running-docker-compos)，按答案装了一下就可以了。

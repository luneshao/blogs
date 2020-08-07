---
title: "Vue Loader笔记"
description: "记录Vue Loader文档中新学到的知识。"
tags: ["前端", "vue"]
date: 2020-07-21T17:06:16+08:00
type: "post"
author: "luneShao"
draft: false
---
Vue Loader 是一个 webpack 的 loader，它允许你以一种名为单文件组件 (SFCs)的格式撰写 Vue 组件。

- 允许为 `Vue` 组件的每个部分使用其它的 `webpack loader`；

- 允许在一个 `.vue` 文件中使用自定义块，并对其运用自定义的 `loader` 链；

- 使用 `webpack loader` 将 `<style>` 和 `<template>` 中引用的资源当作模块依赖来处理；

- 为每个组件模拟出 scoped CSS；

- 在开发过程中使用热重载来保持状态。

## 起步

每个 vue 包的新版本发布时，一个相应版本的 `vue-template-compiler` 也会随之发布。编译器的版本必须和基本的 vue 包保持同步，这样 `vue-loader` 就会生成兼容运行时的代码。**这意味着你每次升级项目中的 vue 包时，也应该匹配升级 vue-template-compiler。**

### webpack 配置

除了通过一条规则将 `vue-loader` 应用到所有扩展名为 `.vue` 的文件上之外，请确保在你的 `webpack` 配置中添加 `Vue Loader` 的插件：

```js
// webpack.config.js
const VueLoaderPlugin = require('vue-loader/lib/plugin')

module.exports = {
  module: {
    rules: [
      // ... 其它规则
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      }
    ]
  },
  plugins: [new VueLoaderPlugin()]
}
```

**这个插件是必须的！** 它的职责是将你定义过的其它规则复制并应用到 `.vue` 文件里相应语言的块。

### 处理资源路径

当 Vue Loader 编译单文件组件中的 `<template>` 块时，它也会将所有遇到的**资源 URL 转换为 webpack 模块请求**。

- 如果路径是绝对路径 (例如 `/images/foo.png`)，会原样保留。

- 如果路径以 `.` 开头，将会被看作相对的模块依赖，并按照你的本地文件系统上的目录结构进行解析。

- 如果路径以 `~` 开头，其后的部分将会被看作模块依赖。这意味着你可以用该特性来引用一个 Node 依赖中的资源：

```html
<img src="~some-npm-package/foo.png">
```

- 如果路径以 `@` 开头，也会被看作模块依赖。如果你的 `webpack` 配置中给 `@` 配置了 `alias`，这就很有用了。所有 `vue-cli` 创建的项目都默认配置了将 `@` 指向 `/src`。

### 使用预处理器

#### Sass vs SCSS

注意 `sass-loader` 会默认处理不基于缩进的 `scss` 语法。为了使用基于缩进的 `sass` 语法，你需要向这个 `loader` 传递选项：

```js
// webpack.config.js -> module.rules
{
  test: /\.sass/,
  use: [
    'vue-style-loader',
    'css-loader',
    {
      loader: 'sass-loader',
      options: {
        indentedSyntax: true,
        // sass-loader version >= 8
        sassOptions: {
          indentedSyntax: true
        }
      }
    }
  ]
}
```

#### 共享全局变量

`sass-loader` 也支持一个 `prependData` 选项，这个选项允许你在所有被处理的文件之间共享常见的变量，而不需要显式地导入它们：

```js
// webpack.config.js -> module.rules
{
  test: /\.scss$/,
  use: [
    'vue-style-loader',
    'css-loader',
    {
      loader: 'sass-loader',
      options: {
        // 你也可以从一个文件读取，例如 `variables.scss`
        // 如果 sass-loader 版本 < 8，这里使用 `data` 字段
        prependData: `$color: red;`
      }
    }
  ]
}
```

### Scoped CSS

#### 深度作用选择器

如果你希望 scoped 样式中的一个选择器能够作用得“更深”，例如影响子组件，你可以使用 >>> 操作符：

```scss
<style scoped>
.a >>> .b { /* ... */ }
</style>
```

有些像 Sass 之类的预处理器无法正确解析 `>>>`。这种情况下你可以使用 `/deep/` 或 `::v-deep` 操作符取而代之——两者都是 `>>>` 的别名，同样可以正常工作。


#### 动态生成的内容

通过 `v-html` 创建的 `DOM` 内容**不受** `scoped` 样式影响，但是你仍然可以通过深度作用选择器来为他们设置样式。

### CSS Modules

#### 用法

首先，CSS Modules 必须通过向 `css-loader` 传入 `modules: true` 来开启：

```js
// webpack.config.js
{
  module: {
    rules: [
      // ... 其它规则省略
      {
        test: /\.css$/,
        use: [
          'vue-style-loader',
          {
            loader: 'css-loader',
            options: {
              // 开启 CSS Modules
              modules: true,
              // 自定义生成的类名
              localIdentName: '[local]_[hash:base64:8]'
            }
          }
        ]
      }
    ]
  }
}
```

然后在你的 `<style>` 上添加 `module` 特性：

```vue
<style module>
.red {
  color: red;
}
.bold {
  font-weight: bold;
}
</style>
```

这个 `module` 特性指引 Vue Loader 作为名为 `$style` 的计算属性，向组件注入 CSS Modules 局部对象。然后你就可以在模板中通过一个动态类绑定来使用它了：

```vue
<template>
  <p :class="$style.red">
    This should be red
  </p>
</template>
```

#### 可选用法

如果你只想在某些 Vue 组件中使用 CSS Modules，你可以使用 `oneOf` 规则并在 `resourceQuery` 字符串中检查 `module` 字符串：

```js
// webpack.config.js -> module.rules
{
  test: /\.css$/,
  oneOf: [
    // 这里匹配 `<style module>`
    {
      resourceQuery: /module/,
      use: [
        'vue-style-loader',
        {
          loader: 'css-loader',
          options: {
            modules: true,
            localIdentName: '[local]_[hash:base64:5]'
          }
        }
      ]
    },
    // 这里匹配普通的 `<style>` 或 `<style scoped>`
    {
      use: [
        'vue-style-loader',
        'css-loader'
      ]
    }
  ]
}
```

#### 自定义的注入名称

在 `.vue` 中你可以定义不止一个 `<style>`，为了避免被覆盖，你可以通过设置 `module` 属性来为它们定义注入后计算属性的名称。

```vue
<style module="a">
  /* 注入标识符 a */
</style>

<style module="b">
  /* 注入标识符 b */
</style>
```

### 热重载
#### 状态保留规则

- 当编辑一个组件的 `<template>` 时，这个组件实例将就地重新渲染，并保留当前所有的私有状态。能够做到这一点是因为模板被编译成了新的无副作用的渲染函数。

- 当编辑一个组件的 `<script>` 时，这个组件实例将就地销毁并重新创建。(应用中其它组件的状态将会被保留) 是因为 `<script>` 可能包含带有副作用的生命周期钩子，所以将重新渲染替换为重新加载是必须的，这样做可以确保组件行为的一致性。这也意味着，如果你的组件带有全局副作用，则整个页面将会被重新加载。

- `<style>` 会通过 `vue-style-loader` 自行热重载，所以它不会影响应用的状态。

[Vue Loader 文档](https://vue-loader.vuejs.org/zh/)
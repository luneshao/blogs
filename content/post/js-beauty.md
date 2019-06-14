+++
title = "js 代码美化"
description = "js代码美化，截取了一些自己学到的。"
tags = ["前端", "Javascript"]
date = "2019-05-27"
location = "JiNan, CN"
type = "post"
draft = "true"
keywords = "javascript,代码美化,前端"
+++

[github完整文章连接](https://github.com/airbnb/javascript)

### Objects

* 1.1 将简写属性，放在对象定义的开始部分。

```js
// bad
const obj = {
  key1: 2,
  key2,
  key3: 2,
}

// good
const obj = {
  key2,
  key4,
  key1: 2,
  key3: 2,
}
```

* 1.2 不要直接调用 `Object.prototype`，例如 `hasOwnProperty`， `propertyIsEnumerable`，

因为这些名字没有被 `Javascript` 保留，如果被重新定义就会被覆盖。所以，最好是在原型链上调用。

[MDN相关连接](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/hasOwnProperty#Using_hasOwnProperty_as_a_property_name)

```js
// bad 
const a = obj.hasOwnProperty('name')

// good 
const a = Object.prototype.hasOwnProperty.call(obj, 'name')

// best 
// has.js
const has = Object.prototype.hasOwnProperty

// use.js
import has from './has.js'
const a = has.call(obj, 'name')
```

* 1.3 使用 **解构赋值** 和 **拓展运算** 实现对象的浅拷贝。

* 1.4 `Object` 的 `delete` 运算符

用于删除对象的某个属性，如果没有指向这个属性的引用，那它最终会被释放。

```js
delete object.property 
delete object['property']
```

```js
const obj1 = {a: 1, b: 2}

// very bad
const copy = Object.assign(obj1, {c: 3}) // 会修改源数据

// bad
const copy = Object.assign({}, obj1, {c: 3})

// good 
const copy = {...obj1, {c: 3}}

const {a, ...z} = copy // z = {b: 2, c: 3}
```

### Array

* 2.1 将可迭代的对象转换为数组，最好使用 **拓展运算符 ...**，而不是 `Array.from`

```js
const array = document.querySelectorAll('div')

// good
const itArr = Array.from (array)

// best 
const itArr = [...array]

```

* 2.2 使用 `Array.from()` 将一个类数组的对象转换为数组。

```js
const obj = {0: 'a', 1: 'b', 2: 'c'}

// bad
const arr = Array.prototype.slice.call(arrLike);

// good
const arr = Array.from (obj)
```

> **拓展延伸：** 

  

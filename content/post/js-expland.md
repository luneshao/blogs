+++
title = "=8 js 拓展"
description = "js 拓展"
tags = ["Javascrip", "前端"]
date = "2019-05-27"
location = "JiNan, CN"
type = "post"
keywords = "javascript,Date,前端"
+++

## 1.Array

### 1.1 将类数组转化为数组

* `Array.prototype.slice.call()` 方法：

  [MDN slice相关](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/slice#Array-like)

  `slice` 方法可以用来将一个类数组（Array-like）对象/集合转换成一个新数组。你只需将该方法绑定到这个对象上。

  `Array.slice(start, end)` 方法用来截取数组 `start` 到 `end` （不包含 `end`）值，并返回一个新数组。

  ```js
  function list () {
    return Array.property.slice.call(arguments)
  }

  list(1, 2, 3)
  ```

  除此以外可以使用 `[].splice.call(arguments)` 代替，也可以使用 `bind` 来简化过程。

  ```js
  const unboundSlice = Array.property.slice
  const slice = Function.property.bind.call(unboundSlice)

  function list () {
    return slice(arguments)
  }

  list(1, 2, 3)
  ```

  * `Array.from` 方法

  [MDN Array.from](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array/from)

  `Array.from()` 方法从一个类似数组或可迭代对象中创建一个新的数组实例。
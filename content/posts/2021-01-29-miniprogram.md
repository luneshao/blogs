---
title: "uniapp 开发小程序压缩图片"
date: 2021-01-29T10:11:28+08:00
description: ""
tags: ['小程序']
type: "post"
author: "luneShao"
featured_image: "/img/cover.jpg"
draft: false
---
### uniapp 小程序压缩图片
小程序压缩图片和普通 html 压缩图片思路一致。

#### 步骤为：

1. 获取图片信息
2，获取canvas 节点
3. 创建图片对象
4. 压缩图片

#### 详细代码

```js
/**
 * 获取图片信息
 * @param {string} imgObj 图片对象path
 * @param {function} fn 回调函数
 * @returns {ojbect} cbParams 
 * {
 *  height: 722,
 *  width: 1366,
 *  type: 'png',
 *  path: '',
 *  orientation: 'up',
 *  errMsg: ''
 * }
 */
function getImageObject (src, fn) {
  uni.getImageInfo({
    src: src,
    success (res) {
      fn(res)
    }
  })
}

/**
 * 压缩图片
 * @param {object} img 图片
 * @param {function} fn 回调函数
 */
function compressImg (img, fn) {
  const selectorQuery = uni.createSelectorQuery()
  selectorQuery.select('#canvas')
    .fields({node: true, size: true})
    .exec(res => {
      const canvas = res[0].node
      const ctx = canvas.getContext('2d')
      canvas.height = img.height
      canvas.width = img.width

      let seal = canvas.createImage();
      seal.src = img.path;
      seal.onload = () => {
        ctx.drawImage(seal, 0, 0, img.width, img.height)
        const url = canvas.toDataURL('image/jpeg', .1)
        fn(url)
      }
    })
}
```

新发现

base64字符的长度就是文件尺寸 :P

(ps::::这也太厉害了 👍👍👍👍👍👍👍👍)
```js
/**
 * 返回图片尺寸
 * @param {string} url base64 url
 * @param {functino} fn 返回图片尺寸
 */
function getSize(url, fn) {
  let arr = url.split(',')[1],
    bstr = atob(arr),
    n = bstr.length;
  fn(n)
}
```

#### 使用方法
```js
getImageObject(list[0].file.path, img => {
  compressImg(img, res => {
    console.log(res);
  })
})
```

### 普通压缩图片处理
这里假设压缩上传的文件。

#### 步骤为：

1. 获取 `File` 文件 
2. `File` && filereader.readAsDataURL(file) 生成 `base64` 编码
3. 创建 `Image` 对象 && `Image.src = base64 url`
4. 创建 `canvas` && `ctx.drawImage()` && `canvas.toDataURL(type, encoderOptions)`
5.  生成 `base64 url`

#### 详细代码
```js
  function Compress(obj) {
    this.file = obj.file
    this.fileType = this.file.type // mime tyoe
    this.filename = this.file.name // 文件名
    this.beforeSize = this.file.size
    this.factor = obj.factor
  }

  /**
  * 生成 base64 url
  * @params { File } file 文件
  * @params { function } fn 回调函数
  * */
  function toDataurl(file, fn) {
    const filereader = new FileReader()
    filereader.readAsDataURL(file)
    
    filereader.onload = () => {
      const url = filereader.result
      if (url) {
        // ---------vvvvvvvv 测试句 vvvvvvvv---------
        addImg(url)
        // ---------^^^^^^^ 测试句 ^^^^^^^----------
        fn(url)
        console.info('before: ' + file.size)
      } else {
        console.error('filereader error');
      }
    }
  }

  /**
  * 创建 image 对象
  * @params { string } base64 url
  * @params { string } filename 文件名
  * @params { function } fn 回调函数
  * */
  function dataurl2File (url, filename, fn) {
    let type = url.split(',')[0].replace(/^.*:(.*);.*$/, '$1'), 
          arr = url.split(',')[1], 
          bstr = atob(arr), 
          n = bstr.length;
    let u8arr = new Uint8Array(n); 
  
    while(n --) {
      u8arr[n] = bstr.charCodeAt(n)
    }

    const file = new File([u8arr], filename, {type: type})
    fn(file)
  }

  /**
  * 创建 image 对象
  * @params { string } base64 编码
  * @params { function } fn 回调函数
  * */
  function createImg(dataurl, fn) {
    const img = new Image()
    img.src = dataurl
    img.onload = () => {
      fn(img)
    }
  }

  Compress.prototype = {
    /**
    * 文件生成 base64 url => 创建 image 对象
    * */
    init() {
      toDataurl(this.file, url => {
        createImg(url, img => {
          this.run(img)
        })
      })
    },
    /**
    * 创建 canvas 对象 => 压缩并转化为图片
    * */
    run(img) {
      const canvas = document.createElement('canvas')
      const ctx = canvas.getContext('2d')
      canvas.width = img.width
      canvas.height = img.height
      ctx.drawImage(img, 0, 0, canvas.width, canvas.height)

      // 此句为实现压缩关键句
      this.newDataurl = canvas.toDataURL('image/jpeg', this.factor)
      // ---------vvvvvvvv 测试句 vvvvvvvv---------
      addImg(this.newDataurl)
      // ---------^^^^^^^ 测试句 ^^^^^^^----------

      dataurl2File(this.newDataurl, this.filename, (file) => {
        console.info('after: ' + file.size);

        if (this.beforeSize > file.size) {
          console.info('压缩成功');
        } else {
          console.error('压缩失败');
        }
      })
    }
  }
  /**
  * 对比压缩前后的两个图片
  * */
  function addImg (url) {
    const img = new Image()
    img.src = url

    document.body.appendChild(img)
  }
```

#### 使用方法
```js
  /**
  * 获取上传文件，创建压缩图片实例，压缩图片
  * */
  function compressFile() {
    const dom = document.querySelector('[name=file]')

    dom.addEventListener('change', () => {
      const file = dom.files[0]
      const cp = new Compress({
        file: file,
        factor: 0.1
      })
      cp.init()
    })
  }

  window.onload = function () {
    compressFile()
  }
```

### 报错处理
1、 小程序 canvas drawImage 报错：

[TypeError: Failed to execute 'drawImage' 报错](https://developers.weixin.qq.com/community/develop/doc/00024466bc81d0b5510a9e63b51c00)
[解决办法](https://developers.weixin.qq.com/community/develop/doc/000e801ba445d060cdb9b078b56000?_at=1583717387456&jumpto=reply&commentid=000ccc3025020865ccb96fc95514&parent_commentid=00062a9c9ecc4873c3b9e2e46560)

```js
let seal = canvas.createImage();
seal.src = img.path;
seal.onload = () => {
  ctx.drawImage(seal, 0, 0, img.width, img.height)
  // 压缩图片
  const url = canvas.toDataURL('image/jpeg', .1)
}
```

⚠️：压缩图片时要注意 `canvas.toDataURL` 的第一个参数是 __image/jpeg__ 或 __image/webp__ 时可以压缩。8-)

> 在指定图片格式为 __image/jpeg__ 或 __image/webp__ 的情况下，可以从 0 到 1 的区间内选择图片的质量。如果超出取值范围，将会使用默认值 0.92。其他参数会被忽略。

### 参考文章
[了解JS压缩图片，这一篇就够了](https://developer.51cto.com/art/202008/623099.htm)
[使用canvas压缩图片大小](https://www.jianshu.com/p/f46195810c3b)
[HTMLCanvasElement.toDataURL()](https://developer.mozilla.org/zh-cn/docs/Web/API/HTMLCanvasElement/toDataURL)
[Uint8Array](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Uint8Array)
[Blob](https://developer.mozilla.org/zh-CN/docs/Web/API/Blob)



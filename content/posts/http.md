<!--
 * @Date: 2019-09-03 10:24:45
 * @LastEditors: LuneShao
 * @LastEditTime: 2019-09-03 15:01:16
 -->

+++
title = "httt 协议与 TCP/IP 协议"
description = "http 协议和 TCP/IP 协议的理解，以及一些简写的释义。"
tags = ['http', '前端']
date = "2019-09-03"
location = "JiNan, CN"
type = "post"
draft="true"
+++
参考微信公众号文章，记录一些知识点，原文请点击 👉🏻[微信公众号原文](https://mp.weixin.qq.com/s/69EvvR0FHR57QuhDC7bJ8w)

### 名词缩写释义

`OSI 参考模型`：OSI 参考模型是一个尝试让全世界计算机互联为网络的概念性框架，为定制标准提供参考的概念性框架。

OSI 参考模型中将计算机网络体系结构划分为 7 层，从下至上依次是：

- 物理层：光纤和网卡等，负责通信设备和网络媒体之间的互通
- 数据链路层：以太网，用来加强物理层功能
- 网络层：IP 协议和 ICMP 协议等，负责数据的路由的选择与数据转寄
- 传输层：TCP 协议和 UDP 协议等，承上启下，控制连接，控制流量
- 会话层：建立和维护会话关系
- 表达层：把数据转换为接受者系统可兼容的格式
- 应用层：HTTP、FTP、SMTP 和 SSH 等，粗犷的理解为程序员层

`TCP/IP 参考模型`：TCP/IP 协议代表一整个网络传输协议家族，而不仅仅是 TCP 协议和 IP 协议，TCP 协议和 IP 协议是该协议家族中最早通过的最核心的两个协议标准，因此该协议家族被称作 TCP/IP 协议族，也就是我们通常所说的 TCP/IP 协议。

要完成一个任务需要该协议家族的各种协议分工协作，在该参考模型中的网络体系结构一共分为 4 层，从下至上依次是：

- 网络连接层：主机与网络相连的协议，如：以太网
- 网络互联层：IP 协议和 ICMP 协议等，负责数据的路由的选择与数据转寄
- 传输层：TCP 协议和 UDP 协议等，控制端对端的连接、流量和稳定性
- 应用层：HTTP、FTP、SMTP 和 SSH 等，粗犷的理解为程序员层

`Socket`：TCP/IP 协议需要向程序员提供可编程的 API，该 API 就是 Socket

`MAC地址`： 媒体存取控制位址，也称为局域网地址，它是一个用来确认网络设备位置的位址。在 OSI 模型中，第三层网络层负责 IP 地址，第二层数据链路层则负责 MAC 位址。

`ARP`：地址解析协议，即 ARP（Address Resolution Protocol），是根据 IP 地址获取物理地址的一个 TCP/IP 协议。

`TCP 的数据结构图`：
<img width="100%" src="/img/0903-http-tcp1.webp" alt="TCP 的数据结构图">

- SYN：建立连接标识
- ACK：响应标识
- FIN：断开连接标识
- seq：seq number，发送序号
- ack：ack number，响应序号

#### 建立 TCP 连接，3 次握手

- 客户端发送 SYN, seq=x，进入 SYN_SEND 状态
- 服务端回应 SYN, ACK, seq=y, ack=x+1，进入 SYN_RCVD 状态
- 客户端回应 ACK, seq=x+1, ack=y+1，进入 ESTABLISHED 状态，服务端收到后进入 ESTABLISHED 状态

#### 进行数据传输

- 客户端发送 ACK, seq=x+1, ack=y+1, len=m
- 服务端回应 ACK, seq=y+1, ack=x+m+1, len=n
- 客户端回应 ACK, seq=x+m+1, ack=y+n+1

#### 断开 TCP 连接， 4 次挥手

- 主机 A 发送 FIN, ACK, seq=x+m+1, ack=y+n+1，进入 FNIWAIT1 状态
- 主机 B 回应 ACK, seq=y+n+1, ack=x+m+1，进入 CLOSEWAIT 状态，主机 A 收到后 进入 FINWAIT_2 状态
- 主机 B 发送 FIN, ACK, seq=y+n+1, ack=x+m+1，进入 LAST_ACK 状态
- 主机 A 回应 ACk, seq=x+m+1, ack=y+n+1，进入 TIME_WAIT 状态，等待主机 B 可能要求重传 ACK 包，主机 B 收到后关闭连接，进入 CLOSED 状态或者要求主机 A 重传 ACK，客户端在一定的时间内没收到主机 B 重传 ACK 包的要求后，断开连接进入 CLOSED 状态

根据 HTTP 协议，更加规范的来看包体的内容类型可以分为三大类，分别是 URL 参数、任意流和表单。

* 第一种，发送 URL 参数，在 Body 中的数据是这样拼接的：

```
name=harry&gender=man
```

此时，请求头Content-Type是：

```
Content-Type: application/x-www-form-urlencoded
```

* 第二种，任意流，可以是字节流、字符流或者文件流等。

例一：json等特定格式数据

```js
{ "name": "harry", "gender": "man" }
```

此时，请求头Content-Type是：

```
Content-Type: application/json
```

例二，发送任意字符串数据，在 Body 中数据是这样的：eg：'hello world'

此时，请求头Content-Type是：

```
Content-Type: text/plain
```

例三，发送已知类型的文件，比如是一张jpeg的图片

此时，请求头Content-Type是对应的文件的MimeType：

```
Content-Type: image/jpeg
```

例四，未知类型的数据或者文件，此时 Body 中可以想象成这样：

此时，请求头Content-Type是：

```
Content-Type: application/octet-stream
```

* 第三种，表单数据，因为表单具有一定的格式，所以只要按照格式上传就可以传递复杂的数据，比如可以在表单中全部传递字符串，也可以全部是文件，也可以是文件和字符串的混合，表单实际上可以理解为一个对象键值对，下面是表单的数据结构：

此时，请求头Content-Type是： [参考](https://imququ.com/post/four-ways-to-post-data-in-http.html)

```
Content-Type: multipart/form-data; boundary={boundary}
```

后边就懵了。。。
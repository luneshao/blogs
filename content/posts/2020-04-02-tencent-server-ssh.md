---
title: 修改腾讯云默认远程连接端口
description: 内容概要：修改腾讯云默认远程连接端口以及设置ssh远程连接方式。
author: luneShao
cover: "/img/cover.jpg"
tags: ["腾讯云"]
date: 2020-04-02T10:36:26+08:00
draft: false
---
### 引子
话说去年夏天，腾讯云最低端配置的服务器两百多可以包三年，我就冲了一台给自己瞎鼓捣东西用。最近在测试Jekyll的自动部署就又把服务器用起来了，然后，这两天就提示越南的IP异常登录，emmm，我又不太懂，怕服务器被黑了，就查了下解决办法。然后，就看到了[腾讯云防暴力破解防异地登陆](https://www.cnblogs.com/lurenjia1994/p/9484628.html)。然后，就踩了一个小坑“修改ssh远程登陆端口后，ssh连接一直connect refused”所以记录下。

## 正文
文章中的步骤：
> 1、 vim  /etc/ssh/sshd_config,将#Port 22解注释，然后改成其他端口，最后重启sshd服务
> 2、 重启sshd服务： systemctl restart sshd
> 3、 在腾讯云安全组开放你的端口，来源最好绑定自己ip

这里步骤是完全没问题的，但是不完整。下面我补充一下：

- 5、 根据[修改云服务器远程默认端口](https://cloud.tencent.com/document/product/213/42838#ModifyLinuxCVMPort)这篇文章，在执行完第二步之后需要配置下防火墙，放行新增端口。
- 6、 也就是我踩的坑。重启实例。具体原因我不清楚，但是不重启的话，我修改的远程端口配置就不生效。如果大佬们清楚原因还望赐教，感谢。

### 补充腾讯云其他操作
#### 一、使用ssh方式远程连接服务器
参考[腾讯云购买以及配置ssh密钥登录](https://blog.csdn.net/ouzuosong/article/details/52225087)
为了安全，在本地生成公钥、私钥配置到实例中。
步骤：
- 1、 本地执行 ssh-keygen -t rsa ,然后会出现如下内容：
  ```txt
  Generating public/private rsa key pair.
  Enter file in which to save the key (/Users/apple/.ssh/id_rsa): 
  ```
  可以在此时输入自定义的ssh文件名，默认的是 id_rsa，为了区分我修改为 id_rsa_tencent-server。之后可以一路回车，如果想设置密码可以设置，我嫌麻烦没设置。
- 2、 本地配置ssh对应的hostname及端口：
  ```vi
  $ cd ~/.ssh
  $ vi config 
  （键盘键入 i 输入内容）
  $ Host tencent
    UseKeychain yes
    User root
    Port 8888
    HostName 8.8.8.8
    IdentityFile ~/.ssh/id_rsa_tencent-server
    # 参数
    # Host: 识别模式
    # HostName: 要登陆的主机名
    # Port: 端口
    # User: 登录名
    # IdentityFile: user对应的identityFile
  ```
  以上的三行命令分别是：进入ssh菜单、编辑config文件、配置ssh对应的主机名及端口，Host、User、Port、HostName都需要自行配置。
  输入完成后，键入 esc => :wq 保存。
- 3、 使用账号、密码远程连接服务器，添加公钥。
  ```vi
  $ cd ~/.ssh
  $ vi authorized_keys
  (i)
  ```
  把公钥（id_rsa_tencent-server.pub）拷贝进去，键入 `esc` => `$ :wq` 保存 => `$ chmod 600 authorized_keys`。($ 仅表示在命令行输入，实际不需输入)
- 4、 本地命令行输入 ssh tencent ，测试配置是否成功。


#### 二、添加弹性IP
在云服务器页左侧的菜单中找到 弹性公网IP，点击 申请，完成申请弹性公网IP。（注意申请后如果闲置的话会被扣费，最好及时绑定实例）

实例页和弹性公网IP页都可以实现 EIP 绑定实例。绑定后记得修改本地ssh config 中的主机地址。

**注意**申请弹性IP并绑定实例后，公网IP将被释放，并且需要重启nginx服务恢复80端口的访问。如果想用公网IP，解绑时在弹出框勾选左下角的 “解绑后分配免费公网IP”
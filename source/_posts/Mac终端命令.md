---
title: Mac终端命令
date: 2019-06-03 11:55:06
categories: Mac
tags: Mac
---

### 出现'permission denied: 的解决办法

 ```
libs chmod 777 path
 ```



### 查看端口占用情况命令

```shell
 sudo lsof -i tcp:port
 //如： sudo lsof -i tcp:8082
```



### 看到进程的PID，可以将进程杀死。

```shell
sudo kill -9 PID
//如：sudo kill -9 3210
```




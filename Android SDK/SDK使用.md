# SDK使用

- [SDK使用](#sdk使用)
  - [概述](#概述)
  - [初始化](#初始化)
  - [日志](#日志)

## 概述

SDK的核心类为AlickSdkCore， 它是SDK功能的总入口，并提供相应的调试开关，供开发者使用。

## 初始化

在使用SDK前，必须进行如下初始化操作

```Java
AlivcSdkCore.register(Context context)
```

## 日志

SDK提供了多种日志级别模式AlivcLogLevel，打开日志后可通过tag : AliYunLog 过滤相应日志信息。

```Java
AlivcSdkCore.setLogLevel(AlivcLogLevel level)
```

同时支持，输出日志到文件

```Java
//设置输出日志的文件路径
AlivcSdkCore.setLogPath(String path)

//设置输出日志的级别
AlivcSdkCore.setDebugLoggerLevel(AlivcDebugLoggerLevel level)
```
>[返回上一级](README.md)

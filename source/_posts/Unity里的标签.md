---
title: Unity里的标签
date: 2019-05-30 14:55:23
categories:
tags:
---

```c#
//只允许一个同样的Component
[DisallowMultipleComponent]
public class Sample:MonoBehaviour{}
```

```c#
[Header("头标题")]
[RequireComponent(Type of("必须加上的组件"))]
```


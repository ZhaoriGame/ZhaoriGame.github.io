---
title: Unity记录
date: 2019-07-17 18:06:46
categories: Unity
tags: Unity
---



- 相同的材质，属性不同，避免创建新的材质

  **MaterialPropertyBlock**

```
//会创建一个新的材质
meshRenderer.material.color = clolr;
//不会创建一个新的材质
var propertyBlock = new MaterialPropertyBlock();
propertyBlock.SetColor("_Color", color);
meshRenderer.SetPropertyBlock(propertyBlock);
```


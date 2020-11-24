---
title: Blending
date: 2019-08-10 17:12:19
categories: 图形学
tags: 图形学
---

#### 混合(Blending)

混合(Blending)通常是实现物体透明度(Transparency)的一种技术。



在Unity中提供了渲染队列来实现透明效果，使用SubShader的Queue标签决定渲染队列，索引越小越早渲染。

| Background  | 索引 | 效果                               |
| ----------- | ---- | ---------------------------------- |
| Background  | 1000 | 最先绘制，通常绘制背景             |
| Geometry    | 2000 | 默认                               |
| AlphaTest   | 2450 | 需要透明度测试使用此队列           |
| Transparent | 3000 | 从后往前渲染，透明度混合使用此队列 |
| Overlay     | 4000 | 实现叠加效果                       |

Unity中实现物体透明分全透明和半透明两种：

1. 透明度测试（全透明），给定一个值，不满足条件的都将被舍弃

   函数： void clip (float x)

   例如：

   ```
   clip(float x);
   if(x<0.5f){  //舍弃小于0.5的片元
       discard;
   }
   ```

1. 透明度混合（半透明），Blend是Unity提供的设置混合模式的命令。想要实现半透明的效果就需要把当前自身的颜色和已经存在的颜色缓冲中的颜色值进行混合。

   一般的混合都是通过以下方程来实现：

   ![](https://i.loli.net/2019/07/13/5d29cc8754c2f30953.png)

   - C source：源颜色向量。这是源自纹理的颜色向量。
   - C destination：目标颜色向量。这是当前储存在颜色缓冲中的颜色向量。
   - F source：源因子值。指定了alpha值对源颜色的影响。
   - F destination：目标因子值。指定了alpha值对目标颜色的影响。

   例如：要实现红和绿两种颜色的混合

   ![](https://i.loli.net/2019/07/13/5d29cd84b9aa434910.png)

   结果就是重叠方形的片段包含了一个60%绿色，40%红色的一种脏兮兮的颜色：

   ![](https://i.loli.net/2019/07/13/5d29cdb288de887569.png)

​        要想让混合在多个物体上工作，我们需要最先绘制最远的物体，最后绘制最近的物体。普通不需要混合的物体仍然可以使用深度缓冲正常绘制，所以它们不需要排序。但我们仍要保证它们在绘制（排序的）透明物体之前已经绘制完毕了。当绘制一个有不透明和透明物体的场景的时候，大体的原则如下：

1. 先绘制所有不透明的物体。
2. 对所有透明的物体排序。
3. 按顺序绘制所有透明的物体。

在Unity中为了得到透明物体的排序我们需要开启深度写入，但这会使透明无法进行，所以需要两个Pass来渲染，第一个开启深度写入，但不输出颜色，第二个Pass进行正常的透明度混合。

```
Pass{
    ZWrite On
    ColorMask 0
}
Pass{
    //混合颜色
}
```

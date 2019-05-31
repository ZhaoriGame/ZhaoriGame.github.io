---
title: CG标准函数库
date: 2019-05-31 10:01:33
categories: 图形学
tags: 图形学
---

### Cg 标准函数库 

-- 来自《 GPU编程与CG语言GPU-Programming-AndCgLanguage-Primer》

1. 数学函数（Mathematical Functions）;

2. 几何函数(Geometric Functions)；

3. 纹理映射函数(Texture Map Functions)；

4. 偏导数函数(Derivative Functions)；

5. 调试函数(Debugging Function)；

### 数学函数（Mathematical Functions）

列举了 Cg 标准函数库中所有的数学函数，这些数学函数用于执行数学上常用计算，包括：三角函数、幂函数、园函数、向量和矩阵的操作函数。这些函数都被重载，以支持标量数据和不同长度的向量作为输入参数。

| 函数         | 功能                                                         |
| ------------ | ------------------------------------------------------------ |
| abs(x)       | 返回输入参数的绝对值                                         |
| acos(x)      | 反余切函数，输入参数范围为[-1,1]， 返回[0,*p* ]区间的角度值  |
| all(x)       | 如果输入参数均不为 0，则返回 ture；否则返回 flase。&&运算    |
| any(x)       | 输入参数只要有其中一个不为 0，则返回true。\|\|运算           |
| asin(x)      | 反正弦函数,输入参数取值区间为[-1,1] ，返回角度值范围为⎡⎢- *p* , *p* ⎤⎥⎣	2   2 ⎦ |
| atan(x)      | 反正切函数，返回角度值范围为⎡- *p* , *p* ⎤⎢⎣	2  2 ⎥⎦      |
| atan2(y,x)   | 计算 y/x 的反正切值。实际上和 atan(x)函数功能完全一样，至少输入参数不同。atan(x) =atan2(x, float(1))。 |
| ceil(x)      | 对输入参数向上取整。例如：ceil(float(1.3)) ，其返回值为 2.0  |
| clamp(x,a,b) | 如果 x 值小于 a，则返回 a；如果 x 值大于 b，返回 b；否则，返回 x。 |
| cos(x)       | 返回弧度 x 的余弦值。返回值范围为[-1,1]                      |
| cosh(x)      | 双曲余弦（hyperbolic cosine）函数，计算 x的双曲余弦值。      |
| cross(A,B)   | 返回两个三元向量的叉积(cross product)。注意，输入参数必须是三元向量！ |
| degrees(x)   | 输入参数为弧度值(radians)，函数将其转换为角度值(degrees)     |

| determinant(m)       | 计算矩阵的行列式因子。                                       |
| :------------------- | :----------------------------------------------------------- |
| dot(A,B)             | 返回A 和 B 的点积(dot product)。参数 A 和 B可以是标量，也可以是向量（输入参数方面， 点积和叉积函数有很大不同）。 |
| exp(x)               | 计算*e**x* 的值，e= 2.71828182845904523536                   |
| exp2(x)              | 计算2*x* 的值                                                |
| floor(x)             | 对输入参数向下取整。例如 floor(float(1.3))返回的值为 1.0；但是 floor(float(-1.3))返回的值为-2.0。该函数与 ceil(x)函数相对应。 |
| fmod(x,y)            | 返回 x/y 的余数。如果 y 为 0，结果不可预料。                 |
| frac(x)              | Returns the fractional portion of a scalar oreach vector component |
| frexp(x, out exp)    | 将浮点数 x 分解为尾数和指数，即x = m* 2^exp，返回 m，并将指数存入 exp 中； 如果 x 为 0，则尾数和指数都返回 0 |
| isfinite(x)          | 判断标量或者向量中的每个数据是否是有限数，如果是返回 true；否则返回 false;无限的或者非数据(not-a-number NaN)， |
| isinf(x)             | 判断标量或者向量中的每个数据是否是无限，如果是返回 true；否则返回 false; |
| isnan(x)             | 判断标量或者向量中的每个数据是否是非数据(not-a-number NaN)，如果是返回 true；否则返回 false; |
| ldexp(x, n)          | 计算 *x* * 2*n* 的值                                         |
| lerp(a, b, f)        | 计算(1- *f* )* *a* + *b* * *f* 或者*a* + *f* *(*b* - *a*) 的值。即在下限 a 和上限 b 之间进行插值，f 表示权值。注意，如果 a 和 b 是向量，则权值 f 必须是标量或者等长的向量。 |
| lit(NdotL, NdotH, m) | N 表示法向量；L 表示入射光向量；H 表示半角向量；m 表示高光系数。函数计算环境光、散射光、镜面光的贡献， 返回的 4 元向量：X 位表示环境光的贡献，总是 1.0；Y 位代表散射光的贡献，如果 *N* · *L* < 0 ，则为 0；否则为 *N* · *L*Z 位代表镜面光的贡献，如果 *N* · *L* < 0 或者*N* · *H* < 0 ，则位 0；否则为(*N* · *H* )*m* ；W 位始终位 1.0 |



| log(x)                        | 计算ln ( *x*) 的值，x 必须大于 0                             |
| ----------------------------- | ------------------------------------------------------------ |
| log2(x)                       | 计算log(*x*) 的值，x 必须大于 02                             |
| log10(x)                      | 计算log(*x*) 的值，x 必须大于 010                            |
| max(a, b)                     | 比较两个标量或等长向量元素，返回最大值。                     |
| min(a,b)                      | 比较两个标量或等长向量元素，返回最小值。                     |
| modf(x, out ip)               | 在 Cg Reference Manual 中没有查到                            |
| mul(M, N)                     | 计算两个矩阵相乘，如果 M 为 AxB 阶矩阵，N 为 BxC 阶矩阵，则返回 AxC 阶矩阵。下面两个函数为其重载函数。 |
| mul(M, v)                     | 计算矩阵和向量相乘                                           |
| mul(v, M)                     | 计算向量和矩阵相乘                                           |
| noise( x)                     | 噪声函数，返回值始终在 0，1 之间；对于同样的输入，始终返回相同的值（也就是说， 并不是真正意义上的随机噪声）。 |
| pow(x, y)                     | *x* *y*                                                      |
| radians(x)                    | 函数将角度值转换为弧度值                                     |
| round(x)                      | Round-to-nearest，或 closest integer to x 即四舍五入。       |
| rsqrt(x)                      | X 的反平方根，x 必须大于 0                                   |
| saturate(x)                   | 如果 x 小于 0，返回 0；如果 x 大于 1，返回1；否则，返回 x    |
| sign(x)                       | 如果 x 大于 0，返回 1；如果 x 小于 0，返回01；否则返回 0。   |
| sin(x)                        | 输入参数为弧度，计算正弦值，返回值范围为[-1,1]               |
| sincos(float x, out s, out c) | 该函数是同时计算 x 的 sin 值和 cos 值，其中s=sin(x)，c=cos(x)。该函数用于“同时需要计算 sin 值和 cos 值的情况”，比分别运算要快很多! |
| sinh(x)                       | 计算双曲正弦（hyperbolic sine）值。                          |
| smoothstep(min, max, x)       | 值 x 位于 min、max 区间中。如果 x=min，返回 0；如果 x=max，返回 1；如果 x 在两者之间，按照下列公式返回数据：-2*( *x* - min )3 + 3*( *x* - min )2max- min	max- min |
| step(a, x)                    | 如果 x<a，返回 0；否则，返回 1。                             |
| sqrt(x)                       | 求 x 的平方根，	*x* ，x 必须大于 0。                      |



| tan(x)       | 输入参数为弧度，计算正切值 |
| ------------ | -------------------------- |
| tanh(x)      | 计算双曲正切值             |
| transpose(M) | M 为矩阵，计算其转置矩阵   |

 

表 4 Cg 标准函数库中的数学函数

 

### 几何函数（Geometric Functions) 

几何函数，如表 5 所示，用于执行和解析几何相关的计算，例如根据入射光向量和顶点法向量，求取反射光和折射光方向向量。Cg 语言标准函数库中有3 个几何函数会经常被使用到，分别是：normalize 函数，对向量进行归一化；reflect函数，计算反射光方向向量；refract 函数，计算折射光方向向量。大声呐喊，并要求强烈注意：

1. 着色程序中的向量最好进行归一化之后再使用，否则会出现难以预料的错误；

2. reflect 函数和 refract 函数都存在以“入射光方向向量”作为输入参数， 注意这两个函数中使用的入射光方向向量，是从外指向几何顶点的；平时我们在着色程序中或者在课本上都是将入射光方向向量作为从顶点出发。

 

| 函数                | 功能                                                         |
| ------------------- | ------------------------------------------------------------ |
| distance( pt1, pt2) | 两点之间的欧几里德距离（Euclideandistance）                  |
| faceforward(N,I,Ng) | 如果 *Ng* · *I* < 0 ，返回 N；否则返回-N。                   |
| length(v)           | 返回一个向量的模，即 sqrt(dot(v,v))                          |
| normalize( v)       | 归一化向量                                                   |
| reflect(I, N)       | 根据入射光方向向量 I，和顶点法向量N，计算反射光方向向量。其中 I 和 N 必须被归一化，需要非常注意的是，这个 I 是指向顶点的；函数只对三元向量有效。 |
| refract(I,N,eta)    | 计算折射向量，I 为入射光线，N 为法向量，eta 为折射系数；其中 I 和 N 必须被归一化，如果 I 和 N 之间的夹角太大，则返回（0，0，0），也就是没有折射光线；I 是指向顶点的；函数只对三元向量有效。 |

表 5 Cg 标准函数库几何函数

 

### 纹理映射函数（Texture **Map** Functions）

 

下表提供 Cg 标准函数库中的纹理映射函数。这些函数被 ps_2_0、ps_2_x、arbfp1、fp30 和 fp40  等 profiles 完全支持（fully supported）。所有的这些函数返回四元向量值。

 

| 函数                                                         |      |
| ------------------------------------------------------------ | ---- |
| tex1D(sampler1D tex, float s)一维纹理查询                    |      |
| tex1D(sampler1D tex, float s, float dsdx, float dsdy)使用导数值（derivatives）查询一维纹理 |      |
| Tex1D(sampler1D tex, float2 sz)一维纹理查询，并进行深度值比较 |      |
| Tex1D(sampler1D tex, float2 sz, float dsdx,float dsdy)使用导数值（derivatives）查询一维纹理， 并进行深度值比较 |      |
| Tex1Dproj(sampler1D tex, float2 sq)一维投影纹理查询          |      |
| Tex1Dproj(sampler1D tex, float3 szq)一维投影纹理查询，并比较深度值 |      |
| Tex2D(sampler2D tex, float2 s)二维纹理查询                   |      |
| Tex2D(sampler2D tex, float2 s, float2 dsdx, float2 dsdy)使用导数值（derivatives）查询二维纹理 |      |
| Tex2D(sampler2D tex, float3 sz)二维纹理查询，并进行深度值比较 |      |
| Tex2D(sampler2D tex, float3 sz, float2 dsdx,float2 dsdy)使用导数值（derivatives）查询二维纹理，并进行深度值比较 |      |
| Tex2Dproj(sampler2D tex, float3 sq)二维投影纹理查询          |      |
| Tex2Dproj(sampler2D tex, float4 szq)二维投影纹理查询，并进行深度值比较 |      |
| texRECT(samplerRECT tex, float2 s)                           |      |
| texRECT (samplerRECT tex, float2 s, float2 dsdx, float2 dsdy) |      |
| texRECT (samplerRECT tex, float3 sz)                         |      |
| texRECT (samplerRECT tex, float3 sz, float2 dsdx,float2 dsdy) |      |
| texRECT proj(samplerRECT tex, float3 sq) texRECT proj(samplerRECT tex, float3 szq) |      |
| Tex3D(sampler3D tex, float s)  三维纹理查询                  |      |
| Tex3D(sampler3D tex, float3 s, float3 dsdx, float3 dsdy)  结合导数值（derivatives）查询三维纹理 |      |
| Tex3Dproj(sampler3D tex, float4 szq) 查询三维投影纹理，并进行深度值比较 |      |
| texCUBE(samplerCUBE tex, float3 s)  查询立方体纹理           |      |
| texCUBE (samplerCUBE tex, float3 s, float3 dsdx, float3 dsdy)  结合导数值（derivatives）查询立方体纹理 |      |
| texCUBEproj (samplerCUBE tex, float4 sq) 查询投影立方体纹理  |      |
|                                                              |      |

​                                             标准函数库纹理映射函数

 

 

 

 

### 偏导函数（Derivative Functions） 

| 函数   | 功能                                                         |
| ------ | ------------------------------------------------------------ |
| ddx(a) | 参数 a 对应一个像素位置，返回该像素 值在 X 轴上的偏导数      |
| ddy(a) | 参数 a 对应一个像素位置，返回该像素 值在 X 轴上的偏导数 表 7 Cg 标准函数库偏导函数 |

 

### 调试函数（Debugging Function） 

 

| 函数                 | 功能                                                         |
| -------------------- | ------------------------------------------------------------ |
| void debug(float4 x) | 如果在编译时设置了 DEBUG，片段着 色程序中调用该函数可以将值 x 作为 COLOR 语义的终输出；否则该函数 什么也不做。 |

  
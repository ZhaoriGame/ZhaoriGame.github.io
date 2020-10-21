---
title: Design_Pattern_享元模式
date: 2019-08-13 19:49:34
categories: 设计模式
tags: 设计模式
---

# 设计模式：享元模式

# 一、什么是享元模式？

**享元模式（Flyweight）**，运用共享技术有效地支持大量细粒度的对象。UML结构图如下：
![享元模式UML图.png](https://cdn.nlark.com/yuque/0/2019/png/225637/1547115239417-4616bc5b-775f-4362-b2b2-0a165997e94b.png#align=left&display=inline&height=316&name=%E4%BA%AB%E5%85%83%E6%A8%A1%E5%BC%8FUML%E5%9B%BE.png&originHeight=316&originWidth=634&size=21131&width=634)

Flyweight是抽象享元角色。它是产品的抽象类，同时定义出对象的外部状态和内部状态的接口或实现；ConcreteFlyweight是具体享元角色，是具体的产品类，实现抽象角色定义的业务；
UnsharedConcreteFlyweight是不可共享的享元角色，一般不会出现在享元工厂中；
FlyweightFactory是享元工厂，它用于构造一个池容器，同时提供从池中获得对象的方法。

# 二、内部状态与外部状态的区分

享元享元，共享细粒度的单元。那么什么是细粒度的单元呢？如果用乐高积木作比喻，那么一个积木人可以称为一个完整的对象。如果我们把积木人拆开，可以进一步得到头、身躯，腿三个部分。而这些部分，相比于完整的积木人而言，它们三个就是细粒度的单元。

那么为什么要把一个完整的对象区分内外部呢？这岂不是增加了代码的复杂度？好，我们暂时搁置，接下来思考这样一个问题，如果我们要创造 10 个积木人，用程序怎么表示呢？

我们先创建一个积木人的类，如下：

```csharp
public class LegoMan
{
  public string Head;
  public string Torso;
  public string Leg;
  
  public LegoMan(string head, string torso, string leg)
  {
    this.Head = head;
    this.Torso = torso;
    this.Leg = leg;
  }
}
```

接着我们开始创造积木人，先采用直接 new 的方式：

```csharp
public class Example {
    public static void main(String[] args) 
    {
      LegoMan man1 = new LegoMan("head1", "torso1", "leg1");
      LegoMan man2 = new LegoMan("head2", "torso2", "leg2");
      ...
      LegoMan man10 = new LegoMan("head10", "torso10", "leg10");
    }
}
```

现在我们得到了 10 个积木人，接下来我们对积木人作出一些限制，我们现在需要 10 个士兵积木人，由于士兵的制服统一，那么这一百个积木人的下半身是完全一样的，也就是说除了 Head，积木人的 Torso 和 Leg 都是一样的。现在我们继续创建十个士兵积木人。好吧，和上面的例子一样，只是传入的后两个参数均一致。

```csharp
LegoMan manN = new LegoMan("headN", "torsoStandard", "legStandard")
```

接下来，我们思考这样一个问题，如果需要 1000 个士兵积木人呢？如果采用一般的方式，需要创建 1000 个实例对象，但是这 1000 个对象都有着共同的部分，就是它们的 Torso 和 Leg。那我们可不可以把共同的部分抽取出来呢？当然可以，现在我们把 Torso 和 Leg 整合为一个 Body 类，如下：

```csharp
public class Body
{
  public string Torso;
  public string Leg;
  
  public Body(string torso, string leg)
  {
    this.Torso = torso;
    this.Leg = leg;
  }
}
```

既然 Body 被提取出来了，那么 LegoMan 这个类也要被重写了，如下：

```csharp
public class LegoMan
{
  public string Head;
  public Body BodyIntrinsic;
  
  public LegoMan(string head, Body body)
  {
    this.Head = head;
    this.BodyIntrinsic = body;
  }
}
```

现在我们再来创建 1000 个积木人士兵的话，应该是这样：

```csharp
public class Example {
    public static void main(String[] args) 
    {
      //先创建一个通用的 Body 
      Body bodyStandard = new Body("torsoStandard", "legStandard");
      
      LegoMan man1 = new LegoMan("head1", bodyStandard);
      LegoMan man2 = new LegoMan("head2", bodyStandard);
      ...
      LegoMan man1000 = new LegoMan("head1000", bodyStandard);
    }
}
```

发现了吗？现在虽然也是1000个 LegoMan 的实例，但是却只有一个 Body，也就是说，1000个积木人士兵 的 Head，共享了一个 Body。听起来很疯狂，九头蛇也才九头，一千个头的怪物得多可怕！？哈哈，虽然积木人的玩具不可能这么拼，但是程序里，这种共享机制是可行的。Body 就是享元模式中的内部状态，一个重复度很高的细粒度单元。而 Head 则对应外部状态，会随着需求发生变化。这么分离的好处也很明显，就是大大减少了总数据量。如果不分离内外部，创建 1000 个积木人士兵的成本就是1000个 Head 和1000个 Body，而采用分离策略后，就只需要1000个 Head 外加1个 Body了。当随着创建对象数量级的增大，这种策略带来的好处会越来越明显。

# 三、完整的享元模式

理解了分离内外部的原因后，下面简单实现一下享元模式

## 1.Flyweight抽象类

通过最上面的 UML 图可以看出，Flyweight 被分为两部分，ConcreteFlyweight（共享的内部）和UnsharedConcreteFlyweight（不可共享的外部）。所以 Flyweight 最好被做成接口，或者抽象类，这里用抽象类实现，如下：

```csharp
public abstract class Flyweight 
{
    //内部状态
    public String intrinsic;
    //外部状态
    public String extrinsic;
    
    //要求享元角色必须接受外部状态
    public Flyweight(String extrinsic) 
    {
        this.extrinsic = extrinsic;
    }
    
    //定义业务操作
    public abstract void Operate(int extrinsic);

}
```

## 2. ConcreteFlyweight类

```csharp
public class ConcreteFlyweight : Flyweight 
{
    //接受外部状态
    public ConcreteFlyweight(String extrinsic):base(extrinsic)
    {
        Debug.Log("共享的 " + extrinsic);
    }

    //根据外部状态进行逻辑处理
    public void Operate(string extrinsic)
    {
        Debug.Log("处理共享数据 " + extrinsic);
    }
}
```

## 3. UnsharedConcreteFlyweight类

```csharp
public class UnsharedConcreteFlyweight : Flyweight
{
    public UnsharedConcreteFlyweight(String extrinsic):base(extrinsic)
    {
        Debug.Log("非共享的 " + extrinsic);
    }

    public void Operate(int extrinsic) 
    {
        Debug.Log("处理非共享数据 " + extrinsic);
    }

}
```

## 4. FlyweightFactory类

既然是处理大量数据，那免不了用一个对象池来进行管理，如下：

```csharp
public class FlyweightFactory 
{
    //定义一个池容器
    private static List<Flyweight> pool = new List<Flyweight>();
    
    //享元工厂
    public static Flyweight GetFlyweight(String extrinsic) 
    {
        var flyweight = pool.Find(obj => obj.extrinsic == extrinsic);
      
        if (flyweight == null)
        {
            flyweight = new ConcreteFlyweight(extrinsic);
            pool.Add(flyweight);
            Debug.Log("新创建 " + extrinsic);
        }
      	else
      	{
          	Debug.Log("从池中取出 " + extrinsic);
      	}
      
        return flyweight;
    }
}
```

## 5.客户端的调用

```csharp
public class Client {

    public static void main(String[] args)
    {
        Flyweight flyweight1 = FlyweightFactory.GetFlyweight("one");
        flyweight1.Operate("one");
        
        Flyweight flyweight2 = FlyweightFactory.GetFlyweight("two");
        flyweight2.Operate("two");
        
        Flyweight flyweight3 = FlyweightFactory.getFlyweight("one");
        flyweight3.Operate("one");
        
        Flyweight unsharedFlyweight = new UnsharedConcreteFlyweight("one");
        unsharedFlyweight.operate("one");
    }
}
```

打印结果如下：
新创建 one
处理共享数据 one
新创建 two
处理共享数据 two
从池中取出 one
处理共享数据 one
非共享的 one
处理非共享数据 one

参考博客：
[https://www.cnblogs.com/adamjwh/p/9070107.html](https://www.cnblogs.com/adamjwh/p/9070107.html)
[https://blog.csdn.net/justloveyou_/article/details/55045638](https://blog.csdn.net/justloveyou_/article/details/55045638)
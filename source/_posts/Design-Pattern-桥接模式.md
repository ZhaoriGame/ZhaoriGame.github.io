---
title: Design_Pattern_桥接模式
date: 2019-08-13 19:49:45
categories: 设计模式
tags: 设计模式
---

# 设计模式：桥接模式(Bridge Pattern)

将类的功能层次结构和实现层次结构相分离，使二者能够独立地变化，并在两者之间搭建桥梁，实现桥接。它是一种对象结构型模式，又称为**柄体(Handle and Body)模式**或**接口(Interfce)模式**。

**意图：**在一个软件系统的抽象化和实现化之间使用关联关系（组合或者聚合关系）而**不是继承关系**，从而使两者可以相对独立地变化。

- 将类的功能层次分离开，父类拥有子类所共有的功能，子类里实现新的功能。
- 将类的实现层次分离开，父类声明抽象方法，子类来实现。

桥接模式主要包含以下几个角色

- **Abstraction**：抽象类，抽象了功能的实现。
- **RefinedAbstraction**：扩充抽象类实现了具体的新的功能，构成功能层次结构。
- **Implementor**：实现类接口，提供了用于抽象类的接口。
- **ConcreteImplementor**：具体实现类，构成实现层次结构。

**现要画一个不同颜色不同形状组合的圆，把抽象化和实现分离开来使其能独立地变化**

**抽象类：**

```csharp
		public abstract class Shape
    {
        public Color color;

        public void SetColor(Color color)
        {
            this.color = color;
        }

        public abstract void Draw();
    }
```

**扩充抽象类**

```csharp
		public class Circle : Shape
    {
        public override void Draw()
        {
            color.BePaint("圆");
        }
    }


    public class Square : Shape
    {
        public override void Draw()
        {
            color.BePaint("正方形");
        }
    }
```

**实现类的接口：**

```csharp
		public interface Color
    {
       void BePaint(string shape);
    }
```

**具体实现类:**

```csharp
	public class Red : Color
    {
        public void BePaint(string shape)
        {
            Console.WriteLine("红色的" + shape);
        }
    }

    public class Black : Color
    {
        public void BePaint(string shape)
        {
            Console.WriteLine("黑色的" + shape);
        }
    }
```

**画出不同颜色不同形状的圆：**

```csharp
	public class Draw
    {
        public void DoDraw()
        {
            Color red = new Red();
            Color black = new Black();
            Shape circle = new Circle();

            //画红色的圆
            circle.SetColor(red);
            circle.Draw();

            //画黑色的圆
            circle.SetColor(black);
            circle.Draw();

        }
    }
```


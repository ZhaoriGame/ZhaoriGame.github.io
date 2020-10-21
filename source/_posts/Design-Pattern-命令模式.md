---
title: Design_Pattern_命令模式
date: 2019-08-13 19:49:20
categories: 设计模式
tags: 设计模式
---

# 设计模式：命令模式

**命令模式在GoF中的定义是：**

> 将一个请求封装为一个对象，从而使你可用不同的请求对客户进行参数化； 对请求排队或记录请求日志，以及支持可撤销的操作。
> 命令模式是一种回调的面向对象实现。

**游戏设计模式里把它精简为：**

> 命令是具现化的方法调用。

两种术语都意味着将概念变成数据一个对象可以存储在变量中，传给函数。
所以称命令模式为“具现化方法调用”，意思是方法调用被存储在对象中。
类似C#里的回调
把一个对象传递到方法中，让方法内部解析。

下面是一个C#版本的角色控制，传入一个角色，就能调用对应的各种行动。

```csharp
using UnityEngine;

/// <summary>
/// 命令基类
/// </summary>
public abstract class Command
{
    public abstract void Execute(BaseCharacter character);
}

/// <summary>
/// 跳的命令
/// </summary>
public class JumpCommand : Command
{
    public override void Execute(BaseCharacter character)
    {
        character.Jump();
    }
}

/// <summary>
/// 射击的命令
/// </summary>
public class FireCommand : Command
{
    public override void Execute(BaseCharacter character)
    {
        character.Fire();
    }
}

/// <summary>
/// 移动的命令
/// </summary>
public class MoveCommand : Command
{
    public override void Execute(BaseCharacter character)
    {

    }
}

/// <summary>
/// 对输入的解析
/// </summary>
public class InputHandler
{

    private JumpCommand buttonA;
    private FireCommand buttonD;
    private MoveCommand buttonW;

    public Command HandleInputAction()
    {
        if (Input.GetKeyDown(KeyCode.A)) { return buttonA; }
        if (Input.GetKeyDown(KeyCode.D)) { return buttonD; }
        if (Input.GetKeyDown(KeyCode.W)) { return buttonW; }

        return null;
    }



    private Player mPlayer;
    private Enemy mEnemy;

    public void Command()
    {
        Command command = HandleInputAction();

        if (command != null)
        {
            command.Execute(mPlayer);
            command.Execute(mEnemy);
        }
    }
}

public class Player : BaseCharacter
{
    public override void Fire()
    {
        base.Fire();
    }
    public override void Jump()
    {
        base.Jump();
    }
}

public class Enemy : BaseCharacter
{
    public override void Fire()
    {
        base.Fire();
    }
}
/// <summary>
/// 角色的基类
/// </summary>
public abstract class BaseCharacter
{
    public virtual void Jump() { }
    public virtual void Fire() { }
}

```


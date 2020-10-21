---
title: Design_Pattern_状态模式
date: 2019-08-13 19:49:11
categories: 设计模式
tags: 设计模式
---

# 设计模式：状态模式（有限、分层和下推状态机）



实现了最简单的有限状态机

```csharp
public class FSM : MonoBehaviour
{
    public MonoStateMachine monoStateMachine = new MonoStateMachine();

    public RunState RunState;
    public IdleState IdleState;

    private void Start()
    {
        monoStateMachine.StartState(RunState);

        
    }

    private void Update()
    {
        monoStateMachine.Update();
    }
}

public class RunState : MonoState
{
    public static RunState instance;

    public static RunState Instance()
    {
        if (instance == null)
        {
            instance = new RunState();
        }
        return instance;
    }

    public override void Enter()
    {
        Debug.Log("进入跑步");
    }

    public override void Execute()
    {
        Debug.Log("开始跑步");
    }

    public override void Exit()
    {
        Debug.Log("退出跑步");
    }

   
}

public class IdleState : MonoState
{

    public static IdleState instance;

    public static IdleState Instance()
    {
        if (instance == null)
        {
            instance = new IdleState();
        }
        return instance;
    }

    public override void Enter()
    {

    }

    public override void Execute()
    {

    }

    public override void Exit()
    {

    }

}

public class MonoState 
{
    public virtual void Enter()
    {

    }
    public virtual void Execute()
    {

    }
    
    public virtual void Exit()
    {

    }

}

public class MonoStateMachine
{
   // private MonoState mOwner;

    private MonoState mCurrentState;
    private MonoState mPreviousState;
    private MonoState mGlobalState;


    public MonoStateMachine()
    {
        mCurrentState = null;
        mPreviousState = null;
        mGlobalState = null;
    }

    /// <summary>
    /// 设置初始状态
    /// </summary>
    /// <param name="state"></param>
    public void StartState(MonoState state)
    {
        mCurrentState = state as MonoState;
        mCurrentState.Enter();

    }

    public void ChangeState(MonoState state)
    {
        if (state == null)
        {
            Debug.Log("无法找到此状态");
        }

        mPreviousState = mCurrentState;
        mCurrentState.Exit();
        //转换后
        mCurrentState = state as MonoState;
        mCurrentState.Enter();

    }
    /// <summary>
    /// 还原之前的状态
    /// </summary>
    public void RevertToPreviouState()
    {
        ChangeState(mPreviousState);
    }

    /// <summary>
    /// 得到当前状态
    /// </summary>
    /// <returns></returns>
    public MonoState GetCurrentState()
    {
        return mCurrentState;
    }

    /// <summary>
    /// 得到之前的状态
    /// </summary>
    /// <returns></returns>
    public MonoState GetPreviousState()
    {
        return mPreviousState;
    }

    public void Update()
    {
        if (mCurrentState!=null)
        {
            mCurrentState.Execute();
        }
    }
}

```


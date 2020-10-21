---
title: Design_Pattern_单例
date: 2019-08-13 19:48:30
categories: 设计模式
tags: 设计模式
---



# 单例

- 单例为最常见的一种设计模式，目前在用的主要有两种方式，一种是基于Unity的，一种是基于C#的
- 一般来说，unity里的单例分为两种，一种是继承于Monobehaviour的，一种是不继承于它的；
- 这里给出了两种实现方法

**使用Unity里的方法**

```csharp
public abstract class ScriptSingleton<T>  : MonoBehaviour where T : ScriptSingleton<T>
    {
        protected static T _instance;
        public static T Instance
        {
            get
            {
                if (_instance == null)
                {
                    //从场景中找T脚本的对象
                    _instance = FindObjectOfType<T>();
                    if (FindObjectsOfType<T>().Length > 1)
                    {
                        Debug.LogError("场景中的单例脚本数量 > 1:" + _instance.GetType().ToString());
                        return _instance;
                    }
                    //场景中找不到的情况
                    if (_instance == null)
                    {
                        string instanceName = typeof(T).Name;
                        GameObject instanceGO = GameObject.Find(instanceName);
                        if (instanceGO == null)
                        {
                            instanceGO = new GameObject(instanceName);
                            DontDestroyOnLoad(instanceGO);
                            _instance = instanceGO.AddComponent<T>();
                            DontDestroyOnLoad(_instance);
                        }
                        else
                        {
                            //场景中已存在同名游戏物体时就打印提示
                            Debug.LogError("场景中已存在单例:" + instanceGO.name);
                        }
                    }
                }
                return _instance;
            }
        }

         void OnDestroy()
        {
            _instance = null;
        }
}
```

**通过反射实现的单例**

```csharp
public abstract class Singleton<T> where T : Singleton<T> 
{ 
    protected static T mInstance = null;
    protected Singleton() { }
    public static T Instance 
    { 
        get 
        { 
            if (mInstance == null)
            {
                 var ctors = typeof(T).GetConstructors(BindingFlags.Instance | BindingFlags.NonPublic);  
                var ctor = Array.Find(ctors, c => c.GetParameters().Length == 0); 
                if (ctor == null) 
                {
                    throw new Exception("Non-public ctor() not found!"); 
                }
                 mInstance = ctor.Invoke(null) as T; }
                
                return mInstance;
            }
        }
    }
}
```


---
title: 简单UI框架
date: 2019-07-09 10:18:04
categories: Unity
tags: UI
---



简单的UI框架，方便以后复制

``` c#
using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace IL
{

    public enum UILevel
    {
        Bottom,//底层
        Common, //普通层
        Top,//最前层
    }


    public class UIMgr : ASingleton<UIMgr>
    {



        private Dictionary<string, PanelView> mAllPanel = new Dictionary<string, PanelView>();

        private Transform mBottomTrans;
        private Transform mCommonTrans;
        private Transform mTopTrans;

        private Canvas mCanvas;
        private CanvasScaler mCanvasScaler;
        private GraphicRaycaster mGraphicRaycaster;
        private RectTransform mRectTransform;

        private EventSystem mEventSystem;

        private Transform UIRoot;


        public void Init()
        {
            UIRoot = GameObject.Instantiate(ResMgr.Ins.Load<GameObject>(AssetBundleName.UI,"uiroot")).transform;
            GameObject.DontDestroyOnLoad(UIRoot);

            mBottomTrans = UIRoot.Find("Bottom");
            mCommonTrans = UIRoot.Find("Common");
            mTopTrans = UIRoot.Find("Top");

            mCanvas = UIRoot.GetComponent<Canvas>();
            mCanvasScaler = UIRoot.GetComponent<CanvasScaler>();
            mGraphicRaycaster = UIRoot.GetComponent<GraphicRaycaster>();
            mRectTransform = UIRoot.GetComponent<RectTransform>();

            mEventSystem = UIRoot.Find("EventSystem").GetComponent<EventSystem>();

        }

        public RectTransform RectTransform
        {
            get { return mRectTransform; }
        }

        public GraphicRaycaster GraphicRaycaster
        {
            get { return mGraphicRaycaster; }
        }

        public Canvas RootCanvas
        {
            get { return mCanvas; }
        }
        /// <summary>
        /// 设置分辨率
        /// </summary>
        /// <param name="width"></param>
        /// <param name="height"></param>
        public void SetResolution(int width, int height)
        {
            mCanvasScaler.referenceResolution = new Vector2(width, height);
        }


        private T OpenUI<T>(string PanelName, UILevel uiLevel) where T:PanelView
        {
            if (!mAllPanel.ContainsKey(PanelName))
            {
                CreateUI(typeof(T), PanelName, uiLevel);
            }
            mAllPanel[PanelName].SetActive(true);
            return mAllPanel[PanelName]as T;

        }

        private void OpenUIAsync<T>(string PanelName, Action<UnityEngine.Object> onLoaded = null) where T : PanelView, new()
        {
            if (!mAllPanel.ContainsKey(PanelName))
            {
                CreateUIAsync<T>(PanelName,onLoaded);
            }
            onLoaded(null);
           // return mAllPanel[PanelName];

        }

        private void CreateUIAsync<T>(string panelName, Action<UnityEngine.Object> onLoaded) where T : PanelView, new()
        {
            ResMgr.Ins.LoadAsync(AssetBundleName.UI, panelName,onLoaded);
        }

        private void CreateUI(Type type, string panelName, UILevel uiLevel) 
        {
            PanelView panelView = Activator.CreateInstance(type) as PanelView;

            Transform parent;

            switch (uiLevel)
            {
                case UILevel.Bottom:
                    parent = mBottomTrans;
                    break;
                case UILevel.Common:
                    parent = mCommonTrans;
                    break;
                case UILevel.Top:
                    parent = mTopTrans;
                    break;
                default:
                    parent = mCommonTrans;
                    break;
            }
            GameObject ui = GameObject.Instantiate(ResMgr.Ins.Load<GameObject>(AssetBundleName.UI, panelName), parent);
            ui.name = panelName;
            panelView.SetGameObject(ui);
            panelView.Init();
            mAllPanel.Add(panelName, panelView);

        }

        public ViewType Open<ViewType>(UILevel uiLevel = UILevel.Common) where ViewType : PanelView
        {
            return OpenUI<ViewType>( GetName<ViewType>(), uiLevel);
        }

        public void OpenAsync<T>( Action<UnityEngine.Object> onLoaded = null) 
        {
            OpenUIAsync<PanelView>(GetName<T>(), onLoaded);
        }

        private string GetName<T>()
        {
            if (Runtime.Ins.IsHotResProject)
            {
                string name = typeof(T).ToString();
                return name.Replace("Type : ", "");
            }
            else
            {
                string name = typeof(T).ToString();
                string[] nameSplits = name.Split('.');
                return nameSplits[nameSplits.Length - 1];
            }


            //return name;
        }
    }
}

```


#### 昨天闲来无事，对着自己的iPhone6s,准备给IT江湖加入3D Touch吧！！

没有6s的 模拟器也可以测试，按照@conradev 的SBShortcutMenuSimulator测试

项目地址：https://github.com/DeskConnect/SBShortcutMenuSimulator.git

 * icon 重按弹出菜单
 * tableView Cell 轻按按预览文章详情
 * tableView Cell 轻按按预览文章详情,上滑底部显示Action
 * tableView Cell 轻按按预览文章详情,重按进入文章详情页
 
### 效果图
<p>
<img src="http://img.itjh.com.cn/1.pic.jpg" wight="360px" height="640px"/>
<img src="http://img.itjh.com.cn/7.pic.jpg" wight="360px" height="640px"/>
<img src="http://img.itjh.com.cn/2.pic.jpg" wight="360px" height="640px"/>
<img src="http://img.itjh.com.cn/3.pic.jpg" wight="360px" height="640px"/>
</p>

<a href="http://v.youku.com/v_show/id_XMTM0NzY2NDQ1Mg==.html" title="3D Touch">完整的3D Touch 动画视频</a> 

## icon 重按弹出菜单
 
代码片段:

在`AppleDelegate`文件中

```swift

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //添加icon 3d Touch
        let firstItemIcon:UIApplicationShortcutIcon = UIApplicationShortcutIcon(type: .Share)
        let firstItem = UIMutableApplicationShortcutItem(type: "1", localizedTitle: "分享", localizedSubtitle: nil, icon: firstItemIcon, userInfo: nil)
        
        let firstItemIcon1:UIApplicationShortcutIcon = UIApplicationShortcutIcon(type: .Compose)
        let firstItem1 = UIMutableApplicationShortcutItem(type: "2", localizedTitle: "编辑", localizedSubtitle: nil, icon: firstItemIcon1, userInfo: nil)
        
        
        application.shortcutItems = [firstItem,firstItem1]
        
        return true
    }
    
    /**
    3D Touch 跳转
    
    - parameter application:       application
    - parameter shortcutItem:      item
    - parameter completionHandler: handler
    */
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
        
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false

        if shortcutItem.type == "1" { //分享

            let rootNavigationViewController = window!.rootViewController as? UINavigationController
            let rootViewController = rootNavigationViewController?.viewControllers.first as UIViewController?

            rootNavigationViewController?.popToRootViewControllerAnimated(false)
            rootViewController?.performSegueWithIdentifier("toShare", sender: nil)
            handled = true
            
        }
        
        if shortcutItem.type == "2" { //编辑

            let rootNavigationViewController = window!.rootViewController as? UINavigationController
            let rootViewController = rootNavigationViewController?.viewControllers.first as UIViewController?

            rootNavigationViewController?.popToRootViewControllerAnimated(false)
            rootViewController?.performSegueWithIdentifier("toCompose", sender: nil)
            handled = true
            
        }
        return handled
    }
```
## tableView Cell 轻按预览文章详情 重按进入详情页

代码片段:

```swift

    // MARK: 3D Touch Delegate
    
    /**
    轻按进入浮动页面
    
    - parameter previewingContext: previewingContext description
    - parameter location:          location description
    
    - returns: 文章详情页  浮动页
    */
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        
        // Get indexPath for location (CGPoint) + cell (for sourceRect)
        guard let indexPath = tableView.indexPathForRowAtPoint(location),
            _ = tableView.cellForRowAtIndexPath(indexPath) else { return nil }
        
        // Instantiate VC with Identifier (Storyboard ID)
        guard let myVC = storyboard?.instantiateViewControllerWithIdentifier("ArtilceShowView") as? ArticleShowViewController else { return nil }
        
        myVC.urlStr = "https://www.baidu.com"
        
        let cellFrame = tableView.cellForRowAtIndexPath(indexPath)!.frame
        
        previewingContext.sourceRect = view.convertRect(cellFrame, fromView: tableView)
        
        return myVC
    }
    
    /**
    重按进入文章详情页
    
    - parameter previewingContext:      previewingContext description
    - parameter viewControllerToCommit: viewControllerToCommit description
    */
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        self.showViewController(viewControllerToCommit, sender: self)
        
        
    }
```
更多代码查看`ArticlesTableViewController`文件

## 详情页 上滑出现 赞 分享

```swift
override func previewActionItems() -> [UIPreviewActionItem] {
        
        let action1 = UIPreviewAction(title: "赞", style: .Default) { (_, _) -> Void in
            
            print("点击了赞")
            
        }
        
        let action2 = UIPreviewAction(title: "分享", style: .Default) { (_, _) -> Void in
            
            print("点击了分享")
            
        }
        
        let actions = [action1,action2]
        
        return actions
        
    }
```

 

//
//  AppDelegate.swift
//  itjh_3dTouch
//
//  Created by Songlijun on 15/9/28.
//  Copyright © 2015年 Songlijun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


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

    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


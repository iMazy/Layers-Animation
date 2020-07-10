//
//  AppDelegate.swift
//  LayersAnimation
//
//  Created by Mazy on 2017/5/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
// 60 208 221

let globalColor = UIColor(red: 60/255, green: 208/255, blue: 221/255, alpha: 1.0)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 设置 UILabel 的全局属性
        UILabel.appearance().font = UIFont(name: "Avenir-Light", size: 17.0)
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).font = UIFont(name: "Avenir-Light", size: 14.0)
        // 设置导航栏属性
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = globalColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "Avenir-Light", size: 20.0)!]
        // 设置 tableView 的全局属性
        UITableView.appearance().separatorColor = globalColor
        // 设置 tableViewCell的分割线偏移为0
        UITableViewCell.appearance().separatorInset = UIEdgeInsets.zero
        // 设置所有 UIControl 的 颜色为全局色
        UIControl.appearance().tintColor = globalColor
        
        // 截取图片,将一张大图截取成若干小图
        let size = CGSize(width: sideLength, height: sideLength)
        UIImage.saveTileOfSize(size, name: fileName)
        
        let overlayClass = NSClassFromString("UIDebuggingInformationOverlay") as? UIWindow.Type
        _ = overlayClass?.perform(NSSelectorFromString("prepareDebuggingOverlay"))
        
        return true
    }

    
}


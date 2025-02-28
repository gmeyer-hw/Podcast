//
//  AppDelegate.swift
//  Podcast
//
//  Created by Meyer, Gustavo on 7/11/19.
//  Copyright © 2019 Meyer Systems. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var backgroundSessionCompletionHandler: (() -> Void)?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PodcastDataManager.default.load()
        
        applyAppearance()
        setupCache()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabController()
        window?.makeKeyAndVisible()

        return true
    }
    
    func application(_ application: UIApplication,
                     handleEventsForBackgroundURLSession handleEventsForBackgroundURLSessionidentifier: String,
                     completionHandler: @escaping () -> Void) {
        backgroundSessionCompletionHandler = completionHandler
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        try? PodcastDataManager.default.saveViewContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        try? PodcastDataManager.default.saveViewContext()
    }

    private func applyAppearance() {
        // Navigation bar
        let proxyNavBar = UINavigationBar.appearance()
        proxyNavBar.prefersLargeTitles = true
        proxyNavBar.isTranslucent = false
        proxyNavBar.backgroundColor = .white
        proxyNavBar.shadowImage = UIImage.imageWithColor(
            color: .clear,
            size: CGSize(width: 1, height: 1)
        )

        proxyNavBar.shadowImage = UIImage()
        proxyNavBar.backIndicatorImage = UIImage()
        

        let proxyTabBar = UITabBar.appearance()
        proxyTabBar.isTranslucent = false
    }

    private func setupCache() {
        // 500 MB
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "imagePath")
        URLCache.shared = cache
    }
}

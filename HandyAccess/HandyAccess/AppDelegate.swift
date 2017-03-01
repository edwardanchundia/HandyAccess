//
//  AppDelegate.swift
//  HandyAccess
//
//  Created by Karen Fuentes on 2/17/17.
//  Copyright © 2017 NYCHandyAccess. All rights reserved.
//

import UIKit
import Firebase
import SideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var customizedLaunchScreenView: UIView?
    var rollingLogo: UIImageView?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let tabVC: UITabBarController = UITabBarController()
        
        let initialVc = InitialViewController()
        let mapVC = MapViewController()
        //let eventsVC = EventsViewController()
        let resourcesTVC = SocialServicesTableViewController()
        let firstShowVC = FirstShowViewController()
        //let profileVc = ProfileFavoritesViewController()
    
        let firstNav = UINavigationController(rootViewController: initialVc)
        let secondNav = UINavigationController(rootViewController: mapVC)
        //let thirdNav = UINavigationController(rootViewController: eventsVC)
        let fourthNav = UINavigationController(rootViewController: resourcesTVC)
        //let fifthNav = UINavigationController(rootViewController: profileVc)
        
        let firstTabItemImage = #imageLiteral(resourceName: "Filter-50")
        let secondTabItemImage = #imageLiteral(resourceName: "map")
        //let thirdTabItemImage = #imageLiteral(resourceName: "events")
        let fourthTabItemImage = #imageLiteral(resourceName: "resources")
        //let fifthTabItemImage = #imageLiteral(resourceName: "profile")
    
        
        let tab1ItemInfo = UITabBarItem(title: "Initial", image: firstTabItemImage, tag: 4)
        let tab2ItemInfo = UITabBarItem(title: "Map", image: secondTabItemImage, tag: 0)
        //let tab3ItemInfo = UITabBarItem(title: "Events", image: thirdTabItemImage, tag: 1)
        let tab4ItemInfo = UITabBarItem(title: "Resources", image: fourthTabItemImage, tag: 2)
        //let tab5ItemInfo = UITabBarItem(title: "Profile", image: fifthTabItemImage, tag: 3)

    
        firstNav.tabBarItem = tab1ItemInfo
        secondNav.tabBarItem = tab2ItemInfo
        //thirdNav.tabBarItem = tab3ItemInfo
        fourthNav.tabBarItem = tab4ItemInfo
        //fifthNav.tabBarItem = tab5ItemInfo
        
        UITabBar.appearance().tintColor = UIColor(red: 71/255, green: 138/255, blue: 204/255, alpha: 1.0)
        
        tabVC.viewControllers = [firstNav,secondNav,/*thirdNav,*/ fourthNav, /*fifthNav*/]
        
        //let navVC = UINavigationController(rootViewController: tabVC)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let firstShowNavVC = UINavigationController(rootViewController: firstShowVC)
        self.window?.rootViewController = firstShowNavVC
        self.window?.makeKeyAndVisible()
        
        //--------For initial View Controller---------
//        let initialVC = InitialViewController()
//        let navVC = UINavigationController(rootViewController: initialVC)
//
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = navVC
//        self.window?.makeKeyAndVisible()
        //----------
        
        
//        if let window = self.window {
//            self.customizedLaunchScreenView = UIView(frame: window.bounds)
//            self.customizedLaunchScreenView?.backgroundColor = .cyan
//            
//            self.window?.addSubview(self.customizedLaunchScreenView!)
//            self.window?.bringSubview(toFront: self.customizedLaunchScreenView!)
//            
//            self.rollingLogo = UIImageView(frame: .zero)
//            self.rollingLogo?.image = UIImage(named: "logo")
//            
//            self.window?.addSubview(rollingLogo!)
//            self.window?.bringSubview(toFront: rollingLogo!)
//            
//            self.rollingLogo?.snp.makeConstraints{ (view) in
//                view.centerY.equalTo(window.snp.centerY).offset(10)
//                view.centerX.equalTo(window.snp.centerX)
//            }
//        }


//        tabVC.viewControllers = [firstNav,secondNav,thirdNav, fourthNav]


        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


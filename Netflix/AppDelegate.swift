//
//  AppDelegate.swift
//  Netflix
//
//  Created by Tanakorn Phoochaliaw on 14/3/2566 BE.
//

import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let tabBarController = UITabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - Load Font
        UIFont.loadAllFonts
        
        // MARK: - Set up tabbar
        self.setupTabBar()
        
        // MARK: - Setup View
        let frame = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
        self.window!.rootViewController = self.tabBarController
        self.window!.overrideUserInterfaceStyle = .dark
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func setupTabBar() {
        // MARK: - Setup TabBar
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.asset(.regular, fontSize: .small)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.asset(.regular, fontSize: .small)], for: .selected)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.tabBarController.view.bounds
        blurView.autoresizingMask = .flexibleWidth
        
        self.tabBarController.tabBar.insertSubview(blurView, at: 0)
        self.tabBarController.tabBar.tintColor = .white
        self.tabBarController.tabBar.unselectedItemTintColor = .lightGray
//        self.tabBarController.delegate = self

//        let bottomSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
//        let inset: CGFloat = (bottomSafeAreaHeight > 20 ? 10.0 : 5.0)
//        let insets = UIEdgeInsets(top: inset, left: 0, bottom: -inset, right: 0)

        // MARK: - Home
//        self.feedNavi = UINavigationController(rootViewController: FeedOpener.open(.feed))
        let iconFeed = UITabBarItem(title: nil, image: UIImage.init(icon: .solid(.house), size: CGSize(width: 25, height: 25)), selectedImage: UIImage.init(icon: .solid(.house), size: CGSize(width: 25, height: 25)))
//        self.feedNavi?.tabBarItem = iconFeed
//        self.feedNavi?.tabBarItem.tag = 0
//        self.feedNavi?.tabBarItem.imageInsets = insets
        let homeView = UIViewController()
        homeView.view.backgroundColor = .red
        homeView.tabBarItem = iconFeed
        homeView.tabBarItem.title = "Home"

        // MARK: - News
//        self.exploreNavi = UINavigationController(rootViewController: ExploreOpener.open(.explore))
        let exploreAction = UITabBarItem(title: nil, image: UIImage.init(icon: .regular(.files), size: CGSize(width: 25, height: 25)), selectedImage: UIImage.init(icon: .regular(.files), size: CGSize(width: 25, height: 25)))
//        self.exploreNavi?.tabBarItem = exploreAction
//        self.exploreNavi?.tabBarItem.tag = 1
//        self.exploreNavi?.tabBarItem.imageInsets = insets
        let newView = UIViewController()
        newView.view.backgroundColor = .green
        newView.tabBarItem = exploreAction
        newView.tabBarItem.title = "New & Hot"

        // MARK: - Download
//        self.searchNavi = UINavigationController(rootViewController: SearchOpener.open(.search))
        let iconSearch = UITabBarItem(title: nil, image: UIImage.init(icon: .regular(.circleArrowDown), size: CGSize(width: 25, height: 25)), selectedImage: UIImage.init(icon: .regular(.circleArrowDown), size: CGSize(width: 25, height: 25)))
//        self.searchNavi?.tabBarItem = iconSearch
//        self.searchNavi?.tabBarItem.tag = 3
//        self.searchNavi?.tabBarItem.imageInsets = insets
        let downloadView = UIViewController()
        downloadView.view.backgroundColor = .blue
        downloadView.tabBarItem = iconSearch
        downloadView.tabBarItem.title = "Downloads"

        self.tabBarController.viewControllers = [homeView, newView, downloadView]
    }
}


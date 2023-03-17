//
//  AppDelegate.swift
//  Netflix
//
//  Created by Tanakorn Phoochaliaw on 14/3/2566 BE.
//

import UIKit
import Core
import Home

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let tabBarController = UITabBarController()
    var homeNavi: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - Load Font
        UIFont.loadAllFonts
        
        // MARK: - Set up tabbar
        self.setupTabBar()
        
        // MARK: - Set up UINavigationBar item spacing
        let stackViewAppearance = UIStackView.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        stackViewAppearance.spacing = 3
        
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
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.asset(.regular, fontSize: .custom(size: 10))], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.asset(.regular, fontSize: .custom(size: 10))], for: .selected)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.tabBarController.view.bounds
        blurView.autoresizingMask = .flexibleWidth
        
        self.tabBarController.delegate = self
        self.tabBarController.tabBar.insertSubview(blurView, at: 0)
        self.tabBarController.tabBar.tintColor = .white
        self.tabBarController.tabBar.unselectedItemTintColor = .lightGray

        // MARK: - Home
        self.homeNavi = UINavigationController(rootViewController: HomeOpener.open(.home))
        let iconHome = UITabBarItem(title: nil, image: UIImage.init(icon: .solid(.house), size: CGSize(width: 25, height: 25)), selectedImage: UIImage.init(icon: .solid(.house), size: CGSize(width: 25, height: 25)))
        self.homeNavi?.tabBarItem = iconHome
        self.homeNavi?.tabBarItem.title = "Home"

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

        self.tabBarController.viewControllers = [self.homeNavi!, newView, downloadView]
    }
}

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let fromViewCotroller = tabBarController.selectedViewController,
              fromViewCotroller != viewController else { return true }
        
        let context = LayerContext(fromViewController: fromViewCotroller, toViewController: viewController)
        
        if let toBackgroundLayer = context.toBackgroundLayer {
            tabBarController.view.layer.insertSublayer(toBackgroundLayer, at: 0)
        }
        if let fakeLayer = context.fakeLayer {
            tabBarController.view.layer.insertSublayer(fakeLayer, at: 0)
        }
        if let backgroundLayer = context.backgroundLayer {
            tabBarController.view.layer.insertSublayer(backgroundLayer, at: 0)
        }
        
        tabBarController.addFakeNavigationBarLayerIfNeeded(context: context)
        
        let selectedIndex = tabBarController.selectedIndex
        let shouldSelectIndex = tabBarController.viewControllers?.firstIndex(of: viewController) ?? 0
        let direction = Direction(selectedIndex: selectedIndex, shouldSelectIndex: shouldSelectIndex)
        
        tabBarController.animate(context: context, direction: direction)
        
        return true
    }
}

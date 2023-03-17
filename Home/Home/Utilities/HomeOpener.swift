//
//  HomeOpener.swift
//  Home
//
//  Created by Tanakorn Phoochaliaw on 6/7/2564 BE.
//

import UIKit
import Core

public enum HomeScene {
    case home
}

public struct HomeOpener {
    public static func open(_ homeScene: HomeScene) -> UIViewController {
        switch homeScene {
        case .home:
            let storyboard: UIStoryboard = UIStoryboard(name: HomeNibVars.Storyboard.home, bundle: ConfigBundle.home)
            let viewController = storyboard.instantiateViewController(withIdentifier: HomeNibVars.ViewController.home)
            return viewController
        }
    }
}

//
//  NavigationBar.swift
//  Core
//
//  Created by Tanakorn Phoochaliaw on 14/3/2566 BE.
//

import UIKit

public enum NavBarButtonType {
    case search
    case screencast

    public var image: UIImage {
        switch self {
        case .search:
            return UIImage.init(icon: .regular(.magnifyingGlass), size: CGSize(width: 24, height: 24), textColor: .white)
        case .screencast:
            return UIImage.init(icon: .regular(.screencast), size: CGSize(width: 24, height: 24), textColor: .white)
        }
    }

    public var barButton: UIButton {
        let icon = UIButton(type: .system)
        icon.setImage(self.image.withRenderingMode(.alwaysOriginal), for: .normal)
        return icon
    }
}

public enum NavBarType {
    case primary
    case secondary
    case search
}

public enum SecondaryBackType {
    case normal
    case root
}

public extension UIViewController {

    func customNavigationBar(_ type: NavBarType, title: String, urlString: String = "", textColor: UIColor = .white, leftBarButton: NavBarButtonType? = nil, secondaryBackType: SecondaryBackType = .normal, animated: Bool = true) {
        if type == .primary {
            self.navigationController?.navigationBar.installBlurEffect()
            self.setupPrimaryNavigationBar(title: title, textColor: textColor, leftBarButton: leftBarButton, animated: animated)
        }
    }

    private func setupPrimaryNavigationBar(title: String, textColor: UIColor = .white, leftBarButton: NavBarButtonType?, animated: Bool) {
        // MARK: - Title
        let titleLabel = UILabel()
        titleLabel.textColor = textColor
        titleLabel.text = title
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.asset(.bold, fontSize: .head2)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)

        // MARK: - Right Bar Button
        var rightButton: [UIBarButtonItem] = []
        let profileIcon = UIButton(type: .system)
        profileIcon.setImage(UIImage.Asset.avatarNavbar.withRenderingMode(.alwaysOriginal), for: .normal)
        rightButton.append(UIBarButtonItem(customView: profileIcon))
        
        let searchIcon = NavBarButtonType.search.barButton
//        searchIcon.addTarget(self, action: #selector(self.settingAction), for: .touchUpInside)
        rightButton.append(UIBarButtonItem(customView: searchIcon))
        let castIcon = NavBarButtonType.screencast.barButton
//        castIcon.addTarget(self, action: #selector(self.settingAction), for: .touchUpInside)
        rightButton.append(UIBarButtonItem(customView: castIcon))
        self.navigationItem.rightBarButtonItems = rightButton
    }

//    private func setupLeftNavigationBar(leftBarButton: NavBarButtonType?, animated: Bool) {
//        if let leftButton = leftBarButton {
            
//
//            if leftBarButton == .back {
//                icon.tag = (animated ? 1 : 0)
//                icon.addTarget(self, action: #selector(popAction(_ :)), for: .touchUpInside)
//            }
//            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: icon)
//        }
//    }
//
//    @objc private func popAction(_ sender: UIButton) {
//        Utility.currentViewController().navigationController?.popViewController(animated: (sender.tag == 1))
//    }
//
//    @objc private func popToRootAction(_ sender: UIButton) {
//        Utility.currentViewController().navigationController?.popToRootViewController(animated: (sender.tag == 1))
//    }
}

extension UINavigationBar {
    func installBlurEffect() {
        isTranslucent = true
        setBackgroundImage(UIImage(), for: .default)
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight: CGFloat = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        var blurFrame = bounds
        blurFrame.size.height += statusBarHeight
        blurFrame.origin.y -= statusBarHeight
        let blurView  = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.isUserInteractionEnabled = false
        blurView.frame = blurFrame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
        blurView.layer.zPosition = -1
    }
}

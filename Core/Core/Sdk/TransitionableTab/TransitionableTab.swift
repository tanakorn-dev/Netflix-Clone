//
//  TransitionableTab.swift
//  Core
//
//  Created by Tanakorn Phoochaliaw on 17/3/2566 BE.
//

import UIKit

private struct AnimationKeys {
    static var toViewAnimationKey = "ToViewAnimationKey"
    static var fromViewAnimationKey = "FromViewAnimationKey"
    static var navigationBarAnimationKey = "navigationBarAnimationKey"
    static var backgroundAnimatonKey = "BackgroundAnimationKey"
}

public extension UITabBarController {
    func addFakeNavigationBarLayerIfNeeded(context: LayerContext) {
        guard let fakeNavigationBar = context.fakeNavigationBarLayer else { return }
        self.view.layer.addSublayer(fakeNavigationBar)
    }
    
    func animate(context: LayerContext, direction: Direction) {
        let fromAnimation = DefineAnimation.move(.from, direction: direction)
        let toAnimation = DefineAnimation.move(.to, direction: direction)
        let backgroundAnimation = AnimationFactory.makeAnimation(type: .opacity, from: 0, to: 1)
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.4)
        CATransaction.setAnimationTimingFunction(.easeOut)
        CATransaction.setCompletionBlock {
            context.reset()
        }
        
        if let fakeNavigationBar = context.fakeNavigationBarLayer {
            let fadeAnimation = AnimationFactory.makeAnimation(type: .opacity, from: 1, to: 0)
            fadeAnimation.isRemovedOnCompletion = false
            fadeAnimation.fillMode = .forwards
            fakeNavigationBar.add(fadeAnimation, forKey: AnimationKeys.navigationBarAnimationKey)
        }

        context.toBackgroundLayer?.add(backgroundAnimation, forKey: AnimationKeys.backgroundAnimatonKey)
        context.fakeLayer?.add(fromAnimation, forKey: AnimationKeys.fromViewAnimationKey)
        context.toLayer?.add(toAnimation, forKey: AnimationKeys.toViewAnimationKey)
        CATransaction.commit()
    }
}

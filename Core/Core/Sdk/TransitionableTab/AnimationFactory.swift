//
//  AnimationFactory.swift
//  Core
//
//  Created by Tanakorn Phoochaliaw on 17/3/2566 BE.
//

import UIKit

enum AnimationType: String {
    case opacity
    case scale = "transform.scale"
    case translation = "transform.translation.x"
    
    func animation<T>(from: T, to: T) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: rawValue)
        animation.fromValue = from
        animation.toValue = to
        return animation
    }
}

class AnimationFactory {
    
    static func makeAnimation<T>(type: AnimationType, from: T, to: T) -> CAAnimation {
        let animation = type.animation(from: from, to: to)
        return animation
    }
    
    static func makeGroupAnimation(_ animations: [CAAnimation]) -> CAAnimationGroup {
        let group = CAAnimationGroup()
        group.animations = animations
        return group
    }
}

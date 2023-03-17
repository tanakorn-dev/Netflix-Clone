//
//  CAMediaTimingFunction+Transition.swift
//  Core
//
//  Created by Tanakorn Phoochaliaw on 17/3/2566 BE.
//

import UIKit

public extension CAMediaTimingFunction {
    static let linear = CAMediaTimingFunction(name: .linear)
    static let easeIn = CAMediaTimingFunction(name: .easeIn)
    static let easeOut = CAMediaTimingFunction(name: .easeOut)
    static let easeInOut = CAMediaTimingFunction(name: .easeInEaseOut)
}

//
//  Options.swift
//  Core
//
//  Created by Tanakorn Phoochaliaw on 17/3/2566 BE.
//

import UIKit

public enum Direction {
    case left
    case right
    
    public init(selectedIndex: Int, shouldSelectIndex: Int) {
        self = selectedIndex > shouldSelectIndex ? .left : .right
    }
}

public enum TransitionViewType: Int {
    case to
    case from
}

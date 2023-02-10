//
//  N64.swift
//  N64DeltaCore
//
//  Created by Riley Testut on 3/27/19.
//  Copyright © 2019 Riley Testut. All rights reserved.
//

import Foundation

import DeltaCore

@objc public enum N64GameInput: Int, _Input {
    // D-Pad
    case up = 0
    case down = 1
    case left = 2
    case right = 3
    
    // Analog-Stick
    case analogStickUp = 4
    case analogStickDown = 5
    case analogStickLeft = 6
    case analogStickRight = 7
    
    // C-Buttons
    case cUp = 8
    case cDown = 9
    case cLeft = 10
    case cRight = 11
    
    // Other
    case a = 12
    case b = 13
    case l = 14
    case r = 15
    case z = 16
    case start = 17

    public var isContinuous: Bool {
        switch self
        {
        case .analogStickUp, .analogStickDown, .analogStickLeft, .analogStickRight: return true
        default: return false
        }
    }
}

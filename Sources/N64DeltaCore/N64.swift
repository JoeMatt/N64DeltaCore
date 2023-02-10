//
//  N64.swift
//  N64DeltaCore
//
//  Created by Riley Testut on 3/27/19.
//  Copyright © 2019 Riley Testut. All rights reserved.
//

import Foundation
import AVFoundation

import DeltaCore
@_exported import N64Swift

extension N64GameInput: Input {
    public var type: InputType {
        return .game(.n64)
    }
}

public struct N64: DeltaCoreProtocol {
    public static let core = N64()
    
    public var name: String { "Mupen64Plus" }
    public var identifier: String { "com.rileytestut.N64DeltaCore" }
    
    public var gameType: GameType { GameType.n64 }
    public var gameInputType: Input.Type { N64GameInput.self }
    public var gameSaveFileExtension: String { "sav" }
    
    public var audioFormat: AVAudioFormat { N64EmulatorBridge.shared.preferredAudioFormat }
    public var videoFormat: VideoFormat { VideoFormat(format: .openGLES, dimensions: CGSize(width: 640, height: 480)) }
    
    public var supportedCheatFormats: Set<CheatFormat> {
        let gameSharkFormat = CheatFormat(name: NSLocalizedString("GameShark", comment: ""), format: "XXXXXXXX YYYY", type: .gameShark)
        return [gameSharkFormat]
    }
    
    public var emulatorBridge: EmulatorBridging { N64EmulatorBridge.shared as! EmulatorBridging }
    
    private init()
    {
    }
}

// Expose DeltaCore properties to Objective-C.
public extension N64EmulatorBridge {
    @objc(n64Resources) class var __n64Resources: Bundle {
        return N64.core.resourceBundle
    }
    
    @objc(coreDirectoryURL) class var __coreDirectoryURL: URL {
        return _coreDirectoryURL
    }
}

private let _coreDirectoryURL = N64.core.directoryURL

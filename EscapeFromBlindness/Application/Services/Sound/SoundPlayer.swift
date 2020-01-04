//
//  SoundPlayer.swift
//  EscapeFromBlindness
//
//  Created by Michael Martinez on 26/12/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import Foundation

/// Protocol for sound playing capable classes
protocol SoundPlayer: MessagesSoundPlayer & LocalSoundPlayer {}

protocol MessagesSoundPlayer: class {
    /// Sound Player delegate will can be notified about sound info
    var delegate: NavigationSoundPlayerDelegate? { get set }
    
    /// Audio speak message (can include delays by including {0.0} format)
    /// IMPORTANT: Sound priorities are handled internally, mode will be ignored
    /// If sound spatialization model is provider sound will be played
    /// using 3D Audio Engine
    func speak(
        message: String,
        type: AnyHashable?
    )
    
    /// Whether the sound player is speaking or not
    var isSpeaking: Bool { get }
    
    /// Pause/resume speaking
    func pause(_ isPaused: Bool)
    func stop()
    /// Tune spoken messages volume
    func setVolume(_ volume: Double)
    /// Tune spoken messages speech rate
    func setSpeechRate(_ speechRate: Double)
}

extension SoundPlayer {
    func speak(
        message: String,
        type: AnyHashable? = nil
    ) {
        speak(message: message, type: type)
    }
}

protocol LocalSoundPlayer: class {
    /// Play local contextual sound file
    func playSound(_ filename: String)
}

/// The navigation sound player delegate receives main sound playing events
protocol NavigationSoundPlayerDelegate: class {
    func didFinishPlayingSound(areQueuedMessages: Bool)
}

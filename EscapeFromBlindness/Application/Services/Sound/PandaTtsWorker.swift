//
//  Created by Michael Martinez on 27/09/2019.
//  Copyright © 2019 michael-martinez. All rights reserved.
//

import AVFoundation
import UIKit

final class TTSWorker: NSObject, MessagesSoundPlayer {
    var delegate: NavigationSoundPlayerDelegate?
    
    private var lastMessage: String = ""
    private var volume: Float = 0.5
    private var speechRate: Float = 1.0
    var isMuted: Bool {
        get {
            return volume == 0
        }
    }
    private var isSettingVolume = false
    private var remainingString = ""
    
    // MARK: Variables
    public let speechSynthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    var isSpeaking: Bool {
        get {
            return speechSynthesizer.isSpeaking
        }
    }
    
    var isPaused: Bool {
        get {
            return speechSynthesizer.isPaused
        }
    }
    
    override init() {
        super.init()
        self.speechSynthesizer.delegate = self
    }
    
    func speak(message: String, type: AnyHashable?) {
        guard !message.isEmpty else { return }
        
        self.speechSynthesizer.speakWithDelay(
            message,
            volume: self.volume,
            rate: self.speechRate
        )
    }
    
    func pause(_ isPaused: Bool) {
        guard self.isPaused != isPaused else { return }
        
        if isPaused {
            self.speechSynthesizer.pauseSpeaking(at: .word)
        } else {
            self.speechSynthesizer.continueSpeaking()
        }
        
        print("pause 2D")
    }
    func stop() {
        self.speechSynthesizer.stopSpeaking(at: .word)
    }
    
    func setVolume(_ volume: Double) {
        print("setVolume 2D \(volume)")
        self.volume = Float(volume)
        
        self.isSettingVolume = true
        self.speechSynthesizer.stopSpeaking(at: .immediate)
    }
    
    func setSpeechRate(_ speechRate: Double) {
        print("setSpeechRate 2D \(speechRate)")
        self.speechRate = Float(speechRate)
    }
    
}

extension TTSWorker: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        self.remainingString = utterance.speechString[characterRange.lowerBound..<utterance.speechString.count]
        print("willSpeakRangeOfSpeechString \(self.remainingString)")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        print("didCancel utterance")
        if self.isSettingVolume {
            self.isSettingVolume = false
            synthesizer.speakWithDelay(self.remainingString, volume: self.volume)
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        delegate?.didFinishPlayingSound(areQueuedMessages: false)
    }
}

extension AVSpeechSynthesizer {
    /// Handle the pause in speech : put {0.8} in your text to have a pause of 0.8 sec
    /// - Parameters:
    ///     - volume: The utterance volume between 0 and 1
    ///     - rate: The utterance rate between 0 and 1
    func speakWithDelay(_ text: String, volume: Float? = nil, rate: Float? = nil) {
        let pattern = #"([^{]*)(?:\{([0-9]+(?:\.[0-9]+))\})?"#
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: text, options: .anchored, range: NSRange(0..<text.utf16.count))
        for match in matches {
            let utteranceText = String(text[Range(match.range(at: 1), in: text)!])
            
            let utterance = AVSpeechUtterance(string: utteranceText)
            utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
            if let volume = volume {
                utterance.volume = volume
            }
            if let rate = rate {
                utterance.rate = rate
            }
            
            if let range = Range(match.range(at: 2), in: text) {
                let delay = TimeInterval(text[range])!
                utterance.postUtteranceDelay = delay
            }
            speak(utterance)
        }
    }
}

//
//  Created by Michael Martinez on 19/03/2020.
//  Copyright © 2020 michael-martinez. All rights reserved.
//

import AVFoundation

enum CustomSoundTypes: String, CaseIterable {
    case jungle = "jungle.mp3"
    case quake = "quake+5.mp3"
    case thunder = "thunder.mp3"
    case wind = "wind-sand.mp3"
}

protocol SoundPlayerProtocol {
    func start(type: CustomSoundTypes)
    func stop()
}

class SoundPlayer: SoundPlayerProtocol {
    
    private var audioPlayer: AVAudioPlayer?
    
    func start(type: CustomSoundTypes) {
        if audioPlayer != nil {
            stop()
        }
        
        audioPlayer = try? AVAudioPlayer(contentsOf: Bundle.customSoundURL(type: type))
        audioPlayer?.volume = 0.3
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.play()
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
}

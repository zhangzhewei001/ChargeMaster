//
//  PlayerHandler.swift
//  ChargingMaster
//
//  Created by 张哲炜 on 2021/8/5.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    
    private var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    func loadAudio(forResource: String, ofType: String){
        if let bundlePath = Bundle.main.path(forResource: forResource, ofType: ofType) {
            let url = URL.init(fileURLWithPath: bundlePath)
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: url)
                audioPlayer.delegate = self
                audioPlayer.prepareToPlay()
            } catch let error as NSError {
                print("audioPlayer error \(error.localizedDescription)")
            }
            
        }
    }
    
    func play() {
        audioPlayer.play()
    }
    
    func stop() {
        audioPlayer.stop()
    }
    
    func pause() {
        audioPlayer.pause()
    }
  
}

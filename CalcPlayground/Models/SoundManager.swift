//
//  SoundManager.swift
//  CalcPlayground
//
//  Created by Wayne Dahlberg on 10/8/24.
//

import AVFoundation

class SoundManager {
  static let shared = SoundManager()
  
  private var audioPlayers: [AVAudioPlayer] = []
  private let maxPlayers = 5 // Adjust this number based on your needs
  
  private init() {}
  
  func preloadSounds(baseName: String, count: Int, fileExtension: String = "wav") {
    for i in 1...count {
      if let url = Bundle.main.url(forResource: "\(baseName)\(i)", withExtension: fileExtension) {
        do {
          let player = try AVAudioPlayer(contentsOf: url)
          player.prepareToPlay()
          audioPlayers.append(player)
        } catch {
          print("Error loading sound \(baseName)\(i): \(error.localizedDescription)")
        }
      }
    }
  }
  
  func playRandomSound() {
    guard !audioPlayers.isEmpty else { return }
    
    let availablePlayer = audioPlayers.first { !$0.isPlaying } ?? audioPlayers[0]
    availablePlayer.play()
  }
}

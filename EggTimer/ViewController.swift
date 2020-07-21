//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
import AVFoundation

var player: AVAudioPlayer?

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eggDone: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft":3,"Medium":4,"Hard":7]
    
    
    var totalTime = 0
    var secondsRemaining = 0

    var timer = Timer()
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        timer.invalidate()  // canceling the reuse
        
        progressBar.progress = 0
        secondsRemaining = 0
        eggDone.text = hardness
        
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        
        
        
        
        
    }
    @objc func fire()
    {
        if secondsRemaining <= totalTime{
            
            progressBar.progress = Float(secondsRemaining)/Float(totalTime)
            print("\(secondsRemaining) seconds.")
            
            secondsRemaining += 1
            
        }
        else{
            eggDone.text = "DONE!"
            playSound()
        }
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
}

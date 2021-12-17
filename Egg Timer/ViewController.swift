//
//  ViewController.swift
//  Egg Timer
//
//  Created by Joao daniel on 16/12/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720, "default": 0]
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    
    @IBAction func HardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let buttonTitle = sender.titleLabel?.text
        totalTime = eggTimes[buttonTitle ?? "default"] ?? 0
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = buttonTitle
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                       player = try! AVAudioPlayer(contentsOf: url!)
                       player.play()
        }
    }
    
}



//
//  ViewController.swift
//  ShakeDemo
//
//  Created by Mathias Møller Feldt on 24/04/2020.
//  Copyright © 2020 Mathias Møller. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer?  //The audio player
    var generator = UINotificationFeedbackGenerator()  //For generating vibration
    var animation = AnimationManager() //The class that handles the snow animation
    var isThereAnySnow = Bool() //Checks if the animation is running
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isThereAnySnow = false
        
    }
    
    //If the device is shaken
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if isThereAnySnow == false {
                animation.injectItemLayer(into: self.view)
                generator.notificationOccurred(.success)
                isThereAnySnow = true
                playSound(soundName: "sound1")
            } else {
                animation.removeLayer()
                self.player?.stop()
                isThereAnySnow = false
                generator.notificationOccurred(.warning)
                
            }
            
        }
    }
    
    //Method for playing sounds
    func playSound(soundName:String) {
        let path = Bundle.main.path(forResource: soundName, ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("could not load file")
        }
    }

}




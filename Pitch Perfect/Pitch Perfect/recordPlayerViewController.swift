//
//  recordPlayerViewController.swift
//  Pitch Perfect
//
//  Created by Jing Jia on 4/10/15.
//  Copyright (c) 2015 Jing Jia. All rights reserved.
//

import UIKit
import AVFoundation

class recordPlayerViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBAction func StopSoundPLay(sender: AnyObject) {
        audioPlayer.stop()
    }
    @IBAction func PlayFastSound(sender: AnyObject) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

        audioPlayer.rate=1.5
        audioPlayer.currentTime=0
        audioPlayer.play()
    }
    @IBAction func playDarthVaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func playChipmunkAudio(sender: AnyObject) {
        playAudioWithVariablePitch(1000)
    }
    @IBAction func PlaySlowSound(sender: AnyObject) {
        

        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

        audioPlayer.rate=0.5
        audioPlayer.currentTime=0
        audioPlayer.play()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var session = AVAudioSession.sharedInstance()
        let speaker = AVAudioSessionPortOverride.Speaker
        session.overrideOutputAudioPort(speaker, error: nil)
        
        audioPlayer=AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate=true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

}

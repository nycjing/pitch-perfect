//
//  VoiceRecordingViewController.swift
//  Pitch Perfect
//
//  Created by Jing Jia on 4/7/15.
//  Copyright (c) 2015 Jing Jia. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceRecordingViewController: UIViewController,AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordInProgress: UILabel!
    @IBOutlet weak var stopRecording: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        stopRecording.hidden=true
        recordButton.enabled=true
        recordInProgress.text="Tap to Record"
        recordInProgress.hidden=false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordButton(sender: UIButton) {
        recordInProgress.text="Record in Progress"
        recordInProgress.hidden=false
        stopRecording.hidden=false
        recordButton.enabled=true
        println("recording process")
        
        let dirPath=NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate=self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
      
        var recordedAudio = RecordedAudio(filePathUrl: recorder.url,
            title: recorder.url.lastPathComponent!)

        println("recording success")
            self.performSegueWithIdentifier("stopRecord", sender: recordedAudio)}
        else{
            println("recording not success")
            recordButton.enabled=true
            stopRecording.hidden=true

        }
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier=="stopRecord"){
            let playsoundVC:recordPlayerViewController=segue.destinationViewController as! recordPlayerViewController
            let data=sender as! RecordedAudio
            playsoundVC.receivedAudio=data
        }
    }
    @IBAction func stopButton(sender: UIButton) {
        recordButton.enabled=false
        audioRecorder.stop()
        println("recording success")
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

